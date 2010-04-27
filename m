From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG] 2.6.33.2-rt13 and iptables
Date: Tue, 27 Apr 2010 10:13:36 +0200 (CEST)
Message-ID: <alpine.LFD.2.00.1004271012280.2951@localhost.localdomain>
References: <hr1vm2$2tk$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: FC <prd.gtt@operamail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:56095 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752838Ab0D0INq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 27 Apr 2010 04:13:46 -0400
In-Reply-To: <hr1vm2$2tk$1@dough.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 25 Apr 2010, FC wrote:

> - Updated Debian SID x86 32 bit
> - kernel 2.6.33.2-rt13
> - iptables v1.4.6
> 
> I've experimented some problems while displaying processed packets by
> iptables ( iptables -L -n -v ). The output displays a large number of
> processed packets with a very low network activity in my LAN ( max 1 hundred
> of packets delivered )
> 
> A sample output obtained after loading iptables rules and quite immediately
> running iptables -L -n -v

Can you please test the patch below on top of -rt ?

Thanks,

	tglx

---------->
Subject: net-fix-iptables-fallout.patch
From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 27 Apr 2010 10:05:28 +0200

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 net/ipv4/netfilter/ip_tables.c  |    9 +++++----
 net/ipv6/netfilter/ip6_tables.c |   10 +++++-----
 2 files changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6-tip/net/ipv4/netfilter/ip_tables.c
===================================================================
--- linux-2.6-tip.orig/net/ipv4/netfilter/ip_tables.c
+++ linux-2.6-tip/net/ipv4/netfilter/ip_tables.c
@@ -907,7 +907,7 @@ get_counters(const struct xt_table_info 
 {
 	unsigned int cpu;
 	unsigned int i;
-	unsigned int curcpu = NR_CPUS;
+	unsigned int curcpu;
 
 	/* Instead of clearing (by a previous call to memset())
 	 * the counters and using adds, we set the counters
@@ -917,16 +917,17 @@ get_counters(const struct xt_table_info 
 	 * if new softirq were to run and call ipt_do_table
 	 */
 	local_bh_disable();
-#ifndef CONFIG_PREEMPT_RT
-	curcpu = smp_processor_id();
+	curcpu = raw_smp_processor_id();
 
 	i = 0;
+	xt_info_wrlock(curcpu);
 	IPT_ENTRY_ITERATE(t->entries[curcpu],
 			  t->size,
 			  set_entry_to_counter,
 			  counters,
 			  &i);
-#endif
+	xt_info_wrunlock(curcpu);
+
 	for_each_possible_cpu(cpu) {
 		if (cpu == curcpu)
 			continue;
Index: linux-2.6-tip/net/ipv6/netfilter/ip6_tables.c
===================================================================
--- linux-2.6-tip.orig/net/ipv6/netfilter/ip6_tables.c
+++ linux-2.6-tip/net/ipv6/netfilter/ip6_tables.c
@@ -939,7 +939,7 @@ get_counters(const struct xt_table_info 
 {
 	unsigned int cpu;
 	unsigned int i;
-	unsigned int curcpu = NR_CPUS;
+	unsigned int curcpu;
 
 	/* Instead of clearing (by a previous call to memset())
 	 * the counters and using adds, we set the counters
@@ -949,17 +949,17 @@ get_counters(const struct xt_table_info 
 	 * if new softirq were to run and call ipt_do_table
 	 */
 	local_bh_disable();
