RSpec.describe Pixela::Webhook do
  include_context :api_variables

  let(:webhook)      { client.webhook(webhook_hash) }
  let(:webhook_hash) { "webhookHash" }

  describe "#invoke" do
    subject { webhook.invoke }

    before do
      allow(client).to receive(:invoke_webhook)
    end

    it "successful" do
      subject
      expect(client).to have_received(:invoke_webhook).with(webhook_hash: webhook_hash)
    end
  end

  describe "#delete" do
    subject { webhook.delete }

    before do
      allow(client).to receive(:delete_webhook)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_webhook).with(webhook_hash: webhook_hash)
    end
  end
end
