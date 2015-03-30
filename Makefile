# based on example https://projects.archlinux.org/abs.git/tree/Makefile

NAME = dangerous-jack-connector
VERSION = 0.1.3

DESTDIR = 
LIBDIR = /usr/lib/udev/
CONFDIR = /rules.d/

# /lib/udev/rules.d/

.PHONY: install
install:
	@echo -e "Installing $(NAME)"
	@echo -e "  Copying scripts..."
	@install -Dm755 $(NAME).sh $(DESTDIR)$(LIBDIR)$(NAME)
	@install -Dm644 98-$(NAME).rules $(DESTDIR)$(LIBDIR)$(CONFDIR)98-$(NAME).rules

.PHONY: uninstall
uninstall:
	@echo -e "Uninstalling $(NAME)"
	@echo -e "  Removing scripts..."
	@rm $(DESTDIR)$(LIBDIR)$(NAME)
	@rm $(DESTDIR)$(LIBDIR)$(CONFDIR)98-$(NAME).rules

.PHONY: dist
dist:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(VERSION) | gzip -9 > $(NAME)-$(VERSION).tar.gz
	@md5sum $(NAME)-$(VERSION).tar.gz

clean:
	@echo -e "Cleaning current directory"
	@echo -e "  Erasing all *.tar.gz files..."
	@rm *.tar.gz

