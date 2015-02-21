# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "touch_up"
  spec.version       = `cat VERSION`
  spec.authors       = ["da99"]
  spec.email         = ["i-hate-spam-1234567@mailinator.com"]
  spec.summary       = %q{My alternative to markdown for morons.}
  spec.description   = %q{
    Provides italics, strikes, bold, and links.
    Nothing else.
  }
  spec.homepage      = "https://github.com/da99/touch_up"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |file|
    file.index('bin/') == 0 && file != "bin/#{File.basename Dir.pwd}"
  }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.2.0'

  spec.add_development_dependency "pry"           , "~> 0.9"
  spec.add_development_dependency "bundler"       , "~> 1.5"
  spec.add_development_dependency "bacon"         , "~> 1.0"
  spec.add_development_dependency "Bacon_Colored" , "~> 0.1"
end
