Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE1F0C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 05:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbiFXF4m (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 01:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiFXF4l (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 01:56:41 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B419653A56
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 22:56:40 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 68so1451627pgb.10
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kR9Bh5KsE8AoUOfzfRXUJn9Sy+bHJBXRlap3Lj0cwbc=;
        b=H3tUhDuGJaXKFwSfEOEFiNFx8jPd1uzztiVb3iRWrFe1m1wWg3DeIf43Fe2l2kLgG7
         M+iadcveJ9scg5aUgdQ3HP0v9QbknpwSCWYvRKesl72bSmMJUbHX7t0x9CVDAPWVfwmS
         7HFqu2x47HeVg7zKJETlp8UGrNQHpkejFPmxvaeLTtbO55ZVrppmwtgdVExm010vaB6h
         bf8/k3L2dBF7OmwULAPBwPhsAGiWEBtlD/aiIKUaKCs1j5ZzaNDU5OV9dcTdJRTSRIv/
         H7ur5t0a8JIgpmLRy1VfLSavZu3BepK8ZjNLhqRIrL6SAqh6jNfRHBq4VLWYfHTX47GB
         weFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kR9Bh5KsE8AoUOfzfRXUJn9Sy+bHJBXRlap3Lj0cwbc=;
        b=JATArhYO8Q5zwpDSJprPUW5a8FKz6y9M6ENTpklgxvM9WylMIZL8JGYVojAV1GjPTn
         6AbTobMNqUGnqsYfHhCMS181+iMw4yOsd4iyJe75sXaAOYB+UH+DsGIGIeINtQx+xTid
         +lNLXLaegt573zK4HabK+pJ85iS9vGw4OAAf2cldWZCd9nAhbeh1A3rw9clwMlNDd5Ho
         w9AdcvYddFBPlWmLl1yAi/S03eA33obv/JvaMRf4DZgzKKFZX99nKAswxY8+ivMq5h0k
         VJdKoqClJc8yrSU3zXrNRoVXYBgKO2u+ws/vhRclCEpFE1lCmV35WjW1HxJg2J4Q1n/E
         o0Tg==
X-Gm-Message-State: AJIora/AQ2fx+VU2NurqnuKVXhee2Pnz59SIgQKAL6h28cDR5wfDDdWt
        CODgKNQPUIE5rDwZuVn81bI=
X-Google-Smtp-Source: AGRyM1t8pSvn8n7TF/pNsuudTZq4ZY2Alcbl9MZXQ+AHDxattVEzXvsn9nf3TJRHq04M+sioWSNA9Q==
X-Received: by 2002:a63:2ccb:0:b0:3fe:1929:b30b with SMTP id s194-20020a632ccb000000b003fe1929b30bmr10534948pgs.64.1656050200065;
        Thu, 23 Jun 2022 22:56:40 -0700 (PDT)
Received: from ubuntu20 (60-249-39-197.hinet-ip.hinet.net. [60.249.39.197])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090abc4500b001ea629a431bsm796945pjv.8.2022.06.23.22.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 22:56:39 -0700 (PDT)
Date:   Fri, 24 Jun 2022 13:56:33 +0800
From:   Zhipeng Shi <zhipeng.shi0@gmail.com>
To:     Baoquan He <bhe@redhat.com>, Waiman Long <longman@redhat.com>
Cc:     linux-mm@kvack.org, linux-rt-users@vger.kernel.org,
        tglx@linutronix.de, shengjian.xu@horizon.ai, schspa@gmail.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        peterz@infradead.org
Subject: Re: [Question] vmalloc latency in RT-Linux
Message-ID: <20220624055633.GA836199@ubuntu20>
References: <20220621121547.GB37196@ubuntu20>
 <YrRFpmk0pxvXanbH@MiWiFi-R3L-srv>
 <dd4f2422-3151-2c0b-e4c6-fe49f6d2ac30@redhat.com>
 <YrUj70P1sYFXsnqf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrUj70P1sYFXsnqf@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Jun 24, 2022 at 10:39:43AM +0800, Baoquan He wrote:
> On 06/23/22 at 02:04pm, Waiman Long wrote:
> > On 6/23/22 06:51, Baoquan He wrote:
> > > On 06/21/22 at 08:15pm, Zhipeng Shi wrote:
> > > > I noticed in rt-linux, vmalloc has a large latency. This is because the
> > > > free_vmap_area_lock is held for a long time in the function
> > > > __purge_vmap_area_lazy.
> > > > 
> > > > In non-RT-Linux, because the function spin_is_contended is well
> > > > implemented, so there will be no such problem.
> > > > 
> > > > But in RT-Linux, spin_is_contended simply returns 0. I don't understand
> > > > why this function was implemented like this before, but in order to
> > > > solve this problem, I thought of two ways.
> > > > 
> > > > The first is to modify the spin_is_contended definition in spinlock_rt.h
> > > > as shown below, but I'm not sure if the change has side-effects:
> > > > 
> > > > -#define spin_is_contended(lock)    (((void)(lock), 0))
> > > > +static inline int spin_is_contended(spinlock_t *lock)
> > > > +{
> > > > + unsigned long *p = (unsigned long *) &lock->lock.owner;
> > > > +
> > > > + return (READ_ONCE(*p) & RT_MUTEX_HAS_WAITERS);
> > > > +}
> > > > 
> > > > The second is by reducing the number of lazy_max_pages, but it will lead
> > > > to lower performance of vmalloc.
> > > __purge_vmap_area_lazy() has cond_resched_lock() to reschedule and drop
> > > the lock. From your saying, it's spin_is_contended() which is not
> > > working well to make rescheduling happen during __purge_vmap_area_lazy()
> > > handling. Then the fixing should be done in lock side.
> > 
> > Sebastian had sent out patch last year to fix spin_is_contended().
> > 
> > https://lore.kernel.org/lkml/20210906143004.2259141-3-bigeasy@linutronix.de/
> > 
> > However, there is no follow-up after some discussion and the patch wasn't
> > merged.
> 
> That's great. Thanks, Longman.
> 
> Then this is a good chance to reconsider it, maybe with a test from Zhipeng.

Before that, since I didn't find the patch that Sebastian sent before, 
I sent relevant patch for this problem (now it seems that Sebastian's 
changes are better than mine) and test scripts. please refer to the 
following links:

https://lore.kernel.org/lkml/20220608142457.GA2400218@ubuntu20/

With this patch, max-latency of vmalloc reduce from 10+ msec to
200+ usec, this because spin_lock is released halfway through 
__purge_vmap_area_lazy.

Best regards,
Zhipeng
