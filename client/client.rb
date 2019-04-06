#!/bin/ruby
require 'socket'
require 'json'

ENV = JSON.parse( File.read('./config/config.json') )
SEND_SIGNALS_MODE = "1"
SEND_SIGNAL_MODE = "0"

def validate(args)
	puts args.length
 if args.length == 2 && args[0] == SEND_SIGNAL_MODE && args[1].length == 1	
 	puts "send_signal_mode selected"
	return true
 elsif args.length == 1 && args[0] == SEND_SIGNALS_MODE
 	puts "send_signals_mode selected"
 	return true
 else
 	puts "invalid option"
 	return false
 end
end

def get_tcp_message(sock)
  msg = ""
  while message = sock.gets
  	msg += message
  end
  return msg
end


def signal_server(ip,port,signal)
	server_sock = TCPSocket.new(ip,port)	
    server_sock.puts(signal)	
	server_sock.close
end

def send_signals_mode
   begin 
   	 while true
   	   puts "type 'exit' quit signal mode"
   	   next_signal = gets.chomp
   	   if next_signal == 'exit'
   	   	exit
   	   else 
   	   	signal_server(ENV['dev_ip'],ENV['server_port'].to_i,next_signal)
   	   end
  	 end
   rescue SignalException => e
   	  puts "shuting down gracefully!"
   	  exit
   end 
end



def run(args)
  exit if validate(args) == false

  if args[0] == SEND_SIGNAL_MODE
  	#signal_server(ENV['server_ip'],ENV['server_port'].to_i,args[1])
	#signal_server(ENV['dev_ip'],ENV['server_port'].to_i,args[1])
  elsif args[0] == SEND_SIGNALS_MODE
	send_signals_mode
  end
end

run(ARGV)



