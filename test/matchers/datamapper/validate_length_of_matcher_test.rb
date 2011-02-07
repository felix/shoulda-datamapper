require 'test_helper'

class EnsureLengthOfMatcher < ShouldaDataMapperTest # :nodoc:

  context "an attribute with a non-zero minimum length validation" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :min => 4
      end.new
    end

    should "accept ensuring the correct minimum length" do
      assert_accepts validate_length_of(:attr).is_at_least(4), @model
    end

    should "reject ensuring a lower minimum length with any message" do
      assert_rejects validate_length_of(:attr).is_at_least(3).with_short_message(/.*/), @model
    end

    should "reject ensuring a higher minimum length with any message" do
      assert_rejects validate_length_of(:attr).is_at_least(5).with_short_message(/.*/), @model
    end

    should "not override the default message with a blank" do
      assert_accepts validate_length_of(:attr).is_at_least(4).with_short_message(nil), @model
    end
  end

  context "an attribute with a minimum length validation of 0" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :min => 0
      end.new
    end

    should "accept ensuring the correct minimum length" do
      assert_accepts validate_length_of(:attr).is_at_least(0), @model
    end
  end

  context "an attribute with a maximum length" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :max => 4
      end.new
    end

    should "accept ensuring the correct maximum length" do
      assert_accepts validate_length_of(:attr).is_at_most(4), @model
    end

    should "reject ensuring a lower maximum length with any message" do
      assert_rejects validate_length_of(:attr).is_at_most(3).with_long_message(/.*/), @model
    end

    should "reject ensuring a higher maximum length with any message" do
      assert_rejects validate_length_of(:attr).is_at_most(5).with_long_message(/.*/), @model
    end

    should "not override the default message with a blank" do
      assert_accepts validate_length_of(:attr).is_at_most(4).with_long_message(nil), @model
    end
  end

  context "an attribute with a required exact length" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :is => 4
      end.new
    end

    should "accept ensuring the correct length" do
      assert_accepts validate_length_of(:attr).is_equal_to(4), @model
    end

    should "reject ensuring a lower maximum length with any message" do
      assert_rejects validate_length_of(:attr).is_equal_to(3).with_message(/.*/), @model
    end

    should "reject ensuring a higher maximum length with any message" do
      assert_rejects validate_length_of(:attr).is_equal_to(5).with_message(/.*/), @model
    end

    should "not override the default message with a blank" do
      assert_accepts validate_length_of(:attr).is_equal_to(4).with_message(nil), @model
    end
  end

  context "an attribute with a custom minimum length validation" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :min => 4, :message => 'short'
      end.new
    end

    should "accept ensuring the correct minimum length" do
      assert_accepts validate_length_of(:attr).is_at_least(4).with_short_message(/short/), @model
    end

  end

  context "an attribute with a custom maximum length validation" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :max => 4, :message => 'long'
      end.new
    end

    should "accept ensuring the correct minimum length" do
      assert_accepts validate_length_of(:attr).is_at_most(4).with_long_message(/long/), @model
    end

  end

  context "an attribute without a length validation" do
    setup do
      @model = define_model :example do
        property :attr, String
      end.new
    end

    should "reject ensuring a minimum length" do
      assert_rejects validate_length_of(:attr).is_at_least(1), @model
    end
  end

  context "an attribute with a range length validation" do
    setup do
      @model = define_model :example do
        property :attr, String
        validates_length_of :attr, :in => (3..5)
      end.new
    end

    should "accept a length within the range" do
      assert_accepts validate_length_of(:attr).is_in_range(3..5), @model
    end

    should "reject a length below the range" do
      assert_rejects validate_length_of(:attr).is(2), @model
    end

    should "reject a length above the range" do
      assert_rejects validate_length_of(:attr).is(6), @model
    end

  end
end
