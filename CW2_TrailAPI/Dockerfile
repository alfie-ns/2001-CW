# Use slim variant of Python 3.13
FROM python:3.13-slim 

# Accept EULA & install prerequisites
ENV ACCEPT_EULA=Y PATH="/opt/mssql-tools/bin:${PATH}"
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    curl gcc g++ gnupg unixodbc-dev dos2unix \
    && curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg \
    && echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends msodbcsql18 mssql-tools18 \
    && apt-get clean

# Set working directory
WORKDIR /app

# Set environment variables(i was using .env but they weren't loading with the image)
ENV DB_NAME=COMP2001_ANurse
ENV DB_USER=ANurse
ENV DB_PASSWORD=KzcG127+
ENV DB_HOST=DIST-6-505.uopnet.plymouth.ac.uk
ENV SECRET_KEY=django-insecure-jyrtu3p0aohba=9pi1!k7p^jb1=c%=ncwwe_6++9@2rw*a5m(5

# Copy project files
COPY . .

# Install dependencies
RUN dos2unix manage.py requirements.txt
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Start Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
