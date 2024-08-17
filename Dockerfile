FROM mobiledevops/flutter-sdk-image:3.19.4 AS Build
WORKDIR /app
COPY . /app
RUN flutter config enable-web
RUN flutter build web --release --no-tree-shake-icons

FROM httpd:latest AS Host
COPY --from=Build /app/build/web/ /usr/local/apache2/htdocs/
EXPOSE 80
