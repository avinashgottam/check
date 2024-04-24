FROM node:18.19.1-alpine3.19
EXPOSE 8080
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop
WORKDIR /opt/server
ENV MONGO=true
RUN chown roboshop:roboshop /opt/server
USER roboshop
COPY package.json /opt/server/
COPY server.js /opt/server/
RUN npm install
CMD ["node", "server.js"]