RSpec.describe Pixela::Graph do
  include_context :api_variables

  let(:graph)    { client.graph(graph_id) }
  let(:graph_id) { "test-graph" }

  describe "#create" do
    subject do
      graph.create(
        name:  name,
        unit:  unit,
        type:  type,
        color: color,
      )
    end

    let(:name)  { "graph-name" }
    let(:unit)  { "commit" }
    let(:type)  { "int" }
    let(:color) { "shibafu" }

    before do
      allow(client).to receive(:create_graph).with(graph_id: graph_id, name: name, unit: unit, type: type, color: color)
    end

    it "successful" do
      subject
    end
  end

  describe "#url" do
    subject { graph.url(date: date) }

    let(:date) { Date.parse("2018-03-31") }

    it { should eq "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331" }
  end

  describe "#update" do
    subject do
      graph.update(
        name:  name,
        unit:  unit,
        color: color,
        purge_cache_urls: purge_cache_urls,
      )
    end

    let(:name)  { "graph-name" }
    let(:unit)  { "commit" }
    let(:color) { "shibafu" }
    let(:purge_cache_urls) { ["https://camo.githubusercontent.com/xxx/xxxx"] }

    before do
      allow(client).to receive(:update_graph).with(graph_id: graph_id, name: name, unit: unit, color: color, purge_cache_urls: purge_cache_urls)
    end

    it "successful" do
      subject
    end
  end

  describe "#increment" do
    subject { graph.increment }

    before do
      allow(client).to receive(:increment_pixel).with(graph_id: graph_id)
    end

    it "successful" do
      subject
    end
  end

  describe "#decrement" do
    subject { graph.decrement }

    before do
      allow(client).to receive(:decrement_pixel).with(graph_id: graph_id)
    end

    it "successful" do
      subject
    end
  end
end
