module Sed
  class Runner
  
    attr_reader :input_file_path, :opts
  
    def initialize(input_file_path, opts = {}, &blk)
      @input_file_path = input_file_path
      @opts = opts
    
      instance_eval(&blk) if block_given?
    end
  
    def replace(expression, replacement)
      Sed::Commander.replace(
        input_file_path, 
        expression,
        replacement,
        opts
      )
    end
    
  end
end