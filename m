From: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rt-tests: Makefile - rt-tests.spec is not a PHONY target
Date: Mon, 16 Nov 2009 22:18:56 +0100
Message-ID: <1258406336-13751-1-git-send-email-jkacur@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:9989 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752729AbZKPVSy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 16 Nov 2009 16:18:54 -0500
Received: by fg-out-1718.google.com with SMTP id d23so1421472fga.1
        for <linux-rt-users@vger.kernel.org>; Mon, 16 Nov 2009 13:18:59 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 7414a68..eb37c19 100644
--- a/Makefile
+++ b/Makefile
@@ -78,8 +78,6 @@ push:	release
 pushtest: release
 	scripts/do-git-push --test $(VERSION_STRING)
=20
-# Note although rt-tests.spec is a file, it is okay to remake it every=
 time.
-.PHONY: rt-tests.spec
 rt-tests.spec: Makefile rt-tests.spec-in
 	sed s/__VERSION__/$(VERSION_STRING)/ <$@-in >$@
=20
--=20
1.6.2.5

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
