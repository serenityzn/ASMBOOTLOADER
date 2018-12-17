sec=-1
sectornew=1
head=0
cylinder=0
for i in {1..1024}
do
	sec=$((sec+2))
	if [ "x$head" == "x1" ];then
		sectornew=$((sec+32))
	else
		sectornew=$((sec))
	fi

	let "c = i % 9"
	let "d = i % 18"
	#echo "Cylinder=$cylinder, Head=$head, Sector=$sec . Ostatok $i / 9 = $c"
#	echo "=======$i===="
#	echo "ax = [cylinder head+sector]"
	if [ $cylinder -lt 16 ];then
		if [ $sectornew -lt 16 ];then
			echo "     0x0$(echo "obase=16; $cylinder" | bc)0$(echo "obase=16; $sectornew" | bc)  "
		else
			echo "     0x0$(echo "obase=16; $cylinder" | bc)$(echo "obase=16; $sectornew" | bc)  "
		fi
	else
		if [ $sectornew -lt 16 ];then
			echo "     0x$(echo "obase=16; $cylinder" | bc)0$(echo "obase=16; $sectornew" | bc)  "
		else
			echo "     0x$(echo "obase=16; $cylinder" | bc)$(echo "obase=16; $sectornew" | bc)  "
		fi
	fi
#	echo "mov 	ch, 0x$(echo "obase=16; $cylinder" | bc)"
#	echo "mov 	dh, 0x0$head"
#	echo "mov 	cl, 0x$(echo "obase=16; $sec" | bc)"
	if [ "x$sec" == "x17" ];then
		sec=-1
	fi
	if [ "x$c" == "x0" ];then
		if [ "x$head" == "x0" ];then
			head=1
		else
			head=0
		fi
	fi
	if [ "x$d" == "x0" ];then
		cylinder=$((cylinder+1))
	fi

done
