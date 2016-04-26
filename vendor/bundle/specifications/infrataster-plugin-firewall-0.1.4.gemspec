# -*- encoding: utf-8 -*-
# stub: infrataster-plugin-firewall 0.1.4 ruby lib

Gem::Specification.new do |s|
  s.name = "infrataster-plugin-firewall"
  s.version = "0.1.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Hiroshi Ota"]
  s.date = "2015-06-24"
  s.description = "Firewall plugin for Infrataster."
  s.email = ["otahi.pub@gmail.com"]
  s.homepage = "https://github.com/otahi/infrataster-plugin-firewall"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Firewall plugin for Infrataster."

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<infrataster>, ["~> 0.3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.7"])
      s.add_development_dependency(%q<rake>, ["~> 10.0"])
      s.add_development_dependency(%q<rspec>, ["~> 3.0"])
      s.add_development_dependency(%q<rubocop>, ["= 0.28.0"])
      s.add_development_dependency(%q<coveralls>, ["~> 0.7"])
      s.add_development_dependency(%q<byebug>, [">= 0"])
    else
      s.add_dependency(%q<infrataster>, ["~> 0.3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.7"])
      s.add_dependency(%q<rake>, ["~> 10.0"])
      s.add_dependency(%q<rspec>, ["~> 3.0"])
      s.add_dependency(%q<rubocop>, ["= 0.28.0"])
      s.add_dependency(%q<coveralls>, ["~> 0.7"])
      s.add_dependency(%q<byebug>, [">= 0"])
    end
  else
    s.add_dependency(%q<infrataster>, ["~> 0.3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.7"])
    s.add_dependency(%q<rake>, ["~> 10.0"])
    s.add_dependency(%q<rspec>, ["~> 3.0"])
    s.add_dependency(%q<rubocop>, ["= 0.28.0"])
    s.add_dependency(%q<coveralls>, ["~> 0.7"])
    s.add_dependency(%q<byebug>, [">= 0"])
  end
end
