    FROM python:3.10-slim

    WORKDIR /app

    # Install required dependencies for Playwright + Chromium
    RUN apt-get update && apt-get install -y \
        wget \
        curl \
        gnupg \
        libnss3 \
        libatk1.0-0 \
        libatk-bridge2.0-0 \
        libcups2 \
        libdrm2 \
        libxkbcommon0 \
        libxcomposite1 \
        libxdamage1 \
        libxrandr2 \
        libgbm1 \
        libasound2 \
        libpangocairo-1.0-0 \
        libpango-1.0-0 \
        libglib2.0-0 \
        libx11-xcb1 \
        libxcb1 \
        libxss1 \
        libxext6 \
        libxi6 \
        fonts-liberation \
        libappindicator3-1 \
        xdg-utils \
        ca-certificates \
        && rm -rf /var/lib/apt/lists/*

    COPY . /app

    # Install Python dependencies
    RUN pip install --no-cache-dir -r requirements.txt

    ENV PLAYWRIGHT_BROWSERS_PATH=/root/.cache/ms-playwright

    # Install Playwright and Chromium browser
    RUN pip install playwright && playwright install chromium

    rm -rf ~/.cache/ms-playwright/*


    EXPOSE 7860

    CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
