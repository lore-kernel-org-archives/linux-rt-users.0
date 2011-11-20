From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/5] softirq: Export in_serving_softirq()
Date: Sun, 20 Nov 2011 15:23:17 -0800
Message-ID: <20111120232317.GB17982@linux.vnet.ibm.com>
References: <20111119044510.811163517@goodmis.org>
 <20111119044829.193255499@goodmis.org>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>, stable-rt@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:58303 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab1KTXXZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 20 Nov 2011 18:23:25 -0500
Received: from /spool/local
	by e2.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Sun, 20 Nov 2011 18:23:24 -0500
Content-Disposition: inline
In-Reply-To: <20111119044829.193255499@goodmis.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Nov 18, 2011 at 11:45:11PM -0500, Steven Rostedt wrote:
> From: John Kacur <jkacur@redhat.com>
> 
> ERROR: "in_serving_softirq" [net/sched/cls_cgroup.ko] undefined!
> 
> The above can be fixed by exporting in_serving_softirq
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>
> Cc: Paul McKenney <paulmck@linux.vnet.ibm.com>

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Cc: stable-rt@vger.kernel.org
> Link: http://lkml.kernel.org/r/1321235083-21756-2-git-send-email-jkacur@redhat.com
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> ---
>  kernel/softirq.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index e8756aa..026a283 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -447,6 +447,7 @@ int in_serving_softirq(void)
>  	preempt_enable();
>  	return res;
>  }
> +EXPORT_SYMBOL(in_serving_softirq);
>  
>  /*
>   * Called with bh and local interrupts disabled. For full RT cpu must
> -- 
> 1.7.7.1
> 
> 


