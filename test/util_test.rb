require_relative 'test_helper'

class UtilTest < Test::Unit::TestCase
  
  def test_system_osx
    Kernel.expects(:system).with("sed --version 2> /dev/null").returns(false)
    assert_equal(:osx, Sed::Util.system)
  end
  
  def test_system_gnu
    Kernel.expects(:system).with("sed --version 2> /dev/null").returns(true)
    assert_equal(:gnu, Sed::Util.system)
  end
  
  def test_osx
    Sed::Util.expects(:system).returns(:osx)
    assert(Sed::Util.osx?)
    
    Sed::Util.expects(:system).returns(:gnu)
    assert(!Sed::Util.osx?)
  end
  
  def test_gnu
    Sed::Util.expects(:system).returns(:osx)
    assert(!Sed::Util.gnu?)
    
    Sed::Util.expects(:system).returns(:gnu)
    assert(Sed::Util.gnu?)
  end
end