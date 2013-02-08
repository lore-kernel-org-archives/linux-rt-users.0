From: John Kacur <jkacur@redhat.com>
Subject: [PATCH RT-TESTS 3/3] Makefile: Add BUILDROOT and SPECS to the dirs to remove for distclean
Date: Fri,  8 Feb 2013 15:47:35 +0100
Message-ID: <1360334855-10176-4-git-send-email-jkacur@redhat.com>
References: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f54.google.com ([209.85.214.54]:61348 "EHLO
	mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759940Ab3BHOrr (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 09:47:47 -0500
Received: by mail-bk0-f54.google.com with SMTP id w5so1695040bku.41
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Feb 2013 06:47:46 -0800 (PST)
In-Reply-To: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: John Kacur <jkacur@redhat.com>

make rpm creates the dirs BUILDROOT and SPECS that are missed by distclean.
Gather all rpm related DIRS to the RPMDIRS and add that to distclean.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index ecc7386..25cfbfb 100644
--- a/Makefile
+++ b/Makefile
@@ -111,9 +111,10 @@ clean:
 	rm -f hwlatdetect
 	rm -f tags
 
+RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
 .PHONY: distclean
 distclean: clean
-	rm -rf BUILD RPMS SRPMS releases *.tar.gz rt-tests.spec tmp
+	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
 
 .PHONY: changelog
 changelog:
-- 
1.7.11.7

