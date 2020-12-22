# isso-admin

Commands for managing an [Isso](https://posativ.org/isso/) instance in a Makefile.

## Prereqs

- Clone the [Isso repo](https://github.coam/posativ/isso/).
- Build the Docker image as it instructs.
- Push the image up to Docker Hub.
- Install Docker on your server.
- Pull the image down to your server.
- Create a config.mk file.

# Usage

Run `make update-remote` when you have a change.
