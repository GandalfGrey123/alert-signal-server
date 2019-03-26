#!/bin/ruby

require 'socket'

MAX_ARG_LENGTH = 1
VALID_PORTS = [443]

def validate(args)
  if args.length != MAX_ARG_LENGTH || !(VALID_PORTS.include? args[0].to_i) 
  	return false 
  else 
  	return true
  end
end


#get port from command line as first arg
def run(args) 
   return false if validate(args) == false
   server = TCPServer.new args[0].to_i

   while true
   	client_socket = server.accept
   	client.puts " hello client! "
   	client.close
   end

end



run(ARGV)