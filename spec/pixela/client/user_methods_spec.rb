RSpec.describe Pixela::Client::UserMethods do
  include_context :api_variables

  describe "#create_user" do
    subject do
      client.create_user(
        agree_terms_of_service: agree_terms_of_service,
        not_minor:              not_minor,
      )
    end

    context "when successful" do
      before do
        json_body = <<~JSON.strip
          {"token":"thisissecret","username":"a-know","agreeTermsOfService":"yes","notMinor":"yes"}
        JSON

        stub_request(:post, "https://pixe.la/v1/users").
          with(body: json_body, headers: default_headers).
          to_return(status: 200, headers: response_headers, body: fixture("success.json"))
      end

      let(:agree_terms_of_service) { true }
      let(:not_minor)              { true }

      it_behaves_like :success
    end

    context "when failure" do
      before do
        json_body = <<~JSON.strip
          {"token":"thisissecret","username":"a-know","agreeTermsOfService":"yes","notMinor":"no"}
        JSON

        stub_request(:post, "https://pixe.la/v1/users").
          with(body: json_body, headers: default_headers).
          to_return(status: 403, body: fixture("post_users_failure.json"))
      end

      let(:agree_terms_of_service) { true }
      let(:not_minor)              { false }

      it { expect { subject }.to raise_error Pixela::PixelaError, "In order to use this service, you have to be aged or have the consent of a custodial person." }
    end
  end

  describe "#update_user" do
    subject { client.update_user(new_token: new_token) }

    let(:new_token) { "newsecret" }
    let(:graph_id)  { "test-graph" }
    let(:date)      { Date.parse("2018-09-15") }
    let(:quantity)  { 5 }

    before do
      json_body = <<~JSON.strip
        {"newToken":"newsecret"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success

    it { expect { subject }.to change { client.send(:token) }.from("thisissecret").to("newsecret") }

    describe "update_user and other API method" do
      before do
        post_json_body = <<~JSON.strip
          {"date":"20180915","quantity":"5"}
        JSON

        stub_request(:post, "https://pixe.la/v1/users/a-know/graphs/test-graph").
          with(body: post_json_body, headers: user_token_headers).
          to_return(status: 200, headers: response_headers, body: fixture("success.json"))

        put_json_body = <<~JSON.strip
          {"quantity":"7"}
        JSON

        new_token_headers = user_token_headers.merge("X-USER-TOKEN" => new_token )

        stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/20180915").
          with(body: put_json_body, headers: new_token_headers).
          to_return(status: 200, headers: response_headers, body: fixture("success.json"))
      end

      it "called create_pixel with new token" do
        client.graph("test-graph").pixel(Date.parse("2018-09-15")).create(quantity: 5)

        subject

        client.graph("test-graph").pixel(Date.parse("2018-09-15")).update(quantity: 7)
      end
    end
  end

  describe "#delete_user" do
    subject { client.delete_user }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
