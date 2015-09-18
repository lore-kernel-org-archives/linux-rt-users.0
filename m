From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 1/7] Add CROSS_COMPILE-switch to CC and AR
Date: Fri, 18 Sep 2015 18:52:44 +0200
Message-ID: <1442595170-6229-2-git-send-email-haustad@cisco.com>
References: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from aer-iport-1.cisco.com ([173.38.203.51]:30285 "EHLO
	aer-iport-1.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbbIRRE2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 18 Sep 2015 13:04:28 -0400
In-Reply-To: <1442595170-6229-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index f3534b3..d4988c5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,6 @@
 VERSION = 0.93
+CC=$(CROSS_COMPILE)gcc
+AR=$(CROSS_COMPILE)ar
 
 HAVE_NPTL ?= yes
 
-- 
1.9.1

