module Sed
  module Commander
    
    extend self
    
    def replace(input_file_path, expression, replacement, opts = {})
      command = "sed #{argv(input_file_path, expression, replacement, opts)}"
      result  = Kernel.system command
    end
    
    def argv(input_file_path, expression, replacement, opts = {})
      result = []
      
      if opts[:output].nil?
        result << Sed::Commander.inplace_option
      end

      if opts[:extended_regex]
        result << Sed::Commander.extended_regex_option
      end
      
      result << "'s/#{expression}/#{replacement}/g'"
      result << "'#{input_file_path}'"
      
      if opts[:output]
        result << "> '#{opts[:output]}'"
      end
      
      result.join(' ')
    end
    
    def inplace_option
      return "-i ''"  if Sed::Util.osx?
      return "-i"     if Sed::Util.gnu?
    end
    
    def extended_regex_option
      return "-E"  if Sed::Util.osx?
      return "-r"  if Sed::Util.gnu?
    end
    
  end
end