RSpec.describe Pixela::Client::PixelMethods do
  include_context :api_variables

  describe "#create_pixel" do
    subject do
      client.create_pixel(
        graph_id: graph_id,
        date:     date,
        quantity: quantity,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:date)     { Date.parse("2018-09-15") }
    let(:quantity) { 5 }

    before do
      json_body = <<~JSON.strip
        {"date":"20180915","quantity":"5"}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs/test-graph").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
  end
end
