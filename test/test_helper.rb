shoulda_path = File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << shoulda_path
require 'shoulda'
require 'shoulda/datamapper'
require 'data_mapper'
require 'extlib'

class ShouldaDataMapperTest < Test::Unit::TestCase
  DataMapper.setup(:default, 'sqlite::memory:')

  def define_model(name, &block)
    class_name = Extlib::Inflection::classify(name.to_s)

    DataMapper::Model.descendants.each do |e|
      DataMapper::Model.descendants.delete(e)
    end

    if Object.const_defined?(class_name)
      Object.send(:remove_const, class_name.to_sym) 
    end

    klass = Object.const_set(class_name, Class.new)
    klass.class_eval <<-RUBY
      include DataMapper::Resource
      property :id, Serial
    RUBY
    klass.class_eval(&block) if block_given?
    
    # sqlite adapter can't do an auto_upgrade: complains about duplicate columns
    # what a pain
    # DataMapper.auto_update!
    
    klass
  end
  
  def recreate_database
    DataMapper.auto_migrate!
  end
end
