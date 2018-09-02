local class = require 'ext.class'
local fromlua = require 'ext.fromlua'
local file = require 'ext.file'

local MIMETypes = class()

MIMETypes.filename = 'mimetypes.conf'

function MIMETypes:init(filename)
	 self.filename = filename
	 self.types = fromlua(file[self.filename] or '')
	if not self.types then
		local CSV = require 'csv'
		self.types = {}
		for _,source in pairs{'application','audio','image','message','model','multipart','text','video'} do
			print('fetching '..source..' mime types...')
			local csv = CSV.string(assert(http.request('http://www.iana.org/assignments/media-types/'..source..'.csv')))
			csv:setColumnNames(csv.rows:remove(1))
			for _,row in ipairs(csv.rows) do
				self.types[row.Name:lower()] = row.Template
			end
		end
		-- well this is strange
		self.types.js = self.types.js or self.types.javascript
		file[self.filename] =  tolua(self.types,{indent = true})
	end
end

return MIMETypes
