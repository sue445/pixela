RSpec.describe Pixela::Pixel do
  include_context :api_variables

  let(:pixel)    { client.graph(graph_id).pixel(date) }
  let(:graph_id) { "test-graph" }
  let(:date)     { Date.parse("2018-09-15") }
  let(:optional_data) { { key: "value" } }

  describe "#create" do
    subject { pixel.create(quantity: quantity, optional_data: optional_data) }

    let(:quantity) { 5 }

    before do
      allow(client).to receive(:create_pixel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_pixel).with(graph_id: graph_id, date: date, quantity: quantity, optional_data: optional_data)
    end
  end

  describe "#create_multi" do
    subject { pixel.create_multi(pixels: pixels) }

    let(:pixels) do
      [
        {
          date: Date.parse("2018-09-14"),
          quantity: 6,
        },
        {
          date: Date.parse("2018-09-15"),
          quantity: 5,
          optional_data: { key: "value" },
        },
        {
          date: Date.parse("2018-09-16"),
          quantity: 4,
        },
      ]
    end

    before do
      allow(client).to receive(:create_pixels)
    end

    it "successful" do
      subject
      expect(client).to have_received(:create_pixels).with(graph_id: graph_id, pixels: pixels)
    end
  end

  describe "#get" do
    subject { pixel.get }

    before do
      allow(client).to receive(:get_pixel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:get_pixel).with(graph_id: graph_id, date: date)
    end
  end

  describe "#update" do
    subject { pixel.update(quantity: quantity, optional_data: optional_data) }

    let(:quantity) { 7 }

    before do
      allow(client).to receive(:update_pixel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:update_pixel).with(graph_id: graph_id, date: date, quantity: quantity, optional_data: optional_data)
    end
  end

  describe "#delete" do
    subject { pixel.delete }

    before do
      allow(client).to receive(:delete_pixel)
    end

    it "successful" do
      subject
      expect(client).to have_received(:delete_pixel).with(graph_id: graph_id, date: date)
    end
  end
end
