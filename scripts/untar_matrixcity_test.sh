for num in {1..10}
do  
tar -xvf block_${num}_test.tar
mkdir block_${num}_test/input
mv block_${num}_test/*.png block_${num}_test/input
done 