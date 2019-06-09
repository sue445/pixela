RSpec.describe Pixela::Graph do
  include_context :api_variables

  let(:graph)    { client.graph(graph_id) }
  let(:graph_id) { "test-graph" }

  describe "#create" do
    subject do
      graph.create(
        name:            name,
        unit:            unit,
        type:            type,
        color:           color,
        timezone:        timezone,
        self_sufficient: self_sufficient,
        is_secret:             is_secret,
        publish_optional_data: publish_optional_data,
      )
    end

    let(:name)            { "graph-name" }
    let(:unit)            { "commit" }
    let(:type)            { "int" }
    let(:color)           { "shibafu" }
    let(:timezone)        { "Asia/Tokyo" }
    let(:self_sufficient) { "increment" }
    let(:is_secret)             { true }
    let(:publish_optional_data) { true }

    before do
      allow(client).to receive(:create_graph)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_graph).with(graph_id: graph_id, name: name, unit: unit, type: type, color: color, timezone: timezone, self_sufficient: self_sufficient, is_secret: is_secret, publish_optional_data: publish_optional_data)
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
        self_sufficient:  self_sufficient,
      )
    end

    let(:name)             { "graph-name" }
    let(:unit)             { "commit" }
    let(:color)            { "shibafu" }
    let(:timezone)         { "Asia/Tokyo" }
    let(:purge_cache_urls) { ["https://camo.githubusercontent.com/xxx/xxxx"] }
    let(:self_sufficient)  { "increment" }

    before do
      allow(client).to receive(:update_graph)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_graph).with(graph_id: graph_id, name: name, unit: unit, color: color, timezone: timezone, purge_cache_urls: purge_cache_urls, self_sufficient: self_sufficient)
    end
  end

  describe "#delete" do
    subject { graph.delete }

    before do
      allow(client).to receive(:delete_graph)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_graph).with(graph_id)
    end
  end

  describe "#increment" do
    subject { graph.increment }

    before do
      allow(client).to receive(:increment_pixel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:increment_pixel).with(graph_id: graph_id)
    end
  end

  describe "#decrement" do
    subject { graph.decrement }

    before do
      allow(client).to receive(:decrement_pixel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:decrement_pixel).with(graph_id: graph_id)
    end
  end

  describe "#pixel_dates" do
    subject { graph.pixel_dates(from: from, to: to) }

    let(:from) { Date.new(2018, 1, 1) }
    let(:to)   { Date.new(2018, 12, 31) }

    before do
      allow(client).to receive(:get_pixel_dates)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_pixel_dates).with(graph_id: graph_id, from: from, to: to)
    end
  end

  describe "#stats" do
    subject { graph.stats }

    before do
      allow(client).to receive(:get_graph_stats)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_graph_stats).with(graph_id: graph_id)
    end
  end
end
