FROM python:3.10-slim

WORKDIR /app

# Install system dependencies for Playwright + Chromium
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

# Copy app code
COPY . /app

# Install Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Set Playwright install path to persist browser cache if needed
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright

# Install Chromium browser for Playwright
RUN playwright install --with-deps chromium

# Expose Gradio or Uvicorn default port
EXPOSE 7860

# Run the FastAPI server
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "7860"]
