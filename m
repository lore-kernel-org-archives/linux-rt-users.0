Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1861C4320A
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 12:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02AD61132
	for <linux-rt-users@archiver.kernel.org>; Thu,  5 Aug 2021 12:56:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241536AbhHEM5J (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 5 Aug 2021 08:57:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbhHEM5J (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 5 Aug 2021 08:57:09 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628168213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVf3PfykKYQU3CTBy9ZESamUrkWVChfXxQyzL80BiXo=;
        b=peYGOaIZKlNcKu82FZ+29EvQTK9tEiX9kAm7iStGMPWHKrfF5CKz0fUUr3DKoGChDSRNhZ
        W2onQknbLQQk9eXa7/bsxV7qyF7xILLb6R0/dqSl2cCCULJFViJD8v3Q/R1oazJYnq5ttu
        Ei9HChS0r0EJBqGLLS4KaqThoDy/M1Noqi7u4D7CKVIaBDtlhRIMTIsKd7P2k6e2CGX6oC
        1cx9E60OjNHEn88P88FtxNrD2vjNChOuX9B/4HZSq3qK6xmwh+KZLif0ShScod+k3krRlu
        n5FISmyIo33SzWJX78HtSQqcqKaqdBHSUz+piX+WjM69mbBp64XvpMjwrHh/hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628168213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RVf3PfykKYQU3CTBy9ZESamUrkWVChfXxQyzL80BiXo=;
        b=lGkYg8f60GgKq3ZFgWC+c4sOHP6+KK3gi0j7kzgpuabkhVPPQbRS3Os2psr65fU4LDaRk3
        Hm9RSNyD5dvCB+BQ==
To:     Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
In-Reply-To: <20210804142306.GE6464@techsingularity.net>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
 <20210723100034.13353-3-mgorman@techsingularity.net> <87czqu2iew.ffs@tglx>
 <20210804095425.GA6464@techsingularity.net>
 <91b2f893-eb6a-d91d-3769-baba8601b0f6@suse.cz>
 <20210804142306.GE6464@techsingularity.net>
Date:   Thu, 05 Aug 2021 14:56:53 +0200
Message-ID: <87h7g4123u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Aug 04 2021 at 15:23, Mel Gorman wrote:
Mel,

> On Wed, Aug 04, 2021 at 03:42:25PM +0200, Vlastimil Babka wrote:
>> The idea was not build-time, but runtime (hidden behind lockdep, VM_DEBUG or
>> whatnot), i.e.:
>> 
>> <sched_expert> what that code needs is switch(item) { case foo1: case foo2:
>> lockdep_assert_irqs_disabled(); break; case bar1: case bar2:
>> lockdep_assert_preempt_disabled(); lockdep_assert_no_in_irq(); break; } or
>> something along those lines
>> 
> Ok, that would potentially work. It may not even need to split the stats
> into different enums. Simply document which stats need protection from
> IRQ or preemption and use PROVE_LOCKING to check if preemption or IRQs
> are disabled depending on the kernel config. I don't think it gets rid
> of preempt_disable_rt unless the API was completely reworked with entry
> points that describe the locking requirements. That would be tricky
> because the requirements differ between kernel configurations.

Right. This won't get rid of the preempt disabling on RT, but I think we
should rather open code this

       if (IS_ENABLED(CONFIG_PREEMPT_RT))
       		preempt_dis/enable();

instead of proliferating these helper macros which have only one user left.

Thanks,

        tglx
