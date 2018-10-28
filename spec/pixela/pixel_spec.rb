RSpec.describe Pixela::Pixel do
  include_context :api_variables

  let(:pixel)    { client.graph(graph_id).pixel(date) }
  let(:graph_id) { "test-graph" }
  let(:date)     { Date.parse("2018-09-15") }

  describe "#create" do
    subject { pixel.create(quantity: quantity) }

    let(:quantity) { 5 }

    before do
      allow(client).to receive(:create_pixel).with(graph_id: graph_id, date: date, quantity: quantity)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_pixel).with(graph_id: graph_id, date: date, quantity: quantity)
    end
  end

  describe "#get" do
    subject { pixel.get }

    before do
      allow(client).to receive(:get_pixel).with(graph_id: graph_id, date: date)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_pixel).with(graph_id: graph_id, date: date)
    end
  end

  describe "#update" do
    subject { pixel.update(quantity: quantity) }

    let(:quantity) { 7 }

    before do
      allow(client).to receive(:update_pixel).with(graph_id: graph_id, date: date, quantity: quantity)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_pixel).with(graph_id: graph_id, date: date, quantity: quantity)
    end
  end

  describe "#delete" do
    subject { pixel.delete }

    before do
      allow(client).to receive(:delete_pixel).with(graph_id: graph_id, date: date)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_pixel).with(graph_id: graph_id, date: date)
    end
  end
end
