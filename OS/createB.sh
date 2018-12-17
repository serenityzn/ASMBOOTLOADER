head=0
cyl=0
count=1
:>../hello.bin
for i in {1..2880}
do	
	if [ "x$count" == "x19" ];then
		count=1
		if [ "x$head" != "x1" ];then
			head=1
		else
			head=0
			cyl=$((cyl+1))
		fi
	fi
	count=$((count+1))
	echo "text db 'THIS IS THE SECTOR $i. Cylinder =$cyl. Head =$head  ', 0" > test.asm
	echo 'times 512-($-$$) db 0' >> test.asm
	yasm -f bin -o sector3.bin test.asm
	cat sector3.bin >> ../hello.bin
done
