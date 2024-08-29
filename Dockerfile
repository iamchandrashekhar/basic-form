FROM mobiledevops/flutter-sdk-image:latest as build
WORKDIR /app
COPY . /app
RUN flutter config --enable-web
RUN flutter build web --release --no-tree-shake-icons

FROM httpd:latest as host
COPY --from=build /app/build/web/ /usr/local/apache2/htdocs/
EXPOSE 80
