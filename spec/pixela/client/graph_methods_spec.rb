RSpec.describe Pixela::Client::GraphMethods do
  include_context :api_variables

  describe "#create_graph" do
    subject do
      client.create_graph(
        graph_id: graph_id,
        name:     name,
        unit:     unit,
        type:     type,
        color:    color,
        timezone: timezone,
        self_sufficient: self_sufficient,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:name)     { "graph-name" }
    let(:unit)     { "commit" }
    let(:type)     { "int" }
    let(:color)    { "shibafu" }
    let(:timezone) { "Asia/Tokyo" }
    let(:self_sufficient) { "increment" }

    before do
      json_body = <<~JSON.strip
        {"id":"test-graph","name":"graph-name","unit":"commit","type":"int","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment"}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_graphs" do
    subject(:graphs) { client.get_graphs }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("get_graphs.json"))
    end

    its(:count) { should eq 1 }

    describe "[0]" do
      subject { graphs[0] }

      its(:id)             { should eq "test-graph" }
      its(:name)           { should eq "graph-name" }
      its(:unit)           { should eq "commit" }
      its(:type)           { should eq "int" }
      its(:color)          { should eq "shibafu" }
      its(:purgeCacheURLs) { should eq ["https://camo.githubusercontent.com/xxx/xxxx"] }
    end
  end

  describe "#graph_url" do
    subject { client.graph_url(graph_id: graph_id, date: date, mode: mode) }

    using RSpec::Parameterized::TableSyntax

    let(:graph_id) { "test-graph" }

    where(:date, :mode, :expected_url) do
      nil                               | nil     | "https://pixe.la/v1/users/a-know/graphs/test-graph"
      Date.parse("2018-03-31")          | nil     | "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331"
      Time.parse("2018-03-31 11:22:33") | nil     | "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331"
      nil                               | "short" | "https://pixe.la/v1/users/a-know/graphs/test-graph?mode=short"
      Date.parse("2018-03-31")          | "short" | "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331&mode=short"
    end

    with_them do
      it { should eq expected_url }
    end
  end

  describe "#update_graph" do
    subject do
      client.update_graph(
        graph_id:         graph_id,
        name:             name,
        unit:             unit,
        color:            color,
        timezone:         timezone,
        purge_cache_urls: purge_cache_urls,
        self_sufficient:  self_sufficient,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:self_sufficient) { "increment" }

    before do
      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    context "with optional args" do
      let(:name)     { "graph-name" }
      let(:unit)     { "commit" }
      let(:color)    { "shibafu" }
      let(:timezone) { "Asia/Tokyo" }

      context "without purge_cache_urls" do
        let(:purge_cache_urls) { nil }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment"}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is String" do
        let(:purge_cache_urls) { "https://camo.githubusercontent.com/xxx/xxxx" }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","purgeCacheURLs":["https://camo.githubusercontent.com/xxx/xxxx"]}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is Array" do
        let(:purge_cache_urls) { ["https://camo.githubusercontent.com/xxx/xxxx"] }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","purgeCacheURLs":["https://camo.githubusercontent.com/xxx/xxxx"]}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is empty Array" do
        let(:purge_cache_urls) { [] }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","purgeCacheURLs":[]}
          JSON
        end

        it_behaves_like :success
      end
    end

    context "without optional args" do
      let(:name)     { nil }
      let(:unit)     { nil }
      let(:color)    { nil }
      let(:timezone) { nil }
      let(:self_sufficient) { nil }

      context "purge_cache_urls is String" do
        let(:purge_cache_urls) { "https://camo.githubusercontent.com/xxx/xxxx" }

        let(:json_body) do
          <<~JSON.strip
            {"purgeCacheURLs":["https://camo.githubusercontent.com/xxx/xxxx"]}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is Array" do
        let(:purge_cache_urls) { ["https://camo.githubusercontent.com/xxx/xxxx"] }

        let(:json_body) do
          <<~JSON.strip
            {"purgeCacheURLs":["https://camo.githubusercontent.com/xxx/xxxx"]}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is empty Array" do
        let(:purge_cache_urls) { [] }

        let(:json_body) do
          <<~JSON.strip
            {"purgeCacheURLs":[]}
          JSON
        end

        it_behaves_like :success
      end
    end
  end

  describe "#delete_graph" do
    subject do
      client.delete_graph(graph_id)
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:delete, "https://pixe.la/v1/users/a-know/graphs/test-graph").
        with(headers: user_token_headers).
        to_return(status: 200, body: fixture("success.json"))
    end

    it_behaves_like :success
  end
end
