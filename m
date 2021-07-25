Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37930C4338F
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1635560EB4
	for <linux-rt-users@archiver.kernel.org>; Sun, 25 Jul 2021 14:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbhGYNgr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Jul 2021 09:36:47 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37410 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231210AbhGYNgq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Jul 2021 09:36:46 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 825E421DD5;
        Sun, 25 Jul 2021 14:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1627222635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8ld6eWOXWKab5mW3GS50lPqoO9veaqwntkiFTmeRvI=;
        b=PkFWRCgX5fFQpPytMRH8aSjiRGDCAQQ9DZwtgeg9/3knLpQsknGrQm693Ujt61SP+4MCzt
        bDPBuHEAMnMMdPrC7C9FyP+F1J3aWQUA2qCI0SpmRcz0YsF9CeG1wvoh+2ksrbBkXn0Xbj
        SH1J4oVwQB9LO5k2aq/2vyic2pbPnoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1627222635;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8ld6eWOXWKab5mW3GS50lPqoO9veaqwntkiFTmeRvI=;
        b=Myb4ls9NRtS2ogZ4/T7qnDB5Qz2c62ZVdCE8T9cunPvyhljOje1eKrHnM7FkY2IzAi7jXb
        5rjTNIuvlIPL11Cw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 5C37A13277;
        Sun, 25 Jul 2021 14:17:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id IL0aFWty/WD9FgAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Sun, 25 Jul 2021 14:17:15 +0000
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
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <76dedfc3-0497-1776-d006-486b9bfd88da@suse.cz>
Date:   Sun, 25 Jul 2021 16:16:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <bd121f5db01404774dbecc70bd7155f8431d8046.camel@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 7/25/21 4:09 PM, Mike Galbraith wrote:
> On Sat, 2021-07-24 at 00:39 +0200, Vlastimil Babka wrote:
>>
>> If not, then I would expect this to work (I don't think they ever nest
>> in the opposite order, also lockdep should tell us instead of
>> -ENOBOOT?), but might be missing something...
> 
> Yeah, like #ifndef CONFIG_PREMPT_RT at the bottom of the loop that our
> useless damn eyeballs auto-correct instead of reporting :)

Well doh, good catch. Hope fixing that helps then?
I've so far convinced myself that the full patch will be needed - in my
theory the ->partial cmpxchg in put_cpu_partial() itself can race with
assignment in ___slab_alloc() in a way that will not cause crashes, but
will leak slab pages.

> 	-Mike
> 

