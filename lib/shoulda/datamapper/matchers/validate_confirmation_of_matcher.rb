module Shoulda # :nodoc:
  module DataMapper # :nodoc:
    module Matchers

      # Ensures that the model is not valid if the given attribute is 
      # not confirmed.
      #
      # Options:
      # * <tt>with_message</tt> - value the test expects to find in
      #   <tt>errors.on(:attribute)</tt>. <tt>Regexp</tt> or <tt>String</tt>.
      #   Defaults to the translation for <tt>:blank</tt>.
      #
      # Examples:
      #   it { should validate_confirmation_of(:name) }
      #   it { should validate_confirmation_of(:name).
      #                 with_message(/is not required/) }
      #
      def validate_confirmation_of(attr)
        ValidateConfirmationOfMatcher.new(attr)
      end

      class ValidateConfirmationOfMatcher < ValidationMatcher # :nodoc:

        def with_message(message)
          @expected_message = message if message
          self
        end
        
        def with_confirm(confirm)
          @expected_confirm = confirm.to_s if confirm
          self
        end
        
        def matches?(subject)
          super(subject)
          @expected_message ||= :confirm
          @expected_confirm ||= @attribute.to_s+"_confirmation"
          begin
            subject.send(@expected_confirm+'=', 'YYY')
            disallows_value_of('XXX', @expected_message)
          rescue NoMethodError
            false
          end
        end

        def description
          "require that #{@attribute} is not set"
        end
      end

    end
  end
end
