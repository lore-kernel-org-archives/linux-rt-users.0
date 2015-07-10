From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 6/6] Create an rt-tests.tar file using git-archive
Date: Fri, 10 Jul 2015 14:25:31 +0200
Message-ID: <1436531131-9186-7-git-send-email-jkacur@redhat.com>
References: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33319 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932331AbbGJMZv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 10 Jul 2015 08:25:51 -0400
Received: by wgck11 with SMTP id k11so248247777wgc.0
        for <linux-rt-users@vger.kernel.org>; Fri, 10 Jul 2015 05:25:49 -0700 (PDT)
In-Reply-To: <1436531131-9186-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Create an rt-tests.tar file using git-archive so we don't mistakenly
pull in uncommitted files

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index 1f7640b82fa6..07394e1292f7 100644
--- a/Makefile
+++ b/Makefile
@@ -118,6 +118,7 @@ CLEANUP += $(if $(wildcard .git), ChangeLog)
 .PHONY: clean
 clean:
 	for F in $(CLEANUP); do find -type f -name $$F | xargs rm -f; done
+	rm -f rt-tests-*.tar
 	rm -f hwlatdetect
 	rm -f tags
 
@@ -165,6 +166,10 @@ release: distclean changelog
 	rm -f ChangeLog
 	cp rt-tests-$(VERSION).tar.gz rt-tests-$(VERSION).tar.asc releases
 
+.PHONY: tarball
+tarball:
+	git archive --worktree-attributes --prefix=rt-tests-${VERSION}/ -o rt-tests-${VERSION}.tar v${VERSION}
+
 .PHONY: push
 push:	release
 	scripts/do-git-push $(VERSION)
-- 
1.8.3.1

