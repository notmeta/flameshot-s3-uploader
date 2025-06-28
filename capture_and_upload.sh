#!/bin/bash
url="https://media.notmeta.io"
bucket_name="media.notmeta.io"

temp_file="/tmp/screenshot.png"

rand_file_name=$(openssl rand -hex 6)
prefix=$(date +'%Y/%m/%d')
full_object_name="$prefix/$rand_file_name.png"

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
  # Fix flameshot on wayland https://github.com/flameshot-org/flameshot/issues/2364#issuecomment-2336826654
  QT_QPA_PLATFORM=xcb flameshot gui -r > $temp_file
else
  flameshot gui -r > $temp_file
fi

# For some reason flameshot always seems to exit with 0 even when aborting the process
# so we had to find a way around that.
if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
  rm $temp_file
  notify-send "Screenshot aborted" -a "Flameshot" && exit 1
fi

aws s3 cp "$temp_file" "s3://$bucket_name/$full_object_name" --quiet --profile flameshot-upload
image_url="$url/$full_object_name"

echo -n $image_url | xclip -sel c
notify-send "Image URL copied to clipboard" "$image_url" -a "Flameshot" -i $temp_file
rm $temp_file

aws s3api put-object-tagging --bucket "$bucket_name" --key "$full_object_name" --tagging '{"TagSet": [{ "Key": "flameshot", "Value": "true" }]}' --profile flameshot-upload
