Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F9BC4320A
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19B860F58
	for <linux-rt-users@archiver.kernel.org>; Wed,  4 Aug 2021 13:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238464AbhHDNmk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 4 Aug 2021 09:42:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:45570 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237305AbhHDNmj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 4 Aug 2021 09:42:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 133881FDF0;
        Wed,  4 Aug 2021 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628084546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cd6QFPd1A0Bmx9XXWp5vLXMioX3R+S1I/iAZz0+5Ls4=;
        b=NdOwFa031p1tD5wGcSqoW6lXbr5pHOZfdIZigz9+bZarnzU/vrf3eEFouH2Ba9OW1HbnOY
        r8DG1aqp/N3YT+EbvHuQWY2XJSiC1rxW3IXzezRKHXFaq8aviX/KmS1xZG0dVXkCXMFBeZ
        BI3stuXS2SyOB4gxGKD2DsYAQzpV14o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628084546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cd6QFPd1A0Bmx9XXWp5vLXMioX3R+S1I/iAZz0+5Ls4=;
        b=y05y+n1nHBWU82vDBKoaBOVztk7mSZqow5Jwmq0SvZEKxZ1SaGo8UymlvIFU4odwaBcbWW
        MCL6IfvwIF+BeuDQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E150313942;
        Wed,  4 Aug 2021 13:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id dALvNUGZCmFgQQAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 04 Aug 2021 13:42:25 +0000
To:     Mel Gorman <mgorman@techsingularity.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        Linux-RT-Users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20210723100034.13353-1-mgorman@techsingularity.net>
 <20210723100034.13353-3-mgorman@techsingularity.net> <87czqu2iew.ffs@tglx>
 <20210804095425.GA6464@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 2/2] mm/vmstat: Protect per cpu variables with preempt
 disable on RT
Message-ID: <91b2f893-eb6a-d91d-3769-baba8601b0f6@suse.cz>
Date:   Wed, 4 Aug 2021 15:42:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210804095425.GA6464@techsingularity.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/4/21 11:54 AM, Mel Gorman wrote:
> On Wed, Aug 04, 2021 at 01:54:47AM +0200, Thomas Gleixner wrote:
>> 
>>  <tglx> so in vmstat.c there is this magic comment:
>>  <tglx>  * For use when we know that interrupts are disabled
>>  <tglx>  * or when we know that preemption is disabled and that
>>  <tglx>  * particular counter cannot be updated from interrupt context.
>>  <tglx> how can I know which counters need what?
>>  <mm_expert> I don't think there's a list, one would have to check on counter to counter basis :/ 
>>  <tglx> and of course there is nothing which validates that, right?
>>  <mm_expert> exactly
>> 
> 
> While I'm not "mm_expert", I agree with his/her statements.

Phew, since you do, I can now disclose it was me.

> Each counter
> would need to be audited and two question are asked
> 
>  o If this counter is inaccurate, does anything break?
>  o If this counter is inaccurate, does it both increment and decrement
>    allowing the possibility it goes negative?
> 
> The decision on that is looking at the counter and seeing if any
> functional decision is made based on its value. So two examples;
> 
> 	NR_VMSCAN_IMMEDIATE is a node-based counter that only every
> 	increments and is reported to userspace. No kernel code makes
> 	any decision based on its value. Therefore it's likely safe to
> 	move to numa_stat_item instead.
> 
> 	Action: move it
> 
> 	WORKINGSET_ACTIVATE_FILE is a node-based counter that is used to
> 	determine if a mem cgroup is potentially congested by looking at
> 	the ratio of cgroup to node refault rates as well as deciding if
> 	LRU file pages should be deactivate.  If that value drifts, the
> 	ratios are miscalculated and could lead to functional oddities
> 	and therefore must be accurate.
> 
> 	Action: leave it alone
> 
> I guess it could be further split into state that must be accurate from
> IRQ and non-IRQ contexts but that probably would be very fragile and
> offer limited value.
> 
>> Brilliant stuff which prevents you to do any validation on this. Over
>> the years there have been several issues where callers had to be fixed
>> by analysing bug reports instead of having a proper instrumentation in
>> that code which would have told the developer that he got it wrong.
>> 
> 
> I'm not sure it could be validated at build-time but I'm just back from
> holiday and may be lacking imagination.

The idea was not build-time, but runtime (hidden behind lockdep, VM_DEBUG or
whatnot), i.e.:

<sched_expert> what that code needs is switch(item) { case foo1: case foo2:
lockdep_assert_irqs_disabled(); break; case bar1: case bar2:
lockdep_assert_preempt_disabled(); lockdep_assert_no_in_irq(); break; } or
something along those lines

>> Of course on RT kernels the preempt_disable_rt() will serialize
>> everything correctly, but as we have learned over the years just
>> slapping _if_rt() or if_not_rt() variants of things around is most of
>> the time papering over the underlying problem of badly defined
>> protection scopes. Let's not proliferate that. As I said in the above
>> IRC conversation:
>> 
>>  <tglx> I fundamentally hate this preempt_disable_rt() muck
>> 
> 
> The issue is that even if this was properly audited and the inaccurate
> and accurate counters were in the proper enums using the correct APIs, it
> would still be necessary to protect the accurate counters from updates from
> IRQ context. Hence, as I write this, I don't think preempt_[dis|en]able_rt
> would go away and that is why I didn't continue with the series to break
> out "accurate" stats
> 

