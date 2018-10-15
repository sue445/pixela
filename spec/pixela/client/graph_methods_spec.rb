RSpec.describe Pixela::Client::GraphMethods do
  include_context :api_variables

  describe "#create_graph" do
    subject do
      client.create_graph(
        id:    id,
        name:  name,
        unit:  unit,
        type:  type,
        color: color,
      )
    end

    let(:id)    { "test-graph" }
    let(:name)  { "graph-name" }
    let(:unit)  { "commit" }
    let(:type)  { "int" }
    let(:color) { "shibafu" }

    before do
      json_body = <<~JSON.strip
        {"id":"test-graph","name":"graph-name","unit":"commit","type":"int","color":"shibafu"}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("post_graphs.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
  end
end
