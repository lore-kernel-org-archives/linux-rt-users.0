From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [RFC 2/4] cyclictest: move debugfs init code to its own function
Date: Tue, 23 Feb 2016 14:43:51 -0500
Message-ID: <1456256633-17639-3-git-send-email-lcapitulino@redhat.com>
References: <1456256633-17639-1-git-send-email-lcapitulino@redhat.com>
Cc: jkacur@redhat.com, williams@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754318AbcBWTn7 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 23 Feb 2016 14:43:59 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 50CAF627C3
	for <linux-rt-users@vger.kernel.org>; Tue, 23 Feb 2016 19:43:59 +0000 (UTC)
In-Reply-To: <1456256633-17639-1-git-send-email-lcapitulino@redhat.com>
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
