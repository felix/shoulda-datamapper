require 'test_helper'

class ValidateAbsenceOfMatcherTest < ShouldaDataMapperTest # :nodoc:

  context "an unwanted attribute" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_absence_of :attr
      end.new
    end

    should "not require a value" do
      assert_accepts validate_absence_of(:attr), @model
    end

    should "not override the default message with a blank" do
      assert_accepts validate_absence_of(:attr).with_message(nil), @model
    end
  end

  context "an optional attribute" do
    setup do
      @model = define_model :example do
        property :attr, String
      end.new
    end

    should "not require a value" do
      assert_rejects validate_absence_of(:attr), @model
    end
  end

  context "an unwanted has n association" do
    setup do
      define_model :child do
        belongs_to :parent
      end
      @model = define_model :parent do
        has n, :children
        validates_absence_of :children
      end.new
    end

    should "not require the attribute to be set" do
      assert_accepts validate_absence_of(:children), @model
    end
  end

  context "an optional has n association" do
    setup do
      define_model :child do
        belongs_to :parent
      end
      @model = define_model :parent do
        has n, :children
      end.new
    end

    should "not require the attribute to be set" do
      assert_rejects validate_absence_of(:children), @model
    end
  end

end
