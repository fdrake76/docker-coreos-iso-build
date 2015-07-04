# docker-coreos-iso-build

A simple docker image which takes a Cloud Config file and makes an ISO suitable for creating a CoreOS instance.

Volumes To Mount
----------------

* /input: Directory containing the config YML file.  Only the first file in the directory is used.
* /output: Directory containing the resulting ISO file, using the YML file's filename.

Example
-------

    docker -it --rm run \
      -v /Users/bob/coreos-config/files:/input \
      -v /Users/bob/coreos-config/iso:/output \
      coreos-iso-build:latest
