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
          to_return(status: 200, body: fixture("post_users_successful.json"))
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
end
