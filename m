Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60757C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 18 Jun 2022 09:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiFRJfE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 18 Jun 2022 05:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbiFRJfE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 18 Jun 2022 05:35:04 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB7621759C
        for <linux-rt-users@vger.kernel.org>; Sat, 18 Jun 2022 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655544892;
        bh=j7Qsa+ZzDYRvJhxRgxVsLB0A/Or96acR1vNc2NdVwh8=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=WvZj6JsW8ncdis03ZgyOrfHSYBNtAj8qDF1rJJAfUr8jWhZxXL82K2qLjW4lP/sEX
         zZ+AsW2/+4o1fDXLfLd9lfJnMoSSI6IjE95G7ACsltw9U0Ca4mvYAiyIVqAosr5GvN
         iXtEFoxn/bpJBLIg7C/elPbJDpwF8uhP7lsHeNdA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.191.217.210]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1o1OOG0mkW-0018R6; Sat, 18
 Jun 2022 11:34:52 +0200
Message-ID: <bf74019da22b3c6a750153cbc74ffe3fcdb0ddf7.camel@gmx.de>
Subject: v5.19-rc2-rt3: mm/kfence might_sleep() splat
From:   Mike Galbraith <efault@gmx.de>
To:     RT <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Sat, 18 Jun 2022 11:34:51 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tUV653VUZ0AQR4+huzCaI7rdMdEC63dmuPBGhZhM/TVsftZ3yXC
 Omh4fhJr/Cv33XeR6fzePJ0UvZU2DdAxeMCO7++hxyGpRN8GodYO8AzSiC3ye58LSRRcRcE
 IFjH2OD0AL7ZFO+HnC+AI8knjCTIHgDXYYWPvw/kkasIweJUqgta/csNzhHjdu2MotJDlOJ
 weezctM17jHT7RgTSkItA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1B2mSYP8E84=:CK4Bd1njw5EsGonIi790Nz
 z4dpV6z15PmimGhYq0zn+RNSoYyfZkUTZquYreQP4vkTwHnyUfdvaWH/vv8jQIMyPruylWTRE
 h3n0R26nTjIqKJvM2ujWLioqQantb1Ua1FL3+WpjL1qgViCAKaVNANKPkVQD/oSgccnZ8bLs+
 Dtgi748Dr2A1BIkZ9gtW6zhP2GHyXJMff8K523oL4QUs2XpYJBOZawkMxyBpbq76G96iMsry1
 gth6wLi9blXu4/XRG5v4UEzH7qo1SilEob1n1D4H+JMr4YqcatdwBrjuYX+hdyaWAuXzic62a
 XjwW0hpQ4GoYe4DnkHQBOytWDB37Npqhp9ZxdqCstf76XKt3lorT1TYff8Iapb2WR0lmV4M6p
 HurMkirW+pDq28uP4zA3xbtHB3/MMg4PMZh3NxhZ81baflBjLADgpt76f0D3zNWwOrDrGmD14
 ydrELMOu1W6i1x3WJ9YAGGeQcu3G+VD2/u6CCqb4zsaAHqFGEbWtQgAPDoayuB+1jEQ2edFc3
 w+sA3KBZ7TqngnG9OK0u97VEFy6wgEJfSg51q9+vp0NN6XnljYZCnw6GqUIGn51YfYPCeXj1M
 4Fo9zZlQeaMtUhaXc/2XRrvG9fKC3yZRIOvzTuB0g/X3nDXx9WECLYI+gCYCA68pbvsajrwhO
 nbnvwI9WsdTCU+evR5TPqhxoTwcILSj6VI/timUxrT2UvAwG3WC8++VBc0wQMzVhrvYftcPDu
 f+cICm3ZUxAjoGA2llBaJRL/QZIsVMZLzA08OpgJWMCk/emWvn3YgD+o0qVJCe4WUItYUWYIQ
 aYJMX98BGmFEdWCMsyK6x1n+gYbq7Ru7jNZ471zyhJNQexwYJp8WSt7jKL5MLm4wOYK5uwTEw
 LgRrxM4qaxNOj0OxIGLs20CfPorm7bsXpeVDj+FYvsbZHuapDHiRwp/RoCI7DlBGWjb0ca+43
 NgFFQKMu5dCev52jlzc7P7oiFVAK7MEb+yqT3tCgtYOqP4/of3xnZu8Sy7i6Ozp38D0YWl4U+
 WYW17+QvJVpyKYjNsqMyW7m58b7QF8TtFQTHU082GZYPgNx3JK5TrKCo7+PKdtTyQAFYYgTGt
 LsRHNOKw54moWkyePPKXbsTBf+uql8M00iDxxdxSOca7pp/aNc1MrMkBA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

I moved the prandom_u32_max() call in kfence_guarded_alloc() out from
under raw spinlock to shut this one up.

[    1.128544] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:46
[    1.128546] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 90, name: kworker/u16:3
[    1.128547] preempt_count: 1, expected: 0
[    1.128548] RCU nest depth: 1, expected: 1
[    1.128549] CPU: 3 PID: 90 Comm: kworker/u16:3 Tainted: G        W         5.19.0.g0639b59-master-rt #2 55e5fbd63d8381661776ddec390c2b764f305c0b
[    1.128551] Hardware name: MEDION MS-7848/MS-7848, BIOS M7848W08.20C 09/23/2013
[    1.128552] Workqueue: events_unbound async_run_entry_fn
[    1.128556] Call Trace:
[    1.128557]  <TASK>
[    1.128558]  dump_stack_lvl+0x44/0x58
[    1.128562]  __might_resched+0x141/0x160
[    1.128566]  rt_spin_lock+0x2d/0x70
[    1.128569]  get_random_u32+0x45/0x100
[    1.128572]  ? stack_trace_save+0x4b/0x70
[    1.128575]  __kfence_alloc+0x3f4/0x6c0
[    1.128579]  ? __kfence_alloc+0xa8/0x6c0
[    1.128581]  ? kmem_cache_alloc_lru+0x1d8/0x220
[    1.128582]  ? xas_alloc+0x9b/0xc0
[    1.128585]  ? xas_create+0x20c/0x390
[    1.128586]  ? xas_store+0x52/0x5a0
[    1.128587]  ? __filemap_add_folio+0x189/0x5a0
[    1.128590]  ? filemap_add_folio+0x38/0xa0
[    1.128591]  ? __filemap_get_folio+0x1b0/0x580
[    1.128592]  ? pagecache_get_page+0x13/0x80
[    1.128595]  ? simple_write_begin+0x20/0x2d0
[    1.128597]  ? generic_perform_write+0xae/0x1e0
[    1.128599]  ? __generic_file_write_iter+0x141/0x180
[    1.128600]  ? generic_file_write_iter+0x5d/0xb0
[    1.128601]  ? __kernel_write+0x139/0x2f0
[    1.128604]  ? kernel_write+0x56/0x1a0
[    1.128606]  ? xwrite.constprop.8+0x35/0x8e
[    1.128609]  ? do_copy+0xee/0x13a
[    1.128610]  ? write_buffer+0x27/0x37
[    1.128612]  ? flush_buffer+0x34/0x8b
[    1.128614]  ? unxz+0x1b8/0x301
[    1.128616]  ? unpack_to_rootfs+0x17f/0x2ae
[    1.128617]  ? do_populate_rootfs+0x59/0x108
[    1.128619]  ? async_run_entry_fn+0x2b/0x110
[    1.128620]  ? process_one_work+0x21f/0x4a0
[    1.128622]  ? worker_thread+0x39/0x3d0
[    1.128624]  ? kthread+0x13e/0x160
[    1.128625]  ? ret_from_fork+0x1f/0x30
[    1.128628]  ? get_random_u32+0xbb/0x100
[    1.128629]  ? new_slab+0x288/0x4e0
[    1.128631]  ? rt_spin_unlock+0x13/0x40
[    1.128633]  ? ___slab_alloc+0x31a/0x660
[    1.128635]  ? xas_alloc+0x9b/0xc0
[    1.128637]  ? rt_spin_unlock+0x13/0x40
[    1.128638]  ? ___slab_alloc+0x31a/0x660
[    1.128640]  ? __d_alloc+0x29/0x1f0
[    1.128642]  ? ___slab_alloc+0x31a/0x660
[    1.128644]  ? slab_pre_alloc_hook.constprop.85+0x37/0x1c0
[    1.128646]  ? xas_alloc+0x9b/0xc0
[    1.128647]  kmem_cache_alloc_lru+0x1d8/0x220
[    1.128649]  xas_alloc+0x9b/0xc0
[    1.128651]  xas_create+0x20c/0x390
[    1.128653]  xas_store+0x52/0x5a0
[    1.128654]  ? xas_load+0x37/0x40
[    1.128654]  ? xa_get_order+0x9a/0xf0
[    1.128655]  __filemap_add_folio+0x189/0x5a0
[    1.128657]  ? scan_shadow_nodes+0x30/0x30
[    1.128660]  filemap_add_folio+0x38/0xa0
[    1.128661]  __filemap_get_folio+0x1b0/0x580
[    1.128662]  ? mntput_no_expire+0x4a/0x230
[    1.128665]  pagecache_get_page+0x13/0x80
[    1.128667]  simple_write_begin+0x20/0x2d0
[    1.128669]  generic_perform_write+0xae/0x1e0
[    1.128671]  __generic_file_write_iter+0x141/0x180
[    1.128672]  generic_file_write_iter+0x5d/0xb0
[    1.128674]  __kernel_write+0x139/0x2f0
[    1.128676]  kernel_write+0x56/0x1a0
[    1.128678]  xwrite.constprop.8+0x35/0x8e
[    1.128680]  ? initrd_load+0x3f/0x3f
[    1.128682]  do_copy+0xee/0x13a
[    1.128684]  ? write_buffer+0x27/0x37
[    1.128685]  write_buffer+0x27/0x37
[    1.128687]  flush_buffer+0x34/0x8b
[    1.128689]  ? write_buffer+0x37/0x37
[    1.128690]  unxz+0x1b8/0x301
[    1.128692]  ? initrd_load+0x3f/0x3f
[    1.128693]  ? unlzo+0x3cc/0x3cc
[    1.128695]  unpack_to_rootfs+0x17f/0x2ae
[    1.128696]  ? initrd_load+0x3f/0x3f
[    1.128698]  do_populate_rootfs+0x59/0x108
[    1.128700]  async_run_entry_fn+0x2b/0x110
[    1.128701]  process_one_work+0x21f/0x4a0
[    1.128703]  worker_thread+0x39/0x3d0
[    1.128704]  ? process_one_work+0x4a0/0x4a0
[    1.128706]  kthread+0x13e/0x160
[    1.128707]  ? kthread_complete_and_exit+0x20/0x20
[    1.128709]  ret_from_fork+0x1f/0x30
[    1.128711]  </TASK>

