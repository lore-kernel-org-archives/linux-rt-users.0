From: Tiejun Chen <tiejun.chen@windriver.com>
Subject: [PATCH] pin_current_cpu: move preempt_enable() outside
Date: Thu, 7 Nov 2013 11:07:30 +0800
Message-ID: <1383793650-7839-1-git-send-email-tiejun.chen@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <tglx@linutronix.de>, <stable-rt@vger.kernel.org>,
	<linux-rt-users@vger.kernel.org>
To: <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail1.windriver.com ([147.11.146.13]:40150 "EHLO
	mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752707Ab3KGDIi (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 6 Nov 2013 22:08:38 -0500
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

It should make better sense than before.

Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
---
 kernel/cpu.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index da6e128..7b1853f 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -124,12 +124,11 @@ retry:
 		return;
 	}
 
+	preempt_enable();
 	if (hp->grab_lock) {
-		preempt_enable();
 		hotplug_lock(hp);
 		hotplug_unlock(hp);
 	} else {
-		preempt_enable();
 		/*
 		 * Try to push this task off of this CPU.
 		 */
-- 
1.7.9.5

