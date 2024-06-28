----------------------------------------------------------------------
-- ezLCD Read Write Files
--
-- This program demonstrates how to read and write file to the SD
-- card of the ezLCD-5035
--
-- Created  06/28/2024  -  Jacob Christ
----------------------------------------------------------------------

-- io.open, io.read, io.write, io.close, 
-- os.remove()
-- os.rename()

function WriteFile(filename)
	print("Writing: " .. filename)
	local f = assert(io.open(filename, "w")) -- Open datafile.txt for "w" writing (overwrite existing)
	f:write("This is line one\n")
	f:write("This is line two\n")
	f:write("This is line three") -- note no end of line
	f:close()
end

function ReadFile(filename)
	print("Reading: " .. filename)
	local f = assert(io.open(filename, "r"))
	repeat
		local t = f:read("*l") -- "*l" read from current position until the end of the line
		if t == nil then
			print("..end of file..")
		else
			print(t)
		end
	until t == nil
	f:close()
end

function Main()
	local filename1 = "datafile.txt"
	local filename2 = "newfile.txt"

	ez.Cls(ez.RGB(0,0,0))
	WriteFile(filename1) -- Create a file
	os.rename(filename1, filename2) -- Rename file on the SD card
	ReadFile(filename2) -- Read a file

	WriteFile(filename1) -- Create the file again.
	os.remove(filename2) -- Remove a file from the SD card

	-- Uncomment this line to create a file error (due to reading a non-existing file)
	-- ReadFile(filename2) -- Read a file

end

function ErrorHandler(errmsg)
    print(debug.traceback())
    print(errmsg)
end

-- Main()

-- Call Main() protected by ErrorHandler
Rc, Err = xpcall(function() Main() end, ErrorHandler)

