From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [PATCH] kernel/time/posix-cpu-timers: Remove useless call to
 check_dl_overrun
Date: Wed, 7 Nov 2018 15:17:36 +0100
Message-ID: <a2fabbe4-a3be-6d10-1634-a5b23036c6f0@bristot.me>
References: <20181107111032.32291-1-juri.lelli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, bristot@redhat.com,
        linux-rt-users@vger.kernel.org, mtk.manpages@gmail.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>
To: Juri Lelli <juri.lelli@redhat.com>, peterz@infradead.org,
        mingo@redhat.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181107111032.32291-1-juri.lelli@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 11/7/18 12:10 PM, Juri Lelli wrote:
> check_dl_overrun is used to send a SIGXCPU to users that asked to be
> informed when SCHED_DEADLINE runtime overruns occur.
> 
> The function is called by check_thread_timers already, so the call in
> check_process_timers is redundant/wrong (even though harmless).
> 
> Remove it.
> 
> Fixes: 34be39305a77 ("sched/deadline: Implement "runtime overrun signal" support")
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Luca Abeni <luca.abeni@santannapisa.it>
> Cc: Claudio Scordino <claudio@evidence.eu.com>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>

Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>

Thanks!

-- Daniel

> ---
>  kernel/time/posix-cpu-timers.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
> index ce32cf741b25..8f0644af40be 100644
> --- a/kernel/time/posix-cpu-timers.c
> +++ b/kernel/time/posix-cpu-timers.c
> @@ -917,9 +917,6 @@ static void check_process_timers(struct task_struct *tsk,
>  	struct task_cputime cputime;
>  	unsigned long soft;
>  
> -	if (dl_task(tsk))
> -		check_dl_overrun(tsk);
> -
>  	/*
>  	 * If cputimer is not running, then there are no active
>  	 * process wide timers (POSIX 1.b, itimers, RLIMIT_CPU).
> 
