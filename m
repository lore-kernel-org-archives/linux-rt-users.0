Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE05DC43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 09:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiFXJFc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiFXJFb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 05:05:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B474888D
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 02:05:30 -0700 (PDT)
Date:   Fri, 24 Jun 2022 11:05:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656061527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfsUGiGWHTVWBDtum+AXLC4uLJ41OMe5+nGtjZmhQb4=;
        b=GzGLhCTGnV3tL3P1Y7IRz+QE/20L8N0NUUWkBXl3NCD8RQxwonstkwdfUck6BKupyA7L5D
        yFrF0pEAUm5RuPL6Ub8aPk2wnf9Pt3OE9Ahj2BWO14Uk6F0qkxkOplzyDAdKPamgNdllZM
        QBjbLMrNIQk8EK8Nmnfb5VmqxdBCRaVdq2QejZrAWNOa32lI31IQO4RzHsjmUdrKlXIqOn
        TPOCMVkNWa6n/xpaR1vq1pWPAKP2HSy9MlEgzAt4C8+5mbo1BqmAMt0umus6iqKcc82XqV
        bEbGt/JgSxukw8lWP1Ka42T8F631RFUxZc7ra4WSQ6jmyKDydkDQvxjbpUKtcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656061527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MfsUGiGWHTVWBDtum+AXLC4uLJ41OMe5+nGtjZmhQb4=;
        b=UqKN7qtzSXDG4GwI6dS8OMzs5cZaM9A4Mqotc4vnkPCLI7Efoc4um1a4++adpnRmxaJkfA
        ZoTsQjcr8n8kSACw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Subject: Re: v5.19-rc2-rt3: mm/kfence might_sleep() splat
Message-ID: <YrV+Vu47VDGDQpx8@linutronix.de>
References: <bf74019da22b3c6a750153cbc74ffe3fcdb0ddf7.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf74019da22b3c6a750153cbc74ffe3fcdb0ddf7.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-18 11:34:51 [+0200], Mike Galbraith wrote:
> I moved the prandom_u32_max() call in kfence_guarded_alloc() out from
> under raw spinlock to shut this one up.

Care to send a patch? I don't even why kfence_metadata::lock is a
raw_spinlock_t. This is the case since the beginning of the code.

> [    1.128544] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
> [    1.128546] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 90, name: kworker/u16:3
> [    1.128547] preempt_count: 1, expected: 0
> [    1.128548] RCU nest depth: 1, expected: 1
> [    1.128549] CPU: 3 PID: 90 Comm: kworker/u16:3 Tainted: G        W         5.19.0.g0639b59-master-rt #2 55e5fbd63d8381661776ddec390c2b764f305c0b
> [    1.128551] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
> [    1.128552] Workqueue: events_unbound async_run_entry_fn
> [    1.128556] Call Trace:
> [    1.128557]  <TASK>
> [    1.128558]  dump_stack_lvl+0x44/0x58
> [    1.128562]  __might_resched+0x141/0x160
> [    1.128566]  rt_spin_lock+0x2d/0x70
> [    1.128569]  get_random_u32+0x45/0x100
> [    1.128575]  __kfence_alloc+0x3f4/0x6c0
> [    1.128647]  kmem_cache_alloc_lru+0x1d8/0x220
> [    1.128649]  xas_alloc+0x9b/0xc0
> [    1.128651]  xas_create+0x20c/0x390
> [    1.128653]  xas_store+0x52/0x5a0
> [    1.128655]  __filemap_add_folio+0x189/0x5a0
> [    1.128660]  filemap_add_folio+0x38/0xa0
> [    1.128661]  __filemap_get_folio+0x1b0/0x580
> [    1.128665]  pagecache_get_page+0x13/0x80
> [    1.128667]  simple_write_begin+0x20/0x2d0
> [    1.128669]  generic_perform_write+0xae/0x1e0
> [    1.128671]  __generic_file_write_iter+0x141/0x180
> [    1.128672]  generic_file_write_iter+0x5d/0xb0
> [    1.128674]  __kernel_write+0x139/0x2f0
> [    1.128676]  kernel_write+0x56/0x1a0
> [    1.128678]  xwrite.constprop.8+0x35/0x8e
> [    1.128682]  do_copy+0xee/0x13a
> [    1.128685]  write_buffer+0x27/0x37
> [    1.128687]  flush_buffer+0x34/0x8b
> [    1.128690]  unxz+0x1b8/0x301
> [    1.128695]  unpack_to_rootfs+0x17f/0x2ae
> [    1.128698]  do_populate_rootfs+0x59/0x108
> [    1.128700]  async_run_entry_fn+0x2b/0x110
> [    1.128701]  process_one_work+0x21f/0x4a0
> [    1.128703]  worker_thread+0x39/0x3d0
> [    1.128706]  kthread+0x13e/0x160
> [    1.128709]  ret_from_fork+0x1f/0x30
> [    1.128711]  </TASK>

Sebastian
