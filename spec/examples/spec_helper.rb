require File.join(File.dirname(__FILE__), '..', '..', 'lib', 'dependable')

class Thing

  include Dependable
  
  def initialize(*dependencies)
    self.needs *dependencies
  end
  
end
