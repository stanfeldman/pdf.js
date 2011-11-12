###
PDFImage - embeds images in PDF documents
By Devon Govett
###

fs = require 'fs'
Data = require './data'
JPEG = require './image/jpeg'

class PDFImage
    @open: (filename) ->
        @contents = fs.readFileSync filename
        return unless @contents
        
        @data = new Data @contents
        @filter = null
        
        # load info
        data = @data
        firstByte = data.byteAt(0)
        
        if firstByte is 0xFF and data.byteAt(1) is 0xD8
            return new JPEG(data)
            
        else
            throw new Error 'Unknown image format.'
                    
module.exports = PDFImage
