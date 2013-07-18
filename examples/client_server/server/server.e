note
	description : "server application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class
	SERVER
	-- Port of the server of the simple example at http://www.zeromq.org/area:docs-v20
creation {} make
feature
	make
		local ctx: ZMQ_CONTEXT; s: ZMQ_SOCKET; query, answer: ZMQ_MESSAGE
			content: STRING
		do
			create ctx
			s := ctx.new_rep_socket
			-- Bind to the TCP transport and port 5555 on the 'lo' interface
			s.bind("tcp://lo:5555")

			from until False loop -- i.e. "forever do"
				create query
				s.receive(query) -- Receive a message, blocks until one is available
				create content.make_from_c(query.data) -- Process the query
				print ("%NReceived query: '"+content)
				query.close -- message closing may be automatically done by the garbage collector.

				create answer.with_string(answer_body)
				s.send(answer) -- Send back our canned response
				answer.close
			end

		end
		answer_body: STRING = "OK"

end -- class SERVER
