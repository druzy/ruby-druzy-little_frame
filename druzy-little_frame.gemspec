# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'druzy/little_frame/version'

Gem::Specification.new do |spec|
  spec.name          = "druzy-little_frame"
  spec.version       = Druzy::LittleFrame::VERSION
  spec.authors       = ["Jonathan Le Greneur"]
  spec.email         = ["jonathan.legreneur@free.fr"]

  spec.summary       = %q{some little frame like filechooser}
  spec.homepage      = "https://github.com/druzy/ruby-druzy-little_frame"
  spec.license       = "MIT"

  spec.files         = Dir['lib/druzy/*.rb']+Dir['lib/druzy/little_frame/*.rb']
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'druzy-mvc', '>= 1.0.3'
  spec.add_runtime_dependency 'gtk3', '>= 2.2.5'

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end
