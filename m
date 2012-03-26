From: John Kacur <jkacur@redhat.com>
Subject: [PATCH rt-tests RFC] install: Fix failed to create symbolic link hwlatdetect file exists
Date: Mon, 26 Mar 2012 15:33:39 +0200
Message-ID: <1332768819-4447-1-git-send-email-jkacur@redhat.com>
Cc: Carsten Emde <C.Emde@osadl.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>,
	Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:38571 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172Ab2CZNec (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 26 Mar 2012 09:34:32 -0400
Received: by eaaq12 with SMTP id q12so1532818eaa.19
        for <linux-rt-users@vger.kernel.org>; Mon, 26 Mar 2012 06:34:31 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

The following build error can occur if you have done a previous make install

if test -n "/usr/lib/python2.7/site-packages" ; then \
	install -D -m 755 src/hwlatdetect/hwlatdetect.py /usr/lib/python2.7/site-packages/hwlatdetect.py ; \
	ln -s /usr/lib/python2.7/site-packages/hwlatdetect.py "/usr/local/bin/hwlatdetect" ; \
fi
ln: failed to create symbolic link `/usr/local/bin/hwlatdetect': File exists
make: *** [install] Error 1

I initially wanted to fix the error by removing the symbolic link, with rm -rf
but Andrew Burgess pointed out that you can just use the
ln's -f (force) flag. I like that solution better.

Suggested-by: Andrew Burgess <aab@cichlid.com>
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ff697ca..a143545 100644
--- a/Makefile
+++ b/Makefile
@@ -125,7 +125,7 @@ install: all
 	cp $(TARGETS) "$(DESTDIR)$(bindir)"
 	if test -n "$(PYLIB)" ; then \
 		install -D -m 755 src/hwlatdetect/hwlatdetect.py $(DESTDIR)$(PYLIB)/hwlatdetect.py ; \
-		ln -s $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
+		ln -sf $(PYLIB)/hwlatdetect.py "$(DESTDIR)$(bindir)/hwlatdetect" ; \
 	fi
 	install -D -m 644 src/backfire/backfire.c "$(DESTDIR)$(srcdir)/backfire/backfire.c"
 	install -m 644 src/backfire/Makefile "$(DESTDIR)$(srcdir)/backfire/Makefile"
-- 
1.7.7.6

