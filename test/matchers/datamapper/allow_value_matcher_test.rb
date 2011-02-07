require 'test_helper'

class AllowValueMatcherTest < ShouldaDataMapperTest # :nodoc:

  context "an attribute with a format validation" do
    setup do
      define_model :example do
        property :attr, String, :format => /abc/
      end
      @model = Example.new
    end

    should "allow a good value" do
      assert_accepts allow_value("abcde").for(:attr), @model
    end
    
    should "not allow a bad value" do
      assert_rejects allow_value("xyz").for(:attr), @model
    end
  end

  context "an attribute with a format validation and a custom message" do
    setup do
      define_model :example do
        property :attr, String, :format => /abc/, :message => 'bad value'
      end
      @model = Example.new
    end

    should "allow a good value" do
      assert_accepts allow_value('abcde').for(:attr).with_message(/bad/), @model
    end
    
    should "not allow a bad value" do
      assert_rejects allow_value('xyz').for(:attr).with_message(/bad/), @model
    end
  end

  context "an attribute with several validations" do
    setup do
      @model = define_model :example do
        property :attr, Integer
        validates_presence_of :attr
        validates_numericality_of :attr, :gte => 1, :lte => 50000
      end.new
    end

    should "allow a good value" do
      assert_accepts allow_value(12345).for(:attr), @model
    end

    good_values = [1, 50000, 12345, "12345"]
    good_values.each do |value|
      should "not allow a bad value (#{value.inspect})" do
        assert_accepts allow_value(value).for(:attr), @model
      end
    end
    
    bad_values = [nil, "", "abc", "0", 50001, 123456]
    bad_values.each do |value|
      should "not allow a bad value (#{value.inspect})" do
        assert_rejects allow_value(value).for(:attr), @model
      end
    end
  end

end
