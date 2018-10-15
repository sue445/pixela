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

  describe "#get_graphs" do
    subject { client.get_graphs }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("get_graphs.json"))
    end

    its(:count) { should eq 1 }
  end

  describe "#update_graph" do
    subject do
      client.update_graph(
        id:    id,
        name:  name,
        unit:  unit,
        color: color,
      )
    end

    let(:id)    { "test-graph" }
    let(:name)  { "graph-name" }
    let(:unit)  { "commit" }
    let(:color) { "shibafu" }

    before do
      json_body = <<~JSON.strip
        {"name":"graph-name","unit":"commit","color":"shibafu"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("put_graphs.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
  end
end
