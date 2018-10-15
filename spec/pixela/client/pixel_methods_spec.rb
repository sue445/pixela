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
        to_return(status: 200, body: fixture("get_pixel.json"))
    end

    its(:quantity) { should eq 5 }
  end

  describe "#update_pixel" do
    subject do
      client.update_pixel(
        graph_id: graph_id,
        date:     date,
        quantity: quantity,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:date)     { Date.parse("2018-09-15") }
    let(:quantity) { 7 }

    before do
      json_body = <<~JSON.strip
        {"quantity":"7"}
      JSON

      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph/20180915").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
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
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
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
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
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
        to_return(status: 200, body: fixture("success.json"))
    end

    its(:message)   { should eq "Success." }
    its(:isSuccess) { should eq true }
  end
end
