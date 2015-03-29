# based on example https://projects.archlinux.org/abs.git/tree/Makefile

NAME = dangerous-jack-connector
VERSION = 0.1.1

DESTDIR = 
LIBDIR = /lib/udev/
CONFDIR = /rules.d/

# /lib/udev/rules.d/

.PHONY: install
install:
	@echo -e "Installing $(NAME)"
	@echo -e "  Copying scripts..."
	@install -m755 $(NAME).sh $(DESTDIR)$(LIBDIR)$(NAME)
	@install -m644 98-$(NAME).rules $(DESTDIR)$(LIBDIR)$(CONFDIR)
	@echo -e "  Reloading udev's rules..."	
	@udevadm control --reload-rules

.PHONY: uninstall
uninstall:
	@echo -e "Uninstalling $(NAME)"
	@echo -e "  Removing scripts..."
	@rm $(DESTDIR)$(LIBDIR)$(NAME)
	@rm $(DESTDIR)$(LIBDIR)$(CONFDIR)98-$(NAME).rules
	@echo -e "  Reloading udev's rules..."
	@udevadm control --reload-rules

.PHONY: dist
dist:
	git archive --format=tar --prefix=$(NAME)-$(VERSION)/ $(VERSION) | gzip -9 > $(NAME)-$(VERSION).tar.gz

