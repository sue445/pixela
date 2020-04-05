RSpec.describe Pixela::Notification do
  include_context :api_variables

  let(:notification)    { client.graph(graph_id).notification(notification_id) }
  let(:graph_id)        { "test-graph" }
  let(:notification_id) { "my-notification-rule" }

  describe "#create" do
    subject do
      notification.create(
        name: name,
        target: target,
        condition: condition,
        threshold: threshold,
        remind_by: remind_by,
        channel_id: channel_id,
      )
    end

    let(:name)       { "my notification rule" }
    let(:target)     { "quantity" }
    let(:condition)  { ">" }
    let(:threshold)  { "5" }
    let(:remind_by)  { "21" }
    let(:channel_id) { "my-channel" }

    before do
      allow(client).to receive(:create_notification)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_notification).with(graph_id: graph_id, notification_id: notification_id, name: name, target: target, condition: condition, threshold: threshold, remind_by: remind_by, channel_id: channel_id)
    end
  end

  describe "#update" do
    subject do
      notification.update(
        name: name,
        target: target,
        condition: condition,
        threshold: threshold,
        channel_id: channel_id,
      )
    end

    let(:name)       { "my notification rule" }
    let(:target)     { "quantity" }
    let(:condition)  { ">" }
    let(:threshold)  { "5" }
    let(:channel_id) { "my-channel" }

    before do
      allow(client).to receive(:update_notification)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_notification).with(graph_id: graph_id, notification_id: notification_id, name: name, target: target, condition: condition, threshold: threshold, channel_id: channel_id)
    end
  end

  describe "#delete" do
    subject { notification.delete }

    before do
      allow(client).to receive(:delete_notification)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_notification).with(graph_id: graph_id, notification_id: notification_id)
    end
  end
end
