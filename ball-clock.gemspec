# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','ball-clock','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'ball-clock'
  s.version = BallClock::VERSION
  s.author = 'Brian Broderick'
  s.email = 'brianbroderick19@gmail.com'
  s.homepage = 'http://www.thelensflare.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'This was created to show off some coding skills.'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','ball-clock.rdoc']
  s.rdoc_options << '--title' << 'ball-clock' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'ball-clock'
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')
  s.add_runtime_dependency('gli','2.13.2')
end
