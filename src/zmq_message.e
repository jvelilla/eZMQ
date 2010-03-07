note
	description: "Summary description for {ZMQ_MESSAGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class ZMQ_MESSAGE
	-- ØMQ message

	-- Note: current design is a sketch. Most probably we want to make it a generic class allowing data to be of specific types instead of being ANY.
inherit
	MEMORY_STRUCTURE undefine default_create end
	ZMQ_API undefine default_create end

create {ANY} default_create,  with_size, with_string

feature {} -- Creation

	default_create is
		-- Initialize an empty ØMQ message
		local res: INTEGER_32
		do
			make
			res:=zmq_msg_init(item)
		end

	with_size (a_size: NATURAL_32) is
		-- Initialize a ØMQ message `a_size' bytes long. The implementation
		-- chooses whether it is more efficient to store message content on the
		-- stack (small  messages) or  on  the  heap  (large  messages).

		-- TODO: a_size: like size_t
	local res: INTEGER_32
	do
		make
		res:=zmq_msg_init_size(item,a_size)
	end

--	with (some_data: ANY) is
--		-- Initialize a ØMQ message with `some_data'; the
--		-- physical piece of memory is referred by and NOT copied. This means
--		-- that

--		-- * if you change `some_data' the changes will also affect Current
--		--   message.

--		-- * object references in `some_data' are not part of the message; in
--		-- particular the native array composing the body of a STRING is not
--		-- part of the message.

--		-- * expanded object may not be put into a message.

--		-- * `some_data' will no be disposed until Current message is alive.
--	require some_data/=Void
--	local res: INTEGER_32
--	do
--		make
--		-- Keep a reference to some_data; we do not want it to be freed or garbage-collected.
--		any_data := some_data
--		res:=zmq_msg_init_data(item, some_data.default_pointer, some_data..to_natural_32, default_pointer, default_pointer)
--	ensure
--		implementation: data=some_data.to_pointer and size=some_data.object_size.to_natural_32
--	end

	with_string (a_string: STRING) is
		-- Initialize a ØMQ message with the content of `a_string'; the data is NOT
		-- copied only referred by with a pointer. Current minimalist design of the
		-- wrapper requires `a_string' at least not to change size during Current
		-- message lifetime
		-- TODO: use IMMUTABLE_STRING_32  to ensures this.
	require a_string/=Void
	local res: INTEGER_32
		  c_str:C_STRING
	do
	    create c_str.make (a_string)
		make
		-- Keep a reference to `a_string'
		any_data:=a_string
		res:=zmq_msg_init_data(item,c_str.item,c_str.count.as_natural_32,default_pointer, default_pointer)
	ensure
		--implementation: data=c_str.item and size=c_str.count.as_natural_32
	end
feature {ANY} -- Disposing

	delete is
		local rc: INTEGER_32
		do
			any_data := Void
			rc:=zmq_msg_close(item)
			check rc=0 end
		end

	close is
		local rc: INTEGER_32
		do
			rc:=zmq_msg_close(item)
			check rc=0 end
		end

feature {ANY} -- Command

	initialize is
		-- Initialize message
	local rc: INTEGER_32
	do
		rc := zmq_msg_init(item)
		check rc/=0 end
		-- Note: It is debatable whenever the following style is reccomendedable:
		-- if rc /= 0 then	
		--		exceptions.raise (create {STRING}.make_from_c(zmq_strerror (errno)))
		-- end
	end

feature {ANY} -- Size

	size: NATURAL_32 is
		-- the size of message content

		-- TODO: shall be like size_t
	do
		Result := zmq_msg_size(item)
	end

	data: POINTER is
		do
			Result:=zmq_msg_data(item)
		end

feature {} -- Implementation

	any_data: ANY is
		-- Reference to the data feed at creation time using `with_data'
		attribute
	end


	structure_size: INTEGER
			-- Size to allocate (in bytes)
		do
			Result := struct_size
		end

	struct_size: INTEGER is
		external   "C inline use <zmq.h>"
		alias "sizeof(zmq_msg_t)"
		end

feature {NONE} -- Exceptions

	exceptions: EXCEPTIONS
		once
			create Result
		end

end -- ZMQ_MESSAGE

