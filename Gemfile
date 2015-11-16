source 'https://rubygems.org'

# Specify your gem's dependencies in markovian-tools.gemspec
gemspec

group :development, :test do
  gem "rubocop"
  gem "byebug", platform: :mri
  # If you're developing both gems, use the local version of Markovian
  if File.exist?("../markovian")
    gem "markovian", path: "../markovian"
  end
end

group :test do
  gem "rspec"
  gem "faker"
  gem "codeclimate-test-reporter"
end

