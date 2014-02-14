From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 1/1] tracing/latency_hist Fix memory leak
Date: Fri, 14 Feb 2014 20:59:37 +0100
Message-ID: <52FE75A9.6050305@linutronix.de>
References: <20140214172617.382025623@osadl.org> <20140214172751.776971499@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nicholas Mc Guire <der.herr@hofr.at>,
	Thomas Gleixner <tglx@linutronix.de>,
	RT-users <linux-rt-users@vger.kernel.org>
To: Carsten Emde <C.Emde@osadl.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:44291 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751948AbaBNT7n (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Feb 2014 14:59:43 -0500
In-Reply-To: <20140214172751.776971499@osadl.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 02/14/2014 06:26 PM, Carsten Emde wrote:
> The index_ptr memory that is allocated when printout is started
> currently is only returned when the printout is stopped
> prematurely. It is not returned when the printout regularly
> finishes. Fix this memory leak.
> 
> Signed-off-by: Carsten Emde <C.Emde@osadl.org>
> 
> Index: linux-3.12.10-rt15-somedebug/kernel/trace/latency_hist.c
> ===================================================================
> --- linux-3.12.10-rt15-somedebug.orig/kernel/trace/latency_hist.c
> +++ linux-3.12.10-rt15-somedebug/kernel/trace/latency_hist.c
> @@ -313,6 +313,7 @@ static void *l_next(struct seq_file *m, 
>  
>  	if (++*pos >= MAX_ENTRY_NUM) {
>  		atomic_inc(&my_hist->hist_mode);
> +		kfree(p);
>  		return NULL;
>  	}
>  	*index_ptr = *pos;

Sure on that? If I look at seq_read() I see that there is that ->stop()
is always called after ->start() / ->next() before returning to caller.
Based on this I would say that this patach will introduce a double free
of p.

> 
Sebastian
