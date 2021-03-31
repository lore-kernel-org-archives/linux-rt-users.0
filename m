Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDE0C433ED
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 17:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E894061042
	for <linux-rt-users@archiver.kernel.org>; Wed, 31 Mar 2021 17:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbhCaRqw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 31 Mar 2021 13:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbhCaRqh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 31 Mar 2021 13:46:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40AB3C061574;
        Wed, 31 Mar 2021 10:46:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617212794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6M3oUFoCJof3OrZX7FrHMuqU0uhJPLOBOAa++y2rnM=;
        b=hnltiqf9FMDvo83gt70IXR/oNXXJWgEcos+iHuSQjczu8qGm5lo4hi6U1iI42+VlvC6FCd
        jttc6ByhgDH9nBZ8mPYxgPFQEcrJpExZk09rZopS1usU4XD2Ow3cZHmJkWqUr2yTNw55bT
        z3sI86fINzHBfN3y/erHRuX4oGbDn5LKSU0YMK1W7QqRl+Mj+v4QOAMFGmWsbhAfdbqEhh
        nGUYR8AAY/FY4Ud5NfiErnxyIjB+zmf2XiHC5gzYCiLm6e+GeeOQNo6VB5YkMlk1h4Wf3C
        yrPDfE7tbDZrXAE13Dg7qa/e6rLv12gQBWOngyAN5k4zVcAkdmd0rArs0CT4Sg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617212794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e6M3oUFoCJof3OrZX7FrHMuqU0uhJPLOBOAa++y2rnM=;
        b=6v3WlBROvKSc1tFWP8PmqFrEQJ4eDxGM2AErJ05hwHVrcEFvScQiqsEjfCs9TMayipddT1
        rrNb2GPSrmUODkAQ==
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/6] mm/page_alloc: Convert per-cpu list protection to local_lock
In-Reply-To: <871rbv5iel.ffs@nanos.tec.linutronix.de>
References: <20210329120648.19040-1-mgorman@techsingularity.net> <20210329120648.19040-3-mgorman@techsingularity.net> <877dln640j.ffs@nanos.tec.linutronix.de> <20210331110137.GA3697@techsingularity.net> <871rbv5iel.ffs@nanos.tec.linutronix.de>
Date:   Wed, 31 Mar 2021 19:46:34 +0200
Message-ID: <87y2e343np.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 31 2021 at 19:42, Thomas Gleixner wrote:
> On Wed, Mar 31 2021 at 12:01, Mel Gorman wrote:
>> On Wed, Mar 31, 2021 at 11:55:56AM +0200, Thomas Gleixner wrote:
>> @@ -887,13 +887,11 @@ void cpu_vm_stats_fold(int cpu)
>>  
>>  		pzstats = per_cpu_ptr(zone->per_cpu_zonestats, cpu);
>>  
>> -		preempt_disable();
>>  		for (i = 0; i < NR_VM_ZONE_STAT_ITEMS; i++)
>>  			if (pzstats->vm_stat_diff[i]) {
>>  				int v;
>>  
>> -				v = pzstats->vm_stat_diff[i];
>> -				pzstats->vm_stat_diff[i] = 0;
>> +				v = this_cpu_xchg(pzstats->vm_stat_diff[i], 0);
>
> Confused. pzstats is not a percpu pointer. zone->per_cpu_zonestats is.
>
> But @cpu is not necessarily the current CPU.

@cpu _is_ definitely NOT the current CPU as this is invoked from the
hotplug callback _after_ @cpu went dead. @cpu is dead and wont update
these things concurrently. So I'm even more confused :)

Thanks,

        tglx


