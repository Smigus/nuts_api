FROM trenpixster/elixir:1.4.4

ENV APP_NAME nuts_api
ENV VERSION 0.0.1

ENV PORT 4000

RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -&& apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app

ADD mix.* ./
RUN MIX_ENV=prod mix local.rebar
RUN MIX_ENV=prod mix local.hex --force
RUN MIX_ENV=prod mix deps.get

RUN mkdir assets
ADD assets/package.json ./assets
WORKDIR assets
RUN npm install

WORKDIR ..
ADD . .
RUN MIX_ENV=prod mix compile

WORKDIR assets
RUN NODE_ENV=production node_modules/brunch/bin/brunch build --production
WORKDIR ..
RUN MIX_ENV=prod mix phx.digest
#RUN MIX_ENV=prod mix release --no-confirm-missing
#RUN cp rel/$APP_NAME/releases/$VERSION/$APP_NAME.tar.gz ./$APP_NAME.tar.gz
#RUN tar -zxvf $APP_NAME.tar.gz && rm $APP_NAME.tar.gz

EXPOSE 4000

#WORKDIR releases/$VERSION
#ENTRYPOINT ["./nuts_api.sh"]
#CMD ["foreground"]
CMD MIX_ENV=prod mix ecto.create && \
    MIX_ENV=prod mix ecto.migrate && \
    MIX_ENV=prod mix phx.server
