# STAGE 1: svn checkout
FROM fssai/svn as svn
## svn credintials
ARG SVN_URL
ARG SVN_USER
ARG SVN_PASS

RUN svn co $SVN_URL/Frontend \
  --non-interactive \
  --no-auth-cache \
  --username $SVN_USER \
  --password $SVN_PASS 

# STAGE 2: for development
FROM fssai/node as devel
WORKDIR /app
COPY --from=svn /Frontend/package.json /Frontend/package-lock.json ./
RUN npm set progress=false \
 && npm config set depth 0 \
 && npm cache clean --force \
 && npm install
COPY --from=svn /Frontend .
RUN $(npm bin)/ng build --prod
ENTRYPOINT [ "cp", "-av", "dist", "/web" ]

EXPOSE 1000
CMD [ "./node_modules/.bin/ng", "serve", \
      "--port", "1000", "--host", "0.0.0.0" \ 
    ]
    
# STAGE 3: for Production    
FROM fssai/nginx
WORKDIR /usr/share/nginx/html
COPY --from=devel /web/dist .
COPY ./default.conf /etc/nginx/config.d/