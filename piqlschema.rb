module ActiveRecord
  class Schema

    def self.define(info={}, &block)
      yield block
    end
  end
end

class PIQLTable
  attr_accessor :primary_keys, :foreign_keys, :had_fields

  def initialize
    self.primary_keys = Array.new
    self.had_fields = false
    self.foreign_keys = Hash.new
  end

  def method_missing(*args)
    type = args[0]
    name = args[1]
    options = args[2]

    self.primary_keys << name if options and options[:primary_key]

    print ",\n" if self.had_fields
    self.had_fields = true
    
    if name == 'key' or name == 'value' or name == 'val' or name == 'type'
      print "ERROR: Cannot use \"#{name}\" as a field name\n"
    end

    force_not_ref = (options and options.has_key?(:ref) and options[:ref] == nil)

    if options and options[:ref]
      foreignKey(name, options[:ref])
    elsif type == :integer and m=name.match(/^(.+)_id$/) and not force_not_ref
      foreignKey(name, m[1])
    else
      type = :string if type == :text
      type = :int if type == :integer
      type = :int if type == :date
      type = :int if type == :datetime
      type = :bool if type == :boolean
      print "\t#{type} #{name}"
    end
  end

  private

  def foreignKey(name, ref)
    self.foreign_keys[name] = ref
    print "\tFOREIGN KEY #{name} REF #{singularize(capitalize(ref))}"
  end
end

def camelize(name)
  words = name.split('_');
  return words[0] + (words[1, words.length-1].map {|w| w.capitalize}).join
end

def capitalize(name)
  return (name.split('_').map {|w| w.capitalize}).join
end

def singularize(name)
  m = name.match(/^(.*)s$/i)
  if m
    return m[1]
  else
    return name
  end
end

def pluralize(name)
  return name + "s";
end

$queries = Array.new

def create_table(name, options, &block)
  # We ignore all the options
  
  entityName = capitalize(singularize(name))

  t = PIQLTable.new
  print "ENTITY "+entityName+"\n"
  print "{\n"
#  print "\tint "+singularize(name)+"_id,\n"
  block.call(t)

  print "\n"

  if t.primary_keys.length > 0
    print "\tPRIMARY("+ t.primary_keys.join(', ') +")\n"
  else
    print "\tPRIMARY("+singularize(name)+"_id)\n"
  end

  print "}\n\n"

  t.foreign_keys.each_key do |name|
    if m=name.match(/^(.+)_id$/)
      queryName = m[1]
    else
      queryName = name
    end
    q = "\n" +
    "QUERY #{camelize(pluralize(queryName))}\n" +
    "FETCH #{capitalize(t.foreign_keys[name])}\n" +
    "\tOF #{entityName} BY #{name}\n" +
    "WHERE #{entityName} = [this]\n"
    $queries << q
  end
end

def add_index(*args)
  # We ignore index because it's not used in PIQL
end

require ARGV[0]

$queries.each {|q| print q}