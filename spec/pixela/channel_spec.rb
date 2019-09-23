RSpec.describe Pixela::Channel do
  include_context :api_variables

  let(:channel) { client.channel(channel_id) }
  let(:channel_id) { "my-channel" }

  describe "#create" do
    subject do
      channel.create(
        name:   name,
        type:   type,
        detail: detail,
      )
    end

    let(:name)   { "My slack channel" }
    let(:type)   { "slack" }
    let(:detail) { {url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", userName: "Pixela Notification", channelName: "pixela-notify"} }

    before do
      allow(client).to receive(:create_channel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_channel).with(channel_id: channel_id, name: name, type: type, detail: detail)
    end
  end

  describe "#create_with_slack" do
    subject do
      channel.create_with_slack(
        name:         name,
        url:          url,
        user_name:    user_name,
        channel_name: channel_name,
      )
    end

    let(:name)         { "My slack channel" }
    let(:url)          { "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx" }
    let(:user_name)    { "Pixela Notification" }
    let(:channel_name) { "pixela-notify" }

    before do
      allow(client).to receive(:create_slack_channel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_slack_channel).with(channel_id: channel_id, name: name, url: url, user_name: user_name, channel_name: channel_name)
    end
  end

  describe "#update" do
    subject do
      channel.update(
        name:   name,
        type:   type,
        detail: detail,
      )
    end

    let(:name)   { "My slack channel" }
    let(:type)   { "slack" }
    let(:detail) { {url: "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx", userName: "Pixela Notification", channelName: "pixela-notify"} }

    before do
      allow(client).to receive(:update_channel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_channel).with(channel_id: channel_id, name: name, type: type, detail: detail)
    end
  end

  describe "#update_with_slack" do
    subject do
      channel.update_with_slack(
        name:         name,
        url:          url,
        user_name:    user_name,
        channel_name: channel_name,
      )
    end

    let(:name)         { "My slack channel" }
    let(:url)          { "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx" }
    let(:user_name)    { "Pixela Notification" }
    let(:channel_name) { "pixela-notify" }

    before do
      allow(client).to receive(:update_slack_channel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_slack_channel).with(channel_id: channel_id, name: name, url: url, user_name: user_name, channel_name: channel_name)
    end
  end

  describe "#delete" do
    subject { channel.delete }

    before do
      allow(client).to receive(:delete_channel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_channel).with(channel_id: channel_id)
    end
  end
end
