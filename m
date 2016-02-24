From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: [PATCH 2/4] rt-migrate-test: fix return code
Date: Wed, 24 Feb 2016 15:49:39 -0500
Message-ID: <1456346981-24032-3-git-send-email-lcapitulino@redhat.com>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
Cc: williams@redhat.com, jkacur@redhat.com
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35864 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757045AbcBXUtp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 24 Feb 2016 15:49:45 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id 684FBC00B8C8
	for <linux-rt-users@vger.kernel.org>; Wed, 24 Feb 2016 20:49:45 +0000 (UTC)
In-Reply-To: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Change both return codes for the stop == true case:

 * For failures, use exit(1) as exit(-1) is wrong
   (it actually becomes 255 in the shell)

 * For success, use exit(2) instead of exit(1) as
   exit(1) is usually used for errors

This should preserve the requirement of allowing
shell script while loops to break when Ctrl-C is hit.

Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
---
 src/rt-migrate-test/rt-migrate-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
index fc6fd81..6e8acc2 100644
--- a/src/rt-migrate-test/rt-migrate-test.c
+++ b/src/rt-migrate-test/rt-migrate-test.c
@@ -594,9 +594,9 @@ int main (int argc, char **argv)
 		 * loop know to break.
 		 */
 		if (check < 0)
-			exit(-1);
-		else
 			exit(1);
+		else
+			exit(2);
 	}
 	if (check < 0)
 		exit(-1);
-- 
2.1.0

