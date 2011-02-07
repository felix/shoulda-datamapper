module Shoulda # :nodoc:
  module DataMapper # :nodoc:
    module Helpers
      def pretty_error_messages(obj) # :nodoc:
        obj.errors.map do |a, m|
          msg = "#{a} #{m}"
          #msg << " (#{obj.send(a).inspect})" unless a.to_sym == :base
        end
      end

      # Helper method that determines the default error message 
      #
      #   default_error_message(:blank)
      #   default_error_message(:too_short, :count => 5)
      #   default_error_message(:too_long, :count => 60)
      def default_error_message(attribute, key, values = {})
        case key
        when :blank
          "#{attribute.capitalize} must not be blank"
        when :format
          "#{attribute.capitalize} has an invalid format"
        when :too_short
          "#{attribute.capitalize} must be at least #{values[:count]} characters long"
        when :too_long
          "#{attribute.capitalize} must be at most #{values[:count]} characters long"
        when :wrong_length
          "#{attribute.capitalize} must be #{values[:count]} characters long"
        when :accepted
          "#{attribute.capitalize} is not accepted"
        when :not_a_number
          "#{attribute.capitalize} must be a number"
        when :taken
          "#{attribute.capitalize} is already taken"
        when :absence
          "#{attribute.capitalize} must be absent"
        when :confirm
          "#{attribute.capitalize} does not match the confirmation"
        when :not_in_range
          "#{attribute.capitalize} must be between #{values[:low]} and #{values[:high]} characters long"
        else
          "default_error_message: not defined for :#{key} given attribute #{attribute}"
        end
      end
    end
  end
end
