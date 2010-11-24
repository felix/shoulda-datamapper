require 'test_helper'

class ValidateFormatOfMatcherTest < ShouldaDataMapperTest # :nodoc:

  context "a postal code" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_format_of :attr, :with => /^\d{5}$/
      end.new
    end
    
    should "be valid" do
      assert_accepts validate_format_of(:attr).with('12345'), @model
    end
    
    should "not be valid with alpha in zip" do
      assert_rejects validate_format_of(:attr).not_with('1234a'), @model
    end
    
    should "not be valid with to few digits" do
      assert_rejects validate_format_of(:attr).not_with('1234'), @model
    end
    
    should "not be valid with to many digits" do
      assert_rejects validate_format_of(:attr).not_with('123456'), @model
    end
    
    should "raise error if you try to call both with and not_with" do
      assert_raise RuntimeError do
        validate_format_of(:attr).not_with('123456').with('12345')
      end
    end
    
  end


end
