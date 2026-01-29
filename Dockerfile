# Build stage
FROM python:3.14.2 AS builder
ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Final runtime stage
FROM python:3.14.2
COPY --from=builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"
EXPOSE 5000

# Run the application:
COPY *.py .
CMD ["python", "app.py"]
