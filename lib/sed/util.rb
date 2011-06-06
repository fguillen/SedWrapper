module Sed
  module Util
    
    extend self

    # returns :gnu for Linux version
    # returns :osx for Mac version
    def system
      return @system  if @system
      
      command_exit = Kernel.system "sed --version 2> /dev/null"
      @system = command_exit ? :gnu : :osx
      
      return @system
    end
    
    def osx?
      Sed::Util.system == :osx
    end
    
    def gnu?
      Sed::Util.system == :gnu
    end
  end
end