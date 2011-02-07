module Shoulda # :nodoc:
  module DataMapper # :nodoc:
    module Matchers

      # Ensures that the model is not valid if the given attribute is 
      # present.
      #
      # Options:
      # * <tt>with_message</tt> - value the test expects to find in
      #   <tt>errors.on(:attribute)</tt>. <tt>Regexp</tt> or <tt>String</tt>.
      #   Defaults to the translation for <tt>:blank</tt>.
      #
      # Examples:
      #   it { should validate_absence_of(:name) }
      #   it { should validate_absence_of(:name).
      #                 with_message(/is not required/) }
      #
      def validate_absence_of(attr)
        ValidateAbsenceOfMatcher.new(attr)
      end

      class ValidateAbsenceOfMatcher < ValidationMatcher # :nodoc:

        def with_message(message)
          @expected_message = message if message
          self
        end

        def matches?(subject)
          super(subject)
          @expected_message ||= :absence
          disallows_value_of(false_data(subject), @expected_message)
        end

        def description
          "require that #{@attribute} is not set"
        end

        private

        def false_data(subject)
          if collection?
            [Object::const_get(Extlib::Inflection::singularize(@attribute.to_s).camel_case).new]
          else
            'XXX'
          end
        end

        def collection?
          !@subject.send(@attribute).class.to_s.match(/DataMapper::Associations::\w+::Collection/).nil?
        end
      end

    end
  end
end
