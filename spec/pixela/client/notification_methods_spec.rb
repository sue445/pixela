RSpec.describe Pixela::Client::NotificationMethods do
  include_context :api_variables

  describe "#create_notification" do
    subject do
      client.create_notification(
        graph_id: graph_id,
        notification_id: notification_id,
        name: name,
        target: target,
        condition: condition,
        threshold: threshold,
        remind_by: remind_by,
        channel_id: channel_id,
      )
    end

    let(:graph_id)        { "test-graph" }
    let(:notification_id) { "my-notification-rule" }
    let(:name)            { "my notification rule" }
    let(:target)          { "quantity" }
    let(:condition)       { ">" }
    let(:threshold)       { "5" }
    let(:remind_by)       { "21" }
    let(:channel_id)      { "my-channel" }

    before do
      json_body = <<~JSON.strip
        {"id":"my-notification-rule","name":"my notification rule","target":"quantity","condition":">","threshold":"5","remindBy":"21","channelID":"my-channel"}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs/test-graph/notifications").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_notifications" do
    subject(:notifications) { client.get_notifications(graph_id: graph_id) }

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/notifications").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("get_notifications.json"))
    end

    its(:count) { should eq 1 }

    describe "[0]" do
      subject { notifications[0] }

      its(:id)        { should eq "my-notify-rule" }
      its(:name)      { should eq "my notify rule" }
      its(:target)    { should eq "quantity" }
      its(:condition) { should eq ">" }
      its(:threshold) { should eq "5" }
      its(:channelID) { should eq "my-channel" }
    end
  end

  describe "#update_notification" do
    subject do
      client.update_notification(
        graph_id: graph_id,
        notification_id: notification_id,
        name: name,
        target: target,
        condition: condition,
        threshold: threshold,
        channel_id: channel_id,
      )
    end

    let(:graph_id)        { "test-graph" }
    let(:notification_id) { "my-notification-rule" }
    let(:name)            { "my notification rule" }
    let(:target)          { "quantity" }
    let(:condition)       { ">" }
    let(:threshold)       { "5" }
    let(:channel_id)      { "my-channel" }

    before do
      json_body = <<~JSON.strip
        {"name":"my notification rule","target":"quantity","condition":">","threshold":"5","channelID":"my-channel"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/notifications/my-notification-rule").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#delete_notification" do
    subject do
      client.delete_notification(
        graph_id: graph_id,
        notification_id: notification_id,
      )
    end

    let(:graph_id)        { "test-graph" }
    let(:notification_id) { "my-notification-rule" }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know/graphs/test-graph/notifications/my-notification-rule").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
