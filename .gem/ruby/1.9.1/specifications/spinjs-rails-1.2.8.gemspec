# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "spinjs-rails"
  s.version = "1.2.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dmytrii Nagirniak"]
  s.date = "2013-02-10"
  s.description = "An animated CSS3 loading spinner with VML fallback for IE."
  s.email = ["dnagir@gmail.com"]
  s.homepage = "https://github.com/dnagir/spinjs-rails"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "spinjs-rails"
  s.rubygems_version = "1.8.24"
  s.summary = "A spinning activity indicator for Rails 3 with no images and CSS."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.1"])
    else
      s.add_dependency(%q<rails>, [">= 3.1"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.1"])
  end
end
