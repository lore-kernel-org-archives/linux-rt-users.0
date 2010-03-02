From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 2/2] rt: reserve TASK_STOPPED state when blocking on a spin lock
Date: Tue,  2 Mar 2010 16:51:58 -0500
Message-ID: <18e240905fcfd72457930322ee187e7ff9313aec.1267566249.git.paul.gortmaker@windriver.com>
References: <1267566718-9849-1-git-send-email-paul.gortmaker@windriver.com>
 <ffaf532c138188b526a8c623ed3c7f5067da6d68.1267566249.git.paul.gortmaker@windriver.com>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:46197 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753275Ab0CBVwM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 2 Mar 2010 16:52:12 -0500
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o22LqCOH011146
	for <linux-rt-users@vger.kernel.org>; Tue, 2 Mar 2010 13:52:12 -0800 (PST)
In-Reply-To: <ffaf532c138188b526a8c623ed3c7f5067da6d68.1267566249.git.paul.gortmaker@windriver.com>
In-Reply-To: <ffaf532c138188b526a8c623ed3c7f5067da6d68.1267566249.git.paul.gortmaker@windriver.com>
References: <ffaf532c138188b526a8c623ed3c7f5067da6d68.1267566249.git.paul.gortmaker@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

From: Kevin Hao <kexin.hao@windriver.com>

When a process handles a SIGSTOP signal, it will set the state to
TASK_STOPPED, acquire tasklist_lock and notifiy the parent of the
status change. But in the rt kernel the process state will change
to TASK_UNINTERRUPTIBLE if it blocks on the tasklist_lock. So if
we send a SIGCONT signal to this process at this time, the SIGCONT
signal just does nothing because this process is not in TASK_STOPPED
state. Of course this is not what we wanted. Preserving the
TASK_STOPPED state when blocking on a spin lock can fix this bug.

Signed-off-by: Kevin Hao <kexin.hao@windriver.com>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 kernel/rtmutex.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
index 16bfa1c..23dd443 100644
--- a/kernel/rtmutex.c
+++ b/kernel/rtmutex.c
@@ -757,8 +757,9 @@ rt_set_current_blocked_state(unsigned long saved_state)
 	 * saved_state. Now we can ignore further wakeups as we will
 	 * return in state running from our "spin" sleep.
 	 */
-	if (saved_state == TASK_INTERRUPTIBLE)
-		block_state = TASK_INTERRUPTIBLE;
+	if (saved_state == TASK_INTERRUPTIBLE ||
+		saved_state == TASK_STOPPED)
+		block_state = saved_state;
 	else
 		block_state = TASK_UNINTERRUPTIBLE;
 
-- 
1.6.5.2

