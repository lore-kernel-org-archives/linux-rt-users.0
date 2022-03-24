Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0E5C433F5
	for <linux-rt-users@archiver.kernel.org>; Thu, 24 Mar 2022 19:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352782AbiCXTBg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241015AbiCXTBe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 Mar 2022 15:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B29F35A16E
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2022 12:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648148400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BEZsPU6ScEAA3keGh0hVCGrvQvsoW7+VZCfIyHrin5I=;
        b=PKEQsHYshmAHfjI9P8V2Mvq11nlxvLOhz+3isa4dKtuxkdj6mSaxOj5u4kvH5lg6dlqGcJ
        6CsG2ahTB6YJ9wPFpk8rucL/NjFswAXxUUSIdkzaDXOb+mldJyVm4TS+S0Db+1lZnjOw4n
        xPH1QcBdY7UI95T42sZkdttk+4JUzCs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396--cFJpyPrO-2FvqA1yraVkQ-1; Thu, 24 Mar 2022 14:59:59 -0400
X-MC-Unique: -cFJpyPrO-2FvqA1yraVkQ-1
Received: by mail-wm1-f72.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso1904201wmq.3
        for <linux-rt-users@vger.kernel.org>; Thu, 24 Mar 2022 11:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=BEZsPU6ScEAA3keGh0hVCGrvQvsoW7+VZCfIyHrin5I=;
        b=ICLG521S/dRlE1nNHIurFUBbEt2thNLJBtUbhpwT+IdlNcJ+A8AtwHaMdIdMUIVk08
         +2Xroob0WG2J2kc1GKCWjvNTNcJpsus/rvDhjOhBnIYu0gDMWNBWislDXSd/wcw6D7u2
         0PoSOHzJIosBs3X6PvJa7vKNwQE58PaJ/Imz3qzqKU30bEcSGMiI1s10gXqDU5cF2lys
         uKgf9lJcps4hwaObh6ZgkFN0PESW23qanap7A1eLITaPQo0F8/AQjzqYaWlvETo1imFc
         uehTvIWwUwbwomBBb8i96srpZmPb6KfHyRo0xKiHR4PXJ4Aecg93soN2xFCmjaQ5vHtC
         P2kg==
X-Gm-Message-State: AOAM532c331jHzKQaguMS7iT27/p1nbTnQoao6r5NjS4aTe7SqytKz18
        h8mRR3Q/dJuPQVrw00cpm2yhCpHvUVL5etK9aQ6tFVxDGh0pSWVSgFFOBj/Y1xmEqSxOPqL/Ma3
        LjW8fl61SWFEV3K5NBllqkJQD1kI=
X-Received: by 2002:a5d:6101:0:b0:204:871e:9912 with SMTP id v1-20020a5d6101000000b00204871e9912mr5764234wrt.60.1648148398296;
        Thu, 24 Mar 2022 11:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9rLBD0bceg0ZUAVQjV9g6B7JHVhv+FAZqMk/+BCNICmA66CnX4VjHlcEvcDu1+G+z22/Sng==
X-Received: by 2002:a5d:6101:0:b0:204:871e:9912 with SMTP id v1-20020a5d6101000000b00204871e9912mr5764218wrt.60.1648148398054;
        Thu, 24 Mar 2022 11:59:58 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:3506:3400:69b5:c807:1d52:ff67? ([2a0c:5a80:3506:3400:69b5:c807:1d52:ff67])
        by smtp.gmail.com with ESMTPSA id 2-20020a056000154200b00203ee1fd1desm3442514wry.64.2022.03.24.11.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 11:59:57 -0700 (PDT)
Message-ID: <3c24840e8378c69224974f321ec5c06a36a33dd3.camel@redhat.com>
Subject: Re: [PATCH 0/2] mm/page_alloc: Remote per-cpu lists drain support
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, frederic@kernel.org, tglx@linutronix.de,
        mtosatti@redhat.com, linux-rt-users@vger.kernel.org,
        vbabka@suse.cz, cl@linux.com, paulmck@kernel.org,
        willy@infradead.org
Date:   Thu, 24 Mar 2022 19:59:56 +0100
In-Reply-To: <20220303114550.GE4363@suse.de>
References: <20220208100750.1189808-1-nsaenzju@redhat.com>
         <20220303114550.GE4363@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Mel,

On Thu, 2022-03-03 at 11:45 +0000, Mel Gorman wrote:
> For unrelated reasons I looked at using llist to avoid locks entirely. It
> turns out it's not possible and needs a lock. We know "local_locks to
> per-cpu spinlocks" took a large penalty so I considered alternatives on
> how a lock could be used.  I found it's possible to both remote drain
> the lists and avoid the disable/enable of IRQs entirely as long as a
> preempting IRQ is willing to take the zone lock instead (should be very
> rare). The IRQ part is a bit hairy though as softirqs are also a problem
> and preempt-rt needs different rules and the llist has to sort PCP
> refills which might be a loss in total. However, the remote draining may
> still be interesting. The full series is at
> https://git.kernel.org/pub/scm/linux/kernel/git/mel/linux.git/ mm-pcpllist-v1r2
> 
> It's still waiting on tests to complete and not all the changelogs are
> complete which is why it's not posted.
> 
> This is a comparison of vanilla vs "local_locks to per-cpu spinlocks"
> versus the git series up to "mm/page_alloc: Remotely drain per-cpu lists"
> for the page faulting microbench I originally complained about.  The test
> machine is a 2-socket CascadeLake machine.
> 
> pft timings
>                                  5.17.0-rc5             5.17.0-rc5             5.17.0-rc5
>                                     vanilla    mm-remotedrain-v2r1       mm-pcpdrain-v1r1
> Amean     elapsed-1        32.54 (   0.00%)       33.08 *  -1.66%*       32.82 *  -0.86%*
> Amean     elapsed-4         8.66 (   0.00%)        9.24 *  -6.72%*        8.69 *  -0.38%*
> Amean     elapsed-7         5.02 (   0.00%)        5.43 *  -8.16%*        5.05 *  -0.55%*
> Amean     elapsed-12        3.07 (   0.00%)        3.38 * -10.00%*        3.09 *  -0.72%*
> Amean     elapsed-21        2.36 (   0.00%)        2.38 *  -0.89%*        2.19 *   7.39%*
> Amean     elapsed-30        1.75 (   0.00%)        1.87 *  -6.50%*        1.62 *   7.59%*
> Amean     elapsed-48        1.71 (   0.00%)        2.00 * -17.32%*        1.71 (  -0.08%)
> Amean     elapsed-79        1.56 (   0.00%)        1.62 *  -3.84%*        1.56 (  -0.02%)
> Amean     elapsed-80        1.57 (   0.00%)        1.65 *  -5.31%*        1.57 (  -0.04%)
> 
> Note the local_lock conversion took 1 1-17% penalty while the git tree
> takes a negligile penalty while still allowing remote drains. It might
> have some potential while being less complex than the RCU approach.

I finally got some time to look at this and made some progress:

First, I belive your 'mm-remotedrain-v2r1' results are wrong/inflated due to a
bug in my series. Essentially, all 'this_cpu_ptr()' calls should've been
'raw_cpu_ptr()' and your build, which I bet enables CONFIG_DEBUG_PREEMPT,
wasted time trowing warnings about per-cpu variable usage with preemption
enabled. Making the overall performance look worse than it actually is. My
build didn't enable it, which made me miss this whole issue. I'm sorry for the
noise and time wasted on such a silly thing. Note that the local_lock to
spin_lock conversion can handle the preeemption alright, it is part of the
design[1].

As for your idea of not disabling interrupts in the hot paths, it seems to
close the performance gap created by the lock conversion. That said, I'm not
sure I understand why you find the need to keep the local_locks around, not
only it casuses problems for RT systems, but IIUC they aren't really protecting
anything other than the 'this_cpu_ptr()' usage (which isn't really needed). I
rewrote your patch on top of my lock conversion series and I'm in the process
of testing it on multiple systems[2].

Let me know what you think.
Thanks!

[1] It follows this pattern:

	struct per_cpu_pages *pcp;

	pcp = raw_cpu_ptr(page_zone(page)->per_cpu_pageset);
	// <- Migration here is OK: spin_lock protects vs eventual pcplist
	// access from local CPU as long as all list access happens through the
	// pcp pointer.
	spin_lock(&pcp->lock);
	do_stuff_with_pcp_lists(pcp);
	spin_unlock(&pcp->lock);

[2] See:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsaenz/linux-rpi.git pcpdrain-sl-v3r1

-- 
Nicolás Sáenz

