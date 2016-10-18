#this is the script that could calculate the chisquare score of a picture
require 'googlecharts'
require 'win32ole'
require 'Statistics2'

BEGIN{
    puts "give me the name of bmp picture"
	  path=gets.chomp()
	if File.exist?(path)
		Picture=open(path,'rb')
	else
		puts 'error input'
		exit()
	end
}
   content=[]
   calculate=Array.new(256,0)
   #puts Picture.size()
   Picture.each_byte {|ch| content<<ch}
   #puts content
   if content[0]!=0x42||content[1]!=0x4d
		puts "not bmp"
		exit()
	end
   psize=content.size()
   doffset=content[10]|(content[11]<<8)|(content[12]<<16)|(content[13]<<24)
   dsize=psize-doffset
   #puts doffset
   iterator=doffset
   while iterator<psize
		calculate[content[iterator]]+=1
		iterator+=1
   end
   #puts calculate
   url=Gchart.bar( :data => calculate,
                   :size => '600x400',
                   :bar_width_and_spacing => '1,1')
   #puts url.size()
   #puts url
   ie = WIN32OLE.new('InternetExplorer.Application')
   ie.visible = true
   ie.navigate(url)
   i=0
   sum=0
   while(i<256)
        middle=(calculate[i]+calculate[i+1]).to_f/2
        #puts middle
        sum+=((calculate[i]-middle)**2).to_f/middle
        i+=2
   end
   puts "p:#{1-Statistics2.chi2dist(sum,127)}"
END{
	if Picture
		Picture.close()
	end
}
	