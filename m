From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [ANNOUNCE] 4.1.42-rt50
Date: Thu, 17 Aug 2017 09:30:28 +0200
Message-ID: <20170817073027.xzkn7sn4cxki3lcr@linutronix.de>
References: <20170816204228.GE8384@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170816204228.GE8384@jcartwri.amer.corp.natinst.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-16 15:42:28 [-0500], Julia Cartwright wrote:
> Alex Shi (1):
>       cpu_pm: replace raw_notifier to atomic_notifier

…

> diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
> index 9656a3c36503..9da42f83ee03 100644
> --- a/kernel/cpu_pm.c
> +++ b/kernel/cpu_pm.c
> @@ -22,14 +22,13 @@
>  #include <linux/spinlock.h>
>  #include <linux/syscore_ops.h>
>  
> -static DEFINE_RWLOCK(cpu_pm_notifier_lock);
> -static RAW_NOTIFIER_HEAD(cpu_pm_notifier_chain);
> +static ATOMIC_NOTIFIER_HEAD(cpu_pm_notifier_chain);
>  
>  static int cpu_pm_notify(enum cpu_pm_event event, int nr_to_call, int *nr_calls)
>  {
>  	int ret;
>  
> -	ret = __raw_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
> +	ret = __atomic_notifier_call_chain(&cpu_pm_notifier_chain, event, NULL,
>  		nr_to_call, nr_calls);

there is a piece missing, upstream has a different change queued. I know
that this is the same as in latest RT, this is just to let you know in
case someone complains about an RCU backtrace…

>  	return notifier_to_errno(ret);

Sebastian
