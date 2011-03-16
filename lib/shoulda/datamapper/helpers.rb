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
        suffix = case key
        when :too_short
        when :too_long
        when :wrong_length
          I18n.t("errors.messages.#{key}", :count => values[:count])
        when :not_in_range
          "must be between #{values[:low]} and #{values[:high]} characters long"
        when :taken
          "has already been taken"
        else
          #"default_error_message: not defined for :#{key} given attribute #{attribute}"
          I18n.t("errors.messages.#{key}", :value => (values || nil))
        end
        "#{attribute.capitalize} #{suffix}"
      end
    end
  end
end
