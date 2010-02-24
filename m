From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/3] Makefile: don't use temporary files in generation of dependency files
Date: Wed, 24 Feb 2010 17:58:08 +0100
Message-ID: <1267030688-12244-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100224165611.GA22159@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Clark Williams <williams@redhat.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40834 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757319Ab0BXQ6N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2010 11:58:13 -0500
In-Reply-To: <20100224165611.GA22159@pengutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

These temporary files were a real problem when creating the Debian
package for rt-tests.  debhelper (a generic suite of scripts to ease
packaging) did something like:

	perl -c 'close(STDERR); exec("make distclean");'

which leaked the *.d.$$ files and then wailed that the package containe=
d
untracked changes to the vanilla source.  See
http://bugs.debian.org/570443 for some more details.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Makefile |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 99fbba4..5bb8774 100644
--- a/Makefile
+++ b/Makefile
@@ -43,10 +43,7 @@ VPATH	+=3D src/lib
=20
 # Pattern rule to generate dependency files from .c files
 %.d: %.c
-	@set -e; rm -f $@; \
-	$(CC) -MM $(CFLAGS) $< > $@.$$$$; \
-	sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' < $@.$$$$ > $@; \
-	rm -f $@.$$$$
+	@$(CC) -MM $(CFLAGS) $< | sed 's,\($*\)\.o[ :]*,\1.o $@ : ,g' > $@ ||=
 rm -f $@
=20
 .PHONY: all
 all: $(TARGETS) hwlatdetect
--=20
1.6.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
