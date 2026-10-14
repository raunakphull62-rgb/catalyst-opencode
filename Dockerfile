
FROM node:22-bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV NODE_ENV=production
ENV PORT=9000
ENV HOSTNAME=0.0.0.0

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       git \
       ca-certificates \
       openssh-client \
       curl \
       bash \
       tini \
    && rm -rf /var/lib/apt/lists/*

RUN npm install --global opencode-ai \
    && npm cache clean --force

WORKDIR /workspace

EXPOSE 9000

ENTRYPOINT ["/usr/bin/tini", "--"]

CMD ["sh", "-c", "if [ -z \"$OPENCODE_SERVER_PASSWORD\" ]; then echo 'ERROR: Set OPENCODE_SERVER_PASSWORD in the deployment environment.' >&2; exit 1; fi; exec opencode web --hostname 0.0.0.0 --port \"${PORT:-9000}\""]
