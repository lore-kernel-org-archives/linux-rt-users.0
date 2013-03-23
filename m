From: Mike Galbraith <bitbucket@online.de>
Subject: [PATCH] rt,cpusets: seqlock fixlet for
 cpuset.c::cpuset_print_task_mems_allowed()
Date: Sat, 23 Mar 2013 19:10:29 +0100
Message-ID: <1364062229.5596.7.camel@marge.simpson.net>
References: <1363962528.6345.97.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57940 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab3CWSKd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 23 Mar 2013 14:10:33 -0400
In-Reply-To: <1363962528.6345.97.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Added by mainline 63f43f55c9bbc14f76b582644019b8a07dc8219a
cpuset: fix cpuset_print_task_mems_allowed() vs rename() race

Signed-off-by: Mike Galbraith <bitbucket@online.de>
---
 kernel/cpuset.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpuset.c b/kernel/cpuset.c
index ea76c9c..63675f1 100644
--- a/kernel/cpuset.c
+++ b/kernel/cpuset.c
@@ -2503,10 +2503,10 @@ void cpuset_print_task_mems_allowed(struct task_struct *tsk)
 	if (!dentry) {
 		strcpy(cpuset_name, "/");
 	} else {
-		spin_lock(&dentry->d_lock);
+		seq_spin_lock(&dentry->d_lock);
 		strlcpy(cpuset_name, (const char *)dentry->d_name.name,
 			CPUSET_NAME_LEN);
-		spin_unlock(&dentry->d_lock);
+		seq_spin_unlock(&dentry->d_lock);
 	}
 
 	nodelist_scnprintf(cpuset_nodelist, CPUSET_NODELIST_LEN,
-- 
1.7.10.3



