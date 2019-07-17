Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2839C76186
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 13:58:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D43F5208C0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 13:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfGQN6V (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jul 2019 09:58:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41156 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725799AbfGQN6V (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jul 2019 09:58:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 465EB335CE;
        Wed, 17 Jul 2019 13:58:21 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AE6160BE2;
        Wed, 17 Jul 2019 13:58:21 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0304E18089C8;
        Wed, 17 Jul 2019 13:58:21 +0000 (UTC)
Date:   Wed, 17 Jul 2019 09:58:20 -0400 (EDT)
From:   Pankaj Gupta <pagupta@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, bigeasy@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
Message-ID: <140248846.930713.1563371900553.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190717072019.13681-1-juri.lelli@redhat.com>
References: <20190717072019.13681-1-juri.lelli@redhat.com>
Subject: Re: [PATCH] net/xfrm/xfrm_ipcomp: Use {get,put}_cpu_light
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.117.13, 10.4.195.30]
Thread-Topic: net/xfrm/xfrm_ipcomp: Use {get,put}_cpu_light
Thread-Index: 41TD76liOAhl++7yK4uhk+E8FniKcg==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 17 Jul 2019 13:58:21 +0000 (UTC)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


> 
> The following BUG has been reported while running ipsec tests.
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
> The problem resides in the fact that get_cpu() called from ipcomp_input()
> disables preemption, and that triggers the scheduling while atomic BUG
> further
> down the callpath chain of get_page_from_freelist(), i.e.,
> 
>   ipcomp_input
>     ipcomp_decompress
>       <-- get_cpu()
>       alloc_page(GFP_ATOMIC)
>         alloc_pages(GFP_ATOMIC, 0)
>           alloc_pages_current
>             __alloc_pages_nodemask
>               get_page_from_freelist
>                 (try_this_zone:) rmqueue
>                   rmqueue_pcplist
>                     __rmqueue_pcplist
>                       rmqueue_bulk
>                         <-- spin_lock(&zone->lock) - BUG
> 
> Fix this by using {get,put}_cpu_light() in ipcomp_decompress().
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
> Hi,
> 
> This has been found on a 4.19.x-rt kernel, but 5.x-rt(s) are affected as
> well.
> 
> Best,
> 
> Juri
> ---
>  net/xfrm/xfrm_ipcomp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
> index a00ec715aa46..39d9e663384f 100644
> --- a/net/xfrm/xfrm_ipcomp.c
> +++ b/net/xfrm/xfrm_ipcomp.c
> @@ -45,7 +45,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct
> sk_buff *skb)
>  	const int plen = skb->len;
>  	int dlen = IPCOMP_SCRATCH_SIZE;
>  	const u8 *start = skb->data;
> -	const int cpu = get_cpu();
> +	const int cpu = get_cpu_light();
>  	u8 *scratch = *per_cpu_ptr(ipcomp_scratches, cpu);
>  	struct crypto_comp *tfm = *per_cpu_ptr(ipcd->tfms, cpu);
>  	int err = crypto_comp_decompress(tfm, start, plen, scratch, &dlen);
> @@ -103,7 +103,7 @@ static int ipcomp_decompress(struct xfrm_state *x, struct
> sk_buff *skb)
>  	err = 0;
>  
>  out:
> -	put_cpu();
> +	put_cpu_light();
>  	return err;
>  }
>  
> --

Reviewed-by: Pankaj Gupta <pagupta@redhat.com>

> 2.17.2
> 
> 
