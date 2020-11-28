Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2755C83013
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Nov 2020 22:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B113208D5
	for <linux-rt-users@archiver.kernel.org>; Sat, 28 Nov 2020 22:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=natalenko.name header.i=@natalenko.name header.b="sqowTDwT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732070AbgK1VuS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbgK1TFV (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 28 Nov 2020 14:05:21 -0500
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8910AC02A1A3;
        Sat, 28 Nov 2020 06:09:26 -0800 (PST)
Received: from localhost (home.natalenko.name [151.237.229.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 53C758B184D;
        Sat, 28 Nov 2020 15:09:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1606572564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=80LrCKLmbaN4QFAd+vAXkfzcVSLmNqUxi0hyFB1oaKE=;
        b=sqowTDwTj1W5XbWiqI0623pVVQO38XYLOBRIRNl+gdmzR8jFUrNYeWQWVm54Q+/eAwhGnl
        5a0Yx0jJ4a5lPrhepGYlGvSmITmWYokq661Wy5yPYSHTmuHS1Pbxqdgy3pS/x9C0eGZFMm
        pe8RxWxCp5ZqWNgwXgE5NFEcuQ+H7fY=
Date:   Sat, 28 Nov 2020 15:09:24 +0100
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: scheduling while atomic in z3fold
Message-ID: <20201128140924.iyqr2h52z2olt6zb@spock.localdomain>
References: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201128140523.ovmqon5fjetvpby4@spock.localdomain>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sat, Nov 28, 2020 at 03:05:24PM +0100, Oleksandr Natalenko wrote:
> Hi.
> 
> While running v5.10-rc5-rt11 I bumped into the following:
> 
> ```
> BUG: scheduling while atomic: git/18695/0x00000002
> Preemption disabled at:
> [<ffffffffbb93fcb3>] z3fold_zpool_malloc+0x463/0x6e0
> …
> Call Trace:
>  dump_stack+0x6d/0x88
>  __schedule_bug.cold+0x88/0x96
>  __schedule+0x69e/0x8c0
>  preempt_schedule_lock+0x51/0x150
>  rt_spin_lock_slowlock_locked+0x117/0x2c0
>  rt_spin_lock_slowlock+0x58/0x80
>  rt_spin_lock+0x2a/0x40
>  z3fold_zpool_malloc+0x4c1/0x6e0
>  zswap_frontswap_store+0x39c/0x980
>  __frontswap_store+0x6e/0xf0
>  swap_writepage+0x39/0x70
>  shmem_writepage+0x31b/0x490
>  pageout+0xf4/0x350
>  shrink_page_list+0xa28/0xcc0
>  shrink_inactive_list+0x300/0x690
>  shrink_lruvec+0x59a/0x770
>  shrink_node+0x2d6/0x8d0
>  do_try_to_free_pages+0xda/0x530
>  try_to_free_pages+0xff/0x260
>  __alloc_pages_slowpath.constprop.0+0x3d5/0x1230
>  __alloc_pages_nodemask+0x2f6/0x350
>  allocate_slab+0x3da/0x660
>  ___slab_alloc+0x4ff/0x760
>  __slab_alloc.constprop.0+0x7a/0x100
>  kmem_cache_alloc+0x27b/0x2c0
>  __d_alloc+0x22/0x230
>  d_alloc_parallel+0x67/0x5e0
>  __lookup_slow+0x5c/0x150
>  path_lookupat+0x2ea/0x4d0
>  filename_lookup+0xbf/0x210
>  vfs_statx.constprop.0+0x4d/0x110
>  __do_sys_newlstat+0x3d/0x80
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> ```
> 
> The preemption seems to be disabled here:
> 
> ```
> $ scripts/faddr2line mm/z3fold.o z3fold_zpool_malloc+0x463
> z3fold_zpool_malloc+0x463/0x6e0:
> add_to_unbuddied at mm/z3fold.c:645
> (inlined by) z3fold_alloc at mm/z3fold.c:1195
> (inlined by) z3fold_zpool_malloc at mm/z3fold.c:1737
> ```
> 
> The call to the rt_spin_lock() seems to be here:
> 
> ```
> $ scripts/faddr2line mm/z3fold.o z3fold_zpool_malloc+0x4c1
> z3fold_zpool_malloc+0x4c1/0x6e0:
> add_to_unbuddied at mm/z3fold.c:649
> (inlined by) z3fold_alloc at mm/z3fold.c:1195
> (inlined by) z3fold_zpool_malloc at mm/z3fold.c:1737
> ```
> 
> Or, in source code:
> 
> ```
>  639 /* Add to the appropriate unbuddied list */
>  640 static inline void add_to_unbuddied(struct z3fold_pool *pool,
>  641                 struct z3fold_header *zhdr)
>  642 {
>  643     if (zhdr->first_chunks == 0 || zhdr->last_chunks == 0 ||
>  644             zhdr->middle_chunks == 0) {
>  645         struct list_head *unbuddied = get_cpu_ptr(pool->unbuddied);
>  646
>  647         int freechunks = num_free_chunks(zhdr);
>  648         spin_lock(&pool->lock);
>  649         list_add(&zhdr->buddy, &unbuddied[freechunks]);
>  650         spin_unlock(&pool->lock);
>  651         zhdr->cpu = smp_processor_id();
>  652         put_cpu_ptr(pool->unbuddied);
>  653     }
>  654 }
> ```
> 
> Shouldn't the list manipulation be protected with
> local_lock+this_cpu_ptr instead of get_cpu_ptr+spin_lock?
> 
> Thanks.
> 
> -- 
>   Oleksandr Natalenko (post-factum)

Forgot to Cc linux-rt-users@, sorry.

-- 
  Oleksandr Natalenko (post-factum)
