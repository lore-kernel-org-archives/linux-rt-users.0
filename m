From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 3/7] Add a rebuild-switch to Makefile
Date: Fri, 18 Sep 2015 18:52:46 +0200
Message-ID: <1442595170-6229-4-git-send-email-haustad@cisco.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-2.cisco.com ([173.38.203.52]:17744 "EHLO
	aer-iport-2.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753171AbbIRRE1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 13:04:27 -0400
In-Reply-To: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Makefile b/Makefile
index d4988c5..160547c 100644
--- a/Makefile
+++ b/Makefile
@@ -129,6 +129,9 @@ RPMDIRS = BUILD BUILDROOT RPMS SRPMS SPECS
 distclean: clean
 	rm -rf $(RPMDIRS) releases *.tar.gz rt-tests.spec tmp
 
+.PHONY: rebuild
+rebuild: clean all
+
 .PHONY: changelog
 changelog:
 	git log >ChangeLog
-- 
1.9.1

