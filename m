Return-Path: <SRS0=EtfJ=BR=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82363C433E1
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EC02224D
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 Aug 2020 13:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHGN2x (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 Aug 2020 09:28:53 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:54489 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHGN2v (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Aug 2020 09:28:51 -0400
X-Greylist: delayed 719 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2020 09:28:49 EDT
Received: from [94.37.192.58] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 150296837; Fri, 07 Aug 2020 15:28:43 +0200
Date:   Fri, 7 Aug 2020 15:28:32 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        tommaso.cucinotta@santannapisa.it, alessio.balsini@gmail.com,
        bristot@redhat.com, dietmar.eggemann@arm.com,
        linux-rt-users@vger.kernel.org, mtosatti@redhat.com,
        williams@redhat.com, valentin.schneider@arm.com
Subject: Re: [RFC PATCH v2 6/6] sched/fair: Implement starvation monitor
Message-ID: <20200807152832.591f462e@nowhere>
In-Reply-To: <20200807095604.GO42956@localhost.localdomain>
References: <20200807095051.385985-1-juri.lelli@redhat.com>
        <20200807095604.GO42956@localhost.localdomain>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Juri,

On Fri, 7 Aug 2020 11:56:04 +0200
Juri Lelli <juri.lelli@redhat.com> wrote:

> Starting deadline server for lower priority classes right away when
> first task is enqueued might break guarantees

Which guarantees are you thinking about, here? Response times of fixed
priority tasks?

If fixed priority tasks are also scheduled through deadline servers,
then you can provide response-time guarantees to them even when
lower-priority/non-real-time tasks are scheduled through deadline
servers.


			Thanks,
				Luca

> as tasks belonging to
> intermediate priority classes could be uselessly preempted. E.g., a
> well behaving (non hog) FIFO task can be preempted by NORMAL tasks
> even if there are still CPU cycles available for NORMAL tasks to run,
> as they'll be running inside the fair deadline server for some period
> of time.
> 
> To prevent this issue, implement a starvation monitor mechanism that
> starts the deadline server only if a (fair in this case) task hasn't
> been scheduled for some interval of time after it has been enqueued.
> Use pick/put functions to manage starvation monitor status.
> 
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
> ---
>  kernel/sched/fair.c  | 57
> ++++++++++++++++++++++++++++++++++++++++++-- kernel/sched/sched.h |
> 4 ++++ 2 files changed, 59 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6a97ee2a4e26d..5cdf76e508074 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5494,6 +5494,53 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>  
> +
> +static void fair_server_watchdog(struct timer_list *list)
> +{
> +	struct rq *rq = container_of(list, struct rq,
> fair_server_wd);
> +	struct rq_flags rf;
> +
> +	rq_lock_irqsave(rq, &rf);
> +	rq->fair_server_wd_running = 0;
> +
> +	if (!rq->cfs.h_nr_running)
> +		goto out;
> +
> +	update_rq_clock(rq);
> +	dl_server_start(&rq->fair_server);
> +	rq->fair_server_active = 1;
> +	resched_curr(rq);
> +
> +out:
> +	rq_unlock_irqrestore(rq, &rf);
> +}
> +
> +static inline void fair_server_watchdog_start(struct rq *rq)
> +{
> +	if (rq->fair_server_wd_running || rq->fair_server_active)
> +		return;
> +
> +	timer_setup(&rq->fair_server_wd, fair_server_watchdog, 0);
> +	rq->fair_server_wd.expires = jiffies +
> FAIR_SERVER_WATCHDOG_INTERVAL;
> +	add_timer_on(&rq->fair_server_wd, cpu_of(rq));
> +	rq->fair_server_active = 0;
> +	rq->fair_server_wd_running = 1;
> +}
> +
> +static inline void fair_server_watchdog_stop(struct rq *rq, bool
> stop_server) +{
> +	if (!rq->fair_server_wd_running && !stop_server)
> +		return;
> +
> +	del_timer(&rq->fair_server_wd);
> +	rq->fair_server_wd_running = 0;
> +
> +	if (stop_server && rq->fair_server_active) {
> +		dl_server_stop(&rq->fair_server);
> +		rq->fair_server_active = 0;
> +	}
> +}
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -5515,7 +5562,7 @@ enqueue_task_fair(struct rq *rq, struct
> task_struct *p, int flags) util_est_enqueue(&rq->cfs, p);
>  
>  	if (!rq->cfs.h_nr_running)
> -		dl_server_start(&rq->fair_server);
> +		fair_server_watchdog_start(rq);
>  
>  	/*
>  	 * If in_iowait is set, the code below may not trigger any
> cpufreq @@ -5670,7 +5717,7 @@ static void dequeue_task_fair(struct rq
> *rq, struct task_struct *p, int flags) 
>  dequeue_throttle:
>  	if (!rq->cfs.h_nr_running)
> -		dl_server_stop(&rq->fair_server);
> +		fair_server_watchdog_stop(rq, true);
>  
>  	util_est_dequeue(&rq->cfs, p, task_sleep);
>  	hrtick_update(rq);
> @@ -7123,6 +7170,7 @@ done: __maybe_unused;
>  		hrtick_start_fair(rq, p);
>  
>  	update_misfit_status(p, rq);
> +	fair_server_watchdog_stop(rq, false);
>  
>  	return p;
>  
> @@ -7178,6 +7226,8 @@ void fair_server_init(struct rq *rq)
>  	dl_se->dl_period = 20 * TICK_NSEC;
>  
>  	dl_server_init(dl_se, rq, fair_server_has_tasks,
> fair_server_pick); +
> +	rq->fair_server_wd_running = 0;
>  }
>  
>  /*
> @@ -7192,6 +7242,9 @@ static void put_prev_task_fair(struct rq *rq,
> struct task_struct *prev) cfs_rq = cfs_rq_of(se);
>  		put_prev_entity(cfs_rq, se);
>  	}
> +
> +	if (rq->cfs.h_nr_running)
> +		fair_server_watchdog_start(rq);
>  }
>  
>  /*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bf8c9c07705c9..1e1a5436be725 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -375,6 +375,7 @@ extern void dl_server_init(struct sched_dl_entity
> *dl_se, struct rq *rq, dl_server_has_tasks_f has_tasks,
>  		    dl_server_pick_f pick);
>  
> +#define FAIR_SERVER_WATCHDOG_INTERVAL (HZ >> 1)
>  extern void fair_server_init(struct rq *);
>  
>  #ifdef CONFIG_CGROUP_SCHED
> @@ -962,6 +963,9 @@ struct rq {
>  	struct dl_rq		dl;
>  
>  	struct sched_dl_entity	fair_server;
> +	int			fair_server_active;
> +	struct timer_list	fair_server_wd;
> +	int			fair_server_wd_running;
>  
>  #ifdef CONFIG_FAIR_GROUP_SCHED
>  	/* list of leaf cfs_rq on this CPU: */

