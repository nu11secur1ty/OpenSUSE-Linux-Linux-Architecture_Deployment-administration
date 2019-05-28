```bash
#!/usr/bin/bash
# author V.Varbanovski 

# declarete all folders in array
# folder0 folder1 folder2

tupotii=( folder0 folder1 folder2 )

for i in "${tupotii[@]}"
do       
	find $i -type f -mtime +7 -exec rm -fv {} \;
	#find $i -type f -mmin +1 -exec rm -fv {} \;
done
	echo "Djanki"
exit 0;
```
