# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "require_all"
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jarmo Pertman", "Tony Arcieri"]
  s.date = "2010-09-14"
  s.email = "jarmo.p@gmail.com"
  s.extra_rdoc_files = ["LICENSE", "README.textile", "CHANGES"]
  s.files = ["LICENSE", "README.textile", "CHANGES"]
  s.homepage = "http://github.com/jarmo/require_all"
  s.rdoc_options = ["--title", "require_all", "--main", "README.textile", "--line-numbers"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "A wonderfully simple way to load your code"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
