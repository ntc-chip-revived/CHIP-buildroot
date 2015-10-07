#!/bin/bash

BUILD_NUMBER=$1
S3_DEST_BASE=s3://opensource.nextthing.co/chip/buildroot/next

tar czf /tmp/CHIP-buildroot-build${BUILD_NUMBER}.tar.gz ../build; || exit $?

s3cmd put --acl-public --no-guess-mime-type /tmp/CHIP-buildroot-build${BUILD_NUMBER}.tar.gz ${S3_DEST_BASE}/${BUILD_NUMBER}/build${BUILD_NUMBER}.tar.gz || exit $?

rm /tmp/CHIP-buildroot-build%(prop:buildnumber)s.tar.gz || exit $?
