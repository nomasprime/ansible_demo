# -*- encoding: utf-8 -*-
# stub: infrataster 0.3.2 ruby lib

Gem::Specification.new do |s|
  s.name = "infrataster"
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Ryota Arai"]
  s.date = "2015-11-19"
  s.email = ["ryota.arai@gmail.com"]
  s.executables = ["infrataster"]
  s.files = ["bin/infrataster"]
  s.homepage = "https://github.com/ryotarai/infrataster"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5.1"
  s.summary = "Infrastructure Behavior Testing Framework"

  s.installed_by_version = "2.4.5.1" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rspec>, ["< 4.0", ">= 2.0"])
      s.add_runtime_dependency(%q<net-ssh>, [">= 0"])
      s.add_runtime_dependency(%q<net-ssh-gateway>, [">= 0"])
      s.add_runtime_dependency(%q<capybara>, [">= 0"])
      s.add_runtime_dependency(%q<poltergeist>, [">= 0"])
      s.add_runtime_dependency(%q<faraday>, [">= 0"])
      s.add_runtime_dependency(%q<faraday_middleware>, [">= 0.10.0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<itamae>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["< 4.0", ">= 2.0"])
      s.add_dependency(%q<net-ssh>, [">= 0"])
      s.add_dependency(%q<net-ssh-gateway>, [">= 0"])
      s.add_dependency(%q<capybara>, [">= 0"])
      s.add_dependency(%q<poltergeist>, [">= 0"])
      s.add_dependency(%q<faraday>, [">= 0"])
      s.add_dependency(%q<faraday_middleware>, [">= 0.10.0"])
      s.add_dependency(%q<thor>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<itamae>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["< 4.0", ">= 2.0"])
    s.add_dependency(%q<net-ssh>, [">= 0"])
    s.add_dependency(%q<net-ssh-gateway>, [">= 0"])
    s.add_dependency(%q<capybara>, [">= 0"])
    s.add_dependency(%q<poltergeist>, [">= 0"])
    s.add_dependency(%q<faraday>, [">= 0"])
    s.add_dependency(%q<faraday_middleware>, [">= 0.10.0"])
    s.add_dependency(%q<thor>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<itamae>, [">= 0"])
  end
end
