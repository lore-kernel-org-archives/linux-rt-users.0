From: Josh Triplett <josh@kernel.org>
Subject: [PATCH] CFS: Mark print_cfs_stats static
Date: Fri, 20 Jul 2007 11:44:57 -0700
Message-ID: <1184957097.2630.17.camel@josh-work.beaverton.ibm.com>
Reply-To: josh@kernel.org, josht@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-rt-users@vger.kernel.org, mingo@elte.hu
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:58331 "EHLO
	e36.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751608AbXGTSoj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 20 Jul 2007 14:44:39 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

sched_fair.c defines print_cfs_stats, and sched_debug.c uses it, but sched.c
includes both sched_fair.c and sched_debug.c, so all the references to
print_cfs_stats occur in the same compilation unit.  Thus, mark
print_cfs_stats static.

Eliminates a sparse warning:
warning: symbol 'print_cfs_stats' was not declared. Should it be static?

Signed-off-by: Josh Triplett <josh@kernel.org>
---
This patch applies both to current Git and to 2.6.22.1-rt4.

 kernel/sched_fair.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/kernel/sched_fair.c b/kernel/sched_fair.c
index 6971db0..8b954b9 100644
--- a/kernel/sched_fair.c
+++ b/kernel/sched_fair.c
@@ -1120,7 +1120,7 @@ struct sched_class fair_sched_class __read_mostly = {
 };
 
 #ifdef CONFIG_SCHED_DEBUG
-void print_cfs_stats(struct seq_file *m, int cpu, u64 now)
+static void print_cfs_stats(struct seq_file *m, int cpu, u64 now)
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct cfs_rq *cfs_rq;
-- 
1.5.2.1
