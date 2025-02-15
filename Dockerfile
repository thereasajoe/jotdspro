# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends curl ca-certificates

# Download and install uv
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the installed binary is on the PATH
ENV PATH="/root/.local/bin:$PATH"

# Expose port 8000 for the FastAPI app
EXPOSE 8000

# Run the FastAPI app
CMD ["uvicorn", "app.app:app", "--host", "0.0.0.0", "--port", "8000"]

RUN mkdir -p /app/data