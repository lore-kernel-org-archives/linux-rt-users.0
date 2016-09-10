From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] fs/dcache: resched/chill only if we make no progress
Date: Sat, 10 Sep 2016 08:17:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1609100811410.9305@nanos>
References: <20160908182503.bh77mwwhjhiaqf4y@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160908182503.bh77mwwhjhiaqf4y@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 8 Sep 2016, Sebastian Andrzej Siewior wrote:
> +		if (parent == dentry) {
> +			/* the task with the highest priority won't schedule */
> +			r = cond_resched();
> +			if (!r && (rt_task(current) || dl_task(current)))

That's wrong because a non RT task will just spin until its time slice is
up. Wasted cycles for nothing.

Ideally we make spinning conditional on 

    !on_cpu(dentry->lock->owner)

That would avoid going to sleep if the owner runs on another cpu. We have
no mechanism for that, but I think it'd be worth to think about one.

> +				cpu_chill();
> +		} else
> +			dentry = parent;

Missing braces

Thanks,

	tglx
