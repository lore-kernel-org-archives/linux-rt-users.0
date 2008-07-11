From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH][RT][PPC64] Fix a previously reverted "fix"
Date: Fri, 11 Jul 2008 10:02:32 +0200
Message-ID: <20080711100232.30d3d82f@bull.net>
References: <20080710170456.GB7685@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>,
	Nivedita Singhvi <niv@us.ibm.com>,
	Josh Triplett <josht@linux.vnet.ibm.com>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:36795 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbYGKIDX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Jul 2008 04:03:23 -0400
In-Reply-To: <20080710170456.GB7685@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Hi Chirag,

On Thu, 10 Jul 2008 22:34:56 +0530 Chirag Jog <chirag@linux.vnet.ibm.com> wrote:

> 
> This patch reintroduces a "fix" that got reverted.
> Here was the original patch http://lkml.org/lkml/2007/5/22/133
> 
> Here is the new patch
> This patch also fixes OOPS reported here: http://lkml.org/lkml/2008/6/19/146
> 
> From tsutomu.owa@toshiba.co.jp
> Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>

  This indeed fixes the oops we get with matrix_mult, good job.

  You can add my
 
  Tested-by: Sebastien Dugue <sebastien.dugue@bull.net>

  Sebastien.


> 
> 
> 
> --- linux-2.6.25.8-rt7/arch/powerpc/kernel/entry_64.S	2008-07-10 16:37:17.000000000 +0000
> +++ linux-2.6.25.8-rt7.mod/arch/powerpc/kernel/entry_64.S	2008-07-10 07:58:56.000000000 +0000
> @@ -579,14 +579,9 @@ do_work:
>  	cmpdi	r0,0
>  	crandc	eq,cr1*4+eq,eq
>  	bne	restore
> -	/* here we are preempting the current task */
>  1:
> -	li	r0,1
> -	stb	r0,PACASOFTIRQEN(r13)
> -	stb	r0,PACAHARDIRQEN(r13)
> -	ori	r10,r10,MSR_EE
> -	mtmsrd	r10,1		/* reenable interrupts */
> -	bl	.preempt_schedule
> +	/* preempt_schedule_irq() expects interrupts disabled. */
> +	bl	.preempt_schedule_irq
>  	mfmsr	r10
>  	clrrdi	r9,r1,THREAD_SHIFT
>  	rldicl	r10,r10,48,1	/* disable interrupts again */
> 
