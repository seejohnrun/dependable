require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'dependable')
include Dependable

class Thing

  include Dependency
  
  def initialize(*dependencies)
    self.dependencies = dependencies
  end
  
end
