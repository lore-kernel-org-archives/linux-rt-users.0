Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77627C4338F
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 19:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5218360E78
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 Aug 2021 19:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhHJT5K (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:57:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45596 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhHJT5K (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 Aug 2021 15:57:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628625406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ShLdXjBcRSN9+BSVuD5nhnixRvrV/nyBzQZnWsE/3A=;
        b=3G90QhTytbFw6VrnKeea1yg5ZCHrs3LXJvjVjT9HNpXZOnMnRPlC2Sh8P0cO/4zRg2TZvQ
        P1UxKTFSrnHDbGOaVHNEPyK5ktgTvyzTuEvVTRuGlZMDpYX/0skgS7gOOnWJUB5w3uKwMM
        kY1hC9M5wJbFOYPPVjL/rdxU7hEa01UQpJp7tZV2jTz5mVe0Pp7cxSjrIO2tI5lzAzKJcl
        BAX6Iyj9KX8OyWy7u4O51dPdJo+lKegAZNNYGWDoxor1uePe5DQfvIRaZU8u+zyPiBykLN
        DevwdrZHEXaAF4GIUaiIIJXCkGHmIjnTi9kiH/4jTyDx4YCJ8RZDS/8bQEXc1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628625406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ShLdXjBcRSN9+BSVuD5nhnixRvrV/nyBzQZnWsE/3A=;
        b=k9OBeh92PPZgA6Dvms0FBuNB/LFYVADGW92G6SzPJjftUgl2/saJRBBbzMb4VmWXat1tbG
        /PKLujNzZnrbyiDg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [SPLAT 1/3] arm_pmu: Sleeping spinlocks down armpmu_alloc_atomic()
In-Reply-To: <20210810183914.2wd7hehdz7y4crla@linutronix.de>
References: <20210810134127.1394269-1-valentin.schneider@arm.com>
 <20210810134127.1394269-2-valentin.schneider@arm.com>
 <20210810135453.roczkohgm2lzhg66@linutronix.de> <874kbxqkyk.ffs@tglx>
 <20210810183914.2wd7hehdz7y4crla@linutronix.de>
Date:   Tue, 10 Aug 2021 21:56:45 +0200
Message-ID: <87y299oyyq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Aug 10 2021 at 20:39, Sebastian Andrzej Siewior wrote:
> On 2021-08-10 19:16:19 [+0200], Thomas Gleixner wrote:
>> On Tue, Aug 10 2021 at 15:54, Sebastian Andrzej Siewior wrote:
>> > On 2021-08-10 14:41:25 [+0100], Valentin Schneider wrote:
>> >> [    4.172817] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:35
>> >
>> > Would it work to allocate the memory upfront and invoke the HP callback
>> > via smp_function_call()?
>> 
>> Huch? If the memory is allocated during the prepare stage then the
>> actual hotplug callback can just use it. So what's the SMP function call
>> for?
>
> You allocate the memory per-node (based on cpuid id) and you figure that
> out on the target CPU. That is the smp-function call for unless there
> another way to gather that information.
> That is done in
>  arm_pmu_acpi_find_alloc_pmu() -> read_cpuid_id()

There is no SMP function call involved. This is straight CPU hotplug
context on the upcoming CPU.

You cannot allocate upfront on the control CPU and do an SMP function
call to a not even started CPU. No idea what you are trying to do, but
this is going nowhere.

The reason why this atomic allocation is done is described in this
commit:

commit 0dc1a1851af1d593eee248b94c1277c7c7ccbbce
Author: Mark Rutland <mark.rutland@arm.com>
Date:   Mon Feb 5 16:41:58 2018 +0000

    arm_pmu: add armpmu_alloc_atomic()
    
    In ACPI systems, we don't know the makeup of CPUs until we hotplug them
    on, and thus have to allocate the PMU datastructures at hotplug time.
    Thus, we must use GFP_ATOMIC allocations.

I have no idea why ACPI does not expose topology and PMU information in
the first place, but do I really want to know?

So the easy way out is to preallocate one PMU and use that preallocation
when needed in the starting callback. Completely untested patch
below. Note, that because I'm lazy this will waste one preallocated PMU
at the end, but that's trivial enough to clean up.

Thanks,

        tglx
---
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -861,12 +861,12 @@ static void cpu_pmu_destroy(struct arm_p
 					    &cpu_pmu->node);
 }
 
-static struct arm_pmu *__armpmu_alloc(gfp_t flags)
+struct arm_pmu *armpmu_alloc(void)
 {
 	struct arm_pmu *pmu;
 	int cpu;
 
-	pmu = kzalloc(sizeof(*pmu), flags);
+	pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
 	if (!pmu)
 		goto out;
 
@@ -916,17 +916,6 @@ static struct arm_pmu *__armpmu_alloc(gf
 	return NULL;
 }
 
-struct arm_pmu *armpmu_alloc(void)
-{
-	return __armpmu_alloc(GFP_KERNEL);
-}
-
-struct arm_pmu *armpmu_alloc_atomic(void)
-{
-	return __armpmu_alloc(GFP_ATOMIC);
-}
-
-
 void armpmu_free(struct arm_pmu *pmu)
 {
 	free_percpu(pmu->hw_events);
--- a/drivers/perf/arm_pmu_acpi.c
+++ b/drivers/perf/arm_pmu_acpi.c
@@ -185,6 +185,8 @@ static int arm_pmu_acpi_parse_irqs(void)
 	return err;
 }
 
+static struct arm_pmu *arm_pmu_prealloced;
+
 static struct arm_pmu *arm_pmu_acpi_find_alloc_pmu(void)
 {
 	unsigned long cpuid = read_cpuid_id();
@@ -199,15 +201,9 @@ static struct arm_pmu *arm_pmu_acpi_find
 		return pmu;
 	}
 
-	pmu = armpmu_alloc_atomic();
-	if (!pmu) {
-		pr_warn("Unable to allocate PMU for CPU%d\n",
-			smp_processor_id());
-		return NULL;
-	}
-
+	pmu = arm_pmu_prealloced;
+	arm_pmu_prealloced = NULL;
 	pmu->acpi_cpuid = cpuid;
-
 	return pmu;
 }
 
@@ -284,6 +280,19 @@ static int arm_pmu_acpi_cpu_starting(uns
 	return 0;
 }
 
+static int arm_pmu_acpi_cpu_prepare(unsigned int cpu)
+{
+	if (per_cpu(probed_pmus, cpu) || arm_pmu_prealloced)
+		return 0;
+
+	arm_pmu_prealloced = armpmu_alloc();
+	if (!arm_pmu_prealloced) {
+		pr_warn("Unable to allocate PMU for CPU%d\n", cpu);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 int arm_pmu_acpi_probe(armpmu_init_fn init_fn)
 {
 	int pmu_idx = 0;
@@ -338,7 +347,7 @@ int arm_pmu_acpi_probe(armpmu_init_fn in
 
 static int arm_pmu_acpi_init(void)
 {
-	int ret;
+	int ret, dynstate;
 
 	if (acpi_disabled)
 		return 0;
@@ -349,9 +358,17 @@ static int arm_pmu_acpi_init(void)
 	if (ret)
 		return ret;
 
+	dynstate = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN,
+				     "perf/arm/pmu_acpi:prepare",
+				     arm_pmu_acpi_cpu_prepare, NULL);
+	if (dynstate < 0)
+		return dynstate;
+
 	ret = cpuhp_setup_state(CPUHP_AP_PERF_ARM_ACPI_STARTING,
 				"perf/arm/pmu_acpi:starting",
 				arm_pmu_acpi_cpu_starting, NULL);
+	if (ret)
+		cpuhp_remove_state(dynstate);
 
 	return ret;
 }
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -165,7 +165,6 @@ static inline int arm_pmu_acpi_probe(arm
 
 /* Internal functions only for core arm_pmu code */
 struct arm_pmu *armpmu_alloc(void);
-struct arm_pmu *armpmu_alloc_atomic(void);
 void armpmu_free(struct arm_pmu *pmu);
 int armpmu_register(struct arm_pmu *pmu);
 int armpmu_request_irq(int irq, int cpu);
