require 'test/unit'

require 'shoulda/context'
require 'shoulda/proc_extensions'
require 'shoulda/assertions'
require 'shoulda/helpers'
require 'shoulda/autoload_macros'

module Test # :nodoc: all
  module Unit
    class TestCase
      include Shoulda::InstanceMethods
      extend Shoulda::ClassMethods
      include Shoulda::Assertions
      include Shoulda::Helpers
    end
  end
end

