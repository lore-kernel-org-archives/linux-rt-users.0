Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E16C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 09:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF856136A
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 09:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhIVJWP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 05:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbhIVJWO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 05:22:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17387C061574;
        Wed, 22 Sep 2021 02:20:45 -0700 (PDT)
Date:   Wed, 22 Sep 2021 11:20:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632302441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsfkG6tEJiJIjiDfatw6ng1M6I65JveUXPR34wT3l4M=;
        b=NDXzQ2ZhFMBccLKKuhCfQOzukC7Ajim86c8QbZXvMacspu8qDA5QtwyMSp0VpFTf7A0WMT
        egPSpi0dZ1Prg40S+155v4tGjv3TkM04KPcWAf/cXTojUwjJrjb/Q4F+WkY4dJbUI3oOLZ
        844MM1TqlK50MEFR4cGJemFyiqcqv/qoBfzA64Hwwc/nubNkBpjkWtSBg17IEtMhCQwGyW
        cs71Pg65xNo0EMFa0Ms7twyBXa4WL3Q9pwcRIxKv3S1OouvM0IeA8W2mieVLcsVCKfiGVj
        FPtJAuqqQtlXFoc+0c//j0uXheOdK8sfmxSoRa8kPRaUsl0HMuR2OlXuAkK9Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632302441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rsfkG6tEJiJIjiDfatw6ng1M6I65JveUXPR34wT3l4M=;
        b=Jgp5Vbz3h0fVYm+RYtZsaoKjGizPzC76TKJlODeEyRworbpuFf06xDcYt7vj3v9Nt1oNM5
        nkdU7VZFcW6yK7BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     nsaenzju@redhat.com
Cc:     Peter Zijlstra <peterz@infradead.org>, akpm@linux-foundation.org,
        frederic@kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, cl@linux.com,
        juri.lelli@redhat.com, mingo@redhat.com, mtosatti@redhat.com,
        nilal@redhat.com, mgorman@suse.de, ppandit@redhat.com,
        williams@redhat.com, anna-maria@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH 2/6] mm/swap: Introduce alternative per-cpu LRU cache
 locking
Message-ID: <20210922092039.2j6efnkhmfxuzjnx@linutronix.de>
References: <20210921161323.607817-1-nsaenzju@redhat.com>
 <20210921161323.607817-3-nsaenzju@redhat.com>
 <20210921220358.GN4323@worktop.programming.kicks-ass.net>
 <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ec733daf2daaf8a6f5b1fbf56676b9892d5bf73.camel@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-09-22 10:47:07 [+0200], nsaenzju@redhat.com wrote:
> > *why* use migrate_disable(), that's horrible!
> 
> I was trying to be mindful of RT. They don't appreciate people taking spinlocks
> just after having disabled preemption.
> 
> I think getting local_lock(&locks->local) is my only option then. But it adds
> an extra redundant spinlock in the RT+NOHZ_FULL case.

spin_lock() does not disable preemption on PREEMPT_RT. You don't
disables preemption on purpose or did I miss that?

Sebastian
