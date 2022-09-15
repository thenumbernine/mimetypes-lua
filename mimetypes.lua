local class = require 'ext.class'
local fromlua = require 'ext.fromlua'
local tolua = require 'ext.tolua'
local file = require 'ext.file'

local function getFile(url)
	-- luasocket
	local usesockets, http = pcall(require, 'socket.http')
	if usesockets then
		return assert(http.request(url))
	end

	-- curl
	if os.execute('curl --help 2> /dev/null') then
		os.execute('curl -o tmp.csv '..url)
		local data = assert(file'tmp.csv':read())
		file'tmp.csv':remove()
		return data
	end

	if os.execute('wget --help 2> /dev/null') then
		os.execute('wget -O tmp.csv '..url)
		local data = assert(file'tmp.csv':read())
		file'tmp.csv':remove()
		return data
	end

	error("couldn't determine how to download files")
end

local MIMETypes = class()

MIMETypes.filename = 'mimetypes.conf'

function MIMETypes:init(filename)
	self.filename = filename
	self.types = fromlua(file(self.filename):read() or '')
	if not self.types then
		local CSV = require 'csv'
		self.types = {}
		for _,source in pairs{'application','audio','image','message','model','multipart','text','video'} do
			print('fetching '..source..' mime types...')
			local csv = CSV.string(getFile('http://www.iana.org/assignments/media-types/'..source..'.csv'))
			csv:setColumnNames(csv.rows:remove(1))
			for _,row in ipairs(csv.rows) do
				self.types[row.Name:lower()] = row.Template
			end
			file'tmp.csv':remove()
		end
		-- well this is strange
		self.types.js = self.types.js or self.types.javascript
		file(self.filename):write(tolua(self.types,{indent = true}))
	end
end

return MIMETypes
