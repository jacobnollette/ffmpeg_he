givenFolder="$@";


for file in `find "$givenFolder" -type f -name '*  *'`
	do
		rename 's/  / /g' "$file";
	done;

for file in `find "$givenFolder" -type f -name '*   *'`
	do
		rename 's/   / /g' "$file";
	done
