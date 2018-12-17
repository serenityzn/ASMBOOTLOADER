rm ./*.bin
yasm -f bin -o boot.bin boot-loader512.asm
yasm -f bin -o main.bin main-loader.asm
cp boot.bin ../hello.bin
cat main.bin >> ../hello.bin
count=$(ls -l ../hello.bin|awk '{print $5}')
dd if=/dev/zero bs=1 count=$((3072-count)) >> ../hello.bin
dd if=/dev/zero bs=512 count=15 >> ../hello.bin
dd if=../hello.bin of=../disk.img conv=notrunc
