module Dependable
  
  def dependencies=(dependencies)
    raise ArgumentError.new('Dependencies must be enumerable') unless dependencies.kind_of?(Enumerable) # TODO debatable whether this should be here
    @dependencies = dependencies
  end
  
  def dependencies
    @dependencies || []
  end
  
  def load_path(include_self = true)
    load = []
    @dependencies.each do |dependency|
      load.concat dependency.load_path
    end if @dependencies
    load << self if include_self
    load.uniq!
    load
  end
  
  def print_load_path(include_self = true)
    load = self.load_path(include_self)
    load.each_with_index do |thing, index|
      print "#{index + 1}) #{thing}"
      print " (requires: #{thing.dependencies.join(',')})" unless thing.dependencies.empty?
      puts
    end
  end
  
end
