From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 5/7] Makefile: add librttest to rt-migrate-test
Date: Fri, 18 Sep 2015 18:52:48 +0200
Message-ID: <1442595170-6229-6-git-send-email-haustad@cisco.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-2.cisco.com ([173.38.203.52]:17744 "EHLO
	aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754179AbbIRRE2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 13:04:28 -0400
In-Reply-To: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

linker must be able to resolve reference to err_msg_n properly

   rt-migrate-test.c:(.text+0x1ff): undefined reference to `err_msg_n'

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 160547c..b034e19 100644
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

