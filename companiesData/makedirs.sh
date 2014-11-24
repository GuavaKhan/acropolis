for entry in `cat $1`; do
	touch $entry/.dontdelete
done
