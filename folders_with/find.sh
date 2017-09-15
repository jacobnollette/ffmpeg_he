
#find $@ -type f -exec file -N -i -- {} + | grep video



#find "$@" -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p'
find "$@" -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p'
#find "$@" -type f -exec file -N -i -- {} + | grep video


# | xargs -I {} processVideo -c "{}";
