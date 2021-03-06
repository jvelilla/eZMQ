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
	delete (an_object : POINTER)
		local res: INTEGER
		do
			res := zmq_close(an_object)
			-- TODO: handle return value
		end

feature {ANY} -- Binding
	bind (an_address: STRING)
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

	connect (an_address: STRING)
		-- Connect Current socket to the peer identified by `an_address'.  Actual semantics of the  command depend on the underlying transport mechanism, how  ever, in cases where peers connect in an asymetric manner, zmq_bind should be called first, zmq_connect afterwards. Formats of the addr  parameter are defined by individual transports. For a list of supported transports have a look at zmq(7) manual page.

		-- Note that single socket can be connected (and bound) to arbitrary number of peers using different transport mechanisms.
	require an_address/=Void
	local rc: INTEGER_32
	      c_str : C_STRING
	do
		create c_str.make (an_address)
		rc:=zmq_connect(item,c_str.item)
		check
			-- TODO: proper error handling
			rc=0
		end
	end

	
feature {ANY} -- Receiving messages

	receive (a_message: ZMQ_MESSAGE)
		-- Receive `a_message' from Current socket; any previous content of
		-- `a_message' will be properly deallocated. Program is blocked until a
		-- message is received; see also `receive_now'.
	local rc: INTEGER_32
	do
		rc:=zmq_recv(item,a_message.item,0)
		if rc/=0 then
			exceptions.raise("ZMQ_SOCKET.receive error not handled")
		end
	end

	receive_now (a_message: ZMQ_MESSAGE)
		-- Receive `a_message' from Current socket; any previous content of
		-- `a_message' will be properly deallocated. If it cannot be processed immediately, errno is set to EAGAIN.

		-- TODO: perhaps non_blocking_receive is a better name?
	local rc: INTEGER_32
	do
		rc:=zmq_recv(item,a_message.item,zmq_noblock)
		if rc/=0 then
			exceptions.raise("ZMQ_SOCKET.receive error not handled")
		end
	end
feature {ANY} -- Sending
	send (a_message: ZMQ_MESSAGE)
		-- Send `a_message'. Blocking call
	require a_message/=Void
	local rc: INTEGER_32
	do
		rc:=zmq_send(item,a_message.item,0)
		check rc=0 end
	end

feature {} -- Constants
	zmq_noblock: INTEGER_32
		external
	                "C inline use <zmq.h>"
        alias
                "{
                ZMQ_NOBLOCK
             }"
		end

feature {NONE} -- Exceptions

	exceptions: EXCEPTIONS
		once
			create Result
		end

end -- class ZMQ_SOCKET
