Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E53C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 16:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D94760F37
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 16:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhGYPrY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Jul 2021 11:47:24 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:45620 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhGYPrY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Jul 2021 11:47:24 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2107A21F09;
        Sun, 25 Jul 2021 16:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627230473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdVEO3E3GIUf8IVTTxVpGFWvViaWrosGZEQQV0SOYHE=;
        b=2oDlP2LjD0+A4KweLjtLeJQiBCntpkEK/HkzIvcENbR7dNktCH6x7NpZRJrKXwVx0lT9fT
        4Tm9b+tKWPYPgGCw9ztVVGDPKxAESeTte/M6aEXq3y4xKde8OCwuyUjW4PFPW0rNtNprIQ
        +jMAyRLRNlpSJvfGfb/yiGSHlHLM8+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627230473;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdVEO3E3GIUf8IVTTxVpGFWvViaWrosGZEQQV0SOYHE=;
        b=u/DbxoGu9W6NQT0fxlOdp0nbiQUXILcSaTiQBNODZGcsQz6Ehpc8lBY/AfeGZk531elHku
        hVOlx9NrB6GCcMBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id E13EF13277;
        Sun, 25 Jul 2021 16:27:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id aWF3NQiR/WDUJAAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 25 Jul 2021 16:27:52 +0000
Subject: Re: [rfc/patch] mm/slub: restore/expand unfreeze_partials() local
 exclusion scope
To:     Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <87tul5p2fa.ffs@nanos.tec.linutronix.de>
 <8c0e0c486056b5185b58998f2cce62619ed3f05c.camel@gmx.de>
 <878s2fnv79.ffs@nanos.tec.linutronix.de>
 <6c0e20dd84084036d5068e445746c3ed7e82ec4b.camel@gmx.de>
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <18ca0ce9-3407-61e1-31d6-5c48e80eb5bb@suse.cz>
Date:   Sun, 25 Jul 2021 18:27:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <72a045663bf8f091ae11dd328d5e085541d54fcd.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/25/21 5:02 PM, Mike Galbraith wrote:
> On Sun, 2021-07-25 at 16:16 +0200, Vlastimil Babka wrote:
>> On 7/25/21 4:09 PM, Mike Galbraith wrote:
>>> On Sat, 2021-07-24 at 00:39 +0200, Vlastimil Babka wrote:
>>>>
>>>> If not, then I would expect this to work (I don't think they ever nest
>>>> in the opposite order, also lockdep should tell us instead of
>>>> -ENOBOOT?), but might be missing something...
>>>
>>> Yeah, like #ifndef CONFIG_PREMPT_RT at the bottom of the loop that our
>>> useless damn eyeballs auto-correct instead of reporting :)
>>
>> Well doh, good catch.
> 
> I never did see it.  I got sick of saying "but but but", and did make
> mm/slub.i, which made it glow.

Glad you did.

>> Hope fixing that helps then?
> 
> Yeah, though RT should perhaps be pinned across release/re-acquire?

Probably not necessary, this_cpu_cmpxchg() will effectively recognize
being moved to a different CPU.
Might also move __unfreeze_partials() out of the whole loop to avoid the
relock. Yeah that should be better.

> Actually, local locks should rediscover the recursion handling skills
> they long had so such RT specific hole poking isn't necessary.  There
> previously would have been no ifdef+typo there for eyeballs to miss and
> miss and miss.

Hm, now I'm realizing that local_lock() on !RT is just
preempt_disable(), i.e. equivalent to get_cpu_ptr(), so some of the
ifdeffery could go away?

> 	-Mike
> 

