From: John Kacur <jkacur@redhat.com>
Subject: [PATCH RT-TESTS 1/3] Makefile: Don't tag tmp files created when making a release
Date: Fri,  8 Feb 2013 15:47:33 +0100
Message-ID: <1360334855-10176-2-git-send-email-jkacur@redhat.com>
References: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Cc: Frank Rowand <frank.rowand@am.sony.com>,
	rt-users <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f52.google.com ([209.85.214.52]:52455 "EHLO
	mail-bk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758440Ab3BHOrn (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 Feb 2013 09:47:43 -0500
Received: by mail-bk0-f52.google.com with SMTP id jk13so1662147bkc.25
        for <linux-rt-users@vger.kernel.org>; Fri, 08 Feb 2013 06:47:42 -0800 (PST)
In-Reply-To: <1360334855-10176-1-git-send-email-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: John Kacur <jkacur@redhat.com>

Don't tag the copies of the source files placed in the tmp directory
during the creation of a release.
Without this change tags finds both copies, eg: for tag cyclictest.c
  # pri kind tag               file
  1 F C F    cyclictest.c      src/cyclictest/cyclictest.c
               1
  2 F   F    cyclictest.c      tmp/rt-tests/src/cyclictest/cyclictest.c
               1

With this change only the first one is found.

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index fd3cdb3..3b637c5 100644
--- a/Makefile
+++ b/Makefile
@@ -192,4 +192,4 @@ help:
 
 .PHONY: tags
 tags:
-	ctags -R --extra=+f --c-kinds=+p *
+	ctags -R --extra=+f --c-kinds=+p --exclude=tmp *
-- 
1.7.11.7

