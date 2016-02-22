From: "Hillf Danton" <hillf.zj@alibaba-inc.com>
Subject: Re: [patch]  sched,rt: __always_inline preemptible_lazy()
Date: Mon, 22 Feb 2016 11:36:16 +0800
Message-ID: <00a501d16d22$30045140$900cf3c0$@alibaba-inc.com>
Reply-To: "Hillf Danton" <hillf.zj@alibaba-inc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Sebastian Andrzej Siewior'" <bigeasy@linutronix.de>,
	"'Thomas Gleixner'" <tglx@linutronix.de>,
	"'LKML'" <linux-kernel@vger.kernel.org>,
	"'linux-rt-users'" <linux-rt-users@vger.kernel.org>
To: "Mike Galbraith" <umgwanakikbuti@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> 
> homer: # nm kernel/sched/core.o|grep preemptible_lazy
> 00000000000000b5 t preemptible_lazy
> 
> echo wakeup_rt > current_tracer ==> Welcome to infinity.
> 
> Signed-off-bx: Mike Galbraith <umgwanakikbuti@gmail.com>
> ---

Fat finger?

BTW, would you please make a better description of the
problem this patch is trying to address/fix?

Hillf
>  kernel/sched/core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3469,7 +3469,7 @@ static void __sched notrace preempt_sche
>   * set by a RT task. Oterwise we try to avoid beeing scheduled out as long as
>   * preempt_lazy_count counter >0.
>   */
> -static int preemptible_lazy(void)
> +static __always_inline int preemptible_lazy(void)
>  {
>  	if (test_thread_flag(TIF_NEED_RESCHED))
>  		return 1;
