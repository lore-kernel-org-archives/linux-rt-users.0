From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 2/4] cyclictest: move debugfs init code to its own function
Date: Thu, 17 Mar 2016 14:30:15 -0400
Message-ID: <1458239417-31089-3-git-send-email-lcapitulino@redhat.com>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967032AbcCQSa3 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 17 Mar 2016 14:30:29 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 51107C00F217
	for <linux-rt-users@vger.kernel.org>; Thu, 17 Mar 2016 18:30:29 +0000 (UTC)
In-Reply-To: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A function added by a future commit will want to call
this code too.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/cyclictest/cyclictest.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 6070457..4e80831 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -514,11 +514,8 @@ static int settracer(char *tracer)
 	return -1;
 }
 
-static void setup_tracer(void)
+static void debugfs_prepare(void)
 {
-	if (!tracelimit || notrace)
-		return;
