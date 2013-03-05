# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "simple_roles"
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["stanislaw"]
  s.date = "2013-02-22"
  s.description = "Simple Role System for Rails Apps"
  s.email = "s.pankevich@gmail.com"
  s.extra_rdoc_files = ["README.md"]
  s.files = ["README.md"]
  s.homepage = "http://github.com/stanislaw/simple_roles"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Rails Engine providing Role System for Rails apps"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 0"])
      s.add_development_dependency(%q<rake-kit>, [">= 0"])
      s.add_development_dependency(%q<devise>, [">= 0"])
      s.add_development_dependency(%q<mysql2>, [">= 0"])
      s.add_development_dependency(%q<require_all>, [">= 0"])
      s.add_development_dependency(%q<sugar-high>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<cutter>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
      s.add_development_dependency(%q<factory_girl>, ["= 2.6.4"])
    else
      s.add_dependency(%q<activerecord>, [">= 0"])
      s.add_dependency(%q<rake-kit>, [">= 0"])
      s.add_dependency(%q<devise>, [">= 0"])
      s.add_dependency(%q<mysql2>, [">= 0"])
      s.add_dependency(%q<require_all>, [">= 0"])
      s.add_dependency(%q<sugar-high>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<cutter>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
      s.add_dependency(%q<factory_girl>, ["= 2.6.4"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 0"])
    s.add_dependency(%q<rake-kit>, [">= 0"])
    s.add_dependency(%q<devise>, [">= 0"])
    s.add_dependency(%q<mysql2>, [">= 0"])
    s.add_dependency(%q<require_all>, [">= 0"])
    s.add_dependency(%q<sugar-high>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<cutter>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
    s.add_dependency(%q<factory_girl>, ["= 2.6.4"])
  end
end
