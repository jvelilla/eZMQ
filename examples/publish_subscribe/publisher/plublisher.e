																																																																																		note
	description : "client application root class"
	date        : "$Date$"
	revision    : "$Revision$"

class PUBLISHER
create make
feature
	make 
		local context: ZMQ_CONTEXT; socket: ZMQ_SOCKET; message, answer: ZMQ_MESSAGE
			answer_text: STRING
		do
		end
end -- PUBLISHER

