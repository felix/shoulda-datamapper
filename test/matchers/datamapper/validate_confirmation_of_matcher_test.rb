require 'test_helper'

class ValidateConfirmationOfMatcherTest < ShouldaDataMapperTest # :nodoc:

  context "a confirmed attribute" do
    setup do
      @model = define_model :example do
        property :attr, String
        attr_accessor :attr_confirmation
        validates_confirmation_of :attr
      end.new
    end

    should "not accept confirmation" do
      assert_accepts validate_confirmation_of(:attr), @model
    end

    should "not override the default message with a blank" do
      assert_accepts validate_confirmation_of(:attr).with_message(nil), @model
    end
  end

  context "a poorly formed confirmed attribute" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_confirmation_of :attr
      end.new
    end

    should "reject a confirmation" do
      assert_rejects validate_confirmation_of(:attr), @model
    end
  end

  context "a confirmed attribute with custom confirm" do
    setup do
      @model = define_model :example do
        property :attr, String
        attr_accessor :foo
        validates_confirmation_of :attr, :confirm => :foo
      end.new
    end

    should "accept confirmation" do
      assert_accepts validate_confirmation_of(:attr).with_confirm(:foo), @model
    end
  end

end
