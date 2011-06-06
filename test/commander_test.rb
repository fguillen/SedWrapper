require_relative 'test_helper'

class CommanderTest < Test::Unit::TestCase
  
  def setup
    @tmp_path = Dir.mktmpdir
    Sed::Util.stubs(:system).returns(:osx)
  end
  
  def teardown
    FileUtils.rmtree @tmp_path
  end
  
  def test_replace_basic
    input_file_path = "#{@tmp_path}/input01.txt" 
    
    FileUtils.copy(
      "#{FIXTURES_PATH}/input01.txt",
      input_file_path
    )
    
    Sed::Commander.replace(
      input_file_path, 
      "a", 
      "-"
    )
    
    assert_equal(
      File.read("#{FIXTURES_PATH}/output01.txt"), 
      File.read(input_file_path)
    )
  end
  
  def test_replace_with_output
    input_file_path   = "#{FIXTURES_PATH}/input01.txt" 
    output_file_path  = "#{@tmp_path}/output01.txt" 
    
    Sed::Commander.replace(
      input_file_path,
      "a",
      "-",
      :output => output_file_path
    )
    
    assert_equal(
      File.read("#{FIXTURES_PATH}/output01.txt"), 
      File.read(output_file_path)
    )    
  end
  
  def test_replace_with_output_and_ere
    input_file_path   = "#{FIXTURES_PATH}/input01.txt" 
    output_file_path  = "#{@tmp_path}/output02_ere.txt" 
    
    Sed::Commander.replace(
      input_file_path,
      "[aeiou]",
      "-",
      {
        :output => output_file_path, 
        :extended_regex => true
      }
    )
    
    assert_equal(
      File.read("#{FIXTURES_PATH}/output01_ere.txt"), 
      File.read(output_file_path)
    )    
  end
  
  def test_argv_basic
    argv = 
      Sed::Commander.argv(
        'input.txt',
        'expression',
        'replacement'
      )
      
    assert_equal(
      "-i '' 's/expression/replacement/g' 'input.txt'",
      argv
    )
  end
  
  def test_argv_with_output
    argv = 
      Sed::Commander.argv(
        'input.txt',
        'expression',
        'replacement',
        { :output => 'output.txt' }
      )
      
    assert_equal(
      "'s/expression/replacement/g' 'input.txt' > 'output.txt'",
      argv
    )
  end
  
  def test_argv_with_ere
    argv = 
      Sed::Commander.argv(
        'input.txt',
        'expression',
        'replacement',
        { :extended_regex => true }
      )
      
    assert_equal(
      "-i '' -E 's/expression/replacement/g' 'input.txt'",
      argv
    )
  end
  
  def test_argv_with_and_output
    argv = 
      Sed::Commander.argv(
        'input.txt',
        'expression',
        'replacement',
        {
          :output => 'output.txt',
          :extended_regex => true
        }
      )
      
    assert_equal(
      "-E 's/expression/replacement/g' 'input.txt' > 'output.txt'",
      argv
    )
  end

end