
FROM node:22-bookworm-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends git ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN npm install -g opencode-ai

WORKDIR /workspace

ENV HOSTNAME=0.0.0.0
ENV PORT=9000
ENV NODE_ENV=production

EXPOSE 9000

CMD ["sh", "-c", "exec opencode web --hostname 0.0.0.0 --port ${PORT:-9000}"]
