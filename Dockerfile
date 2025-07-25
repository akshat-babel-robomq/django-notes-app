FROM python:3.9

WORKDIR /app/backend

COPY requirements.txt /app/backend
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y gcc default-libmysqlclient-dev pkg-config \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN pip install mysqlclient
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app source code
COPY . /app/backend

# Make sure entrypoint.sh is executable
RUN chmod +x /app/backend/entrypoint.sh

# Set entrypoint to your script
ENTRYPOINT ["/app/backend/entrypoint.sh"]

# Expose Django's default port
EXPOSE 8000

