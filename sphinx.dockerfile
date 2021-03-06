FROM python:3.8-alpine3.10 AS sphinx_min
COPY sphinx_ctx/min.txt /tmp/
RUN apk --no-cache -U upgrade && apk --no-cache add curl git make \
  && pip install -r /tmp/min.txt
WORKDIR /src

#---

FROM sphinx_min AS sphinx_base
COPY sphinx_ctx/base.txt /tmp/
RUN pip install -r /tmp/base.txt

#---

FROM sphinx_base AS sphinx_featured
COPY sphinx_ctx/featured.txt /tmp/
RUN apk add -U --no-cache gcc linux-headers musl-dev libffi-dev zlib-dev jpeg-dev
RUN pip install -r /tmp/featured.txt
