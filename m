From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] kernel/printk: Don't try to print from IRQ/NMI
 region
Date: Fri, 27 May 2016 10:12:51 -0400
Message-ID: <20160527101251.0ae36e23@gandalf.local.home>
References: <20160527135812.GB24120@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160527135812.GB24120@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Fri, 27 May 2016 15:58:12 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On -RT we try to acquire sleeping locks which might lead to warnings
> from lockdep or a warn_on() from spin_try_lock() (which is a rtmutex on
> RT).
> We don't print in general from a IRQ off region so we should not try
> this via console_unblank() / bust_spinlocks() as well.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/printk/printk.c |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1502,6 +1502,11 @@ static void call_console_drivers(int lev
>  	if (!console_drivers)
>  		return;
>  
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT_BASE)) {
> +		if (in_irq() || in_nmi())
> +			return;
> +	}
> +

We use to have a patch where a console could flag itself as atomic.
That is, that it doesn't call any sleeping locks. What happened to that.

IIRC, the video console was one such console. Otherwise, we lose out on
backtraces in irq context.

-- Steve

>  	migrate_disable();
>  	for_each_console(con) {
>  		if (exclusive_console && con != exclusive_console)
