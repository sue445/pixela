module FixtureUtil
  def fixture(file)
    spec_dir.join("support", "fixtures", file).read
  end
end
