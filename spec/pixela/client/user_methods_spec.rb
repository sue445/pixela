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
          to_return(status: 200, body: fixture("success.json"))
      end

      let(:agree_terms_of_service) { true }
      let(:not_minor)              { true }

      its(:message)   { should eq "Success." }
      its(:isSuccess) { should eq true }
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

    before do
      json_body = <<~JSON.strip
        {"newToken":"newsecret"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }

    it { expect { subject }.to change { client.send(:token) }.from("thisissecret").to("newsecret") }
  end

  describe "#delete_user" do
    subject { client.delete_user }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
  end
end
