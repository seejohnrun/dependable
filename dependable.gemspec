require 'lib/dependable/version'

spec = Gem::Specification.new do |s|
  
  s.name = 'dependable'  
  s.author = 'John Crepezzi'
  s.add_development_dependency('rspec')
  s.description = 'dependable is an easy way to calcualte dependencies'
  s.email = 'john@crepezzi.com'
  s.files = Dir['lib/**/*.rb']
  s.has_rdoc = true
  s.homepage = 'http://github.com/seejohnrun/dependable/'
  s.platform = Gem::Platform::RUBY
  s.require_paths = ['lib']
  s.summary = 'Dependable dependency calculations'
  s.test_files = Dir.glob('spec/*.rb')
  s.version = Dependable::VERSION
  s.rubyforge_project = 'dependable'

end
