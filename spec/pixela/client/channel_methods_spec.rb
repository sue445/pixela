RSpec.describe Pixela::Client::ChannelMethods do
  include_context :api_variables

  describe "#create_slack_channel" do
    subject do
      client.create_slack_channel(
        channel_id:   channel_id,
        name:         name,
        url:          url,
        user_name:    user_name,
        channel_name: channel_name,
      )
    end

    let(:channel_id)   { "my-channel" }
    let(:name)         { "My slack channel" }
    let(:url)          { "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx" }
    let(:user_name)    { "Pixela Notification" }
    let(:channel_name) { "pixela-notify" }

    before do
      json_body = <<~JSON.strip
        {"id":"my-channel","name":"My slack channel","type":"slack","detail":{"url":"https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx","userName":"Pixela Notification","channelName":"pixela-notify"}}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/channels").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_channels" do
    subject(:channels) { client.get_channels }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/channels").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("get_channels.json"))
    end

    its(:count) { should eq 1 }

    describe "[0]" do
      subject { channels[0] }

      its(:id)                  { should eq "my-channel" }
      its(:name)                { should eq "My slack channel" }
      its(:type)                { should eq "slack" }
      its("detail.url")         { should eq "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx" }
      its("detail.userName")    { should eq "Pixela Notification" }
      its("detail.channelName") { should eq "pixela-notify" }
    end
  end

  describe "#update_slack_channel" do
    subject do
      client.update_slack_channel(
        channel_id:   channel_id,
        name:         name,
        url:          url,
        user_name:    user_name,
        channel_name: channel_name,
      )
    end

    let(:channel_id)   { "my-channel" }
    let(:name)         { "My slack channel" }
    let(:url)          { "https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx" }
    let(:user_name)    { "Pixela Notification" }
    let(:channel_name) { "pixela-notify" }

    before do
      json_body = <<~JSON.strip
        {"name":"My slack channel","type":"slack","detail":{"url":"https://hooks.slack.com/services/T035DA4QD/B06LMAV40/xxxx","userName":"Pixela Notification","channelName":"pixela-notify"}}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know/channels/my-channel").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#delete_channel" do
    subject do
      client.delete_channel(channel_id: channel_id)
    end

    let(:channel_id) { "my-channel" }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know/channels/my-channel").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
