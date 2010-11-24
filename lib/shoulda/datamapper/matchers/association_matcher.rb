module Shoulda # :nodoc:
  module DataMapper # :nodoc:
    module Matchers

      # Ensure that the belongs_to relationship exists.
      #
      #   it { should belong_to(:parent) }
      #
      def belong_to(name)
        AssociationMatcher.new(:belongs_to, 1, name)
      end

      # Ensures that the has x relationship exists.  
      #
      #   it { should have(500, :friends) }
      #   it { should have(3, :enemy) }
      #
      def have(qty, name)
        AssociationMatcher.new(:has_n, qty, name)
      end

      # Ensures that the has n relationship exists.  
      #
      #   it { should have_many(:friends) }
      #
      def have_many(name)
        AssociationMatcher.new(:has_many, Infinity, name)
      end

      # Ensures that the has n relationship exists.  
      #
      #   it { should have_one(:life) }
      #
      def have_one(name)
        AssociationMatcher.new(:has_one, 1, name)
      end
      
      # Ensures that the one-many relationship exists. Both sides of the model are checked.
      #
      #   it { should have_one_to_many_association_with(:gadgets) }
      #
      def have_one_to_many_association_with(name)
        AssociationMatcher.new(:has_many_and_belongs_to, Infinity, name)
      end
      
      # Ensures that the one-many relationship exists. Both sides of the model are checked.
      #
      #   it { should have_one_to_one_association_with(:spouse) }
      #
      def have_one_to_one_association_with(name)
        AssociationMatcher.new(:has_one_and_belongs_to, 1, name)
      end

      # Ensures that the one-many relationship exists. Both sides of the model are checked.
      #
      #   it { should have_one_to_n_association_with(10, :fingers) }
      #
      def have_one_to_n_association_with(qty, name)
        AssociationMatcher.new(:has_n_and_belongs_to, qty, name)
      end

      # Ensures that the many-many relationship exists. Both sides of the model are checked.
      #
      #   it { should have_many_to_many_association_with(:tags) }
      #
      def have_many_to_many_association_with(name)
        AssociationMatcher.new(:has_many_and_belongs_to_many, Infinity, name)
      end


      class AssociationMatcher # :nodoc:
        
        def initialize(macro, qty, name)
          @macro = macro
          @name = name
          @qty = qty
        end

        def through(through)
          @through = through
          self
        end

        def using_optional_parent
          @using_optional_parent = true
          self
        end

        def matches?(subject)
          @subject = subject
          @through ||= Object::DataMapper::Resource
          @using_optional_parent ||= false
          association?
        end

        def failure_message
          "Expected #{expectation} (#{@missing})"
        end

        def negative_failure_message
          "Did not expect #{expectation}"
        end

        def description
          description = "#{macro_description} #{@name}"
          description += " through #{@through}" if @through
          description
        end

        protected
        
        def association?
          case @macro
          when :has_one
            one_to_one_association(model_class, @name)
          when :has_n
            one_to_n_association(model_class, @name, @qty)
          when :has_many
            one_to_many_association(model_class, @name)
          when :belongs_to
            many_to_one_association(model_class, @name, options)
          when :has_one_and_belongs_to, :has_n_and_belongs_to, :has_many_and_belongs_to
            reverse_class = Object.const_get(Extlib::Inflection::classify(@name.to_s))
            reverse_name = model_class.to_s.snake_case
            many_to_one_association(reverse_class, reverse_name, options) &&
              case @macro
              when :has_one_and_belongs_to
                one_to_one_association(model_class, @name)
              when :has_n_and_belongs_to
                one_to_n_association(model_class, @name, @qty)
              when :has_many_and_belongs_to
                one_to_many_association(model_class, @name)
              end 
          when :has_many_and_belongs_to_many
            reverse_class = Object.const_get(Extlib::Inflection::classify(@name.to_s))
            reverse_name = Extlib::Inflection::tableize(model_class.to_s)
            many_to_many_association(model_class, @name, {:through=>@through}) &&
              many_to_many_association(reverse_class, reverse_name, {:through=>@through}) &&
              join_model
          end
        end
        
        def options
          options={}
          options = {:required => false, :min=>0} if @using_optional_parent
          options
        end
        
        def join_model
          return true if (@through == Object::DataMapper::Resource)
          
          join_model_class = Object.const_get(Extlib::Inflection::classify(@through))
          join1_name = model_class.to_s.snake_case
          join2_name = Object.const_get(Extlib::Inflection::classify(@name.to_s)).to_s.snake_case
          
          many_to_one_association(join_model_class, join1_name) && 
            many_to_one_association(join_model_class, join2_name)
        end

        def one_to_one_association(klass, name, opts={})
          association(klass, name, Object::DataMapper::Associations::OneToOne::Relationship, {:min=>1, :max=>1}.merge(opts)) 
        end
        
        def one_to_many_association(klass, name, opts={})
          association(klass, name, Object::DataMapper::Associations::OneToMany::Relationship, {:min=>0, :max=>Infinity}.merge(opts)) 
        end

        def one_to_n_association(klass, name, n, opts={})
          association(klass, name, Object::DataMapper::Associations::OneToMany::Relationship, {:min=>n, :max=>n}.merge(opts)) 
        end

        def many_to_one_association(klass, name, opts={})
          association(klass, name, Object::DataMapper::Associations::ManyToOne::Relationship, {:min=>1, :max=>1}.merge(opts)) 
        end

        def many_to_many_association(klass, name, opts={})
          association(klass, name, Object::DataMapper::Associations::ManyToMany::Relationship, {:min=>0, :max=>Infinity}.merge(opts)) 
        end

        def association(klass, name, type, options={})
          relationship = klass.relationships[name.to_s]
          relationship && 
            (relationship.class == type) && 
            (options.to_a.all? { |opt| relationship.options.to_a.include? opt})
        end
        
        def model_class
          @subject.class
        end
        
        def expectation
          case @macro
          when :has_one
            "class '#{model_class.name}' to have association 'has 1, :#{@name}'"
          when :has_n
            "class '#{model_class.name}' to have association 'has #{@qty}, :#{@name}'"
          when :has_many
            "class '#{model_class.name}' to have association 'has n, :#{@name}'"
          when :belongs_to
            "class '#{model_class.name}' to have association 'belongs_to, :#{@name}'"
          when :has_one_and_belongs_to, :has_n_and_belongs_to, :has_many_and_belongs_to
            reverse_class = Object.const_get(Extlib::Inflection::classify(@name.to_s))
            reverse_name = model_class.to_s.snake_case
              case @macro
              when :has_one_and_belongs_to
                "class '#{model_class.name}' to have association 'has 1, :#{@name}' and class '#{reverse_class.to_str}' to have association 'belongs_to :#{reverse_name}'"
              when :has_n_and_belongs_to
                "class '#{model_class.name}' to have association 'has #{@qty}, :#{@name}' and class '#{reverse_class.to_str}' to have association 'belongs_to :#{reverse_name}'"
              when :has_many_and_belongs_to
                "class '#{model_class.name}' to have association 'has n, :#{@name}' and class '#{reverse_class.to_str}' to have association 'belongs_to :#{reverse_name}'"
              end 
          when :has_many_and_belongs_to_many
            reverse_class = Object.const_get(Extlib::Inflection::classify(@name.to_s))
            reverse_name = Extlib::Inflection::tableize(model_class.to_s)
            join_model_class = Object.const_get(Extlib::Inflection::classify(@through))
            join1_name = model_class.to_s.snake_case
            join2_name = reverse_class.to_s.snake_case
            "class '#{model_class.name}' to have association 'has n, :#{@name}, :through => :#{@through}' and class '#{reverse_class.to_s}' to have association 'has n, :#{reverse_name}, :through => :#{@through}' and class '#{join_model_class}' to have associations 'belongs_to :#{join1_name}, :key => true' and 'belongs_to :#{join2_name}, :key => true'"
          end
        end

        def macro_description
          case @macro.to_s
          when 'belongs_to' then 'belong to'
          when 'has_n' then 'have many'
          when 'has_one' then 'have one'
          end
        end
      end
    end
  end
end
