note
	description : "client application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class CLIENT
create make
feature
	make 
		local context: ZMQ_CONTEXT; socket: ZMQ_SOCKET; message, answer: ZMQ_MESSAGE
			answer_text: STRING
		do
			create context -- Initialise 0MQ context with one application and one I/O thread
			socket := context.new_req_socket -- to send requests and receive replies
			-- Connect it to port 5555 on localhost using the TCP transport
			socket.connect ("tcp://localhost:5555")
			-- Construct an example message with our query
			create message.with_string("SELECT * FROM mytable")
			socket.send(message)

			-- Receive and display the result
			create answer
			socket.receive(answer)

			create answer_text.make_from_c (answer.data)
			print ("%NReceived answer: "+answer_text)
		end
end -- CLIENT

