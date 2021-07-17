# flameshot-s3-uploader

Runs `flameshot gui` and uploads the contents with a random file name and dated prefix to an S3 bucket, copying the URL to the clipboard.

Generated url format: `https://media.notmeta.io/2021/07/17/e9a6ced4e1b0.png`

## Requirements:
- [Flameshot](https://github.com/flameshot-org/flameshot/)
- S3 bucket
- aws-cli
- openssl
- [xclip](https://linux.die.net/man/1/xclip)

## Setup:
- Clone this repo or copy `capture_and_upload.sh`
- Modify url and bucket name within script
- Run `aws configure --profile flameshot-upload` and enter IAM user details with permission to PutObject to your bucket
- You may need to `chmod +x capture_and_upload.sh`
- Add to /usr/local/bin `sudo cp capture_and_upload.sh /usr/local/bin/flameshots3`
- Optionally assign `flameshots3` to keyboard shortcut

Adapted from https://github.com/TannerReynolds/ShareX-Upload-Server#using-with-flameshot-linux
