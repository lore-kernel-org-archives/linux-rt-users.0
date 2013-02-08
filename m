From: John Kacur <jkacur@redhat.com>
Subject: [PATCH RT-TESTS 2/3] Makefile: Add tmp dir to distclean and "make release" call distclean
Date: Fri,  8 Feb 2013 15:47:34 +0100
Message-ID: <1360334855-10176-3-git-send-email-jkacur@redhat.com>
References: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:60142 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760017Ab3BHOrp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 09:47:45 -0500
Received: by mail-bk0-f49.google.com with SMTP id w11so1722639bku.36
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Feb 2013 06:47:44 -0800 (PST)
In-Reply-To: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: John Kacur <jkacur@redhat.com>

The files in the tmp dir are generated during make release.
These are the kind of generated files that should be removed for distclean,
So add tmp. make release can be slightly simplified by then depending
on distclean instead of clean.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index 3b637c5..ecc7386 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ clean:
 
 .PHONY: distclean
 distclean: clean
-	rm -rf BUILD RPMS SRPMS releases *.tar.gz rt-tests.spec
+	rm -rf BUILD RPMS SRPMS releases *.tar.gz rt-tests.spec tmp
 
 .PHONY: changelog
 changelog:
@@ -143,9 +143,9 @@ install: all
 	gzip src/hackbench/hackbench.8 -c >"$(DESTDIR)$(mandir)/man8/hackbench.8.gz"
 
 .PHONY: release
-release: clean changelog
+release: distclean changelog
 	mkdir -p releases
-	rm -rf tmp && mkdir -p tmp/rt-tests
+	mkdir -p tmp/rt-tests
 	cp -r Makefile COPYING ChangeLog src tmp/rt-tests
 	tar -C tmp -czf rt-tests-$(VERSION_STRING).tar.gz rt-tests
 	rm -f ChangeLog
-- 
1.7.11.7

