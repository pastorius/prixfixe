# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "prixfixe/version"

Gem::Specification.new do |s|
  s.name        = "prixfixe"
  s.version     = PrixFixe::VERSION
  s.authors     = ["Evan Smith"]
  s.email       = ["pastorius@gmail.com"]
  # s.homepage    = ""
  s.summary     = %q{Configurable billing.}
  # s.description = %q{Configurable billing.}

  # s.rubyforge_project = "prixfixe"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  s.add_development_dependency "rake"
  s.add_development_dependency "yard"
  s.add_development_dependency "rcov"
  s.add_development_dependency "minitest"
  # s.add_runtime_dependency "rest-client"
end
