Return-Path: <SRS0=oQYw=3I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0A4C33CB6
	for <linux-rt-users@archiver.kernel.org>; Sun, 19 Jan 2020 08:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A631F20730
	for <linux-rt-users@archiver.kernel.org>; Sun, 19 Jan 2020 08:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwUy1gyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgASIDf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 19 Jan 2020 03:03:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726421AbgASIDe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 19 Jan 2020 03:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579421012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HGHTf/nk3zvoglwNRormVJrMOvgLpS2fcUW5xWc/kuk=;
        b=gwUy1gyjM33967fv7ZnxeN/9/iK+LayZQQFi0YEVksBCtunLNYFc1zSIZSJMzSS7uztF6k
        aMs4ztkWF0D2hmKUbH0K21+Nq7ydg+NKA/02Rm3LR0mqeVLUUYBIGtK6cns7Cox+0a67m+
        Rm3FU+gizp5CjlS42pnSx66qUQ4ABOY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-ZaRJnskUMByj1AIuqOz8gA-1; Sun, 19 Jan 2020 03:03:28 -0500
X-MC-Unique: ZaRJnskUMByj1AIuqOz8gA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B79110054E3;
        Sun, 19 Jan 2020 08:03:26 +0000 (UTC)
Received: from ovpn-120-231.rdu2.redhat.com (ovpn-120-231.rdu2.redhat.com [10.10.120.231])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 706977C35A;
        Sun, 19 Jan 2020 08:03:24 +0000 (UTC)
Message-ID: <f19f0181e819989b13dc3605c25b110aa2677189.camel@redhat.com>
Subject: Re: [PATCH RT] Revert "cpumask: Disable CONFIG_CPUMASK_OFFSTACK for
 RT"
From:   Scott Wood <swood@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sun, 19 Jan 2020 02:03:23 -0600
In-Reply-To: <20191218174159.ndcvzgqxavpcb37c@linutronix.de>
References: <20191218174159.ndcvzgqxavpcb37c@linutronix.de>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5 (3.30.5-1.fc29) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 2019-12-18 at 18:41 +0100, Sebastian Andrzej Siewior wrote:
> The one x86 case we had was fixed in commit
> 	832df3d47badc ("x86/smp: Enhance native_send_call_func_ipi()")
> 
> I didn't find another in-IRQ user. Most callers use GFP_KERNEL and the
> ATOMIC users are allocating the mask while holding a spinlock_t.
> 
> Allow to use CPUMASK_OFFSTACK becauase it no longer is a problem on RT.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/x86/Kconfig | 2 +-
>  lib/Kconfig      | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 7f359aacf8148..4b77b3273051e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -967,7 +967,7 @@ config CALGARY_IOMMU_ENABLED_BY_DEFAULT
>  config MAXSMP
>  	bool "Enable Maximum number of SMP Processors and NUMA Nodes"
>  	depends on X86_64 && SMP && DEBUG_KERNEL
> -	select CPUMASK_OFFSTACK if !PREEMPT_RT
> +	select CPUMASK_OFFSTACK

I get splats with this due to zalloc_cpumask_var() with preemption disabled
(from the get_cpu() in x86 flush_tlb_mm_range()):


[   26.576878] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: systemd
[   26.576879] 3 locks held by systemd/1:
[   26.576881]  #0: ffff8897d66a1258 (&mm->mmap_sem#2){++++}, at: __do_munmap+0x430/0x470
[   26.576891]  #1: ffffffff824be3a0 (rcu_read_lock){....}, at: rt_spin_lock+0x5/0xd0
[   26.576899]  #2: ffff8897e04e42e0 ((pa_lock).lock){+.+.}, at: get_page_from_freelist+0x2eb/0x1860
[   26.576906] Preemption disabled at:
[   26.576906] [<ffffffff81068b5d>] flush_tlb_mm_range+0x2d/0x1b0
[   26.576911] CPU: 11 PID: 1 Comm: systemd Tainted: G            E     5.4.10-rt5.dbg+ #224
[   26.576913] Hardware name: Intel Corporation S2600BT/S2600BT, BIOS SE5C620.86B.01.00.0763.022420181017 02/24/2018
[   26.576914] Call Trace:
[   26.576916]  dump_stack+0x68/0x9b
[   26.576921]  ___might_sleep+0x191/0x1f0
[   26.576929]  rt_spin_lock+0x93/0xd0
[   26.576931]  ? get_page_from_freelist+0x2eb/0x1860
[   26.576933]  get_page_from_freelist+0x2eb/0x1860
[   26.576939]  ? lockdep_hardirqs_on+0xf0/0x1a0
[   26.576944]  ? _raw_spin_unlock_irqrestore+0x3e/0x90
[   26.576945]  ? find_held_lock+0x2d/0x90
[   26.576954]  __alloc_pages_nodemask+0x186/0x440
[   26.576960]  new_slab+0x357/0xc20
[   26.576971]  ___slab_alloc+0x52f/0x7a0
[   26.576977]  ? alloc_cpumask_var_node+0x1f/0x30
[   26.576981]  ? __lock_acquire+0x24b/0x1080
[   26.576985]  ? alloc_cpumask_var_node+0x1f/0x30
[   26.576987]  __slab_alloc.isra.89+0x6a/0xb4
[   26.576992]  ? alloc_cpumask_var_node+0x1f/0x30
[   26.576993]  __kmalloc_node+0xd9/0x410
[   26.576997]  ? x86_configure_nx+0x50/0x50
[   26.576998]  ? flush_tlb_func_common.isra.8+0x530/0x530
[   26.576999]  alloc_cpumask_var_node+0x1f/0x30
[   26.577001]  on_each_cpu_cond_mask+0x55/0x1e0
[   26.577006]  ? rcu_read_lock_sched_held+0x52/0x80
[   26.577013]  flush_tlb_mm_range+0x13b/0x1b0
[   26.577018]  tlb_flush_mmu+0x89/0x170
[   26.577020]  tlb_finish_mmu+0x3d/0x70
[   26.577022]  unmap_region+0xd9/0x120
[   26.577028]  ? rt_mutex_slowunlock+0x65/0x70
[   26.577034]  __do_munmap+0x26c/0x470
[   26.577039]  __vm_munmap+0x72/0xc0
[   26.577044]  __x64_sys_munmap+0x27/0x30
[   26.577046]  do_syscall_64+0x6c/0x280
[   26.577050]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   26.577053] RIP: 0033:0x7f33a23243f7
[   26.577054] Code: 64 89 02 48 83 c8 ff eb 9c 48 8b 15 93 da 2c 00 f7 d8 64 89 02 e9 6a ff ff ff 66 0f 1f 84 00 00 00 00 00 b8 0b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 69 da 2c 00 f7 d8 64 89 01 48
[   26.577056] RSP: 002b:00007fffc45a8228 EFLAGS: 00000206 ORIG_RAX: 000000000000000b
[   26.577056] RAX: ffffffffffffffda RBX: 000055bce7ca7790 RCX: 00007f33a23243f7
[   26.577057] RDX: 0000000000000000 RSI: 0000000000001000 RDI: 00007f33a3b0f000
[   26.577058] RBP: 0000000000000000 R08: 000055bce7ca7870 R09: 00007f33a3afc940
[   26.577058] R10: 0000000000000006 R11: 0000000000000206 R12: 0000000000000000
[   26.577059] R13: 0000000000000000 R14: 000055bce7ca6e70 R15: 000055bce7c9cea0

-Scott


