From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT] sched: let softirq_count() return !0 if inside
 local_bh_disable()ed section
Date: Tue, 22 May 2018 11:53:11 -0400
Message-ID: <20180522115311.0fee528a@gandalf.local.home>
References: <20180517102214.orea3ol6dj7wvpf5@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517102214.orea3ol6dj7wvpf5@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 17 May 2018 12:22:14 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> I don't see a reason why softirq_count() shouldn't reflect the fact that
> we are within a local_bh_disable() section. I *think* it was done
> primary because in RT the softirq is slightly different (and
> preemptible) and it broke some of RCU's assumptions.
> I don't see any fallout with this change. Furthermore, all checks like
> "WARN_ON(!softirq_count())" will work and we can drop the workaround we
> currently have in the queue.

Looks to keep the paradigm closer to vanilla Linux to me.

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/preempt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index 0591df500e9d..d8c05a2626ca 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -91,7 +91,7 @@
>  # define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
>  # define in_serving_softirq()	(softirq_count() & SOFTIRQ_OFFSET)
>  #else
> -# define softirq_count()	(0UL)
> +# define softirq_count()	(current->softirq_nestcnt)
>  extern int in_serving_softirq(void);
>  #endif
>  
