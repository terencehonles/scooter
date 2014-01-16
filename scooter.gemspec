Gem::Specification.new do |s|
  s.author = 'Terence Honles'
  s.bindir = 'bin'
  s.email = %q{terence@honles.com}
  s.files = Dir.glob('{bin,contrib,lib}/**/*').to_a
  s.has_rdoc = false
  s.homepage = 'https://github.com/terencehonles/scooter'
  s.name = 'scooter'
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 1.8.7'
  s.required_rubygems_version = '>= 1.3.7'
  s.summary = %q{Command-line remote environment assistant}
  s.version = '0.5.0'
end
