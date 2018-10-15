RSpec.describe Pixela::Client do
  let(:client)   {  Pixela::Client.new(username: username, token: token) }
  let(:username) { "a-know" }
  let(:token)    { "thisissecret" }

  let(:default_headers) do
    {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Content-Type" => "application/json",
      "User-Agent" => "Pixela v#{Pixela::VERSION}",
    }
  end

  describe "#register" do
    subject do
      client.register(
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
