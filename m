From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH rt-tests] Makefile: complement user-supplied CFLAGS with needed parameters
Date: Tue, 16 Jul 2013 17:51:40 +0200
Message-ID: <1373989900-25351-1-git-send-email-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
To: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:55138 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932590Ab3GPPvu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 16 Jul 2013 11:51:50 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

=46rom: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

=46or compilation to work

	-D_GNU_SOURCE -Isrc/include

is needed to be passed to the compiler. For Debian packaging several
things are added to CFLAGS but not these two from above yielding compil=
ation
errors, similar to:

	$ make CFLAGS=3D-Wall cyclictest
	cc -D VERSION_STRING=3D0.84 -c src/cyclictest/cyclictest.c -Wall
	In file included from src/cyclictest/cyclictest.c:37:0:
	src/cyclictest/rt_numa.h:17:22: fatal error: rt-utils.h: No such file =
or directory
	compilation terminated.
	make: *** [cyclictest.o] Error 1

So add the needed parameters unconditionally. There is no harm if they
are included in the user supplied CFLAGS and so passed twice.

Moreover be a bit more correct about CFLAGS/CPPFLAGS. Both should be
passed to the compiler with CFLAGS taking options for the compiler and
CPPFLAGS taking options for the preprocessor. This is also needed for
Debian packaging where the helper scripts set CPPFLAGS.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=20
---
 Makefile |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -20,7 +20,8 @@ ifneq ($(filter x86_64 i386 ia64 mips po
 NUMA 	:=3D 1
 endif
=20
-CFLAGS ?=3D -D_GNU_SOURCE -Wall -Wno-nonnull -Isrc/include
+CFLAGS ?=3D -Wall -Wno-nonnull
+CPPFLAGS +=3D -D_GNU_SOURCE -Isrc/include
 LDFLAGS ?=3D
=20
 ifndef DEBUG
@@ -47,11 +48,11 @@ VPATH	+=3D src/lib
 VPATH	+=3D src/hackbench
=20
 %.o: %.c
-	$(CC) -D VERSION_STRING=3D$(VERSION_STRING) -c $< $(CFLAGS)
+	$(CC) -D VERSION_STRING=3D$(VERSION_STRING) -c $< $(CFLAGS) $(CPPFLAG=
S)
=20
 # Pattern rule to generate dependency files from .c files
 %.d: %.c
-	@$(CC) -MM $(CFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ ||=
 rm -f $@
+	@$(CC) -MM $(CFLAGS) $(CPPFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ :=
 ,g' > $@ || rm -f $@
=20
 .PHONY: all
 all: $(TARGETS) hwlatdetect
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
