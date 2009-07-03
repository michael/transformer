# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{transformer}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["michael"]
  s.date = %q{2009-07-03}
  s.email = %q{ma@zive.at}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc",
     "README.textile"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "README.textile",
     "Rakefile",
     "VERSION",
     "lib/transformer.rb",
     "test/templates/album_transformer.haml",
     "test/test_helper.rb",
     "test/transformer_test.rb",
     "test/transformers/album_transformer.rb",
     "test/transformers/track_transformer.rb"
  ]
  s.homepage = %q{http://github.com/michael/transformer}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{turn your ruby objects into a html representation using transformers}
  s.test_files = [
    "test/test_helper.rb",
     "test/transformer_test.rb",
     "test/transformers/album_transformer.rb",
     "test/transformers/track_transformer.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<haml>, [">= 0"])
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
    else
      s.add_dependency(%q<haml>, [">= 0"])
      s.add_dependency(%q<extlib>, [">= 0"])
    end
  else
    s.add_dependency(%q<haml>, [">= 0"])
    s.add_dependency(%q<extlib>, [">= 0"])
  end
end
