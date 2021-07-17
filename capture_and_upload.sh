url="https://media.notmeta.io"
bucket_name="media.notmeta.io"

temp_file="/tmp/screenshot.png"

rand_file_name=$(openssl rand -hex 6)
prefix=$(date +'%Y/%m/%d')
full_object_name="$prefix/$rand_file_name.png"

# Run flameshot --help for options
flameshot gui -r > $temp_file

# For some reason flameshot always seems to exit with 0 even when aborting the process
# so we had to find a way around that.
if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
	rm $temp_file
  notify-send "Screenshot aborted" -a "Flameshot" && exit 1
fi

aws s3 cp "$temp_file" "s3://$bucket_name/$full_object_name" --profile flameshot-upload
image_url="$url/$full_object_name"

echo -n $image_url | xclip -sel c
notify-send "Image URL copied to clipboard" "$image_url" -a "Flameshot" -i $temp_file
rm $temp_file

