require 'test_helper'

class AssociationMatcherTest < ShouldaDataMapperTest # :nodoc:

  context "valid one-to-many model" do
    setup do
      define_model :parent do
        has n, :children
      end
      define_model :child do
        belongs_to :parent
      end
    end
    
    should "accept a valid has n relationship" do
      assert_accepts have_many(:children), Parent.new
    end

    should "accept a valid belong_to relationship" do
      assert_accepts belong_to(:parent), Child.new
    end
    
    should "reject an invalid has n relationship" do
      assert_rejects have_many(:parents), Child.new
    end
    
    should "reject an invalid belong_to relationship" do
      assert_rejects belong_to(:children), Parent.new
    end
    
    should "accept a valid one-to-many association" do
      assert_accepts have_one_to_many_association_with(:children), Parent.new
    end
    
    should "reject invalid one-to-many association" do
      assert_rejects have_one_to_many_association_with(:parents), Child.new
    end
  end

  context "valid one-to-many model with optional child-parent" do
    setup do
      define_model :parent do
        has n, :children
      end
      define_model :child do
        belongs_to :parent, :required => false
      end
    end
    
    should "accept a valid has n relationship" do
      assert_accepts have_many(:children), Parent.new
    end

    should "accept a valid optional belong_to relationship" do
      assert_accepts belong_to(:parent).using_optional_parent, Child.new
    end
    
    should "reject an invalid has n relationship" do
      assert_rejects have_many(:parents), Child.new
    end

    should "reject a mandatory belong_to relationship" do
      assert_rejects belong_to(:parent), Child.new
    end

    should "reject an invalid belong_to relationship" do
      assert_rejects belong_to(:children), Parent.new
    end
    
    should "accept a valid association" do
      assert_accepts have_one_to_many_association_with(:children).using_optional_parent, Parent.new
    end
    
    should "reject invalid association" do
      assert_rejects have_one_to_many_association_with(:children), Child.new
      assert_rejects have_one_to_many_association_with(:parents), Child.new
      assert_rejects have_one_to_many_association_with(:parents).using_optional_parent, Child.new
    end
  end

  context "valid one-to-one model" do
    setup do
      define_model :parent do
        has 1, :children
      end
      define_model :child do
        belongs_to :parent
      end
    end
    
    should "accept a valid has 1 relationship" do
      assert_accepts have_one(:children), Parent.new
    end

    should "accept a valid belong_to relationship" do
      assert_accepts belong_to(:parent), Child.new
    end
    
    should "reject an invalid has 1 relationship" do
      assert_rejects have_many(:parents), Child.new
    end

    should "reject an invalid belong_to relationship" do
      assert_rejects belong_to(:children), Parent.new
    end
    
    should "accept a valid association" do
      assert_accepts have_one_to_one_association_with(:children), Parent.new
    end
    
    should "reject invalid association" do
      assert_rejects have_one_to_one_association_with(:parents), Child.new
    end
  end

  context "valid one-to-n model" do
    setup do
      define_model :parent do
        has 5, :children
      end
      define_model :child do
        belongs_to :parent
      end
    end
    
    should "accept a valid has 5 relationship" do
      assert_accepts have(5, :children), Parent.new
    end

    should "accept a valid belong_to relationship" do
      assert_accepts belong_to(:parent), Child.new
    end
    
    should "reject an invalid has 5 relationship" do
      assert_rejects have(5, :parents), Child.new
      assert_rejects have(4, :children), Parent.new
      assert_rejects have(6, :children), Parent.new
    end

    should "reject an invalid belong_to relationship" do
      assert_rejects belong_to(:children), Parent.new
    end
    
    should "accept a valid association" do
      assert_accepts have_one_to_n_association_with(5, :children), Parent.new
    end
    
    should "reject invalid association" do
      assert_rejects have_one_to_n_association_with(5, :parents), Child.new
      assert_rejects have_one_to_n_association_with(4, :children), Child.new
      assert_rejects have_one_to_n_association_with(6, :children), Child.new
      assert_rejects have_one_to_n_association_with(0, :children), Child.new
    end
  end

  context "invalid one-to-many model" do
    setup do
      define_model :parent do
        has n, :children
      end
      define_model :child do
      end
    end
    
    should "reject invalid one-to-many associations" do
      assert_rejects have_one_to_many_association_with(:parents), Child.new
      assert_rejects have_one_to_many_association_with(:children), Parent.new
    end
  end
  
  context "valid many-to-many association with default join model" do
    setup do
      define_model :tag do
        has n, :photos, :through => DataMapper::Resource
      end
      define_model :photo do
        has n, :tags, :through => DataMapper::Resource
      end
    end
      
    should "accept valid association" do
      assert_accepts have_many_to_many_association_with(:photos), Tag.new
      assert_accepts have_many_to_many_association_with(:tags), Photo.new
    end
  end
    
end
