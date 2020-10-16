RSpec.describe Pixela::Client::ProfileMethods do
  include_context :api_variables

  describe "#update_profile" do
    subject do
      client.update_profile(
        display_name:        display_name,
        gravatar_icon_email: gravatar_icon_email,
        title:               title,
        timezone:            timezone,
        about_url:           about_url,
        contribute_urls:     contribute_urls,
        pinned_graph_id:     pinned_graph_id,
      )
    end

    let(:display_name)        { "a-know" }
    let(:gravatar_icon_email) { "user@example.com" }
    let(:title)               { "my title" }
    let(:timezone)            { "Asia/Tokyo" }
    let(:about_url)           { "https://home.a-know.me/" }
    let(:contribute_urls) do
      [
        "https://pixe.la/",
        "https://github.com/a-know/pi",
        "https://blog.a-know.me/archive/category/Pixela",
      ]
    end
    let(:pinned_graph_id) { "test-graph" }

    before do
      json_body = <<~JSON.strip
        {"displayName":"a-know","gravatarIconEmail":"user@example.com","title":"my title","timezone":"Asia/Tokyo","aboutURL":"https://home.a-know.me/","pinnedGraphID":"test-graph","contributeURLs":["https://pixe.la/","https://github.com/a-know/pi","https://blog.a-know.me/archive/category/Pixela"]}
      JSON

      stub_request(:put, "https://pixe.la/@a-know").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
