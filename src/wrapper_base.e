note
	description: "Summary description for {WRAPPER_BASE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	revision: "$Revision$"

deferred class
	WRAPPER_BASE

inherit
	DISPOSABLE

feature -- Initialization

	make (a_item: POINTER) is
			-- Create.
		do
			item := a_item
		end

feature -- Destruction

	dispose is
			-- Delete C object.
		do
			delete (item)
		end

feature {WRAPPER_BASE} -- C object

		-- Pointer to the c object.
	item: POINTER

feature {NONE} -- C methods

	delete (a_object: POINTER) is
			-- Delete c object
		deferred
		end

end -- WRAPPER_BASE


