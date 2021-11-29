ARG CENTOS_VER=7.9.2009
FROM fssai/centos:${CENTOS_VER}
WORKDIR /app
ADD . /app
ENV EMAIL Test e-mail from fssai/mail_tester
CMD ["python", "email_tester.py"]