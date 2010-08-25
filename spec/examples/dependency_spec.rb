# -*- coding: undecided -*-
require File.dirname(__FILE__) + '/spec_helper'

describe 'Dependable' do

  it 'should be true' do
    true.should be(true)
  end

  it 'should calculate basic dependencies' do
    jquery = Thing.new
    jqtouch = Thing.new(jquery)
    jqtouch.load_path.should == [jquery, jqtouch]
  end

  it 'should calculate one-way dependencies' do
    thing1 = Thing.new
    thing2 = Thing.new(thing1)
    collection = Thing.new(thing1, thing2)
    collection.load_path(false).should == [thing1, thing2]
  end
  
  it 'should calculate one-way dependencies' do
    thing1 = Thing.new
    thing2 = Thing.new
    thing1.needs thing2
    collection = Thing.new(thing1, thing2)
    collection.load_path(false).should == [thing2, thing1]
  end
  
  it 'should calculate multiple dependencies' do
    jquery = Thing.new
    other = Thing.new
    jqtouch = Thing.new(jquery, other)
    jqtouch.load_path.should == [jquery, other, jqtouch]
  end

  it 'should not duplicate dependencies that fall in multiple parts of the tree' do
    other = Thing.new
    jquery = Thing.new(other)
    jqtouch = Thing.new(other, jquery)
    jqtouch.load_path.should == [other, jquery, jqtouch]
  end

  it 'should respond to print_load_path' do
    thing = Thing.new
    thing.should respond_to(:print_load_path)
  end

  it 'should allow something to need two things, one of which needs the other - and negotitate this correctly' do
    thing = Thing.new
    thing1b = Thing.new
    thing1a = Thing.new
    thing1b.needs thing1a
    thing.needs thing1b, thing1a
    thing.load_path.should == [thing1a, thing1b, thing]
    thing.load_path(false).should == [thing1a, thing1b]
  end
  
  it 'should raise an error for mutual dependencies' do
    thing1 = Thing.new
    thing2 = Thing.new
    thing1.needs thing2
    lambda do
      thing2.needs thing1
    end.should raise_error(Dependable::DependencyError)
  end

  it 'should raise an error for dependencies that have themselves as a dependency (level 1)' do
    thing = Thing.new
    lambda do
      thing.needs thing
    end.should raise_error(Dependable::DependencyError)
  end
  
  it 'should raise an error for dependencies that have themselves as a dependency (level 2)' do
    thing1 = Thing.new
    thing2 = Thing.new(thing1)
    lambda do
      thing1.needs thing2
    end.should raise_error(Dependable::DependencyError)
  end

  it 'should raise an error for dependency triangles' do
    thing1 = Thing.new
    thing2 = Thing.new(thing1)
    thing3 = Thing.new(thing2)
    lambda do
      thing1.needs thing3
    end.should raise_error(Dependable::DependencyError)
  end
  
end


