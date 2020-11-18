#!/bin/sh -x
mkdir -p /data
s3fs -o uid=1000,gid=1000,umask=02,mp_umask=02 dataverse-s3 /data
