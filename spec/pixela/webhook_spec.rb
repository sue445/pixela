RSpec.describe Pixela::Webhook do
  include_context :api_variables

  let(:webhook)      { client.webhook(webhook_hash) }
  let(:webhook_hash) { "webhookHash" }

  describe "#invoke" do
    subject { webhook.invoke }

    before do
      allow(client).to receive(:invoke_webhook).with(webhook_hash: webhook_hash)
    end

    it "successful" do
      subject
    end
  end

  describe "#delete" do
    subject { webhook.delete }

    before do
      allow(client).to receive(:delete_webhook).with(webhook_hash: webhook_hash)
    end

    it "successful" do
      subject
    end
  end
end