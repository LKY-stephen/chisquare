
BEGIN{
    path='1.bmp'
	if File.exist?(path)
		cover=open(path,'rb')
	else
		puts 'error input'
		exit()
	end
	path='stego3.bmp'
	if File.exist?(path)
		stego=open(path,'rb')
	else
		puts 'error input'
		exit()
	end
 }
 
   $MSN=0.0
   covercontent=[]
   #puts cover.size()
   cover.each_byte {|ch| covercontent<<ch}
   #puts covercontent
   coverpsize=covercontent.size()
   coverdoffset=covercontent[10]|(covercontent[11]<<8)|(covercontent[12]<<16)|(covercontent[13]<<24)
   coverdsize=coverpsize-coverdoffset
   #puts doffset
   
   stegocontent=[]
   #puts Picture.size()
   stego.each_byte {|ch| stegocontent<<ch}
   #puts stegocontent
   width=stegocontent[18]|(stegocontent[19]<<8)|(stegocontent[20]<<16)|(stegocontent[21]<<24)
   height=stegocontent[22]|(stegocontent[23]<<8)|(stegocontent[24]<<16)|(stegocontent[25]<<24)
   iterator=coverdoffset
   while iterator<coverpsize
		$MSN+=(covercontent[iterator]-stegocontent[iterator])**2
		iterator+=1
   end
   $MSN/=(height*width).to_f
   puts"#{10*Math.log10(65025.0/$MSN)}"