Return-Path: <SRS0=6U1w=RS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B19BC43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Mar 2019 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428AE218AC
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Mar 2019 16:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbfCOQmn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Mar 2019 12:42:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:53783 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728480AbfCOQmm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Mar 2019 12:42:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h4pum-0004z8-7P; Fri, 15 Mar 2019 17:42:36 +0100
Date:   Fri, 15 Mar 2019 17:42:36 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Liu, Yongxin" <Yongxin.Liu@windriver.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "pagupta@redhat.com" <pagupta@redhat.com>,
        "Gortmaker, Paul" <Paul.Gortmaker@windriver.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Subject: Re: [PATCH RT] nvdimm: make lane acquirement RT aware
Message-ID: <20190315164236.rzbwe7reeprjv3um@linutronix.de>
References: <20190306095709.23138-1-yongxin.liu@windriver.com>
 <20190307143344.ytsnbmot5tjzjhip@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A52669@ALA-MBD.corp.ad.wrs.com>
 <20190308094131.ge4wbsvz4p6xikdf@linutronix.de>
 <597B109EC20B76429F71A8A97770610D12A5643B@ALA-MBD.corp.ad.wrs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <597B109EC20B76429F71A8A97770610D12A5643B@ALA-MBD.corp.ad.wrs.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-11 00:44:58 [+0000], Liu, Yongxin wrote:
> > but you still have the ndl_lock->lock which protects the resource. So in
> > the unlikely (but possible event) that you switch CPUs after obtaining
> > the CPU number you block on the lock. No harm is done, right?
> 
> The resource "lane" can be acquired recursively, so "ndl_lock->lock" is a conditional lock.
> 
> ndl_count->count is per CPU.
> ndl_lock->lock is per lane.
> 
> Here is an example:
> Thread A  on CPU 5 --> nd_region_acquire_lane --> lane# 5 --> get "ndl_lock->lock"
> --> nd_region_acquire_lane --> lane# 5 --> bypass "ndl_lock->lock" due to "ndl_count->count++".
> 
> Thread B on CPU 5 --> nd_region_acquire_lane --> lane# 5 --> bypass "ndl_lock->lock" ("ndl_count->count"
> was changed by Thread A)
> 
> If we use raw_smp_processor_id(), no matter which CPU the thread was migrated to, 
> if there is another thread running on the old CPU, there will be race condition 
> due to per CPU variable "ndl_count->count".

so I've been looking at it again. The recursive locking could have been
solved better. Like the local_lock() on -RT is doing it.
Given that you lock with preempt_disable() there should be no in-IRQ
usage.
But in the "nd_region->num_lanes >= nr_cpu_ids" case you don't take any
locks. That would be a problem with raw_smp_processor_id() approach.

So what about the completely untested patch here:

diff --git a/drivers/nvdimm/nd.h b/drivers/nvdimm/nd.h
index 379bf4305e615..98c2e9df4b2e4 100644
--- a/drivers/nvdimm/nd.h
+++ b/drivers/nvdimm/nd.h
@@ -109,7 +109,8 @@ unsigned sizeof_namespace_label(struct nvdimm_drvdata *ndd);
 			res; res = next, next = next ? next->sibling : NULL)
 
 struct nd_percpu_lane {
-	int count;
+	struct task_struct *owner;
+	int nestcnt;
 	spinlock_t lock;
 };
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index e2818f94f2928..8a62f9833513f 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -946,19 +946,17 @@ int nd_blk_region_init(struct nd_region *nd_region)
  */
 unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 {
+	struct nd_percpu_lane *ndl_lock;
 	unsigned int cpu, lane;
 
-	cpu = get_cpu();
-	if (nd_region->num_lanes < nr_cpu_ids) {
-		struct nd_percpu_lane *ndl_lock, *ndl_count;
-
-		lane = cpu % nd_region->num_lanes;
-		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
-		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
-		if (ndl_count->count++ == 0)
-			spin_lock(&ndl_lock->lock);
-	} else
-		lane = cpu;
+	cpu = raw_smp_processor_id();
+	lane = cpu % nd_region->num_lanes;
+	ndl_lock  = per_cpu_ptr(nd_region->lane, lane);
+	if (ndl_lock->owner != current) {
+		spin_lock(&ndl_lock->lock);
+		ndl_lock->owner = current;
+	}
+	ndl_lock->nestcnt++;
 
 	return lane;
 }
@@ -966,17 +964,16 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
 
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 {
-	if (nd_region->num_lanes < nr_cpu_ids) {
-		unsigned int cpu = get_cpu();
-		struct nd_percpu_lane *ndl_lock, *ndl_count;
+	struct nd_percpu_lane *ndl_lock;
 
-		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
-		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
-		if (--ndl_count->count == 0)
-			spin_unlock(&ndl_lock->lock);
-		put_cpu();
-	}
-	put_cpu();
+	ndl_lock = per_cpu_ptr(nd_region->lane, lane);
+	WARN_ON(ndl_lock->nestcnt == 0);
+	WARN_ON(ndl_lock->owner != current);
+	if (--ndl_lock->nestcnt)
+		return;
+
+	ndl_lock->owner = NULL;
+	spin_unlock(&ndl_lock->lock);
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
@@ -1042,7 +1039,8 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
 
 		ndl = per_cpu_ptr(nd_region->lane, i);
 		spin_lock_init(&ndl->lock);
-		ndl->count = 0;
+		ndl->owner = NULL;
+		ndl->nestcnt = 0;
 	}
 
 	for (i = 0; i < ndr_desc->num_mappings; i++) {

> Thanks,
> Yongxin

Sebastian
