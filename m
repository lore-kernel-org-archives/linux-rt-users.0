From: John Kacur <jkacur@redhat.com>
Subject: [PATCH 1/2] rt-tests: cyclicdeadline: Fix minor spelling mistake
Date: Fri, 28 Oct 2016 17:11:09 +0200
Message-ID: <1477667470-9691-1-git-send-email-jkacur@redhat.com>
Cc: Clark Williams <williams@redhat.com>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        John Kacur <jkacur@redhat.com>
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34577 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbcJ1PLf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 28 Oct 2016 11:11:35 -0400
Received: by mail-wm0-f67.google.com with SMTP id p190so1574412wmp.1
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Oct 2016 08:11:34 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Fix spelling mistake, "that" should be "than" in the following message

For less that 2ms run times, you need to
have HRTICK enabled in debugfs/sched_features

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 src/sched_deadline/cyclicdeadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
index fd78d315563e..761f8d7d7483 100644
--- a/src/sched_deadline/cyclicdeadline.c
+++ b/src/sched_deadline/cyclicdeadline.c
@@ -1155,7 +1155,7 @@ int main (int argc, char **argv)
 			 * have HRTICK enabled.
 			 */
 			if (!setup_hr_tick()) {
-				fprintf(stderr, "For less that 2ms run times, you need to\n"
+				fprintf(stderr, "For less than 2ms run times, you need to\n"
 					"have HRTICK enabled in debugfs/sched_features\n");
 				exit(-1);
 			}
-- 
2.5.5

