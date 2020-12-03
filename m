Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1270C43211
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 14:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44889206F6
	for <linux-rt-users@archiver.kernel.org>; Thu,  3 Dec 2020 14:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389063AbgLCOI0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Dec 2020 09:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLCOIZ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Dec 2020 09:08:25 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2AC061A4E
        for <linux-rt-users@vger.kernel.org>; Thu,  3 Dec 2020 06:07:45 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so2862925lfd.9
        for <linux-rt-users@vger.kernel.org>; Thu, 03 Dec 2020 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lLqiQTRfRcyzHYfSN5BBZrNgn1qZHvvv8JQINgT7qhM=;
        b=L7ofV54v+8Hbljj30sqRy5w7AyyabaGCyJYhByvMMc/lzCthZXtwmAAJU8ufUqfWFU
         KWgDzjV11QMKKSOAxpBP6Q9Qrz73Jisk30k3iWZD6EtyAavQypanNjcOgCd8+hjWxHKn
         3baaer5xJKZqF+nUMc1jGcggQ1BgiSGx3Oc74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lLqiQTRfRcyzHYfSN5BBZrNgn1qZHvvv8JQINgT7qhM=;
        b=PzUijHcsWBULLm/vafRuMurL0CqBeGqrsBPL3blEEbvChVDRqcno5n98AAUtygZjWe
         lg/XqkFYJADl8OMW+0XkpiEV7SxvVBddeXuEIWKgPH5euCAbVomqAhv7NN32+jq/POdn
         Y1nJ7XSaTa2oEDGpEvSX9t/LrkabfbuMa3yrs0Pmy7DBqb+GMKEihooBVimCE9c6/cFQ
         q9YQOqhP36xsUACb+iJ37nH0Xs5E/i/4SEP6s33jRyLPZx37Pz5ab+qO6c3QDY4U4msK
         iOC7Zwx13l7l6swx94j0z9kFYeFk1gPmd7gspH1waIi6U0hpnMMjU9wO6iDP/lHJDElh
         38Vw==
X-Gm-Message-State: AOAM530KWOXsdAXb7PEhiHUW/67UqjiSH1e8WwkCYRutHWNm8rYiyctR
        aAJynRno/+UYx84pjy2CyaRgiQX1KDgipOU0iyIxc8YMAeimqYmT
X-Google-Smtp-Source: ABdhPJzZbTl7VRAElprqqAmRuzqHSlb0q/CDFj8YBCXWG3X68JX3uejnmu5PU0Enc4ceVKPvWktD4MWjEg9qJqLB7jU=
X-Received: by 2002:a19:8883:: with SMTP id k125mr1337745lfd.10.1607004463795;
 Thu, 03 Dec 2020 06:07:43 -0800 (PST)
MIME-Version: 1.0
References: <90c4857c53b657147bfb71a281ece9839b0373c2.camel@gmx.de>
 <20201130132014.mlvxeyiub3fpwyw7@linutronix.de> <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
 <20201130145229.mhbkrfuvyctniaxi@linutronix.de> <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
 <20201130160327.ov32m4rapk4h432a@linutronix.de> <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
 <20201202220826.5chy56mbgvrwmg3d@linutronix.de> <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
 <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de> <20201203133934.37aotbdjnd36lrxv@linutronix.de>
In-Reply-To: <20201203133934.37aotbdjnd36lrxv@linutronix.de>
From:   Vitaly Wool <vitaly.wool@konsulko.com>
Date:   Thu, 3 Dec 2020 15:07:32 +0100
Message-ID: <CAM4kBBLH5uSAYc6MXdZG85BNhON8a2D9SfaBG--ddZ2P+z6DCw@mail.gmail.com>
Subject: Re: scheduling while atomic in z3fold
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Mike Galbraith <efault@gmx.de>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Dec 3, 2020 at 2:39 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-12-03 09:18:21 [+0100], Mike Galbraith wrote:
> > On Thu, 2020-12-03 at 03:16 +0100, Mike Galbraith wrote:
> > > On Wed, 2020-12-02 at 23:08 +0100, Sebastian Andrzej Siewior wrote:
> > > Looks like...
> > >
> > > d8f117abb380 z3fold: fix use-after-free when freeing handles
> > >
> > > ...wasn't completely effective...
> >
> > The top two hunks seem to have rendered the thing RT tolerant.

Thanks for all your efforts, I promise to take a closer look at this
today, has had my hands full with RISC-V up until now.

Best regards,
   Vitaly

> Yes, it appears to. I have no idea if this is a proper fix or not.
> Without your write lock, after a few attempts, KASAN says:
>
> | BUG: KASAN: use-after-free in __pv_queued_spin_lock_slowpath+0x293/0x770
> | Write of size 2 at addr ffff88800e0e10aa by task kworker/u16:3/237
> |
> | CPU: 5 PID: 237 Comm: kworker/u16:3 Tainted: G        W         5.10.0-rc6-rt13-rt+
> | Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-1 04/01/2014
> | Workqueue: zswap1 compact_page_work
> | Call Trace:
> |  dump_stack+0x7d/0xa3
> |  print_address_description.constprop.0+0x19/0x120
> |  __kasan_report.cold+0x1d/0x35
> |  kasan_report+0x3a/0x50
> |  check_memory_region+0x145/0x1a0
> |  __pv_queued_spin_lock_slowpath+0x293/0x770
> |  _raw_spin_lock_irq+0xca/0xe0
> |  rt_read_unlock+0x2c/0x70
> |  __release_z3fold_page.constprop.0+0x45e/0x620
> |  do_compact_page+0x674/0xa50
> |  process_one_work+0x63a/0x1130
> |  worker_thread+0xd3/0xc80
> |  kthread+0x401/0x4e0
> |  ret_from_fork+0x22/0x30
> |
> | Allocated by task 225 (systemd-journal):
> |  kasan_save_stack+0x1b/0x40
> |  __kasan_kmalloc.constprop.0+0xc2/0xd0
> |  kmem_cache_alloc+0x103/0x2b0
> |  z3fold_alloc+0x597/0x1970
> |  zswap_frontswap_store+0x928/0x1bf0
> |  __frontswap_store+0x117/0x320
> |  swap_writepage+0x34/0x70
> |  pageout+0x268/0x7c0
> |  shrink_page_list+0x13e1/0x1e80
> |  shrink_inactive_list+0x303/0xde0
> |  shrink_lruvec+0x3dd/0x660
> |  shrink_node_memcgs+0x3a1/0x600
> |  shrink_node+0x3a7/0x1350
> |  shrink_zones+0x1f1/0x7f0
> |  do_try_to_free_pages+0x219/0xcc0
> |  try_to_free_pages+0x1c5/0x4b0
> |  __perform_reclaim+0x18f/0x2c0
> |  __alloc_pages_slowpath.constprop.0+0x7ea/0x1790
> |  __alloc_pages_nodemask+0x5f5/0x700
> |  page_cache_ra_unbounded+0x30f/0x690
> |  do_sync_mmap_readahead+0x3e3/0x640
> |  filemap_fault+0x981/0x1110
> |  __xfs_filemap_fault+0x12d/0x840
> |  __do_fault+0xf3/0x4b0
> |  do_fault+0x202/0x8c0
> |  __handle_mm_fault+0x338/0x500
> |  handle_mm_fault+0x1a8/0x670
> |  do_user_addr_fault+0x409/0x8b0
> |  exc_page_fault+0x60/0xc0
> |  asm_exc_page_fault+0x1e/0x30
> |
> | Freed by task 71 (oom_reaper):
> |  kasan_save_stack+0x1b/0x40
> |  kasan_set_track+0x1c/0x30
> |  kasan_set_free_info+0x1b/0x30
> |  __kasan_slab_free+0x110/0x150
> |  kmem_cache_free+0x7f/0x450
> |  z3fold_free+0x1f8/0xc90
> |  zswap_free_entry+0x168/0x230
> |  zswap_frontswap_invalidate_page+0x145/0x190
> |  __frontswap_invalidate_page+0xe8/0x1a0
> |  swap_range_free.constprop.0+0x266/0x300
> |  swapcache_free_entries+0x1dc/0x970
> |  free_swap_slot+0x19c/0x290
> |  __swap_entry_free+0x139/0x160
> |  free_swap_and_cache+0xda/0x230
> |  zap_pte_range+0x275/0x1590
> |  unmap_page_range+0x320/0x690
> |  __oom_reap_task_mm+0x207/0x330
> |  oom_reap_task_mm+0x78/0x7e0
> |  oom_reap_task+0x6d/0x1a0
> |  oom_reaper+0x103/0x290
> |  kthread+0x401/0x4e0
> |  ret_from_fork+0x22/0x30
> |
> | The buggy address belongs to the object at ffff88800e0e1080
> |  which belongs to the cache z3fold_handle of size 88
> | The buggy address is located 42 bytes inside of
> |  88-byte region [ffff88800e0e1080, ffff88800e0e10d8)
> | The buggy address belongs to the page:
> | page:000000002ba661bc refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xe0e1
> | flags: 0xffff800000200(slab)
> | raw: 000ffff800000200 dead000000000100 dead000000000122 ffff88800aa4eb40
> | raw: 0000000000000000 0000000000200020 00000001ffffffff 0000000000000000
> | page dumped because: kasan: bad access detected
> |
> | Memory state around the buggy address:
> |  ffff88800e0e0f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> |  ffff88800e0e1000: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> | >ffff88800e0e1080: fa fb fb fb fb fb fb fb fb fb fb fc fc fc fc fc
> |                                   ^
> |  ffff88800e0e1100: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> |  ffff88800e0e1180: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
> | ==================================================================
> | Disabling lock debugging due to kernel taint
>
> with the lock I haven't seen anything.
>
> Sebastian
