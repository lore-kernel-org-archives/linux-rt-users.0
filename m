From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 3/7] RT: Initialize the priority value
Date: Mon, 15 Oct 2007 13:46:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710151346160.26495@gandalf.stny.rr.com>
References: <20071013001052.7444.8363.stgit@novell1.haskins.net>
 <20071013001549.7444.81409.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:63560 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757123AbXJORrR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2007 13:47:17 -0400
In-Reply-To: <20071013001549.7444.81409.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Fri, 12 Oct 2007, Gregory Haskins wrote:


hmm, You forgot a description.

-- Steve

> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
>
>  kernel/sched.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index c9afc8a..50c88e8 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -7395,6 +7395,8 @@ void __init sched_init(void)
>  		highest_cpu = i;
>  		/* delimiter for bitsearch: */
>  		__set_bit(MAX_RT_PRIO, array->bitmap);
> +
> +		set_rq_prio(rq, MAX_PRIO);
>  	}
>
>  	set_load_weight(&init_task);
>
>
>
