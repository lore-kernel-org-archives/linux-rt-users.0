Return-Path: <SRS0=uaKE=VO=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE49C76186
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 07:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B5E2173B
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Jul 2019 07:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dkim.kinghost.net header.i=@dkim.kinghost.net header.b="WwSPWQpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfGQHXB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Jul 2019 03:23:01 -0400
Received: from smtpi-sp-222.kinghost.net ([177.185.201.222]:45117 "EHLO
        smtpi-sp-222.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfGQHXB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Jul 2019 03:23:01 -0400
Received: from t460s.bristot.redhat.com (nat-cataldo.sssup.it [193.205.81.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: daniel@bristot.eti.br)
        by smtpi-sp-222.kinghost.net (Postfix) with ESMTPSA id 637406000E14;
        Wed, 17 Jul 2019 04:22:45 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; 
 d=dkim.kinghost.net; i=@dkim.kinghost.net; q=dns/txt; 
 s=king1; t=1563348178; h=subject : to : cc : references : 
 from : message-id : date : mime-version : in-reply-to : 
 content-type : content-transfer-encoding : subject : from 
 : date; bh=67kFt+DJ2C7EC5AJeZz6ERKeWbs66i2q1Ovqu83E9jk=; 
 b=WwSPWQpq1bi2L/0SquDtYmNHiFUiZhQMIWOoNNwBrOzoDaW5zSGId/M0
 eqgX6tX88xzpSCzF5f6uzCcNJz062GcATHowZqK3uPOaO72Sg1orMQNLSM
 S0tIi9slWOo/7QhlXDGyzarCVM/bz6d5X3rNY9Sa9K6+sBUT90xwYVDzE=
Subject: Re: [PATCH] net/xfrm/xfrm_ipcomp: Use {get,put}_cpu_light
To:     Juri Lelli <juri.lelli@redhat.com>, rostedt@goodmis.org,
        tglx@linutronix.de, bigeasy@linutronix.de
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
References: <20190717072019.13681-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <daniel@bristot.me>
Message-ID: <ed2ab5b2-2499-2f0b-9cd9-a84f1d528c4d@bristot.me>
Date:   Wed, 17 Jul 2019 09:22:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190717072019.13681-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SND-ID: E3DhL4HZvWApxdeEu0+R3k19tF2vhIUMcvigv4x0qidpkEMv/61pVU+Ic2kX
        C2E5z/9xJ4WEtUyKW/eV3FZ7zr0447jqsvTjVVzzGZwihvU4GAeD6fvGOR57
        Zy47voTucdR9cR3ZoMJgUmQpRVwBXzDVQtccotOaFUd3Xf2KKjvP7elItJCr
        PUBbTHq8LRE1nbo1/Fj4E24O+Z7TpF6q46Cx3whfnh8+ZkVlhDc7PgGh0BXz
        5PdFXX2Xnn/2tvtR5Rx6szS7OUqJY/YOH/0o4hJCcWu+kBkPOKCCct+L3OAk
        Q/7lIjys5y+t+fo40kycYSdIOzSd8miPOHvD0a7eYLTmDaypOO1SxrQt9XF/
        G97bPFaTBe94Ggt83F+K1mVCHWnT0iw3urD41n1vkfUXQVGI0SwdhWbmX+VS
        GrLaxgMuga6X4mNo8jqtjzg4ex0lA9bHY2myhf5PNQ70F+4T0+6+bKpUGNs9
        FfszjQJawLNnJT/NzBOf3wmWFT9xliFeao6gzz3D8dSUfIpkRAHKWbCiwTbl
        ZQX+6c8nISifNalq2bMDlin0SV+K1Q6CNGcHYByfKYxRdUohCZ3keJMgyw==
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 17/07/2019 09:20, Juri Lelli wrote:
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
> disables preemption, and that triggers the scheduling while atomic BUG further
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

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!
-- Daniel
