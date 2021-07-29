Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D79C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A7A260524
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 09:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235480AbhG2JvP (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 29 Jul 2021 05:51:15 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:58638 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235382AbhG2JvO (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 29 Jul 2021 05:51:14 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 01D06223F8;
        Thu, 29 Jul 2021 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627552271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gefFb5cyHhMaoQsGNrPUy3tjbh0HwOPsM3pF6okurmc=;
        b=ahcKikCV19gicEIOaapvvk2ILb6kJgaybpf4JoAQqHielEgOq/eQhuYQ/sOljz2WJd85L0
        jsnlNJRIvEpB/Ld5PphY7n6KEx5MiQRWxbau9S6PJGmrb6r4udScjo4tENg1ohB4L08MZh
        p8tTlmdC54NzTeTkL5MM1W8vuti/soo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627552271;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gefFb5cyHhMaoQsGNrPUy3tjbh0HwOPsM3pF6okurmc=;
        b=M5Nzm+8E1WAJ2586pAX9L9oweNcLyfa8DHlxIF06rlgRsCSMGnryVdTY5m3f7AHm1JtIg0
        Ga+0wuyp0G6jnTAg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id D790312FF9;
        Thu, 29 Jul 2021 09:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id 4ol+Mw56AmGcQgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Thu, 29 Jul 2021 09:51:10 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <7431ceb9761c566cf2d1f6f263247acd8d38c4b5.camel@gmx.de>
 <f9935c4c-078c-4b52-5297-64ee22272664@suse.cz>
 <f16b78bd3bb8fecf734017d40274e4c3294554ab.camel@gmx.de>
 <240f104fc6757d8c38fa01342511eda931632d5a.camel@gmx.de>
 <69da2ecd-a797-e264-fbfa-13108dc7a573@suse.cz>
 <84a7bd02cf109c6a5a8c7cc2bfc2898cb98270aa.camel@gmx.de>
 <5be1a703-9a0a-4115-1d69-634e5e8ecefd@suse.cz>
 <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
 <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
 <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
 <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
 <73f032c2-70f1-77b6-9fd2-9aca52fd5b4d@suse.cz>
 <b41fa4f2-8368-f33a-10c2-68554b16eb1e@suse.cz>
 <e3470ab357b48bccfbd1f5133b982178a7d2befb.camel@gmx.de>
 <26c181c9-ec48-09e2-2d73-6fc769a19c76@suse.cz>
 <7970e9c3de5d29b93f692001a3796da1b3df45b4.camel@gmx.de>
 <74c71cac-f36a-9c42-2ab1-837c6a068306@suse.cz>
 <93f6d2ca59a2470ea35f3c5561a82c139191ddca.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <ea7694ef-f3b5-a075-8c65-f211515e2716@suse.cz>
Date:   Thu, 29 Jul 2021 11:51:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <93f6d2ca59a2470ea35f3c5561a82c139191ddca.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/29/21 6:51 AM, Mike Galbraith wrote:
> On Wed, 2021-07-28 at 18:59 +0200, Vlastimil Babka wrote:
>> On 7/27/21 6:09 AM, Mike Galbraith wrote:
>> > On Mon, 2021-07-26 at 23:26 +0200, Vlastimil Babka wrote:
>> > > On 7/26/21 7:00 PM, Mike Galbraith wrote:
>> > > >
>> > > > Why not do something like the below?...
>> > >
>> > > Yep, sounds like a good approach, thanks. Percpu partial is not *the*
>> > > SLUB fast path, so it should be sufficient without the lockless cmpxchg
>> > > tricks. Will incorporate in updated series.
>>
>> The updated series incorporating hopefully all fixes from Mike and
>> bigeasy, and rebased to 5.14-rc3 (Thomas told me RT is moving to it), is
>> here:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/vbabka/linux.git/log/?h=slub-local-lock-v3r0
> 
> I had to resurrect the hunk below to build with lockdep, but modulo
> dinky speedbump, the same RT testdrive that previously exploded was as
> entertainment free as such testing is supposed to be.

Ah forgot about that, I'll include it too. Thanks for testing!

> ---
>  mm/slub.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2890,7 +2890,11 @@ static void *___slab_alloc(struct kmem_c
> 
>  load_freelist:
> 
> +#ifdef CONFIG_PREEMPT_RT
> +	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock.lock));
> +#else
>  	lockdep_assert_held(this_cpu_ptr(&s->cpu_slab->lock));
> +#endif
> 
>  	/*
>  	 * freelist is pointing to the list of objects to be used.
> 
> 

