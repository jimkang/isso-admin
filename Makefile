include config.mk

HOMEDIR = $(shell pwd)
SSHCMD = ssh $(USER)@$(SERVER)
PRIVSSHCMD = ssh $(PRIVUSER)@$(SERVER)
PROJECTNAME = isso-admin
APPDIR = /opt/$(PROJECTNAME)
HOMEDIR = $(shell pwd)

setup-dirs:
	$(PRIVSSHCMD) "mkdir -p $(APPDIR)/db && mkdir -p $(APPDIR)/logs && chown -R $(USER):$(GROUP) $(APPDIR)"

pushall:
	git push origin main

sync:
	rsync -avz $(HOMEDIR) $(USER)@$(SERVER):/opt/ --exclude db/

pull-db:
	scp $(USER)@$(SERVER):$(APPDIR)/db/comments.db db

update-remote: sync restart-remote

restart-remote: stop-service start-service

start-service:
	$(SSHCMD) "docker run \
    -d \
    -p 127.0.0.1:8081:8080 \
    -v $(APPDIR):/config \
    -v $(APPDIR)/db:/db \
    -v $(APPDIR)/logs:/logs \
    --restart always \
    --name isso-service \
    jkang/isso"

stop-service:
	$(SSHCMD) "docker rm -f isso-service"

check-logs:
	$(SSHCMD) "docker logs isso-service"
