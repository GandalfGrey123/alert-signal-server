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

def start_serving(server_sock,client_sockets)
   while true
    client_socket = server_sock.accept
    client_socket.puts "hello"
    client_socket.close
   end
end


#get port from command line as first arg
def run(args) 
  #return false if validate(args) == false
   server = TCPServer.new args[0].to_i
   client_sockets =[]

   begin
    start_serving(server,client_sockets)
   rescue SignalException => e

    puts "initializing graceful shutdown ... "

    server.close    
    client_sockets.each{ |next_sock|
      next_sock.close
    }
   end
end

run(ARGV)
