# $Id: Makefile,v 1.10 2011-04-15 17:35:52 tomas Exp $

PKG=stringdistance
V=1.0

DIST_DIR=$(PKG)-$V
DOCS= doc/index.html doc/license.html doc/examples.html doc/stringdistance.png
SRC=src/stringdistance.c
DIST_SRC=$(DIST_DIR)/src
DIST_DOC=$(DIST_DIR)/doc
DIST_TST=$(DIST_DIR)/tests
PKG_FILE=$(DIST_DIR).tar.gz
LIBNAME=$(PKG).so

LUA=/usr/local/bin/lua
LUALIB_DIR=/usr/local/lib/lua/5.1


$(LIBNAME): $(SRC)
	gcc -I/usr/local/include -I/usr/include/lua5.1 -shared -fPIC -Wall -O2 -o $(LIBNAME) $(SRC)

install: $(LIBNAME)
	cp $(LIBNAME) $(LUALIB_DIR)

test: $(LIBNAME)
	$(LUA) tests/test.lua

dist:
	mkdir $(DIST_DIR)
	cp README $(DIST_DIR)
	cp Makefile $(DIST_DIR)
	mkdir $(DIST_SRC)
	cp $(SRC) $(DIST_SRC)
	mkdir $(DIST_DOC)
	cp $(DOCS) $(DIST_DOC)
	mkdir $(DIST_TST)
	cp tests/test.lua $(DIST_TST)
	tar -czf $(PKG_FILE) $(DIST_DIR)
	rm -rf $(DIST_DIR)

clean:
	rm -f $(LIBNAME) $(PKG_FILE)
	rm -rf $(DIST_DIR)
