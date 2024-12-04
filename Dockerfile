FROM node:14

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Use CMD only to define the default behavior /////
CMD ["npm", "start"]

