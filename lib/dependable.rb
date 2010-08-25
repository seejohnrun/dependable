module Dependable

  attr_reader :dependencies

  def clear_dependencies
    @dependencies = []
  end
  
  def needs(*things)
    raise DependencyError.new("Circular Dependency Detected") if things.any? { |thing| thing.dependent_on?(self) }
    @dependencies ||= []
    @dependencies.concat things
  end

  # Bad recursive performance - should use trees
  def dependent_on?(thing)
    return true if self == thing
    @dependencies && @dependencies.any? { |d| d.dependent_on?(thing) }
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

  class DependencyError < ArgumentError
  end
  
end
