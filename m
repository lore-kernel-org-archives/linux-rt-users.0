From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 2/4] cyclictest: move debugfs init code to its own function
Date: Thu, 25 Feb 2016 11:29:15 -0500
Message-ID: <1456417757-13444-3-git-send-email-lcapitulino@redhat.com>
References: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56576 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760903AbcBYQ30 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Feb 2016 11:29:26 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 9F7ED627FB
	for <linux-rt-users@vger.kernel.org>; Thu, 25 Feb 2016 16:29:25 +0000 (UTC)
In-Reply-To: <1456417757-13444-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

A function added by a future commit will want to call
this code too.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/cyclictest/cyclictest.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
index 54fc033..f543c34 100644
--- a/src/cyclictest/cyclictest.c
+++ b/src/cyclictest/cyclictest.c
@@ -479,11 +479,8 @@ static int settracer(char *tracer)
 	return -1;
 }
 
-static void setup_tracer(void)
+static void debugfs_prepare(void)
 {
-	if (!tracelimit || notrace)
-		return;
