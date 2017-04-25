From: Marcelo Tosatti <mtosatti@redhat.com>
Subject: [patch 1/2] MM: remove unused quiet_vmstat function
Date: Tue, 25 Apr 2017 10:57:18 -0300
Message-ID: <20170425135843.636700422@redhat.com>
References: <20170425135717.375295031@redhat.com>
Cc: Luiz Capitulino <lcapitulino@redhat.com>, Rik van Riel <riel@redhat.com>,
        Linux RT Users <linux-rt-users@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
To: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Return-path: <owner-linux-mm@kvack.org>
Content-Disposition: inline; filename=remove-vmstat-quiet
Sender: owner-linux-mm@kvack.org
List-Id: linux-rt-users.vger.kernel.org

Remove unused quiet_vmstat function.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>

---
 include/linux/vmstat.h |    1 -
 mm/vmstat.c            |   25 -------------------------
 2 files changed, 26 deletions(-)

Index: linux-2.6-git-disable-vmstat-worker/include/linux/vmstat.h
===================================================================
--- linux-2.6-git-disable-vmstat-worker.orig/include/linux/vmstat.h	2017-04-24 18:52:42.957724687 -0300
+++ linux-2.6-git-disable-vmstat-worker/include/linux/vmstat.h	2017-04-24 18:53:15.086793496 -0300
@@ -233,7 +233,6 @@
 extern void __dec_zone_state(struct zone *, enum zone_stat_item);
 extern void __dec_node_state(struct pglist_data *, enum node_stat_item);
 
-void quiet_vmstat(void);
 void cpu_vm_stats_fold(int cpu);
 void refresh_zone_stat_thresholds(void);
 
Index: linux-2.6-git-disable-vmstat-worker/mm/vmstat.c
===================================================================
--- linux-2.6-git-disable-vmstat-worker.orig/mm/vmstat.c	2017-04-24 18:52:42.957724687 -0300
+++ linux-2.6-git-disable-vmstat-worker/mm/vmstat.c	2017-04-24 18:53:53.075874785 -0300
@@ -1657,31 +1657,6 @@
 }
 
 /*
- * Switch off vmstat processing and then fold all the remaining differentials
- * until the diffs stay at zero. The function is used by NOHZ and can only be
- * invoked when tick processing is not active.
- */
-void quiet_vmstat(void)
-{
-	if (system_state != SYSTEM_RUNNING)
-		return;
-
-	if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
-		return;
-
-	if (!need_update(smp_processor_id()))
-		return;
-
-	/*
-	 * Just refresh counters and do not care about the pending delayed
-	 * vmstat_update. It doesn't fire that often to matter and canceling
-	 * it would be too expensive from this path.
-	 * vmstat_shepherd will take care about that for us.
-	 */
-	refresh_cpu_vm_stats(false);
-}
-
-/*
  * Shepherd worker thread that checks the
  * differentials of processors that have their worker
  * threads for vm statistics updates disabled because of


--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
