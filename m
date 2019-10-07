Return-Path: <SRS0=Z5tp=YA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D38ECE596
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA3420835
	for <linux-rt-users@archiver.kernel.org>; Mon,  7 Oct 2019 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmCJHtNQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729345AbfJGVoc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:44:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42938 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfJGVoc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Oct 2019 17:44:32 -0400
Received: by mail-lf1-f66.google.com with SMTP id c195so10358284lfg.9;
        Mon, 07 Oct 2019 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q+EvvC8b0zqiykxshjm1BmldMhp8/DtfGeGC5gSB2EY=;
        b=LmCJHtNQEhdw1G9PWFX5SOjwOSJDNkIQ5VwqrayOnBlTyDci9lj1krdHZrkQRQ6LDx
         QBgPeMh7utDKXxGHMpwbKk8NOsJ+9lzf59eOWOg1EnZfWTSI7DiVF+sTvxRfnHePJkvj
         54dwwXLJEDOwZhNkRvxDSOMCV20jYGfYQtJ4QzzMNRGlvxODa1Ge27SJSdJdve9COG9A
         bMriAlSQguyO43fPdCwKBmmaQbzSHy+Hcoz8bSSCmG1cxB7jvkYMOkwytS0UOl6ncBT6
         A66n2/cY7C/L1eDmLjJ4FCwqN8ALgWcCRbWw1Bg+3U8Kx2ex+uWM1rEj+0yz2i73o6bk
         HqeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q+EvvC8b0zqiykxshjm1BmldMhp8/DtfGeGC5gSB2EY=;
        b=TECdmJiZgvPie8shsvg4QP9UXUrbm1otD/GQlvNkK1C1c3wLaMVKMRA9eikOqbWlCs
         2r+f9zviAKIQrL5tRHBXJAO/o+Zo4Gqg1MrxKS8cxiBjsEJLwQL7q5kyaXjg2bUrrtSx
         2YMz3u/o4iMh6a3Z+eAOiqEiJJPMjQeLX1SWNrcWrGsz480HzD/vaE7LtcYXIJ3Vhfdc
         zvlodi3D7/JwFMgqnSuGUsU12CTADif8eZaAtP78kId+zjQROUDDEGZMMyp7ExTjKpbW
         oH0hpFF40qBuXNZKmswgY9GWN7kDNCXBay4YAGzC8pFAfMmu2pZJtW4x6vsb+Efn7RYF
         3eXA==
X-Gm-Message-State: APjAAAXChHaJec5C9iNWrF4uwSdtCUKDPNsHDs9KCvmMSBxX7/MXKeNT
        +rvlzUHr0OiGZcoIB/KEb3QS2y6VEGE=
X-Google-Smtp-Source: APXvYqw/Mh6WzjTN7T5NzOtncMbI+KpytKWLrBJjdkCNEekX43NoCbgOWJENbu6ty2QuTYRUOmKB6w==
X-Received: by 2002:a19:c14a:: with SMTP id r71mr17745983lff.55.1570484669769;
        Mon, 07 Oct 2019 14:44:29 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id k15sm3404755ljg.65.2019.10.07.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 14:44:28 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Mon, 7 Oct 2019 23:44:20 +0200
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Daniel Wagner <dwagner@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: vmalloc: Use the vmap_area_lock to protect
 ne_fit_preload_node
Message-ID: <20191007214420.GA3212@pc636>
References: <20191003090906.1261-1-dwagner@suse.de>
 <20191004153728.c5xppuqwqcwecbe6@linutronix.de>
 <20191004162041.GA30806@pc636>
 <20191004163042.jpiau6dlxqylbpfh@linutronix.de>
 <20191007083037.zu3n5gindvo7damg@beryllium.lan>
 <20191007105631.iau6zhxqjeuzajnt@linutronix.de>
 <20191007162330.GA26503@pc636>
 <20191007163443.6owts5jp2frum7cy@beryllium.lan>
 <20191007165611.GA26964@pc636>
 <20191007173644.hiiukrl2xryziro3@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007173644.hiiukrl2xryziro3@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Oct 07, 2019 at 07:36:44PM +0200, Sebastian Andrzej Siewior wrote:
> On 2019-10-07 18:56:11 [+0200], Uladzislau Rezki wrote:
> > Actually there is a high lock contention on vmap_area_lock, because it
> > is still global. You can have a look at last slide:
> > 
> > https://linuxplumbersconf.org/event/4/contributions/547/attachments/287/479/Reworking_of_KVA_allocator_in_Linux_kernel.pdf
> > 
> > so this change will make it a bit higher. From the other hand i agree
> > that for rt it should be fixed, probably it could be done like:
> > 
> > ifdef PREEMPT_RT
> >     migrate_disable()
> > #else
> >     preempt_disable()
> > ...
> > 
> > but i am not sure it is good either.
> 
> What is to be expected on average? Is the lock acquired and then
> released again because the slot is empty and memory needs to be
> allocated or can it be assumed that this hardly happens? 
> 
The lock is not released(we are not allowed), instead we just try
to allocate with GFP_NOWAIT flag. It can happen if preallocation
has been failed with GFP_KERNEL flag earlier:

<snip>
...
 } else if (type == NE_FIT_TYPE) {
  /*
   * Split no edge of fit VA.
   *
   *     |       |
   *   L V  NVA  V R
   * |---|-------|---|
   */
  lva = __this_cpu_xchg(ne_fit_preload_node, NULL);
  if (unlikely(!lva)) {
      ...
      lva = kmem_cache_alloc(vmap_area_cachep, GFP_NOWAIT);
      ...
  }
...
<snip>

How often we need an extra object for split purpose, the answer
is it depends on. For example fork() path falls to that pattern.

I think we can assume that migration can hardly ever happen and
that should be considered as rare case. Thus we can do a prealoading
without worrying much if a it occurs:

<snip>
urezki@pc636:~/data/ssd/coding/linux-stable$ git diff
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index e92ff5f7dd8b..bc782edcd1fd 100644 
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1089,20 +1089,16 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
         * Even if it fails we do not really care about that. Just proceed
         * as it is. "overflow" path will refill the cache we allocate from.
         */
-       preempt_disable();
-       if (!__this_cpu_read(ne_fit_preload_node)) {
-               preempt_enable();
+       if (!this_cpu_read(ne_fit_preload_node)) {
                pva = kmem_cache_alloc_node(vmap_area_cachep, GFP_KERNEL, node);
-               preempt_disable();

-               if (__this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
+               if (this_cpu_cmpxchg(ne_fit_preload_node, NULL, pva)) {
                        if (pva)
                                kmem_cache_free(vmap_area_cachep, pva);
                }
        }
 
        spin_lock(&vmap_area_lock);
-       preempt_enable();

        /*
         * If an allocation fails, the "vend" address is
urezki@pc636:~/data/ssd/coding/linux-stable$
<snip>

so, we do not guarantee, instead we minimize number of allocations
with GFP_NOWAIT flag. For example on my 4xCPUs i am not able to
even trigger the case when CPU is not preloaded.

I can test it tomorrow on my 12xCPUs to see its behavior there.

--
Vlad Rezki
