RSpec.describe Pixela::Client::PixelMethods do
  include_context :api_variables

  describe "#create_pixel" do
    subject do
      client.create_pixel(
        graph_id:      graph_id,
        date:          date,
        quantity:      quantity,
        optional_data: optional_data,
      )
    end

    let(:graph_id)      { "test-graph" }
    let(:date)          { Date.parse("2018-09-15") }
    let(:quantity)      { 5 }
    let(:optional_data) { { key: "value" } }

    before do
      json_body = <<~JSON.strip
        {"date":"20180915","quantity":"5","optionalData":"{\\"key\\":\\"value\\"}"}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs/test-graph").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_pixel" do
    subject do
      client.get_pixel(
        graph_id: graph_id,
        date:     date,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:date)     { Date.parse("2018-09-15") }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/20180915").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_pixel.json"))
    end

    its(:quantity)      { should eq 5 }
    its(:optional_data) { should eq({"key" => "value"}) }
    it { should_not be_has_key(:optionalData) }
  end

  describe "#update_pixel" do
    subject do
      client.update_pixel(
        graph_id:      graph_id,
        date:          date,
        quantity:      quantity,
        optional_data: optional_data,
      )
    end

    let(:graph_id)      { "test-graph" }
    let(:date)          { Date.parse("2018-09-15") }
    let(:quantity)      { 7 }
    let(:optional_data) { { key: "value" } }

    before do
      json_body = <<~JSON.strip
        {"quantity":"7","optionalData":"{\\"key\\":\\"value\\"}"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/20180915").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#delete_pixel" do
    subject do
      client.delete_pixel(
        graph_id: graph_id,
        date:     date,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:date)     { Date.parse("2018-09-15") }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know/graphs/test-graph/20180915").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#increment_pixel" do
    subject do
      client.increment_pixel(
        graph_id: graph_id,
      )
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/increment").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#decrement_pixel" do
    subject do
      client.decrement_pixel(
        graph_id: graph_id,
      )
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/decrement").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#add_pixel" do
    subject do
      client.add_pixel(
        graph_id: graph_id,
        quantity: quantity,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:quantity) { 1 }

    before do
      json_body = <<~JSON.strip
        {"quantity":"1"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/add").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
