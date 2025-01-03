# use slim variant of Python 3.13 to reduce image size while maintaining compatibility
FROM python:3.13-slim 

# accept EULA & install prerequisites
ENV ACCEPT_EULA=Y
RUN apt-get update -y && apt-get update \
    && apt-get install -y --no-install-recommends curl gcc g++ gnupg unixodbc-dev

# install SQL Server drivers for Debian 12
RUN curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor -o /usr/share/keyrings/microsoft-archive-keyring.gpg \
    && echo "deb [arch=amd64,arm64,armhf signed-by=/usr/share/keyrings/microsoft-archive-keyring.gpg] https://packages.microsoft.com/debian/12/prod bookworm main" > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get update \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends msodbcsql18 \
    && ACCEPT_EULA=Y apt-get install -y --no-install-recommends mssql-tools18 \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

# set working directory
WORKDIR /app

# cp project files
COPY . .

# install dependencies
RUN python -m venv venv
RUN source venv/bin/activate
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# clean up
RUN apt-get -y clean

# expose port 8000 (Django's default port)
EXPOSE 8000

# start Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]