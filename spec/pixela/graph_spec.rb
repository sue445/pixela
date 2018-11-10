RSpec.describe Pixela::Graph do
  include_context :api_variables

  let(:graph)    { client.graph(graph_id) }
  let(:graph_id) { "test-graph" }

  describe "#create" do
    subject do
      graph.create(
        name:     name,
        unit:     unit,
        type:     type,
        color:    color,
        timezone: timezone,
      )
    end

    let(:name)     { "graph-name" }
    let(:unit)     { "commit" }
    let(:type)     { "int" }
    let(:color)    { "shibafu" }
    let(:timezone) { "Asia/Tokyo" }

    before do
      allow(client).to receive(:create_graph).with(graph_id: graph_id, name: name, unit: unit, type: type, color: color, timezone: timezone)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_graph).with(graph_id: graph_id, name: name, unit: unit, type: type, color: color, timezone: timezone)
    end
  end

  describe "#url" do
    subject { graph.url(date: date, mode: mode) }

    let(:date) { Date.parse("2018-03-31") }
    let(:mode) { "short" }

    it { should eq "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331&mode=short" }
  end

  describe "#update" do
    subject do
      graph.update(
        name:             name,
        unit:             unit,
        color:            color,
        timezone:         timezone,
        purge_cache_urls: purge_cache_urls,
      )
    end

    let(:name)             { "graph-name" }
    let(:unit)             { "commit" }
    let(:color)            { "shibafu" }
    let(:timezone)         { "Asia/Tokyo" }
    let(:purge_cache_urls) { ["https://camo.githubusercontent.com/xxx/xxxx"] }

    before do
      allow(client).to receive(:update_graph).with(graph_id: graph_id, name: name, unit: unit, color: color, timezone: timezone, purge_cache_urls: purge_cache_urls)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_graph).with(graph_id: graph_id, name: name, unit: unit, color: color, timezone: timezone, purge_cache_urls: purge_cache_urls)
    end
  end

  describe "#delete" do
    subject { graph.delete }

    before do
      allow(client).to receive(:delete_graph).with(graph_id)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_graph).with(graph_id)
    end
  end

  describe "#increment" do
    subject { graph.increment }

    before do
      allow(client).to receive(:increment_pixel).with(graph_id: graph_id)
    end

    it "successful" do
      subject
      expect(client).to have_received(:increment_pixel).with(graph_id: graph_id)
    end
  end

  describe "#decrement" do
    subject { graph.decrement }

    before do
      allow(client).to receive(:decrement_pixel).with(graph_id: graph_id)
    end

    it "successful" do
      subject
      expect(client).to have_received(:decrement_pixel).with(graph_id: graph_id)
    end
  end
end
