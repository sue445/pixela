shared_context :api_variables do
  let(:client)   {  Pixela::Client.new(username: username, token: token) }
  let(:username) { "a-know" }
  let(:token)    { "thisissecret" }

  let(:default_headers) do
    {
      "Accept" => "*/*",
      "Accept-Encoding" => "gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
      "Content-Type" => "application/json",
      "User-Agent" => "Pixela v#{Pixela::VERSION} (https://github.com/sue445/pixela)",
    }
  end
end
