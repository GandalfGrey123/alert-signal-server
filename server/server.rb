#!/bin/ruby
require 'socket'
require 'time'

LOG_PATH = "./bin/log "
ARG_LENGTH = 1
VALID_PORTS= [2000]


def validate(args)
  if args.length != ARG_LENGTH || !(VALID_PORTS.include? args[0].to_i) 
  	return false 
  else 
  	return true
  end
end

def log_message(message)
 File.write(LOG_PATH, (message+", at time: " + Time.now.to_s + "\n"), mode: 'a')
end

def handle_signal(signal)
  case signal
  when "0"
    puts "recieving signal : 0"
  when "1"
    puts "recieving signal : 1"
  else
    puts "recieving invalid signal : " + signal
   log_message("invalid signal recieved : " + signal)    
  end
end

def start_serving(server_sock)
   while true
    client_socket = server_sock.accept
    handle_signal(client_socket.recv(1))
    client_socket.close
   end
end


#get port from command line as first arg
def run(args) 
   exit if validate(args) == false
   server_sock = TCPServer.new args[0].to_i

   begin
    start_serving(server_sock)

   rescue SignalException => e

    puts "initializing graceful shutdown ... "
    server_sock.close
   end
end

run(ARGV)