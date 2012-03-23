From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC] install: Fix failed to create symbolic link hwlatdetect file exists
Date: Fri, 23 Mar 2012 02:20:55 +0100
Message-ID: <1332465655-7005-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46786 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932240Ab2CWBVy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Mar 2012 21:21:54 -0400
Received: by wibhj6 with SMTP id hj6so1453169wib.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Mar 2012 18:21:53 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The following build error can occur if you have done a previous make install

if test -n "/usr/lib/python2.7/site-packages" ; then \
	install -D -m 755 src/hwlatdetect/hwlatdetect.py /usr/lib/python2.7/site-packages/hwlatdetect.py ; \
	ln -s /usr/lib/python2.7/site-packages/hwlatdetect.py "/usr/local/bin/hwlatdetect" ; \
fi
ln: failed to create symbolic link `/usr/local/bin/hwlatdetect': File exists
make: *** [install] Error 1

Fix the error by removing the symbolic link.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index ff697ca..31e1792 100644
--- a/Makefile
+++ b/Makefile
@@ -125,6 +125,7 @@ install: all
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	if test -n "$(PYLIB)" ; then \
 		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
+		rm -f "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 	fi
 	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
-- 
1.7.7.6

