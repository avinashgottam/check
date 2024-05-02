FROM python:3.9.18-alpine3.19

EXPOSE 8080
ENV AMQP_USER=roboshop \
    AMQP_PASS=roboshop123
USER root
WORKDIR /app
COPY requirements.txt /app/
RUN apk add python3-dev build-base linux-headers pcre-dev
RUN pip install -r requirements.txt
COPY *.py /app/
COPY payment.ini /app/
#CMD ["python", "payment.py"]
CMD ["uwsgi", "--ini", "payment.ini"]