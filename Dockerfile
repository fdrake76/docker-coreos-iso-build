FROM centos:7
RUN yum install -y mkisofs
ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT /entrypoint.sh
