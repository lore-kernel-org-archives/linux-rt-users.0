From: Joerg Abraham <Joerg.Abraham@alcatel-lucent.de>
Subject: [Fwd: Re: 2.6.31.4-rt14 posix message queues problem (solved)]
Date: Fri, 16 Oct 2009 10:25:55 +0200
Message-ID: <4AD82E13.3080301@alcatel-lucent.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smail3.alcatel.fr ([64.208.49.56]:37079 "EHLO smail3.alcatel.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751479AbZJPIr5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 16 Oct 2009 04:47:57 -0400
Received: from FRMRSSXCHHUB01.dc-m.alcatel-lucent.com (FRMRSSXCHHUB01.dc-m.alcatel-lucent.com [135.120.45.61])
	by smail3.alcatel.fr (8.13.8/8.13.8/ICT) with ESMTP id n9G8PrYb026385
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-rt-users@vger.kernel.org>; Fri, 16 Oct 2009 10:26:02 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

forgot to cc rt-users list

Thanx again,


Hi John,

> Hello Joerg
> 
> Does the following patch solve your problem? 

yes, (verified on powerpc and x86_64)

so it may be save to include your patch into the next rt release.

Thanx,

Joerg


> 
> From 69fde4357db4a054733cbca4158606160e821a3a Mon Sep 17 00:00:00 2001
> From: John Kacur <jkacur@redhat.com>
> Date: Thu, 15 Oct 2009 20:52:37 +0200
> Subject: [PATCH] preempt_disable_rt(); should be paired with preempt_enable_rt()
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> ---
>  ipc/mqueue.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/ipc/mqueue.c b/ipc/mqueue.c
> index 63a47f7..ab4df36 100644
> --- a/ipc/mqueue.c
> +++ b/ipc/mqueue.c
> @@ -830,7 +830,7 @@ static inline void pipelined_send(struct mqueue_inode_info *info,
>  	wake_up_process(receiver->task);
>  	smp_wmb();
>  	receiver->state = STATE_READY;
> -	preempt_enable_nort();
> +	preempt_enable_rt();
>  }
>  
>  /* pipelined_receive() - if there is task waiting in sys_mq_timedsend()

