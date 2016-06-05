From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH] Force processes to non-realtime before mm_exit
Date: Sat, 4 Jun 2016 19:28:09 -0500
Message-ID: <57537219.8020904@mvista.com>
References: <1464995924-16367-1-git-send-email-brian@peloton-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, bigeasy@linutronix.de
To: Brian Silverman <brian@peloton-tech.com>,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1464995924-16367-1-git-send-email-brian@peloton-tech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 06/03/2016 06:18 PM, Brian Silverman wrote:
> Without this, a realtime process which has called mlockall exiting
> causes large latencies for other realtime processes at the same or
> lower priorities. This seems like a fairly common use case too, because
> realtime processes generally want their memory locked into RAM.

Could this cause a subtle priority inversion for a process waiting
on this process to die?  I'm thinking that if this is a critical process,
it crashes, and the system is very busy with other RT processes,
it could take a long time before the process gets restarted when
it is expected to happen quickly.

I don't have another solution for you, and beyond speeding up the
memory reclamation process (which may not be possible or easy)
I'm not sure there is.  I'm just pointing out a possible side effect.

-corey

> Signed-off-by: Brian Silverman <brian@peloton-tech.com>
> ---
>   kernel/exit.c | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/kernel/exit.c b/kernel/exit.c
> index a0cf72b..68a97df 100644
> --- a/kernel/exit.c
> +++ b/kernel/exit.c
> @@ -730,6 +730,12 @@ void do_exit(long code)
>   	tsk->exit_code = code;
>   	taskstats_exit(tsk, group_dead);
>   
> +	if (tsk->policy == SCHED_FIFO || tsk->policy == SCHED_RR) {
> +		struct sched_param param = { .sched_priority = 0 };
> +
> +		sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
> +	}
> +
>   	exit_mm(tsk);
>   
>   	if (group_dead)
