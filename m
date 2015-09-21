From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 5/6] Makefile: add librttest to rt-migrate-test
Date: Mon, 21 Sep 2015 17:27:27 +0200
Message-ID: <1442849248-573-6-git-send-email-haustad@cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-1.cisco.com ([173.37.142.88]:33737 "EHLO
	alln-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932067AbbIUP3j (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:39 -0400
In-Reply-To: <1442849248-573-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

linker must be able to resolve reference to err_msg_n properly

   rt-migrate-test.c:(.text+0x1ff): undefined reference to `err_msg_n'

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index fcf20ce..66de743 100644
--- a/Makefile
+++ b/Makefile
@@ -87,8 +87,8 @@ hwlatdetect:  src/hwlatdetect/hwlatdetect.py
 	chmod +x src/hwlatdetect/hwlatdetect.py
 	ln -s src/hwlatdetect/hwlatdetect.py hwlatdetect
 
-rt-migrate-test: rt-migrate-test.o
-	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS)
+rt-migrate-test: rt-migrate-test.o librttest.a
+	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB)
 
 ptsematest: ptsematest.o librttest.a
 	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $< $(LIBS) $(RTTESTLIB) $(EXTRA_LIBS)
-- 
1.9.1

