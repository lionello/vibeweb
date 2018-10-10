FROM dlanguage/dmd AS build-stage
RUN apt-get update && apt-get -y install \
        libevent-dev \
        libssl-dev \
        python-setuptools \
        rsync

# Install dockerize from GIT submodule
WORKDIR /dockerize
COPY dockerize .
RUN python setup.py install

WORKDIR /app
COPY dub.json .
# First just get the dependencies for better caching
ARG BUILD=release
RUN dub build --build=${BUILD} ; true
# Now prepare the actual build inputs
COPY source /app/source/
COPY views /app/views/
RUN dub build --build=${BUILD}
# Copy final binary + all dependencies to output folder
RUN dockerize -o /output -n /app/vibeweb
# Copy static files last
COPY public /output/app/public/

# For optional debugging for runtime container
# RUN dockerize -o /output -n /bin/bash
# RUN dockerize -o /output -n /bin/ls
# RUN dockerize -o /output -n /bin/date

# Build final runtime container
FROM scratch
COPY --from=build-stage /output /
ENV HTTP_PLATFORM_PORT=80
EXPOSE ${HTTP_PLATFORM_PORT}
ARG RUNAS=nobody
USER ${RUNAS}
WORKDIR /app
CMD ["./vibeweb"]
