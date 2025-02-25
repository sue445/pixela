RSpec.describe Pixela::Client::GraphMethods do
  include_context :api_variables

  describe "#create_graph" do
    subject do
      client.create_graph(
        graph_id:              graph_id,
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

    let(:graph_id)              { "test-graph" }
    let(:name)                  { "graph-name" }
    let(:unit)                  { "commit" }
    let(:type)                  { "int" }
    let(:color)                 { "shibafu" }
    let(:timezone)              { "Asia/Tokyo" }
    let(:self_sufficient)       { "increment" }
    let(:is_secret)             { true }
    let(:publish_optional_data) { true }

    before do
      json_body = <<~JSON.strip
        {"id":"test-graph","name":"graph-name","unit":"commit","type":"int","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","isSecret":true,"publishOptionalData":true}
      JSON

      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_graphs" do
    subject(:graphs) { client.get_graphs }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_graphs.json"))
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
    subject { client.graph_url(graph_id: graph_id, date: date, mode: mode, appearance: appearance, less_than: less_than, greater_than: greater_than) }

    using RSpec::Parameterized::TableSyntax

    let(:graph_id) { "test-graph" }

    where(:date, :mode, :appearance, :less_than, :greater_than, :expected_url) do
      nil                               | nil     | nil    | nil | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph"
      Date.parse("2018-03-31")          | nil     | nil    | nil | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331"
      Time.parse("2018-03-31 11:22:33") | nil     | nil    | nil | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331"
      nil                               | "short" | nil    | nil | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph?mode=short"
      Date.parse("2018-03-31")          | "short" | nil    | nil | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph?date=20180331&mode=short"
      nil                               | nil     | "dark" | nil | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph?appearance=dark"
      nil                               | nil     | nil    | 10  | nil | "https://pixe.la/v1/users/a-know/graphs/test-graph?lessThan=10"
      nil                               | nil     | nil    | nil | 20  | "https://pixe.la/v1/users/a-know/graphs/test-graph?greaterThan=20"
    end

    with_them do
      it { should eq expected_url }
    end
  end

  describe "#graphs_url" do
    subject { client.graphs_url }

    it { should eq "https://pixe.la/v1/users/a-know/graphs.html" }
  end

  describe "#update_graph" do
    subject do
      client.update_graph(
        graph_id:              graph_id,
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

    let(:graph_id)              { "test-graph" }
    let(:self_sufficient)       { "increment" }
    let(:is_secret)             { true }
    let(:publish_optional_data) { true }

    before do
      stub_request(:put, "https://pixe.la/v1/users/a-know/graphs/test-graph").
        with(body: json_body, headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
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
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","isSecret":true,"publishOptionalData":true}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is String" do
        let(:purge_cache_urls) { "https://camo.githubusercontent.com/xxx/xxxx" }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","isSecret":true,"publishOptionalData":true,"purgeCacheURLs":["https://camo.githubusercontent.com/xxx/xxxx"]}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is Array" do
        let(:purge_cache_urls) { ["https://camo.githubusercontent.com/xxx/xxxx"] }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","isSecret":true,"publishOptionalData":true,"purgeCacheURLs":["https://camo.githubusercontent.com/xxx/xxxx"]}
          JSON
        end

        it_behaves_like :success
      end

      context "purge_cache_urls is empty Array" do
        let(:purge_cache_urls) { [] }

        let(:json_body) do
          <<~JSON.strip
            {"name":"graph-name","unit":"commit","color":"shibafu","timezone":"Asia/Tokyo","selfSufficient":"increment","isSecret":true,"publishOptionalData":true,"purgeCacheURLs":[]}
          JSON
        end

        it_behaves_like :success
      end
    end

    context "without optional args" do
      let(:name)                  { nil }
      let(:unit)                  { nil }
      let(:color)                 { nil }
      let(:timezone)              { nil }
      let(:self_sufficient)       { nil }
      let(:is_secret)             { nil }
      let(:publish_optional_data) { nil }

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
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_pixel_dates" do
    subject do
      client.get_pixel_dates(
        graph_id: graph_id,
        from:     from,
        to:       to,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:from)     { Date.new(2018, 1, 1) }
    let(:to)       { Date.new(2018, 12, 31) }
    let(:expected) do
      [
        Date.parse("20180101"),
        Date.parse("20180331"),
        Date.parse("20180402"),
        Date.parse("20180505"),
        Date.parse("20181204"),
      ]
    end

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/pixels?from=20180101&to=20181231").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_pixel_dates.json"))
    end

    it { should eq expected }
  end

  describe "#get_pixels" do
    subject(:pixels) do
      client.get_pixels(
        graph_id: graph_id,
        from:     from,
        to:       to,
      )
    end

    let(:graph_id) { "test-graph" }
    let(:from)     { Date.new(2018, 1, 1) }
    let(:to)       { Date.new(2018, 12, 31) }
    let(:expected) do
      [
        {
          date: "20180101",
          quantity: "5",
        },
        {
          date: "20180505",
          quantity: "1",
          optionalData: '{"key":"value"}',
        },
        {
          date: "20181204",
          quantity: "8",
        },
      ]
    end

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/pixels?from=20180101&to=20181231&withBody=true").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_pixels_with_body.json"))
    end

    describe "[0]" do
      subject { pixels[0] }

      its(:date)     { should eq "20180101" }
      its(:quantity) { should eq "5" }
    end

    describe "[1]" do
      subject { pixels[1] }

      its(:date)         { should eq "20180505" }
      its(:quantity)     { should eq "1" }
      its(:optionalData) { should eq '{"key":"value"}' }
    end

    describe "[2]" do
      subject { pixels[2] }

      its(:date)     { should eq "20181204" }
      its(:quantity) { should eq "8" }
    end
  end

  describe "#get_graph_stats" do
    subject do
      client.get_graph_stats(graph_id: graph_id)
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/stats").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_graph_stats.json"))
    end

    its(:totalPixelsCount) { should eq 4 }
  end

  describe "#run_stopwatch" do
    subject do
      client.run_stopwatch(graph_id: graph_id)
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:post, "https://pixe.la/v1/users/a-know/graphs/test-graph/stopwatch").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("success.json"))
    end

    it_behaves_like :success
  end

  describe "#get_graph_def" do
    subject do
      client.get_graph_def(graph_id: graph_id)
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/graph-def").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_graph_def.json"))
    end

    its(:id)                  { should eq "test-graph" }
    its(:name)                { should eq "graph-name" }
    its(:unit)                { should eq "commit" }
    its(:type)                { should eq "int" }
    its(:color)               { should eq "shibafu" }
    its(:timezone)            { should eq "Asia/Tokyo" }
    its(:purgeCacheURLs)      { should eq ["https://camo.githubusercontent.com/xxx/xxxx"] }
    its(:selfSufficient)      { should eq "increment" }
    its(:isSecret)            { should eq false }
    its(:publishOptionalData) { should eq true }
  end

  describe "#get_graph_latest" do
    subject do
      client.get_graph_latest(graph_id: graph_id)
    end

    let(:graph_id) { "test-graph" }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/latest").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_graph_latest.json"))
    end

    its(:date)         { should eq "20240414" }
    its(:quantity)     { should eq "5" }
    its(:optionalData) { should eq '{"key":"value"}' }
  end

  describe "#get_graph_today" do
    subject do
      client.get_graph_today(graph_id: graph_id, return_empty: return_empty)
    end

    let(:graph_id) { "test-graph" }
    let(:return_empty) { true }

    before do
      stub_request(:get, "https://pixe.la/v1/users/a-know/graphs/test-graph/today?returnEmpty=true").
        with(headers: user_token_headers).
        to_return(status: 200, headers: response_headers, body: fixture("get_graph_today.json"))
    end

    its(:date)     { should eq "20240414" }
    its(:quantity) { should eq "0" }
  end
end
