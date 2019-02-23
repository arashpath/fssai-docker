FROM fssai/node
WORKDIR /web
# Installing required npm packages
COPY ./package.json ./package-lock.json ./
RUN npm set progress=false \
 && npm config set depth 0 \
 && npm cache clean --force \
 && npm install
# Building frontend
COPY . .
RUN $(npm bin)/ng build --prod
EXPOSE 1000
VOLUME /deploy
# Copy Build files to deploy and run container.
CMD cp -av dist /deploy/web/ \
 && ./node_modules/.bin/ng serve --port 1000 --host 0.0.0.0
