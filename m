From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH rt-tests 3/3] convert build system to autotools
Date: Mon, 5 Oct 2015 16:00:46 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510051559090.14006@riemann>
References: <1443955723-23042-1-git-send-email-u.kleine-koenig@pengutronix.de> <1443955723-23042-4-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="-1463804494-1808186003-1444053647=:14006"
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>,
	Josh Cartwright <joshc@ni.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37943 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751258AbbJEOAv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 5 Oct 2015 10:00:51 -0400
Received: by wiclk2 with SMTP id lk2so116138194wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Oct 2015 07:00:49 -0700 (PDT)
In-Reply-To: <1443955723-23042-4-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463804494-1808186003-1444053647=:14006
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 4 Oct 2015, Uwe Kleine-König wrote:

> Compared to the Makefile approach used up to now this one has
> autodetection of libnuma and numa_parse_cpustring_all. Compiling with
> numa can be skipped with
> 
> 	./configure --without-numa
> 
> and forced with
> 
> 	./configure --with-numa
> 
> (which results in the configure step failing if libnuma isn't
> available).
> 
> Instead of building with
> 
> 	make NPTL=0
> 
> use
> 
> 	./configure --without-nptl
> 
> now.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  .gitignore                            |  21 +++
>  Makefile                              | 270 ---------------------------
>  Makefile.am                           | 112 ++++++++++++
>  configure.ac                          |  58 ++++++
>  m4/.gitignore                         |   5 +
>  m4/ax_pthread.m4                      | 332 ++++++++++++++++++++++++++++++++++
>  scripts/do-git-push                   |   4 +-
>  src/backfire/sendme.c                 |   4 +-
>  src/cyclictest/cyclictest.c           |   7 +-
>  src/pi_tests/pi_stress.c              |   4 +-
>  src/pmqtest/pmqtest.c                 |   4 +-
>  src/ptsematest/ptsematest.c           |   4 +-
>  src/rt-migrate-test/rt-migrate-test.c |   4 +-
>  src/signaltest/signaltest.c           |   3 +-
>  src/sigwaittest/sigwaittest.c         |   3 +-
>  src/svsematest/svsematest.c           |   4 +-
>  16 files changed, 556 insertions(+), 283 deletions(-)
>  delete mode 100644 Makefile
>  create mode 100644 Makefile.am
>  create mode 100644 configure.ac
>  create mode 100644 m4/.gitignore
>  create mode 100644 m4/ax_pthread.m4
> 
> diff --git a/.gitignore b/.gitignore
> index ceee8bfb6e9a..d7f7197bd8f4 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -6,6 +6,7 @@
>  *.d
>  *.patch
>  *.a
> +*.lo
>  tmp
>  patches
>  ChangeLog
> @@ -34,3 +35,23 @@ SRPMS
>  rt-tests.spec
>  tags
>  TAGS
> +
> +/Makefile.in
> +/aclocal.m4
> +/autom4te.cache/
> +/autoscan.log
> +/compile
> +/config.guess
> +/config.h
> +/config.h.in
> +/config.log
> +/config.status
> +/config.sub
> +/configure
> +/depcomp
> +/install-sh
> +/librttest.la
> +/libtool
> +/ltmain.sh
> +/missing
> +/stamp-h1
> diff --git a/Makefile b/Makefile
> deleted file mode 100644
> index 35a7d5a83fec..000000000000
> --- a/Makefile
> +++ /dev/null
> @@ -1,270 +0,0 @@
> -VERSION = 0.94
> -
> -CROSS_COMPILE ?= $(CONFIG_CROSS_COMPILE:"%"=%)
> -AS = $(CROSS_COMPILE)as
> -LD = $(CROSS_COMPILE)ld
> -CC = $(CROSS_COMPILE)gcc
> -CPP = $(CC) -E
> -AR = $(CROSS_COMPILE)ar
> -NM = $(CROSS_COMPILE)nm
> -STRIP = $(CROSS_COMPILE)strip
> -OBJCOPY = $(CROSS_COMPILE)objcopy
> -OBJDUMP = $(CROSS_COMPILE)objdump
> -
> -OBJDIR = bld
> -
> -HAVE_NPTL ?= yes
> -
> -ifeq ($(HAVE_NPTL),yes)
> -sources = cyclictest.c pi_stress.c pip_stress.c pmqtest.c rt-migrate-test.c
> -endif
> -
> -sources += signaltest.c ptsematest.c sigwaittest.c svsematest.c sendme.c \
> -	  hackbench.c
> -
> -TARGETS = $(sources:.c=)
> -
> -LIBS	= -lrt -lpthread
> -RTTESTLIB = -lrttest -L$(OBJDIR)
> -EXTRA_LIBS ?= -ldl	# for get_cpu
> -DESTDIR	?=
> -prefix  ?= /usr/local
> -bindir  ?= $(prefix)/bin
> -mandir	?= $(prefix)/share/man
> -srcdir	?= $(prefix)/src
> -
> -machinetype = $(shell $(CC) -dumpmachine | \
> -    sed -e 's/-.*//' -e 's/i.86/i386/' -e 's/mips.*/mips/' -e 's/ppc.*/powerpc/')
> -
> -CFLAGS ?= -Wall -Wno-nonnull
> -CPPFLAGS += -D_GNU_SOURCE -Isrc/include
> -LDFLAGS ?=
> -
> -ifneq ($(filter x86_64 i386 ia64 mips powerpc,$(machinetype)),)
> -NUMA 	:= 1
> -ifdef HAVE_PARSE_CPUSTRING_ALL
> -	CFLAGS += -DHAVE_PARSE_CPUSTRING_ALL
> -endif
> -endif
> -
> -PYLIB  ?= $(shell python -c 'import distutils.sysconfig;  print distutils.sysconfig.get_python_lib()')
> -
> -ifndef DEBUG
> -	CFLAGS	+= -O2
> -else
> -	CFLAGS	+= -O0 -g
> -endif
> -
> -ifeq ($(NUMA),1)
> -	CFLAGS += -DNUMA
> -	NUMA_LIBS = -lnuma
> -endif
> -
> -# Bionic (android) does not have:
> -# - pthread barriers
> -# - pthread_[gs]etaffinity
> -#
> -# Typically see something like "aarch64-linux-android"
> -
> -ifneq ($(shell $(CC) -dumpmachine | grep -i android),)
> -	USE_BIONIC := 1
> -	CFLAGS += -DNO_PTHREAD_BARRIER
> -	CFLAGS += -DNO_PTHREAD_SETAFFINITY
> -
> -	LDFLAGS += -pie
> -# -lrt and -lpthread is in standard bionic library, no standalone library
> -	LIBS := $(filter-out -lrt,$(LIBS))
> -	LIBS := $(filter-out -lpthread,$(LIBS))
> -
> -# BIONIC does not support PI, barriers and have different files in
> -# include/. This means that currently, only these binaries will compile
> -# and link properly:
> -# - cyclictest
> -# - hackbench
> -# - hwlatdetect
> -	sources := cyclictest.c hackbench.c hwlatdetect.c
> -	TARGETS = $(sources:.c=)
> -endif
> -
> -VPATH	= src/cyclictest:
> -VPATH	+= src/signaltest:
> -VPATH	+= src/pi_tests:
> -VPATH	+= src/rt-migrate-test:
> -VPATH	+= src/ptsematest:
> -VPATH	+= src/sigwaittest:
> -VPATH	+= src/svsematest:
> -VPATH	+= src/pmqtest:
> -VPATH	+= src/backfire:
> -VPATH	+= src/lib:
> -VPATH	+= src/hackbench:
> -
> -$(OBJDIR)/%.o: %.c
> -	$(CC) -D VERSION=$(VERSION) -c $< $(CFLAGS) $(CPPFLAGS) -o $@
> -
> -# Pattern rule to generate dependency files from .c files
> -$(OBJDIR)/%.d: %.c
> -	@$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ || rm -f $@
> -
> -.PHONY: all
> -all: $(TARGETS) hwlatdetect
> -
> -# Include dependency files, automatically generate them if needed.
> --include $(addprefix $(OBJDIR)/,$(sources:.c=.d))
> -
> -cyclictest: $(OBJDIR)/cyclictest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(NUMA_LIBS)
> -
> -signaltest: $(OBJDIR)/signaltest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> -
> -pi_stress: $(OBJDIR)/pi_stress.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> -
> -hwlatdetect:  src/hwlatdetect/hwlatdetect.py
> -	chmod +x src/hwlatdetect/hwlatdetect.py
> -	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
> -
> -rt-migrate-test: $(OBJDIR)/rt-migrate-test.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> -
> -ptsematest: $(OBJDIR)/ptsematest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> -
> -sigwaittest: $(OBJDIR)/sigwaittest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> -
> -svsematest: $(OBJDIR)/svsematest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> -
> -pmqtest: $(OBJDIR)/pmqtest.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> -
> -sendme: $(OBJDIR)/sendme.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
> -
> -pip_stress: $(OBJDIR)/pip_stress.o $(OBJDIR)/librttest.a
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
> -
> -hackbench: $(OBJDIR)/hackbench.o
> -	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
> -
> -LIBOBJS =$(addprefix $(OBJDIR)/,error.o rt-get_cpu.o rt-sched.o rt-utils.o)
> -$(OBJDIR)/librttest.a: $(LIBOBJS)
> -	$(AR) rcs $@ $^
> -
> -CLEANUP  = $(TARGETS) *.o .depend *.*~ *.orig *.rej rt-tests.spec *.d *.a
> -CLEANUP += $(if $(wildcard .git), ChangeLog)
> -
> -.PHONY: clean
> -clean:
> -	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
> -	rm -f rt-tests-*.tar
> -	rm -f hwlatdetect
> -	rm -f tags
> -
> -RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
> -.PHONY: distclean
> -distclean: clean
> -	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
> -
> -.PHONY: rebuild
> -rebuild:
> -	$(MAKE) clean
> -	$(MAKE) all
> -
> -.PHONY: changelog
> -changelog:
> -	git log >ChangeLog
> -
> -.PHONY: install
> -install: all install_hwlatdetect
> -	mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man4"
> -	mkdir -p "$(DESTDIR)$(srcdir)" "$(DESTDIR)$(mandir)/man8"
> -	cp $(TARGETS) "$(DESTDIR)$(bindir)"
> -	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
> -	install -m 644 src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire/Makefile"
> -	gzip -c src/backfire/backfire.4 >"$(DESTDIR)$(mandir)/man4/backfire.4.gz"
> -	gzip -c src/cyclictest/cyclictest.8 >"$(DESTDIR)$(mandir)/man8/cyclictest.8.gz"
> -	gzip -c src/pi_tests/pi_stress.8 >"$(DESTDIR)$(mandir)/man8/pi_stress.8.gz"
> -	gzip -c src/ptsematest/ptsematest.8 >"$(DESTDIR)$(mandir)/man8/ptsematest.8.gz"
> -	gzip -c src/sigwaittest/sigwaittest.8 >"$(DESTDIR)$(mandir)/man8/sigwaittest.8.gz"
> -	gzip -c src/svsematest/svsematest.8 >"$(DESTDIR)$(mandir)/man8/svsematest.8.gz"
> -	gzip -c src/pmqtest/pmqtest.8 >"$(DESTDIR)$(mandir)/man8/pmqtest.8.gz"
> -	gzip -c src/backfire/sendme.8 >"$(DESTDIR)$(mandir)/man8/sendme.8.gz"
> -	gzip -c src/hackbench/hackbench.8 >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
> -
> -.PHONY: install_hwlatdetect
> -install_hwlatdetect: hwlatdetect
> -	if test -n "$(PYLIB)" ; then \
> -		mkdir -p "$(DESTDIR)$(bindir)" "$(DESTDIR)$(mandir)/man8" ; \
> -		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
> -		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> -		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
> -		gzip -c src/hwlatdetect/hwlatdetect.8 >"$(DESTDIR)$(mandir)/man8/hwlatdetect.8.gz" ; \
> -	fi
> -.PHONY: release
> -release: distclean changelog
> -	mkdir -p releases
> -	mkdir -p tmp/rt-tests
> -	cp -r Makefile COPYING ChangeLog MAINTAINERS doc README.markdown src tmp/rt-tests
> -	rm -f rt-tests-$(VERSION).tar rt-tests-$(VERSION).tar.asc
> -	tar -C tmp -cf rt-tests-$(VERSION).tar rt-tests
> -	gpg2 --default-key clrkwllms@kernel.org --detach-sign --armor rt-tests-$(VERSION).tar
> -	gzip rt-tests-$(VERSION).tar
> -	rm -f ChangeLog
> -	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
> -
> -.PHONY: tarball
> -tarball:
> -	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}
> -
> -.PHONY: push
> -push:	release
> -	scripts/do-git-push $(VERSION)
> -
> -.PHONY: pushtest
> -pushtest: release
> -	scripts/do-git-push --test $(VERSION)
> -
> -rt-tests.spec: Makefile rt-tests.spec-in
> -	sed s/__VERSION__/$(VERSION)/ <$@-in >$@
> -ifeq ($(NUMA),1)
> -	sed -i -e 's/__MAKE_NUMA__/NUMA=1/' $@
> -	sed -i -e 's/__BUILDREQUIRES_NUMA__/numactl-devel/' $@
> -else
> -	sed -i -e 's/__MAKE_NUMA__//' $@
> -	sed -i -e 's/__BUILDREQUIRES_NUMA__//' $@
> -endif
> -
> -
> -HERE	:=	$(shell pwd)
> -RPMARGS	:=	--define "_topdir $(HERE)" 	\
> -		--define "_sourcedir $(HERE)/releases" 	\
> -		--define "_builddir $(HERE)/BUILD" 	\
> -
> -.PHONY: rpm
> -rpm:	rpmdirs release rt-tests.spec
> -	rpmbuild -ba $(RPMARGS) rt-tests.spec
> -
> -.PHONY: rpmdirs
> -rpmdirs:
> -	@[ -d BUILD ]  || mkdir BUILD
> -	@[ -d RPMS ]   || mkdir RPMS
> -	@[ -d SRPMS ]  || mkdir SRPMS
> -
> -.PHONY: help
> -help:
> -	@echo ""
> -	@echo " rt-tests useful Makefile targets:"
> -	@echo ""
> -	@echo "    all       :  build all tests (default"
> -	@echo "    install   :  install tests to local filesystem"
> -	@echo "    release   :  build source tarfile"
> -	@echo "    rpm       :  build RPM package"
> -	@echo "    clean     :  remove object files"
> -	@echo "    distclean :  remove all generated files"
> -	@echo "    help      :  print this message"
> -
> -.PHONY: tags
> -tags:
> -	ctags -R --extra=+f --c-kinds=+p --exclude=tmp --exclude=BUILD *
> diff --git a/Makefile.am b/Makefile.am
> new file mode 100644
> index 000000000000..6f30fb620ef5
> --- /dev/null
> +++ b/Makefile.am
> @@ -0,0 +1,112 @@
> +AM_CPPFLAGS = -I$(srcdir)/src/include -D_GNU_SOURCE
> +EXTRA_DIST = README.markdown
> +
> +noinst_LTLIBRARIES = librttest.la
> +
> +librttest_la_SOURCES = \
> +	src/lib/rt-utils.c \
> +	src/lib/error.c \
> +	src/lib/rt-get_cpu.c \
> +	src/lib/rt-sched.c
> +
> +bin_PROGRAMS = \
> +	hackbench \
> +	ptsematest \
> +	sendme \
> +	signaltest \
> +	sigwaittest \
> +	svsematest
> +
> +if HAVE_NPTL
> +bin_PROGRAMS += \
> +	cyclictest \
> +	pi_stress \
> +	pip_stress \
> +	pmqtest \
> +	rt-migrate-test
> +endif
> +
> +man_MANS = \
> +	src/backfire/backfire.4 \
> +	src/backfire/sendme.8 \
> +	src/cyclictest/cyclictest.8 \
> +	src/hackbench/hackbench.8 \
> +	src/hwlatdetect/hwlatdetect.8 \
> +	src/pi_tests/pi_stress.8 \
> +	src/pmqtest/pmqtest.8 \
> +	src/ptsematest/ptsematest.8 \
> +	src/sigwaittest/sigwaittest.8 \
> +	src/svsematest/svsematest.8
> +
> +cyclictest_SOURCES = \
> +	src/cyclictest/cyclictest.c
> +cyclictest_LDADD = \
> +	librttest.la
> +cyclictest_LDFLAGS = $(PTHREAD_LIBS) -lrt $(LIBNUMA)
> +cyclictest_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +hackbench_SOURCES = \
> +	src/hackbench/hackbench.c
> +hackbench_LDFLAGS = $(PTHREAD_LIBS)
> +hackbench_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +pip_stress_SOURCES = \
> +	src/pi_tests/pip_stress.c
> +pip_stress_LDADD = \
> +	librttest.la
> +pip_stress_LDFLAGS = $(PTHREAD_LIBS)
> +pip_stress_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +pi_stress_SOURCES = \
> +	src/pi_tests/pi_stress.c
> +pi_stress_LDADD = \
> +	librttest.la
> +pi_stress_LDFLAGS = $(PTHREAD_LIBS)
> +pi_stress_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +pmqtest_SOURCES = \
> +	src/pmqtest/pmqtest.c
> +pmqtest_LDADD = \
> +	librttest.la
> +pmqtest_LDFLAGS = $(PTHREAD_LIBS) -lrt
> +pmqtest_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +ptsematest_SOURCES = \
> +	src/ptsematest/ptsematest.c
> +ptsematest_LDADD = \
> +	librttest.la
> +ptsematest_LDFLAGS = $(PTHREAD_LIBS)
> +ptsematest_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +rt_migrate_test_SOURCES = \
> +	src/rt-migrate-test/rt-migrate-test.c
> +rt_migrate_test_LDFLAGS = $(PTHREAD_LIBS)
> +rt_migrate_test_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +sendme_SOURCES = \
> +	src/backfire/sendme.c
> +sendme_LDADD = \
> +	librttest.la
> +
> +signaltest_SOURCES = \
> +	src/signaltest/signaltest.c
> +signaltest_LDADD = \
> +	librttest.la
> +signaltest_LDFLAGS = $(PTHREAD_LIBS)
> +signaltest_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +sigwaittest_SOURCES = \
> +	src/sigwaittest/sigwaittest.c
> +sigwaittest_LDADD = \
> +	librttest.la
> +sigwaittest_LDFLAGS = $(PTHREAD_LIBS) -lrt
> +sigwaittest_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +svsematest_SOURCES = \
> +	src/svsematest/svsematest.c
> +svsematest_LDADD = \
> +	librttest.la
> +svsematest_LDFLAGS = $(PTHREAD_LIBS) -lrt
> +svsematest_CFLAGS = $(PTHREAD_CFLAGS)
> +
> +bin_SCRIPTS = src/hwlatdetect/hwlatdetect.py
> diff --git a/configure.ac b/configure.ac
> new file mode 100644
> index 000000000000..a25669bef673
> --- /dev/null
> +++ b/configure.ac
> @@ -0,0 +1,58 @@
> +AC_PREREQ([2.69])
> +AC_INIT([rt-tests], [0.94], [linux-rt-users@vger.kernel.org])
> +AC_CONFIG_SRCDIR([src/cyclictest/cyclictest.c])
> +AM_INIT_AUTOMAKE([foreign dist-xz subdir-objects])
> +AC_CONFIG_HEADERS([config.h])
> +LT_INIT([disable-shared])
> +AC_CONFIG_MACRO_DIR([m4])
> +
> +# Checks for programs.
> +AC_PROG_CC
> +AC_PROG_MAKE_SET
> +AX_PTHREAD
> +
> +# Checks for header files.
> +AC_CHECK_HEADERS([fcntl.h inttypes.h limits.h memory.h stdint.h stdlib.h string.h sys/socket.h sys/time.h termios.h unistd.h utmpx.h])
> +
> +# Checks for typedefs, structures, and compiler characteristics.
> +AC_C_INLINE
> +AC_TYPE_INT32_T
> +AC_TYPE_INT64_T
> +AC_TYPE_PID_T
> +AC_TYPE_SIZE_T
> +AC_TYPE_SSIZE_T
> +AC_CHECK_DECLS([sys_siglist])
> +AC_TYPE_UINT32_T
> +AC_TYPE_UINT64_T
> +
> +AC_ARG_WITH([nptl], [AS_HELP_STRING([--without-nptl], [support for NPTL @<:@default=on@:>@])], [], [with_nptl=yes])
> +AM_CONDITIONAL(HAVE_NPTL, [test "x$with_nptl" = xyes])
> +
> +AC_ARG_WITH([numa], [AS_HELP_STRING([--with-numa], [support NUMA awareness @<:@default=check@:>@])], [], [with_numa=check])
> +LIBNUMA=
> +AS_IF([test "x$with_numa" != xno],
> +      [AC_CHECK_LIB([numa], [numa_available],
> +		    [AC_SUBST([LIBNUMA], ["-lnuma"])
> +		     AC_DEFINE([HAVE_LIBNUMA], [1], [Define if you have libnuma])
> +		     as_save_LIBS=$LIBS
> +		     LIBS="$LIBNUMA $LIBS"
> +		     AC_CHECK_FUNC([numa_parse_cpustring_all], [AC_DEFINE([HAVE_PARSE_CPUSTRING_ALL], [1],
> +									  [Define if libnuma provides numa_parse_cpustring_all.])])
> +		     LIBS=$ac_save_LIBS
> +		    ],
> +		    [if test "x$with_numa" != xcheck; then
> +		         AC_MSG_FAILURE([--with-numa was given, but test for libnuma failed])
> +		     fi
> +		    ])
> +      ])
> +
> +# Checks for library functions.
> +AC_FUNC_ERROR_AT_LINE
> +AC_FUNC_FORK
> +AC_FUNC_MALLOC
> +AC_FUNC_MMAP
> +AC_FUNC_REALLOC
> +AC_CHECK_FUNCS([alarm bzero clock_gettime ftruncate gettimeofday memset mkfifo munmap strerror strncasecmp strtol strtoul uname])
> +
> +AC_CONFIG_FILES([Makefile])
> +AC_OUTPUT
> diff --git a/m4/.gitignore b/m4/.gitignore
> new file mode 100644
> index 000000000000..94e6f26a7da0
> --- /dev/null
> +++ b/m4/.gitignore
> @@ -0,0 +1,5 @@
> +/libtool.m4
> +/ltoptions.m4
> +/ltsugar.m4
> +/ltversion.m4
> +/lt~obsolete.m4
> diff --git a/m4/ax_pthread.m4 b/m4/ax_pthread.m4
> new file mode 100644
> index 000000000000..d383ad5c6d6a
> --- /dev/null
> +++ b/m4/ax_pthread.m4
> @@ -0,0 +1,332 @@
> +# ===========================================================================
> +#        http://www.gnu.org/software/autoconf-archive/ax_pthread.html
> +# ===========================================================================
> +#
> +# SYNOPSIS
> +#
> +#   AX_PTHREAD([ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])
> +#
> +# DESCRIPTION
> +#
> +#   This macro figures out how to build C programs using POSIX threads. It
> +#   sets the PTHREAD_LIBS output variable to the threads library and linker
> +#   flags, and the PTHREAD_CFLAGS output variable to any special C compiler
> +#   flags that are needed. (The user can also force certain compiler
> +#   flags/libs to be tested by setting these environment variables.)
> +#
> +#   Also sets PTHREAD_CC to any special C compiler that is needed for
> +#   multi-threaded programs (defaults to the value of CC otherwise). (This
> +#   is necessary on AIX to use the special cc_r compiler alias.)
> +#
> +#   NOTE: You are assumed to not only compile your program with these flags,
> +#   but also link it with them as well. e.g. you should link with
> +#   $PTHREAD_CC $CFLAGS $PTHREAD_CFLAGS $LDFLAGS ... $PTHREAD_LIBS $LIBS
> +#
> +#   If you are only building threads programs, you may wish to use these
> +#   variables in your default LIBS, CFLAGS, and CC:
> +#
> +#     LIBS="$PTHREAD_LIBS $LIBS"
> +#     CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
> +#     CC="$PTHREAD_CC"
> +#
> +#   In addition, if the PTHREAD_CREATE_JOINABLE thread-attribute constant
> +#   has a nonstandard name, defines PTHREAD_CREATE_JOINABLE to that name
> +#   (e.g. PTHREAD_CREATE_UNDETACHED on AIX).
> +#
> +#   Also HAVE_PTHREAD_PRIO_INHERIT is defined if pthread is found and the
> +#   PTHREAD_PRIO_INHERIT symbol is defined when compiling with
> +#   PTHREAD_CFLAGS.
> +#
> +#   ACTION-IF-FOUND is a list of shell commands to run if a threads library
> +#   is found, and ACTION-IF-NOT-FOUND is a list of commands to run it if it
> +#   is not found. If ACTION-IF-FOUND is not specified, the default action
> +#   will define HAVE_PTHREAD.
> +#
> +#   Please let the authors know if this macro fails on any platform, or if
> +#   you have any other suggestions or comments. This macro was based on work
> +#   by SGJ on autoconf scripts for FFTW (http://www.fftw.org/) (with help
> +#   from M. Frigo), as well as ac_pthread and hb_pthread macros posted by
> +#   Alejandro Forero Cuervo to the autoconf macro repository. We are also
> +#   grateful for the helpful feedback of numerous users.
> +#
> +#   Updated for Autoconf 2.68 by Daniel Richard G.
> +#
> +# LICENSE
> +#
> +#   Copyright (c) 2008 Steven G. Johnson <stevenj@alum.mit.edu>
> +#   Copyright (c) 2011 Daniel Richard G. <skunk@iSKUNK.ORG>
> +#
> +#   This program is free software: you can redistribute it and/or modify it
> +#   under the terms of the GNU General Public License as published by the
> +#   Free Software Foundation, either version 3 of the License, or (at your
> +#   option) any later version.
> +#
> +#   This program is distributed in the hope that it will be useful, but
> +#   WITHOUT ANY WARRANTY; without even the implied warranty of
> +#   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
> +#   Public License for more details.
> +#
> +#   You should have received a copy of the GNU General Public License along
> +#   with this program. If not, see <http://www.gnu.org/licenses/>.
> +#
> +#   As a special exception, the respective Autoconf Macro's copyright owner
> +#   gives unlimited permission to copy, distribute and modify the configure
> +#   scripts that are the output of Autoconf when processing the Macro. You
> +#   need not follow the terms of the GNU General Public License when using
> +#   or distributing such scripts, even though portions of the text of the
> +#   Macro appear in them. The GNU General Public License (GPL) does govern
> +#   all other use of the material that constitutes the Autoconf Macro.
> +#
> +#   This special exception to the GPL applies to versions of the Autoconf
> +#   Macro released by the Autoconf Archive. When you make and distribute a
> +#   modified version of the Autoconf Macro, you may extend this special
> +#   exception to the GPL to apply to your modified version as well.
> +
> +#serial 21
> +
> +AU_ALIAS([ACX_PTHREAD], [AX_PTHREAD])
> +AC_DEFUN([AX_PTHREAD], [
> +AC_REQUIRE([AC_CANONICAL_HOST])
> +AC_LANG_PUSH([C])
> +ax_pthread_ok=no
> +
> +# We used to check for pthread.h first, but this fails if pthread.h
> +# requires special compiler flags (e.g. on True64 or Sequent).
> +# It gets checked for in the link test anyway.
> +
> +# First of all, check if the user has set any of the PTHREAD_LIBS,
> +# etcetera environment variables, and if threads linking works using
> +# them:
> +if test x"$PTHREAD_LIBS$PTHREAD_CFLAGS" != x; then
> +        save_CFLAGS="$CFLAGS"
> +        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
> +        save_LIBS="$LIBS"
> +        LIBS="$PTHREAD_LIBS $LIBS"
> +        AC_MSG_CHECKING([for pthread_join in LIBS=$PTHREAD_LIBS with CFLAGS=$PTHREAD_CFLAGS])
> +        AC_TRY_LINK_FUNC([pthread_join], [ax_pthread_ok=yes])
> +        AC_MSG_RESULT([$ax_pthread_ok])
> +        if test x"$ax_pthread_ok" = xno; then
> +                PTHREAD_LIBS=""
> +                PTHREAD_CFLAGS=""
> +        fi
> +        LIBS="$save_LIBS"
> +        CFLAGS="$save_CFLAGS"
> +fi
> +
> +# We must check for the threads library under a number of different
> +# names; the ordering is very important because some systems
> +# (e.g. DEC) have both -lpthread and -lpthreads, where one of the
> +# libraries is broken (non-POSIX).
> +
> +# Create a list of thread flags to try.  Items starting with a "-" are
> +# C compiler flags, and other items are library names, except for "none"
> +# which indicates that we try without any flags at all, and "pthread-config"
> +# which is a program returning the flags for the Pth emulation library.
> +
> +ax_pthread_flags="pthreads none -Kthread -kthread lthread -pthread -pthreads -mthreads pthread --thread-safe -mt pthread-config"
> +
> +# The ordering *is* (sometimes) important.  Some notes on the
> +# individual items follow:
> +
> +# pthreads: AIX (must check this before -lpthread)
> +# none: in case threads are in libc; should be tried before -Kthread and
> +#       other compiler flags to prevent continual compiler warnings
> +# -Kthread: Sequent (threads in libc, but -Kthread needed for pthread.h)
> +# -kthread: FreeBSD kernel threads (preferred to -pthread since SMP-able)
> +# lthread: LinuxThreads port on FreeBSD (also preferred to -pthread)
> +# -pthread: Linux/gcc (kernel threads), BSD/gcc (userland threads)
> +# -pthreads: Solaris/gcc
> +# -mthreads: Mingw32/gcc, Lynx/gcc
> +# -mt: Sun Workshop C (may only link SunOS threads [-lthread], but it
> +#      doesn't hurt to check since this sometimes defines pthreads too;
> +#      also defines -D_REENTRANT)
> +#      ... -mt is also the pthreads flag for HP/aCC
> +# pthread: Linux, etcetera
> +# --thread-safe: KAI C++
> +# pthread-config: use pthread-config program (for GNU Pth library)
> +
> +case ${host_os} in
> +        solaris*)
> +
> +        # On Solaris (at least, for some versions), libc contains stubbed
> +        # (non-functional) versions of the pthreads routines, so link-based
> +        # tests will erroneously succeed.  (We need to link with -pthreads/-mt/
> +        # -lpthread.)  (The stubs are missing pthread_cleanup_push, or rather
> +        # a function called by this macro, so we could check for that, but
> +        # who knows whether they'll stub that too in a future libc.)  So,
> +        # we'll just look for -pthreads and -lpthread first:
> +
> +        ax_pthread_flags="-pthreads pthread -mt -pthread $ax_pthread_flags"
> +        ;;
> +
> +        darwin*)
> +        ax_pthread_flags="-pthread $ax_pthread_flags"
> +        ;;
> +esac
> +
> +# Clang doesn't consider unrecognized options an error unless we specify
> +# -Werror. We throw in some extra Clang-specific options to ensure that
> +# this doesn't happen for GCC, which also accepts -Werror.
> +
> +AC_MSG_CHECKING([if compiler needs -Werror to reject unknown flags])
> +save_CFLAGS="$CFLAGS"
> +ax_pthread_extra_flags="-Werror"
> +CFLAGS="$CFLAGS $ax_pthread_extra_flags -Wunknown-warning-option -Wsizeof-array-argument"
> +AC_COMPILE_IFELSE([AC_LANG_PROGRAM([int foo(void);],[foo()])],
> +                  [AC_MSG_RESULT([yes])],
> +                  [ax_pthread_extra_flags=
> +                   AC_MSG_RESULT([no])])
> +CFLAGS="$save_CFLAGS"
> +
> +if test x"$ax_pthread_ok" = xno; then
> +for flag in $ax_pthread_flags; do
> +
> +        case $flag in
> +                none)
> +                AC_MSG_CHECKING([whether pthreads work without any flags])
> +                ;;
> +
> +                -*)
> +                AC_MSG_CHECKING([whether pthreads work with $flag])
> +                PTHREAD_CFLAGS="$flag"
> +                ;;
> +
> +                pthread-config)
> +                AC_CHECK_PROG([ax_pthread_config], [pthread-config], [yes], [no])
> +                if test x"$ax_pthread_config" = xno; then continue; fi
> +                PTHREAD_CFLAGS="`pthread-config --cflags`"
> +                PTHREAD_LIBS="`pthread-config --ldflags` `pthread-config --libs`"
> +                ;;
> +
> +                *)
> +                AC_MSG_CHECKING([for the pthreads library -l$flag])
> +                PTHREAD_LIBS="-l$flag"
> +                ;;
> +        esac
> +
> +        save_LIBS="$LIBS"
> +        save_CFLAGS="$CFLAGS"
> +        LIBS="$PTHREAD_LIBS $LIBS"
> +        CFLAGS="$CFLAGS $PTHREAD_CFLAGS $ax_pthread_extra_flags"
> +
> +        # Check for various functions.  We must include pthread.h,
> +        # since some functions may be macros.  (On the Sequent, we
> +        # need a special flag -Kthread to make this header compile.)
> +        # We check for pthread_join because it is in -lpthread on IRIX
> +        # while pthread_create is in libc.  We check for pthread_attr_init
> +        # due to DEC craziness with -lpthreads.  We check for
> +        # pthread_cleanup_push because it is one of the few pthread
> +        # functions on Solaris that doesn't have a non-functional libc stub.
> +        # We try pthread_create on general principles.
> +        AC_LINK_IFELSE([AC_LANG_PROGRAM([#include <pthread.h>
> +                        static void routine(void *a) { a = 0; }
> +                        static void *start_routine(void *a) { return a; }],
> +                       [pthread_t th; pthread_attr_t attr;
> +                        pthread_create(&th, 0, start_routine, 0);
> +                        pthread_join(th, 0);
> +                        pthread_attr_init(&attr);
> +                        pthread_cleanup_push(routine, 0);
> +                        pthread_cleanup_pop(0) /* ; */])],
> +                [ax_pthread_ok=yes],
> +                [])
> +
> +        LIBS="$save_LIBS"
> +        CFLAGS="$save_CFLAGS"
> +
> +        AC_MSG_RESULT([$ax_pthread_ok])
> +        if test "x$ax_pthread_ok" = xyes; then
> +                break;
> +        fi
> +
> +        PTHREAD_LIBS=""
> +        PTHREAD_CFLAGS=""
> +done
> +fi
> +
> +# Various other checks:
> +if test "x$ax_pthread_ok" = xyes; then
> +        save_LIBS="$LIBS"
> +        LIBS="$PTHREAD_LIBS $LIBS"
> +        save_CFLAGS="$CFLAGS"
> +        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
> +
> +        # Detect AIX lossage: JOINABLE attribute is called UNDETACHED.
> +        AC_MSG_CHECKING([for joinable pthread attribute])
> +        attr_name=unknown
> +        for attr in PTHREAD_CREATE_JOINABLE PTHREAD_CREATE_UNDETACHED; do
> +            AC_LINK_IFELSE([AC_LANG_PROGRAM([#include <pthread.h>],
> +                           [int attr = $attr; return attr /* ; */])],
> +                [attr_name=$attr; break],
> +                [])
> +        done
> +        AC_MSG_RESULT([$attr_name])
> +        if test "$attr_name" != PTHREAD_CREATE_JOINABLE; then
> +            AC_DEFINE_UNQUOTED([PTHREAD_CREATE_JOINABLE], [$attr_name],
> +                               [Define to necessary symbol if this constant
> +                                uses a non-standard name on your system.])
> +        fi
> +
> +        AC_MSG_CHECKING([if more special flags are required for pthreads])
> +        flag=no
> +        case ${host_os} in
> +            aix* | freebsd* | darwin*) flag="-D_THREAD_SAFE";;
> +            osf* | hpux*) flag="-D_REENTRANT";;
> +            solaris*)
> +            if test "$GCC" = "yes"; then
> +                flag="-D_REENTRANT"
> +            else
> +                # TODO: What about Clang on Solaris?
> +                flag="-mt -D_REENTRANT"
> +            fi
> +            ;;
> +        esac
> +        AC_MSG_RESULT([$flag])
> +        if test "x$flag" != xno; then
> +            PTHREAD_CFLAGS="$flag $PTHREAD_CFLAGS"
> +        fi
> +
> +        AC_CACHE_CHECK([for PTHREAD_PRIO_INHERIT],
> +            [ax_cv_PTHREAD_PRIO_INHERIT], [
> +                AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <pthread.h>]],
> +                                                [[int i = PTHREAD_PRIO_INHERIT;]])],
> +                    [ax_cv_PTHREAD_PRIO_INHERIT=yes],
> +                    [ax_cv_PTHREAD_PRIO_INHERIT=no])
> +            ])
> +        AS_IF([test "x$ax_cv_PTHREAD_PRIO_INHERIT" = "xyes"],
> +            [AC_DEFINE([HAVE_PTHREAD_PRIO_INHERIT], [1], [Have PTHREAD_PRIO_INHERIT.])])
> +
> +        LIBS="$save_LIBS"
> +        CFLAGS="$save_CFLAGS"
> +
> +        # More AIX lossage: compile with *_r variant
> +        if test "x$GCC" != xyes; then
> +            case $host_os in
> +                aix*)
> +                AS_CASE(["x/$CC"],
> +                  [x*/c89|x*/c89_128|x*/c99|x*/c99_128|x*/cc|x*/cc128|x*/xlc|x*/xlc_v6|x*/xlc128|x*/xlc128_v6],
> +                  [#handle absolute path differently from PATH based program lookup
> +                   AS_CASE(["x$CC"],
> +                     [x/*],
> +                     [AS_IF([AS_EXECUTABLE_P([${CC}_r])],[PTHREAD_CC="${CC}_r"])],
> +                     [AC_CHECK_PROGS([PTHREAD_CC],[${CC}_r],[$CC])])])
> +                ;;
> +            esac
> +        fi
> +fi
> +
> +test -n "$PTHREAD_CC" || PTHREAD_CC="$CC"
> +
> +AC_SUBST([PTHREAD_LIBS])
> +AC_SUBST([PTHREAD_CFLAGS])
> +AC_SUBST([PTHREAD_CC])
> +
> +# Finally, execute ACTION-IF-FOUND/ACTION-IF-NOT-FOUND:
> +if test x"$ax_pthread_ok" = xyes; then
> +        ifelse([$1],,[AC_DEFINE([HAVE_PTHREAD],[1],[Define if you have POSIX threads libraries and header files.])],[$1])
> +        :
> +else
> +        ax_pthread_ok=no
> +        $2
> +fi
> +AC_LANG_POP
> +])dnl AX_PTHREAD
> diff --git a/scripts/do-git-push b/scripts/do-git-push
> index 1530d1001c49..8ef0fc0e6027 100755
> --- a/scripts/do-git-push
> +++ b/scripts/do-git-push
> @@ -54,7 +54,7 @@ if [ $branch != 'refs/heads/master' ]; then
>  fi
>  
>  # double sanity check
> -mkver=$(awk '$1 == "VERSION_STRING" {print $3; exit 0}' Makefile)
> +mkver=$(awk '$1 == "#define" && $2 == "PACKAGE_VERSION" {print $3; exit 0}' config.h)
>  if [ $version != $mkver ]
>  then
>      echo "parameter mismatch with Makefile!"
> @@ -93,7 +93,7 @@ asc=rt-tests-$version.tar.asc
>  if [ ! -e $tar ];
>  then
>      echo "Generating tarfile $tar"
> -    make release
> +    make dist
>  else
>      echo "Using existing tarfile $tar"
>  fi
> diff --git a/src/backfire/sendme.c b/src/backfire/sendme.c
> index c1854d9660cb..c77e8685bc2d 100644
> --- a/src/backfire/sendme.c
> +++ b/src/backfire/sendme.c
> @@ -18,6 +18,8 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
>   * USA.
>   */
> +#include "config.h"
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -108,7 +110,7 @@ void stop_tracing(void)
>  
>  static void display_help(void)
>  {
> -	printf("sendme V %1.2f\n", VERSION);
> +	printf("sendme V " PACKAGE_VERSION "\n");
>  	puts("Usage: sendme <options>");
>  	puts("Function: send a signal from driver to userspace");
>  	puts(
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 58f198377d7d..2d6f38823965 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -39,6 +39,7 @@
>  #include "rt_numa.h"
>  
>  #include "rt-utils.h"
> +#include "config.h"
>  
>  #define DEFAULT_INTERVAL 1000
>  #define DEFAULT_DISTANCE 500
> @@ -1031,7 +1032,7 @@ static void display_help(int error)
>  			strcpy(tracers, "none");
>  	}
>  
> -	printf("cyclictest V %1.2f\n", VERSION);
> +	printf("cyclictest V " PACKAGE_VERSION "\n");
>  	printf("Usage:\n"
>  	       "cyclictest <options>\n\n"
>  #if LIBNUMA_API_VERSION >= 2
> @@ -1102,7 +1103,7 @@ static void display_help(int error)
>  	       "-T TRACE --tracer=TRACER   set tracing function\n"
>  	       "    configured tracers: %s\n"
>  	       "-u       --unbuffered      force unbuffered output for live processing\n"
> -#ifdef NUMA
> +#ifdef HAVE_LIBNUMA
>  	       "-U       --numa            Standard NUMA testing (similar to SMP option)\n"
>  	       "                           thread data structures allocated from local node\n"
>  #endif
> @@ -1491,7 +1492,7 @@ static void process_options (int argc, char *argv[], int max_cpus)
>  			if (smp)
>  				fatal("numa and smp options are mutually exclusive\n");
>  			numa_on_and_available();
> -#ifdef NUMA
> +#ifdef HAVE_LIBNUMA
>  			num_threads = max_cpus;
>  			setaffinity = AFFINITY_USEALL;
>  			use_nanosleep = MODE_CLOCK_NANOSLEEP;
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index a4e6e3df1a3d..24fc19c259fe 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -40,6 +40,8 @@
>  
>     CW - 2006  */
>  
> +#include "config.h"
> +
>  #include <stdio.h>
>  #include <errno.h>
>  #include <stdlib.h>
> @@ -1362,7 +1364,7 @@ void process_command_line(int argc, char **argv)
>  			debugging = 1;
>  			break;
>  		case 'V':
> -			printf("pi_stress v%1.2f ", VERSION);
> +			printf("pi_stress v" PACKAGE_VERSION "\n");
>  			exit(0);
>  		case 'u':
>  			uniprocessor = 1;
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 75d5ee8185a0..099fc0f41715 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -19,6 +19,8 @@
>   * USA.
>   */
>  
> +#include "config.h"
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -240,7 +242,7 @@ void *pmqthread(void *param)
>  
>  static void display_help(void)
>  {
> -	printf("pmqtest V %1.2f\n", VERSION);
> +	printf("pmqtest V " PACKAGE_VERSION "\n");
>  	puts("Usage: pmqtest <options>");
>  	puts("Function: test POSIX message queue latency");
>  	puts(
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index a31c745ec928..e4f5ecef0ad3 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -19,6 +19,8 @@
>   * USA.
>   */
>  
> +#include "config.h"
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> @@ -162,7 +164,7 @@ void *semathread(void *param)
>  
>  static void display_help(void)
>  {
> -	printf("ptsematest V %1.2f\n", VERSION);
> +	printf("ptsematest V " PACKAGE_VERSION "\n");
>  	puts("Usage: ptsematest <options>");
>  	puts("Function: test POSIX threads mutex latency");
>  	puts(
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 85a78dab7403..fb107b0f3b20 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -20,6 +20,8 @@
>   *
>   * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   */
> +#include "config.h"
> +
>  #ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
>  #endif
> @@ -175,7 +177,7 @@ static void usage(char **argv)
>  		p--;
>  	p++;
>  
> -	printf("%s %1.2f\n", p, VERSION);
> +	printf("%s " PACKAGE_VERSION "\n", p);
>  	printf("Usage:\n"
>  	       "%s <options> nr_tasks\n\n"
>  	       "-p prio --prio  prio        base priority to start RT tasks with (2) \n"
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 61259a0a8913..f02563fe99d5 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -8,6 +8,7 @@
>   * 2 as published by the Free Software Foundation;
>   *
>   */
> +#include "config.h"
>  
>  #include <fcntl.h>
>  #include <getopt.h>
> @@ -202,7 +203,7 @@ out:
>  /* Print usage information */
>  static void display_help(void)
>  {
> -	printf("signaltest V %1.2f\n", VERSION);
> +	printf("signaltest V " PACKAGE_VERSION "\n");
>  	printf("Usage:\n"
>  	       "signaltest <options>\n\n"
>  	       "-b USEC  --breaktrace=USEC send break trace command when latency > USEC\n"
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 91fcdaa5f185..a402e58a5f94 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -18,6 +18,7 @@
>   * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307,
>   * USA.
>   */
> +#include "config.h"
>  
>  #include <stdio.h>
>  #include <sys/stat.h>
> @@ -210,7 +211,7 @@ void *semathread(void *param)
>  
>  static void display_help(void)
>  {
> -	printf("sigwaittest V %1.2f\n", VERSION);
> +	printf("sigwaittest V " PACKAGE_VERSION "\n");
>  	puts("Usage: sigwaittest <options>");
>  	puts("Function: test sigwait() latency");
>  	puts(
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index eeb82858720a..9e808ddb6ea8 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -19,6 +19,8 @@
>   * USA.
>   */
>  
> +#include "config.h"
> +
>  #include <stdio.h>
>  #include <fcntl.h>
>  #include <stdlib.h>
> @@ -236,7 +238,7 @@ union semun {
>  
>  static void display_help(void)
>  {
> -	printf("svsematest V %1.2f\n", VERSION);
> +	printf("svsematest V " PACKAGE_VERSION "\n");
>  	puts("Usage: svsematest <options>");
>  	puts("Function: test SYSV semaphore latency");
>  	puts(
> -- 
> 2.1.4
> 

I was going to give this a try, but it failed to apply.
Probably there were some recent development patches it clashed with, so I 
pushed the latest devel/v0.95-devel if you want to fix it up and resend.

Thanks

John Kacur
---1463804494-1808186003-1444053647=:14006--
