RSpec.describe Pixela::Graph do
  include_context :api_variables

  let(:graph)    { client.graph(graph_id) }
  let(:graph_id) { "test-graph" }

  describe "#create" do
    subject do
      graph.create(
        name:                  name,
        unit:                  unit,
        type:                  type,
        color:                 color,
        timezone:              timezone,
        self_sufficient:       self_sufficient,
        is_secret:             is_secret,
        publish_optional_data: publish_optional_data,
      )
    end

    let(:name)                  { "graph-name" }
    let(:unit)                  { "commit" }
    let(:type)                  { "int" }
    let(:color)                 { "shibafu" }
    let(:timezone)              { "Asia/Tokyo" }
    let(:self_sufficient)       { "increment" }
    let(:is_secret)             { true }
    let(:publish_optional_data) { true }

    before do
      allow(client).to receive(:create_graph)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_graph).with(graph_id: graph_id, name: name, unit: unit, type: type, color: color,
                                                          timezone: timezone, self_sufficient: self_sufficient, is_secret: is_secret,
                                                          publish_optional_data: publish_optional_data)
    end
  end

  describe "#url" do
    subject { graph.url(date: date, mode: mode, appearance: appearance, less_than: less_than, greater_than: greater_than) }

    let(:date) { Date.parse("2018-03-31") }
    let(:mode) { "short" }
    let(:appearance) { "dark" }
    let(:less_than) { "10" }
    let(:greater_than) { "20" }

    it { should eq "https://pixe.la/v1/users/a-know/graphs/test-graph?appearance=dark&date=20180331&greaterThan=20&lessThan=10&mode=short" }
  end

  describe "#update" do
    subject do
      graph.update(
        name:                  name,
        unit:                  unit,
        color:                 color,
        timezone:              timezone,
        purge_cache_urls:      purge_cache_urls,
        self_sufficient:       self_sufficient,
        is_secret:             is_secret,
        publish_optional_data: publish_optional_data,
      )
    end

    let(:name)                  { "graph-name" }
    let(:unit)                  { "commit" }
    let(:color)                 { "shibafu" }
    let(:timezone)              { "Asia/Tokyo" }
    let(:purge_cache_urls)      { ["https://camo.githubusercontent.com/xxx/xxxx"] }
    let(:self_sufficient)       { "increment" }
    let(:is_secret)             { true }
    let(:publish_optional_data) { true }

    before do
      allow(client).to receive(:update_graph)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_graph).with(graph_id: graph_id, name: name, unit: unit, color: color,
                                                          timezone: timezone, purge_cache_urls: purge_cache_urls,
                                                          self_sufficient: self_sufficient, is_secret: is_secret,
                                                          publish_optional_data: publish_optional_data)
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

  describe "#add" do
    subject { graph.add(quantity: quantity) }

    before do
      allow(client).to receive(:add_pixel)
    end

    let(:quantity) { "1" }

    it "successful" do
      subject
      expect(client).to have_received(:add_pixel).with(graph_id: graph_id, quantity: quantity)
    end
  end

  describe "#subtract" do
    subject { graph.subtract(quantity: quantity) }

    before do
      allow(client).to receive(:subtract_pixel)
    end

    let(:quantity) { "1" }

    it "successful" do
      subject
      expect(client).to have_received(:subtract_pixel).with(graph_id: graph_id, quantity: quantity)
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

  describe "#pixels" do
    subject { graph.pixels(from: from, to: to) }

    let(:from) { Date.new(2018, 1, 1) }
    let(:to)   { Date.new(2018, 12, 31) }

    before do
      allow(client).to receive(:get_pixels)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_pixels).with(graph_id: graph_id, from: from, to: to)
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

  describe "#run_stopwatch" do
    subject { graph.run_stopwatch }

    before do
      allow(client).to receive(:run_stopwatch)
    end

    it "successful" do
      subject
      expect(client).to have_received(:run_stopwatch).with(graph_id: graph_id)
    end
  end

  describe "#def" do
    subject { graph.def }

    before do
      allow(client).to receive(:get_graph_def)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_graph_def).with(graph_id: graph_id)
    end
  end

  describe "#latest" do
    subject { graph.latest }

    before do
      allow(client).to receive(:get_graph_latest)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_graph_latest).with(graph_id: graph_id)
    end
  end
end
