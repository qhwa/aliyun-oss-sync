# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','aosss','version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'aliyun-oss-sync'
  s.version = Aosss::VERSION
  s.author = 'qhwa'
  s.email = 'qhwa@163.com'
  s.homepage = 'http://q.pnq.cc'
  s.platform = Gem::Platform::RUBY
  s.summary = 'Sync script for aliyun OSS'
  s.files = `git ls-files`.split("
")
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.md','aosss.rdoc']
  s.rdoc_options << '--title' << 'aosss' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'aliyun-oss-sync'


  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('aruba')

  s.add_runtime_dependency('gli','2.9.0')
  s.add_runtime_dependency('aliyun-sdk')
  s.add_runtime_dependency('listen')
  s.add_runtime_dependency('colored')
  s.add_runtime_dependency('mime-types')
end
