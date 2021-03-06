note
	description: "Summary description for {ZMQ_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ZMQ_API
	inherit ANY undefine is_equal, copy end

		-- TODO: insert typedefs class
feature {} -- External calls

	zmq_init (an_io_threads: INTEGER_32): POINTER
		-- old legacy API
 		-- ZMQ_EXPORT void *zmq_init (int io_threads);
        external
	                "C inline use <zmq.h>"
        alias
                "{
               	zmq_init ((int)$an_io_threads)
             }"
		end

	zmq_setsockopt (a_s: POINTER; an_option: INTEGER_32; an_optval: POINTER; an_optvallen: NATURAL_32): INTEGER_32
 		--ZMQ_EXPORT int zmq_setsockopt (void *s, int option, const void *optval,size_t optvallen);

		external
	                "C inline use <zmq.h>"
		alias
				"{
			 	zmq_setsockopt ((void *)$a_s, (int)$an_option, (const void *)$an_optval,(size_t)$an_optvallen)
		}"
		end

	zmq_msg_init_size (a_msg: POINTER; a_size: NATURAL_32): INTEGER_32
 		-- ZMQ_EXPORT int zmq_msg_init_size (zmq_msg_t *msg, size_t size);
		external
	                "C inline use <zmq.h>"
		alias
				"{
			 zmq_msg_init_size ((zmq_msg_t *)$a_msg, (size_t)$a_size)
		}"
		end

	zmq_send (a_s: POINTER; a_msg: POINTER; a_flags: INTEGER_32): INTEGER_32
 		--ZMQ_EXPORT int zmq_sendmsg (void *s, zmq_msg_t *msg, int flags);
 		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_sendmsg ((void *)$a_s, (zmq_msg_t *)$a_msg, (int)$a_flags)
		}"
		end

	zmq_msg_copy (a_dest: POINTER; a_src: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_msg_copy (zmq_msg_t *dest, zmq_msg_t *src);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_msg_copy ((zmq_msg_t *)$a_dest, (zmq_msg_t *)$a_src)
		}"
		end

	zmq_stopwatch_stop (a_watch: POINTER): NATURAL_32
 		-- ZMQ_EXPORT unsigned long zmq_stopwatch_stop (void *watch_);
		external
	                "C inline use <zmq.h>"
		alias "{
				zmq_stopwatch_stop ((void *)$a_watch)
		}"
		end

	zmq_msg_close (a_msg: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_msg_close (zmq_msg_t *msg);
		external
	                "C inline use <zmq.h>"

		alias "{
			zmq_msg_close((zmq_msg_t *)$a_msg)
		}"
		end

	zmq_msg_size (a_msg: POINTER): NATURAL_32
 		-- ZMQ_EXPORT size_t zmq_msg_size (zmq_msg_t *msg);
		external
	                "C inline use <zmq.h>"

		alias "{
			zmq_msg_size ((zmq_msg_t *)$a_msg)
		}"
		end

	zmq_socket (a_context: POINTER; a_type: INTEGER_32): POINTER
 		-- ZMQ_EXPORT void *zmq_socket (void *context, int type);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_socket ((void *)$a_context, (int)$a_type)
		}"
		end

	zmq_strerror (an_errnum: INTEGER_32): POINTER
 		-- ZMQ_EXPORT const char *zmq_strerror (int errnum);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_strerror ((int)$an_errnum)
		}"
		end

	zmq_close (a_s: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_close (void *s);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_close ((void *)$a_s)
		}"
		end

	zmq_sleep (a_seconds: INTEGER_32)
 		-- ZMQ_EXPORT void zmq_sleep (int seconds_);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_sleep ((int)$a_seconds)
		}"
		end

	zmq_msg_init_data (a_msg: POINTER; a_data: POINTER; a_size: NATURAL_32; a_ffn: POINTER; a_hint: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_msg_init_data (zmq_msg_t *msg, void *data, size_t size, zmq_free_fn *ffn, void *hint);

		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_msg_init_data ((zmq_msg_t *)$a_msg, (void *)$a_data, (size_t)$a_size, (zmq_free_fn *)$a_ffn, (void *)$a_hint)
		}"
		end

	zmq_term (a_context: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_term (void *context);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_term ((void *)$a_context)
		}"
		end

	
	zmq_connect (a_s: POINTER; an_addr: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_connect (void *s, const char *addr);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_connect ((void *)$a_s, (const char *)$an_addr)
		}"
		end

	zmq_msg_data (a_msg: POINTER): POINTER
 		-- ZMQ_EXPORT void *zmq_msg_data (zmq_msg_t *msg);
		external
	                "C inline use <zmq.h>"
		alias "{
			 zmq_msg_data ((zmq_msg_t *)$a_msg)
		}"
		end

	zmq_bind (a_s: POINTER; an_addr: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_bind (void *s, const char *addr);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_bind ((void *)$a_s, (const char *)$an_addr)
		}"
		end

	zmq_recv (a_s: POINTER; a_msg: POINTER; a_flags: INTEGER_32): INTEGER_32
 		-- ZMQ_EXPORT int zmq_recvmsg (void *s, zmq_msg_t *msg, int flags);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_recvmsg ((void *)$a_s,(zmq_msg_t *)$a_msg, (int)$a_flags)
		}"
		end

	zmq_stopwatch_start: POINTER
 		-- ZMQ_EXPORT void *zmq_stopwatch_start ();
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_stopwatch_start ()
		}"
		end

	zmq_poll (an_items: POINTER; a_nitems: INTEGER_32; a_timeout: INTEGER_32): INTEGER_32
 		-- ZMQ_EXPORT int zmq_poll (zmq_pollitem_t *items, int nitems, long timeout);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_poll ((zmq_pollitem_t *)$an_items, (int)$a_nitems, (long)$a_timeout)
		}"
		end

	zmq_msg_move (a_dest: POINTER; a_src: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_msg_move (zmq_msg_t *dest, zmq_msg_t *src);
		external
	                "C inline use <zmq.h>"
		alias "{
			zmq_msg_move ((zmq_msg_t *)$a_dest,(zmq_msg_t *)$a_src)
		}"
		end

	zmq_msg_init (a_msg: POINTER): INTEGER_32
 		-- ZMQ_EXPORT int zmq_msg_init (zmq_msg_t *msg);
		external
	                "C inline use <zmq.h>"
		alias "{
			 zmq_msg_init ((zmq_msg_t *)$a_msg)
		}"
		end


end -- class ZMQ_API
