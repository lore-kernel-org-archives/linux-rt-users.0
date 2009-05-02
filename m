From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 3/3] Makefile: don't override DESTDIR, prefix, bindir and mandir
Date: Sat,  2 May 2009 20:53:22 +0200
Message-ID: <1241290402-15234-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20090502185004.GA14150@cassiopeia.tralala>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46494 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754508AbZEBSxg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 May 2009 14:53:36 -0400
In-Reply-To: <20090502185004.GA14150@cassiopeia.tralala>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This eases packaging rt-tests and shouldn't have any further impact.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 Makefile |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 294d588..e139eb4 100644
--- a/Makefile
+++ b/Makefile
@@ -3,10 +3,10 @@ VERSION_STRING =3D "0.38"
 TARGETS	=3D cyclictest signaltest classic_pi pi_stress
 FLAGS	=3D -Wall -Wno-nonnull -O2
 LIBS 	=3D -lpthread -lrt
-DESTDIR	=3D
-prefix  =3D /usr/local
-bindir  =3D $(prefix)/bin
-mandir	=3D $(prefix)/share/man/man8
+DESTDIR	?=3D
+prefix  ?=3D /usr/local
+bindir  ?=3D $(prefix)/bin
+mandir	?=3D $(prefix)/share/man/man8
=20
 all: $(TARGETS)
=20
--=20
1.6.2.4

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
