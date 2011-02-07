# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{shoulda-datamapper}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Colin Gemmell"]
  s.date = %q{2011-02-07}
  s.description = %q{shoulda matcher for DataMapper ORM}
  s.email = %q{pythonandchips@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "lib/shoulda-datamapper.rb",
    "lib/shoulda.rb",
    "lib/shoulda/datamapper.rb",
    "lib/shoulda/datamapper/assertions.rb",
    "lib/shoulda/datamapper/helpers.rb",
    "lib/shoulda/datamapper/macros.rb",
    "lib/shoulda/datamapper/matchers.rb",
    "lib/shoulda/datamapper/matchers/allow_value_matcher.rb",
    "lib/shoulda/datamapper/matchers/association_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_absence_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_acceptance_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_confirmation_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_format_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_length_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_numericality_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_presence_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validate_uniqueness_of_matcher.rb",
    "lib/shoulda/datamapper/matchers/validation_matcher.rb",
    "lib/shoulda/integrations/test_unit-datamapper.rb",
    "shoulda-datamapper.gemspec",
    "test/matchers/datamapper/allow_value_matcher_test.rb",
    "test/matchers/datamapper/association_matcher_test.rb",
    "test/matchers/datamapper/validate_absence_of_matcher_test.rb",
    "test/matchers/datamapper/validate_acceptance_of_matcher_test.rb",
    "test/matchers/datamapper/validate_confirmation_of_matcher_test.rb",
    "test/matchers/datamapper/validate_format_of_matcher_test.rb",
    "test/matchers/datamapper/validate_length_of_matcher_test.rb",
    "test/matchers/datamapper/validate_numericality_of_matcher_test.rb",
    "test/matchers/datamapper/validate_presence_of_matcher_test.rb",
    "test/matchers/datamapper/validate_uniqueness_of_matcher_test.rb",
    "test/test_helper.rb"
  ]
  s.homepage = %q{http://github.com/pythonandchips/shoulda-datamapper}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.5.0}
  s.summary = %q{shoulda matchers for DataMapper ORM}
  s.test_files = [
    "test/matchers/datamapper/allow_value_matcher_test.rb",
    "test/matchers/datamapper/association_matcher_test.rb",
    "test/matchers/datamapper/validate_absence_of_matcher_test.rb",
    "test/matchers/datamapper/validate_acceptance_of_matcher_test.rb",
    "test/matchers/datamapper/validate_confirmation_of_matcher_test.rb",
    "test/matchers/datamapper/validate_format_of_matcher_test.rb",
    "test/matchers/datamapper/validate_length_of_matcher_test.rb",
    "test/matchers/datamapper/validate_numericality_of_matcher_test.rb",
    "test/matchers/datamapper/validate_presence_of_matcher_test.rb",
    "test/matchers/datamapper/validate_uniqueness_of_matcher_test.rb",
    "test/test_helper.rb"
  ]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<data_mapper>, [">= 0"])
      s.add_runtime_dependency(%q<shoulda>, [">= 0"])
      s.add_runtime_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_development_dependency(%q<test-unit>, [">= 0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
    else
      s.add_dependency(%q<data_mapper>, [">= 0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
      s.add_dependency(%q<test-unit>, [">= 0"])
      s.add_dependency(%q<bundler>, ["~> 1.0.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
      s.add_dependency(%q<rcov>, [">= 0"])
    end
  else
    s.add_dependency(%q<data_mapper>, [">= 0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<dm-sqlite-adapter>, [">= 0"])
    s.add_dependency(%q<test-unit>, [">= 0"])
    s.add_dependency(%q<bundler>, ["~> 1.0.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.5.2"])
    s.add_dependency(%q<rcov>, [">= 0"])
  end
end

