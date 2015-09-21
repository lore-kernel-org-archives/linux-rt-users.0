From: Henrik Austad <haustad@cisco.com>
Subject: [PATCH 1/6] Add CROSS_COMPILE-switch to CC and AR
Date: Mon, 21 Sep 2015 17:27:23 +0200
Message-ID: <1442849248-573-2-git-send-email-haustad@cisco.com>
References: <1442849248-573-1-git-send-email-haustad@cisco.com>
Cc: linux-rt-users@vger.kernel.org, Josh Cartwright <joshc@ni.com>,
	Henrik Austad <haustad@cisco.com>
To: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from alln-iport-6.cisco.com ([173.37.142.93]:61554 "EHLO
	alln-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbbIUP3d (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 11:29:33 -0400
In-Reply-To: <1442849248-573-1-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Signed-off-by: Henrik Austad <haustad@cisco.com>
---
 Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Makefile b/Makefile
index 3094e1b..f630076 100644
--- a/Makefile
+++ b/Makefile
@@ -1,4 +1,6 @@
 VERSION = 0.93
+CC=$(CROSS_COMPILE)gcc
+AR=$(CROSS_COMPILE)ar
 
 HAVE_NPTL ?= yes
 
-- 
1.9.1

