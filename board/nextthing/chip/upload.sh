#!/bin/bash

BUILD_NUMBER=$1

if s3cmd put --acl-public --no-guess-mime-type --recursive output/images s3://stak-images/firmware/chip/next/${BUILD_NUMBER}/ |tee s3cmd_out.txt && \
   s3cmd put --acl-public --no-guess-mime-type --recursive output/images s3://opensource.nextthing.co/chip/buildroot/next/${BUILD_NUMBER}/ |tee s3cmd_os_out.txt
then
  echo "${BUILD_NUMBER}" >upload_buildno
  
  s3cmd put --acl-public --no-guess-mime-type upload_buildno s3://stak-images/firmware/chip/next/${BUILD_NUMBER}/build 

	cat s3cmd_out.txt |grep Public |head -n1 |sed -e 's/.*http:/http:/; s/\(http:.*\/\).*\/.*/\1/' >latest
	s3cmd put --acl-public --no-guess-mime-type latest s3://stak-images/firmware/chip/next/latest
	
	cat s3cmd_os_out.txt |grep Public |head -n1 |sed -e 's/.*http:/http:/; s/\(http:.*\/\).*\/.*/\1/' >os_latest
	s3cmd put --acl-public --no-guess-mime-type --add-header="x-amz-website-redirect-location:/chip/buildroot/next/${BUILD_NUMBER}/rootfs.ubi" os_latest s3://opensource.nextthing.co/chip/buildroot/next/latest
fi
