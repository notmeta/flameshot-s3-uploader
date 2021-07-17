# flameshot-s3-uploader

Runs `flameshot gui` and uploads the contents with a random file name and dated prefix to an S3 bucket, copying the URL to the clipboard.

Generated url format: `https://media.notmeta.io/2021/07/17/e9a6ced4e1b0.png`

Requirements:
- [Flameshot](https://github.com/flameshot-org/flameshot/)
- S3 bucket
- openssl
- [xclip](https://linux.die.net/man/1/xclip)

Adapted from https://github.com/TannerReynolds/ShareX-Upload-Server#using-with-flameshot-linux
