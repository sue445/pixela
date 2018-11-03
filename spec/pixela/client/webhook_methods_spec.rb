RSpec.describe Pixela::Client::WebhookMethods do
  include_context :api_variables

  describe "#create_webhook" do
    subject do
      client.create_webhook(
        graph_id: graph_id,
        type:     type,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:type)     { "increment" }

    before do
      json_body = <<~JSON.strip
        {"graphID":"test-graph","type":"increment"}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/webhooks").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("post_webhook.json"))
    end

    it_behaves_like :success

    its(:webhookHash) { should eq "<WebhookHashString>" }
  end

  describe "#get_webhooks" do
    subject(:webhooks) { client.get_webhooks }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/webhooks").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("get_webhooks.json"))
    end

    its(:count) { should eq 1 }

    describe "[0]" do
      subject { webhooks[0] }

      its(:webhookHash) { should eq "<WebhookHashString>" }
      its(:graphID)     { should eq "test-graph" }
      its(:type)        { should eq "increment" }
    end
  end

  describe "#invoke_webhook" do
    subject do
      client.invoke_webhook(
        webhook_hash: webhook_hash,
      )
    end

    let(:webhook_hash) { "webhookHash" }

    before do
      stub_request(:post, "https://pixe.la/v1/users/a-know/webhooks/webhookHash").
        with(headers: default_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#delete_webhook" do
    subject do
      client.delete_webhook(
        webhook_hash: webhook_hash,
      )
    end

    let(:webhook_hash) { "webhookHash" }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know/webhooks/webhookHash").
        with(headers: default_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
