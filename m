From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: RE: [PATCH] powerpc/64bit,PREEMPT_RT: Check preempt_count before
 preempting
Date: Mon, 15 Apr 2013 05:50:08 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190B332FD3@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1366004831-2931-1-git-send-email-Priyanka.Jain@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: Jain Priyanka-B32167 <B32167@freescale.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-db8lp0188.outbound.messaging.microsoft.com ([213.199.154.188]:27305
	"EHLO db8outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752789Ab3DOFuQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Apr 2013 01:50:16 -0400
Received: from mail12-db8 (localhost [127.0.0.1])	by mail12-db8-R.bigfish.com
 (Postfix) with ESMTP id EF7B646008A	for <linux-rt-users@vger.kernel.org>;
 Mon, 15 Apr 2013 05:50:14 +0000 (UTC)
Received: from DB8EHSMHS019.bigfish.com (unknown [10.174.8.245])	by
 mail12-db8.bigfish.com (Postfix) with ESMTP id 3FC6838012B	for
 <linux-rt-users@vger.kernel.org>; Mon, 15 Apr 2013 05:50:13 +0000 (UTC)
In-Reply-To: <1366004831-2931-1-git-send-email-Priyanka.Jain@freescale.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Please ignore this patch. I have send another patch with updated description.

> -----Original Message-----
> From: Jain Priyanka-B32167
> Sent: Monday, April 15, 2013 11:17 AM
> To: linux-rt-users@vger.kernel.org
> Cc: Jain Priyanka-B32167
> Subject: [PATCH] powerpc/64bit,PREEMPT_RT: Check preempt_count before
> preempting
> 
> In ret_from_except_lite() with CONFIG_PREEMPT enabled, add the missing
> check to compare value of preempt_count with zero before continuing with
> preemption process of the current task.
> If preempt_count is non-zero, restore reg and return, else continue the
> preemption process.
> 
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com> Fixes
> CQ:ENGR257848
> 	 CONFIG_PREEMPT_RT_FULL does not work on 64-bit
> ---
>  arch/powerpc/kernel/entry_64.S |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S
> b/arch/powerpc/kernel/entry_64.S index 1b1c8ae..ec120e6 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -643,6 +643,8 @@ resume_kernel:
>  #ifdef CONFIG_PREEMPT
>  	/* Check if we need to preempt */
>  	lwz	r8,TI_PREEMPT(r9)
> +	cmpwi	0,r8,0		/* if non-zero, just restore regs and
> return */
> +	bne	restore
>  	andi.	r0,r4,_TIF_NEED_RESCHED
>  	bne+	check_count
> 
> --
> 1.7.4.1


