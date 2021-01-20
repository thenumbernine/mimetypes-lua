MIME types

This is a simple class that feteches and caches the MIME types associated with file formats.

It gets them from iana.org.

It also automatically associates the .js file format with the .javascript file format.

Depends on my lua-ext and lua-csv projects.

Expects luasocket, curl, or wget to be installed for downloading the file.
