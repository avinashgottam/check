FROM node:18.19.1-alpine3.19

# Expose port 8080
EXPOSE 8080

# Add a new group and user 'roboshop'
RUN addgroup -S roboshop && adduser -S roboshop -G roboshop

# Set working directory
WORKDIR /opt/server

# Set environment variable
ENV MONGO=true

# Change ownership of the working directory to 'roboshop'
RUN chown roboshop:roboshop /opt/server

# Switch to 'roboshop' user
USER roboshop

# Copy package.json and server.js
COPY package.json server.js /opt/server/

# Install npm dependencies
RUN npm install

# Print a simple message
RUN echo "Hello, world!"

# Add a new user 'cart'
USER root
RUN adduser cart

# Switch back to 'roboshop' user
USER roboshop

# Specify the command to run when the container starts
CMD ["node", "server.js"]
