From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 3/6] Add a rebuild-switch to Makefile
Date: Mon, 21 Sep 2015 17:27:25 +0200
Message-ID: <1442849248-573-4-git-send-email-haustad@cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-5.cisco.com ([173.37.142.92]:5762 "EHLO
	alln-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbIUP3f (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:35 -0400
In-Reply-To: <1442849248-573-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Update from joshc for job-level safety

Co-authored.by: Josh Cartwright <joshc@ni.com>
Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Makefile b/Makefile
index f630076..fcf20ce 100644
--- a/Makefile
+++ b/Makefile
@@ -129,6 +129,11 @@ RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
 distclean: clean
 	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
 
+.PHONY: rebuild
+rebuild:
+	$(MAKE) clean
+	$(MAKE) all
+
 .PHONY: changelog
 changelog:
 	git log >ChangeLog
-- 
1.9.1

