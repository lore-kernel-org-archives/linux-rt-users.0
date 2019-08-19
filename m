Return-Path: <SRS0=6kRx=WP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DA9C3A5A0
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 19:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5252A22CEC
	for <linux-rt-users@archiver.kernel.org>; Mon, 19 Aug 2019 19:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbfHST5Z (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:52748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727925AbfHST5Z (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 19 Aug 2019 15:57:25 -0400
Received: from oasis.local.home (rrcs-76-79-140-27.west.biz.rr.com [76.79.140.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4430B2087E;
        Mon, 19 Aug 2019 19:57:24 +0000 (UTC)
Date:   Mon, 19 Aug 2019 15:57:21 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190819155721.05c878f8@oasis.local.home>
In-Reply-To: <20190819122731.6600-1-juri.lelli@redhat.com>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 19 Aug 2019 14:27:31 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> The following BUG has been reported while running ipsec tests.

Thanks!

I'm still in the process of backporting patches to fix some bugs that
showed up with the latest merge of upstream stable. I'll add this to
the queue to add.

-- Steve


> 
>  BUG: scheduling while atomic: irq/78-eno3-rx-/12023/0x00000002
>  Modules linked in: ipcomp xfrm_ipcomp ...
>  Preemption disabled at:
>  [<ffffffffc0b29730>] ipcomp_input+0xd0/0x9a0 [xfrm_ipcomp]
>  CPU: 1 PID: 12023 Comm: irq/78-eno3-rx- Kdump: loaded Not tainted [...] #1
>  Hardware name: [...]
>  Call Trace:
>   dump_stack+0x5c/0x80
>   ? ipcomp_input+0xd0/0x9a0 [xfrm_ipcomp]
>   __schedule_bug.cold.81+0x44/0x51
>   __schedule+0x5bf/0x6a0
>   schedule+0x39/0xd0
>   rt_spin_lock_slowlock_locked+0x10e/0x2b0
>   rt_spin_lock_slowlock+0x50/0x80
>   get_page_from_freelist+0x609/0x1560
>   ? zlib_updatewindow+0x5a/0xd0
>   __alloc_pages_nodemask+0xd9/0x280
>   ipcomp_input+0x299/0x9a0 [xfrm_ipcomp]
>   xfrm_input+0x5e3/0x960
>   xfrm4_ipcomp_rcv+0x34/0x50
>   ip_local_deliver_finish+0x22d/0x250
>   ip_local_deliver+0x6d/0x110
>   ? ip_rcv_finish+0xac/0x480
>   ip_rcv+0x28e/0x3f9
>   ? packet_rcv+0x43/0x4c0
>   __netif_receive_skb_core+0xb7c/0xd10
>   ? inet_gro_receive+0x8e/0x2f0
>   netif_receive_skb_internal+0x4a/0x160
>   napi_gro_receive+0xee/0x110
>   tg3_rx+0x2a8/0x810 [tg3]
>   tg3_poll_work+0x3b3/0x830 [tg3]
>   tg3_poll_msix+0x3b/0x170 [tg3]
>   net_rx_action+0x1ff/0x470
>   ? __switch_to_asm+0x41/0x70
>   do_current_softirqs+0x223/0x3e0
>   ? irq_thread_check_affinity+0x20/0x20
>   __local_bh_enable+0x51/0x60
>   irq_forced_thread_fn+0x5e/0x80
>   ? irq_finalize_oneshot.part.45+0xf0/0xf0
>   irq_thread+0x13d/0x1a0
>   ? wake_threads_waitq+0x30/0x30
>   kthread+0x112/0x130
>   ? kthread_create_worker_on_cpu+0x70/0x70
>   ret_from_fork+0x35/0x40
> 


