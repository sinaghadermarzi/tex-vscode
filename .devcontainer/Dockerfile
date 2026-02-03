FROM danteev/texlive

# Update CA certificates to fix SSL issues
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    openssl \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Java for LTeX (needed for ARM64 since ltex-ls only provides x64 binaries)
RUN apt-get update && apt-get install -y --no-install-recommends \
    default-jre-headless \
    && rm -rf /var/lib/apt/lists/*

# Install tools
RUN pip install arxiv-latex-cleaner==0.1.* pdflinkchecker-cli==0.2.* --break-system-packages
