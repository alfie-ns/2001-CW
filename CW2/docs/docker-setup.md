# Deploy your service using Docker

This lab will walk you through the steps needed to deploy and publish your service that manages people’s names and notes using Docker.

Specifically, you will learn how to write a Dockerfile, build a Docker image, publish it to a container registry, and run a container.

After completing previous lab sessions, you should have a project directory that looks like this:

```
comp2001_flask_tutorial/
│
├── templates/
│   └── home.html
│
├── app.py
├── config.py
├── models.py
├── notes.py
├── people.py
├── requirements.txt
└── swagger.yml
```

Before starting this lab, ensure you have Docker installed on your machine and have created a Docker Hub account. To verify your Docker installation, run the commands below in PowerShell or Terminal.

```bash
docker --version
docker run hello-world
```

If everything works as expected, you should see the message below.

```
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 <https://hub.docker.com/>

For more examples and ideas, visit:
 <https://docs.docker.com/get-started/>
```

## Create the Dockerfile

A Dockerfile is a script containing commands to build a Docker image. In your project directory, create a new file named `Dockerfile` without any extension and copy the following lines into it.

```docker
FROM python:3.9-slim

ENV ACCEPT_EULA=Y
RUN apt-get update -y && apt-get update \\
  && apt-get install -y --no-install-recommends curl gcc g++ gnupg unixodbc-dev

RUN curl <https://packages.microsoft.com/keys/microsoft.asc> | apt-key add - \\
  && curl <https://packages.microsoft.com/config/debian/10/prod.list> > /etc/apt/sources.list.d/mssql-release.list \\
  && apt-get update \\
  && apt-get install -y --no-install-recommends --allow-unauthenticated msodbcsql17 mssql-tools \\
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \\
  && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

COPY . .

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN apt-get -y clean

EXPOSE 8000

CMD ["python", "app.py"]
```

Let us examine each section in detail:

1. Base Image Selection:

   ```docker
   FROM python:3.9-slim
   ```

   This line specifies the starting point - a lightweight Python 3.9 image. The slim variant provides a balance between image size and functionality, containing just enough packages to run Python applications. This is particularly important in production environments where image size affects deployment time and resource usage.
2. SQL Server Requirements:

   ```docker
   ENV ACCEPT_EULA=Y
   RUN apt-get update -y && apt-get update \\
     && apt-get install -y --no-install-recommends curl gcc g++ gnupg unixodbc-dev
   ```

   These commands prepare our container for SQL Server connectivity. We accept the End User License Agreement (EULA), update the package lists, and install necessary build tools. The `--no-install-recommends` flag keeps our image size smaller by avoiding optional packages.
3. SQL Server Driver Installation:

   ```docker
   RUN curl <https://packages.microsoft.com/keys/microsoft.asc> | apt-key add - \\
     && curl <https://packages.microsoft.com/config/debian/10/prod.list> > /etc/apt/sources.list.d/mssql-release.list \\
     && apt-get update \\
     && apt-get install -y --no-install-recommends --allow-unauthenticated msodbcsql17 mssql-tools \\
     && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \\
     && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
   ```

   This command adds Microsoft’s package repository and installs SQL Server drivers. We also configure the system PATH to include SQL Server tools, making them accessible throughout the container.
4. Application Setup:

   ```docker
   COPY . .

   RUN pip install --upgrade pip
   RUN pip install -r requirements.txt

   RUN apt-get -y clean

   EXPOSE 8000
   ```

   Here, we first copy our code and install all the dependencies listed in requirements.txt. After the installation, we clean up the apt cache to reduce the final image size. We also informs Docker that the container will listen on port 8000 at runtime. Notably, this is purely documentational and doesn’t actually publish the port. Ensure that you explicitly map the port when running the container.
5. Run the Code:

   ```docker
   CMD ["python", "app.py"]
   ```

   This line specifies the command that will be executed when the container starts.

## Build the Docker Image

Open your PowerShell or Terminal in your project directory and run the build command:

```bash
docker build -t <your_image_name> .
```

The `-t` flag tags your image with a name and version. The period at the end tells Docker to look for the Dockerfile in the current directory. Remember to replace the `<your_image_name>` with an actual name you would like to use.

## Publish the Image

After successfully building your image, the next step is to share it through Docker Hub. To authenticate with Docker Hub, use the following command:

```bash
docker login
```

If you haven’t logged in in Docker Desktop, you will be asked to enter your username and password.

For Docker Hub, images must be prefixed with your Docker Hub username. Use the command below to tag the image to your username.

```bash
docker tag <your_image_name> <your_username>/<your_image_name>
```

You can now push your image using the command:

```bash
docker push <your_username>/<your_image_name>
```

During the push process, Docker will upload each layer of your image separately. This layer-based approach means that if you update your image later, only the changed layers need to be uploaded.

## Run the Container

You can pull any image including the one you just published by using the command:

```bash
docker pull <your_username>/<your_image_name>
```

The main command to run your container is:

```bash
docker run -p 8000:8000 <your_username>/<your_image_name>
```

The `-p 8000:8000` flag maps port 8000 (the first one) on your host machine to port 8000 in the container. The second number must match the port specified in your `EXPOSE` command.

To verify that your container is running properly, go to Docker Desktop or use the following command.

```bash
docker ps
```

The command show you all running containers, their IDs, names, status, and port mappings.

---

- [ ] Please include the link to your GitHub repo and also the `<username>`/<image_name> combination for your docker image at the bottom of the first page.
- [X] Make sure you have pulled your image from Docker Hub successfully so that we can download and mark.
