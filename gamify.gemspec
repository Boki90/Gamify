# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "gamify/version"

Gem::Specification.new do |s|
  s.name        = "gamify"
  s.version     = Gamify::VERSION
  s.authors     = ["Ian Ulery"]
  s.email       = ["iulery@ucla.edu"]
  s.homepage    = ""
  s.summary     = %q{Adds support for common gamification features such as points, levels, and achievements.}
  s.description = %q{Adds support for common gamification features such as points, levels, and achievements.}

  s.rubyforge_project = "gamify"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rspec"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "mocha"

  # s.add_runtime_dependency "rest-client"
end
