require 'shoulda/datamapper/helpers'
require 'shoulda/datamapper/matchers/validation_matcher'
require 'shoulda/datamapper/matchers/allow_value_matcher'
require 'shoulda/datamapper/matchers/validate_absence_of_matcher'
require 'shoulda/datamapper/matchers/validate_acceptance_of_matcher'
require 'shoulda/datamapper/matchers/validate_confirmation_of_matcher'
require 'shoulda/datamapper/matchers/validate_length_of_matcher'
require 'shoulda/datamapper/matchers/validate_presence_of_matcher'
require 'shoulda/datamapper/matchers/validate_format_of_matcher'
require 'shoulda/datamapper/matchers/validate_uniqueness_of_matcher'
require 'shoulda/datamapper/matchers/validate_numericality_of_matcher'
require 'shoulda/datamapper/matchers/association_matcher'

module Shoulda # :nodoc:
  module DataMapper # :nodoc:
    # = Matchers for your DataMapper models
    #
    # These matchers will test most of the validations and associations for your
    # DataMapper models.
    #
    #   describe User do
    #     it { should validate_presence_of(:name) }
    #     it { should validate_presence_of(:phone_number) }
    #     %w(abcd 1234).each do |value|
    #       it { should_not allow_value(value).for(:phone_number) }
    #     end
    #     it { should allow_value("(123) 456-7890").for(:phone_number) }
    #     it { should_not allow_mass_assignment_of(:password) }
    #     it { should have_one(:profile) }
    #     it { should have_many(:dogs) }
    #     it { should have_many(:messes).through(:dogs) }
    #     it { should belong_to(:lover) }
    #   end
    #
    module Matchers
    end
  end
end
