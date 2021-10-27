
require_relative "lib/domesticate_monkeys/version"

Gem::Specification.new do |spec|
  
  spec.name        = "domesticate_monkeys"
  spec.version     = DomesticateMonkeys::VERSION
  spec.license     = "MIT"

  spec.authors     = ["Jurriaan Schrofer"]
  spec.email       = ["jschrofer@gmail.com"]
  
  spec.summary     = "Monkey patches make your application great yet dangerous, therefore you ought to domesticate them!"
  spec.description = spec.summary

  spec.homepage                    = "https://github.com/jurriaanschrofer/domesticate_monkeys"
  spec.metadata["homepage_uri"]    = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"]   = spec.homepage

  spec.files = Dir[
    "lib/**/*",
    "bin/*",
    "MIT-LICENSE", 
    "Rakefile", 
    "README.md",
    "Gemfile",
    "Gemfile.lock"
  ]

  spec.bindir       = 'bin'
  spec.executables << 'domesticate_monkeys'

  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  

end