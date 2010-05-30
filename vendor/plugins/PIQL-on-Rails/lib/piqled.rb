# Piqled

active_record = begin
                  USE_AR
                rescue NameError
                  false
                end

if active_record
  module PIQLEntity
    module ClassMethods
      def pfind(piql, ar)
        find(*ar)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end

else

  module PIQLEntity
    def method_missing(symbol, *args)
      str = symbol.to_s
      if str[-1] == '='[0]
        self.put(str[0..-2], args[0])
      end
    end

    def initialize(h = {})
      super()
      h.each_pair do |key, value|
        self.put(key, value)
      end
    end

    def save (env = $piql_env)
      super(env)
    end
  
    module ClassMethods
      def pfind(piql, ar)
        Query.send(piql[0], *piql[1..-1]).to_a
      end

      def belongs_to(*args)
      end
      
      def has_many(*args)
      end
      
      def has_one(*args)
      end

      def has_and_belongs_to_many(*args)
      end

      def validates_presence_of(*args)
      end

      def validates_uniqueness_of(*args)
      end

      def validate(*args)
      end

      def validates_length_of(*args)
      end

      def validates_confirmation_of(*args)
      end

      def before_save(*args)
      end

      def after_create(*args)
      end

      def before_validation(*args)
      end

      def method_missing(symbol, *args)
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end
  end

  class Query
    def self.method_missing(symbol, *args)
      Queries.send(symbol, *args << $piql_env)
    end
  end
end

def get_piql_classes(path = PIQL_JAR_PATH)
  jar = JarFile.new(path)
  jar.entries.map { |entry| 
    entry.getName.match(/^(piql\/[a-zA-Z0-9]*).class$/) }.select {
    |re| re}.map { |re| re[1].sub('/', '.')}
end

def include_piql(classes)
  classes.each { |c| include_class c}
end

def require_models(classes)
  not_entities = ["Queries", "Configurator"]
  entities = classes.map {|c| c.gsub("piql.", "")} - not_entities
  entities.each do |e|
    file_name = "#{RAILS_ROOT}/app/models/#{e.downcase}.rb"
    require file_name if File.exists?(file_name)
  end
end

def active_recordify(classes)
  not_entities = ["Queries", "Configurator"]
  entities = classes.map {|c| c.gsub("piql.", "")} - not_entities
  entities.each do |e|
    eval("class #{e} < ActiveRecord::Base \n end")
  end
end

include Java
  
include_class "java.util.jar.JarFile"

PIQL_JAR_PATH = "#{RAILS_ROOT}/db/piql.jar"

require PIQL_JAR_PATH

classes = get_piql_classes

if active_record
  active_recordify(classes) 
else
  include_piql(classes)
  require_models(classes)

  $piql_env = TestConfigurator.new.configureTestCluster

  include_class "scala.collection.immutable.List"

  class Java::ScalaCollectionImmutable::List
    include Enumerable
    def each(&block)
      unless self.isEmpty
        yield self.head
        self.tail.each(&block)
      end
    end
  
    def to_a
      self.collect {|element| element}
    end
  end

  loader_path = "#{RAILS_ROOT}/db/loader.rb"
  require loader_path if File.exists?(loader_path)
end
