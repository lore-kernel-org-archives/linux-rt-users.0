Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFEC433B4
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 06:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F6E76161F
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 May 2021 06:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhEKGZd (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 May 2021 02:25:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58043 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230027AbhEKGZc (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 May 2021 02:25:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620714266;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCLnR5+cHi+UXLzPt5/tQq3hZM4KsR/ux/tRRh35iVY=;
        b=Mif2/j9TqieAEvHOtGTXng+4khwSJu5onEGrKljaID5Bbg2j0wg0Fma+9EYH8glb8Y2Qo3
        kLQvmdiLZUBWue/EX7mL3I2X3O1IBzjvXQUvb75NrUaLzoQkC6+9ukgi+aqIHBM0tTMqgp
        UxO9C8kQ1/dxtnvSMzFw9dsoHH87sZY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-yUIZDYCdMOO_ljDZ6ytPrQ-1; Tue, 11 May 2021 02:24:22 -0400
X-MC-Unique: yUIZDYCdMOO_ljDZ6ytPrQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B064D1935780;
        Tue, 11 May 2021 06:24:21 +0000 (UTC)
Received: from p50.fritz.box (ovpn-112-109.ams2.redhat.com [10.36.112.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 742D66E0A3;
        Tue, 11 May 2021 06:24:17 +0000 (UTC)
Date:   Tue, 11 May 2021 08:24:15 +0200
From:   Stefan Assmann <sassmann@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] Question about i40e threaded irq
Message-ID: <20210511062415.pdwi4n5ay6vgmg5j@p50.fritz.box>
References: <YJofplWBz8dT7xiw@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YJofplWBz8dT7xiw@localhost.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-05-11 08:09, Juri Lelli wrote:
> Hi,
> 
> The following has been reported on RT.
> 
> [ 2007.106483] list_add corruption. next->prev should be prev (ffff8d86a0aadd00), but was ffff8d86a0aadec8. (next=ffff8d86a0aadd00).
> [ 2007.118155] ------------[ cut here ]------------
> [ 2007.118156] kernel BUG at lib/list_debug.c:25!
> [ 2007.118160] invalid opcode: 0000 [#1] PREEMPT_RT SMP NOPTI
> [ 2007.118162] CPU: 36 PID: 4651 Comm: irq/429-i40e-en Kdump: loaded Tainted: G          I  #1
> [ 2007.118163] Hardware name: Dell Inc. PowerEdge R740xd/04FC42, BIOS 2.6.4 04/09/2020
> [ 2007.118168] RIP: 0010:__list_add_valid.cold.0+0x12/0x28
> [ 2007.118169] Code: 85 5d 00 00 00 48 8b 50 08 48 39 f2 0f 85 42 00 00 00 b8 01 00 00 00 c3 48 89 d1 48 c7 c7 20 1e 6e ad 48 89 c2 e8 e0 11 cd ff <0f> 0b 48 89 c1 4c 89 c6 48 c7 c7 78 1e 6e ad e8 cc 11 cd ff 0f 0b
> [ 2007.118170] RSP: 0018:ffffa598d9b0be68 EFLAGS: 00010246
> [ 2007.118171] RAX: 0000000000000075 RBX: ffff8d86a0aadd00 RCX: 0000000000000001
> [ 2007.118171] RDX: 0000000000000000 RSI: ffffffffad6cf723 RDI: 00000000ffffffff
> [ 2007.118172] RBP: ffff8d8694112010 R08: 0000000000000000 R09: 0000000000000a36
> [ 2007.118173] R10: 0000000000000000 R11: 0000000000000001 R12: ffff8d86a0aadd00
> [ 2007.118173] R13: ffffffffac71f240 R14: ffff8d869d3758a0 R15: ffff8d993af88000
> [ 2007.118174] FS:  0000000000000000(0000) GS:ffff8d86a0a80000(0000) knlGS:0000000000000000
> [ 2007.118174] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 2007.118175] CR2: 00007fa2d29211a0 CR3: 00000011d8c0e002 CR4: 00000000007606e0
> [ 2007.118175] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [ 2007.118176] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [ 2007.118176] PKRU: 55555554
> [ 2007.118176] Call Trace:
> [ 2007.118180]  __napi_schedule_irqoff+0x34/0x60
> [ 2007.118191]  i40e_msix_clean_rings+0x3f/0x50 [i40e]
> [ 2007.118195]  irq_forced_thread_fn+0x30/0x80
> [ 2007.118196]  irq_thread+0xdd/0x180
> [ 2007.118198]  ? wake_threads_waitq+0x30/0x30
> [ 2007.118198]  ? irq_thread_check_affinity+0x20/0x20
> [ 2007.118202]  kthread+0x112/0x130
> [ 2007.118203]  ? kthread_flush_work_fn+0x10/0x10
> [ 2007.118207]  ret_from_fork+0x1f/0x40
> 
> The following tracing bits have been then collected, which seem
> relevant.
> 
> irq/532--4667   36....2 13343.788389: softirq_raise:        vec=3 [action=NET_RX]
> irq/532--4667   36....2 13343.788391: kernel_stack:         <stack trace>
> => trace_event_raw_event_softirq (ffffffff83eb6f77)
> => __raise_softirq_irqoff (ffffffff83eb7acd)
> => i40e_msix_clean_rings (ffffffffc03fe6ef)
> => irq_forced_thread_fn (ffffffff83f1f2a0)
> => irq_thread (ffffffff83f1f58d)
> => kthread (ffffffff83ed5f42)
> => ret_from_fork (ffffffff8480023f)
> 
> irq/529--4664   36d.h.2 13343.788402: softirq_raise:        vec=3 [action=NET_RX]
> irq/529--4664   36d.h.2 13343.788404: kernel_stack:         <stack trace>
> => trace_event_raw_event_softirq (ffffffff83eb6f77)
> => __raise_softirq_irqoff (ffffffff83eb7acd)
> => rps_trigger_softirq (ffffffff8452fa49)
> => flush_smp_call_function_queue (ffffffff83f591c3)
> => smp_call_function_single_interrupt (ffffffff8480294b)
> => call_function_single_interrupt (ffffffff84801c3f)
> => __list_add_valid (ffffffff8424b050)
> => __napi_schedule_irqoff (ffffffff8452fa94)
> => i40e_msix_clean_rings (ffffffffc03fe6ef)
> => irq_forced_thread_fn (ffffffff83f1f2a0)
> => irq_thread (ffffffff83f1f58d)
> => kthread (ffffffff83ed5f42)
> => ret_from_fork (ffffffff8480023f)
> 
> My understanding is that rps_trigger_softirq() sneaked in while
> i40e_msix_clean_rings() threaded irq was running and, since the latter is
> using napi_schedule_irqoff(), the softnet_data poll_list got eventually
> corrupted.
> 
> Now, doing s/napi_schedule_irqoff/napi_schedule/ in the i40e driver seem
> to cure the problem. I'm not sure that there isn't a more general
> solution, though. Is it expected that napi_schedule_irqoff users in RT
> know what they are doing or do we want/need to fix this in a more
> general way?

Just wanted to add that this does not concern i40e alone. A good number
of wired NIC drivers use napi_schedule_irqoff() in the same way.

Thanks!

  Stefan

