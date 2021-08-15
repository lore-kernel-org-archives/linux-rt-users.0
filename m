Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCC7C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 09:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E73161057
	for <linux-rt-users@archiver.kernel.org>; Sun, 15 Aug 2021 09:36:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbhHOJhE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Aug 2021 05:37:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:47464 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232507AbhHOJhC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Aug 2021 05:37:02 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CB3D021F81;
        Sun, 15 Aug 2021 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629020191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ibukn/K3owQg3BwObGXrD7WX0HnC+FfEGrDOQYj+I0=;
        b=cMXji56ir5Ie0k7YUF8Gpx6wbA8F/kZvhcfaMVEBde6ZrvzV92MBFqeSz4lmCfOSnp3lyH
        hPqXfyKy6NQJsYXoODAXvZkMckVKveHpMa3kQTsTwatvJsUqFu3SqIPzIYPWFPhXn5sM3q
        kY2e6rPfY+PVOdCGpSZanV7+DyDd79o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629020191;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Ibukn/K3owQg3BwObGXrD7WX0HnC+FfEGrDOQYj+I0=;
        b=K4N5TtdSnQy3SkG3a2nvFLW/JXrrJq3uHQZAb7bVeAclOj+iHLmJJvh8X7x/rHLOShBrz5
        NiwGS6Pl67XwVKCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ECB513A1C;
        Sun, 15 Aug 2021 09:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +/7aFx/gGGEDRQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Sun, 15 Aug 2021 09:36:31 +0000
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
To:     Mike Galbraith <efault@gmx.de>,
        Clark Williams <williams@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
 <20210812151803.52f84aaf@theseus.lan>
 <5f0c793d-5084-4607-8475-209fa7310ba2@suse.cz>
 <20210812162448.26274298@theseus.lan>
 <bb98b54c-6d88-2a56-4998-51a304c19e8c@suse.cz>
 <20210812164440.0426d8b7@theseus.lan>
 <96ceab8e-4bf9-147a-e931-848676003c3f@suse.cz>
 <5dbf6cf9e82ef15ce0febf070608da2d5b128763.camel@gmx.de>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c92fc2cb-03cd-d6a2-fb4a-7bc33e94e391@suse.cz>
Date:   Sun, 15 Aug 2021 11:35:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <5dbf6cf9e82ef15ce0febf070608da2d5b128763.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 8/15/21 6:17 AM, Mike Galbraith wrote:
> On Sat, 2021-08-14 at 21:08 +0200, Vlastimil Babka wrote:
>>
>> Aha! That's helpful. Hopefully it's just a small issue where we
>> opportunistically test flags on a page that's protected by the local
>> lock we didn't take yet, and I didn't realize there's the VM_BUG_ON
>> which can trigger if our page went away (which we would have realized
>> after taking the lock).
> 
> Speaking of optimistic peeking perhaps going badly, why is the below
> not true?  There's protection against ->partial going disappearing
> during a preemption... but can't it just as easily appear, so where is
> that protection?

If it appears, it appears, we don't care, we just leave it there and
won't use it.

> If the other side of that window is safe, it could use a comment so
> dummies reading this code don't end up asking mm folks why the heck
> they don't just take the darn lock and be done with it instead of tap
> dancing all around thething :)

Well, with your patch, ->partial might appear just after the unlock, so
does that really change anything?
The point is to avoid the taking the lock if it's almost certain there
will be nothing to gain.

c->partial appearing is easy to just ignore. c->page appearing, while we
got our own page, is worse as there can be only one c->page. But it's
unavoidable, we can't just keep holding the local lock while going to
the page allocator etc. That's why under retry_load_page: we have to
deactivate a c->page that appeared under us...

> ---
>  mm/slub.c |   14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2937,17 +2937,16 @@ static void *___slab_alloc(struct kmem_c
> 
>  new_slab:
> 
> +	/*
> +	 * To avoid false negative race with put_cpu_partial() during a
> +	 * preemption, we must call slub_percpu_partial() under lock.
> +	 */
> +	local_lock_irqsave(&s->cpu_slab->lock, flags);
>  	if (slub_percpu_partial(c)) {
> -		local_lock_irqsave(&s->cpu_slab->lock, flags);
>  		if (unlikely(c->page)) {
>  			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
>  			goto reread_page;
>  		}
> -		if (unlikely(!slub_percpu_partial(c))) {
> -			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> -			/* we were preempted and partial list got empty */
> -			goto new_objects;
> -		}
> 
>  		page = c->page = slub_percpu_partial(c);
>  		slub_set_percpu_partial(c, page);
> @@ -2955,8 +2954,7 @@ static void *___slab_alloc(struct kmem_c
>  		stat(s, CPU_PARTIAL_ALLOC);
>  		goto redo;
>  	}
> -
> -new_objects:
> +	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
> 
>  	freelist = get_partial(s, gfpflags, node, &page);
>  	if (freelist)
> 
> 

