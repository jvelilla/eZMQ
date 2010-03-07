note
	description: "Summary description for {ZMQ_SOCKET}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ZMQ_SOCKET

inherit
	WRAPPER_BASE
	ZMQ_API

create {ZMQ_CONTEXT} make

feature {} -- Disposing
	delete (an_object : POINTER) is
		local res: INTEGER
		do
			res := zmq_close(an_object)
			-- TODO: handle return value
		end

feature {ANY} -- Binding
	bind (an_address: STRING) is
		-- Bind Current socket to a particular transport.
	require an_address/=Void
	local res: INTEGER_32
	      c_str : C_STRING
	do
		create c_str.make (an_address)
		res := zmq_bind(item,c_str.item)
		if res/=0 then
			--exceptions.raise(create {STRING}.make_from_c(zmq_strerror(errno)))
		end
	end

	connect (an_address: STRING) is
		-- Connect Current socket to the peer identified by `an_address'.  Actual semantics of the  command depend on the underlying transport mechanism, how
