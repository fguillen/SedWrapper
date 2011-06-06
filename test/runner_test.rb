require_relative 'test_helper'

class RunnerTest < Test::Unit::TestCase
  
  def test_dsl
    Sed::Commander.expects(:replace).with(
      'input.txt', 
      'expression',
      'replacement',
      'OPTS'
    )
    
    Sed::Commander.expects(:replace).with(
      'input.txt', 
      'expression2',
      'replacement2',
      'OPTS'
    )
    
    Sed::Runner.new('input.txt', 'OPTS') do |s|
      s.replace('expression', 'replacement')
      s.replace('expression2', 'replacement2')
    end
    
  end
end