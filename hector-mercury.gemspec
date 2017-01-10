spec = Gem::Specification.new do |s|
  s.name = 'hector-mercury'
  s.version = '1.0.1'
  s.platform = Gem::Platform::RUBY
  s.authors = ['Ross Paffett']
  s.email = ['ross@rosspaffett.com']
  s.homepage = 'https://github.com/blolol/hector-mercury'
  s.summary = 'Deliver Hector messages via Amazon SQS'
  s.description = 'A Hector service that listens for chat messages on an Amazon SQS queue.'
  s.files = Dir['lib/**/*.rb']
  s.require_path = 'lib'

  s.add_dependency 'activesupport', '~> 5.0.1'
  s.add_dependency 'aws-sdk', '>= 1.52.0', '< 2'
  s.add_dependency 'hector', '~> 1.0.9'
end
