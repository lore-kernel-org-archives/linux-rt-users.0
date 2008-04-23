From: "Dmitry Adamushko" <dmitry.adamushko@gmail.com>
Subject: Re: [PATCH 1/2] sched: push rt tasks only if newly activated tasks have been added
Date: Wed, 23 Apr 2008 12:23:25 +0200
Message-ID: <b647ffbd0804230323s20d25697qcf80ca9996e143a7@mail.gmail.com>
References: <20080421180747.4560.67794.stgit@novell1.haskins.net>
	 <20080421181015.4560.7658.stgit@novell1.haskins.net>
	 <b647ffbd0804220830h6524e788n1467b027bc5bc4d2@mail.gmail.com>
	 <Pine.LNX.4.58.0804221144410.21511@gandalf.stny.rr.com>
	 <b647ffbd0804230105u7966ed06wd4ed248f59132849@mail.gmail.com>
	 <b647ffbd0804230253i32f48fcgb5dc7cf5b55607ac@mail.gmail.com>
	 <480ED122.BA47.005A.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>, mingo@elte.hu,
	chinang.ma@intel.com, suresh.b.siddha@intel.com,
	arjan@linux.intel.com, willy@linux.intel.com,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: "Gregory Haskins" <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.181]:50443 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750999AbYDWKX1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Apr 2008 06:23:27 -0400
Received: by wa-out-1112.google.com with SMTP id m16so4528102waf.23
        for <linux-rt-users@vger.kernel.org>; Wed, 23 Apr 2008 03:23:25 -0700 (PDT)
In-Reply-To: <480ED122.BA47.005A.0@novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

2008/4/23 Gregory Haskins <ghaskins@novell.com>:
> [ ... ]
>
>  I think we can simplify this further.  We really only need to push here if we are not going to reschedule anytime soon (probably white-space damaged):
>
>
>  --- a/kernel/sched_rt.c
>
> +++ b/kernel/sched_rt.c
>  @@ -1058,11 +1058,14 @@ static void post_schedule_rt(struct rq *rq)
>         }
>   }
>
>  -
>  +/*
>  + * If we are not running and we are not going to reschedule soon, we should
>  + * try to push tasks away now
>  + */
>
>  static void task_wake_up_rt(struct rq *rq, struct task_struct *p)
>   {
>         if (!task_running(rq, p) &&
>  -           (p->prio >= rq->rt.highest_prio) &&
>  +           !test_tsk_thread_flag(rq->curr, TIF_NEED_RESCHED) &&
>             rq->rt.overloaded)
>                 push_rt_tasks(rq);
>   }


It's somewhat suboptimal as it doesn't guarantee that 'p' gets control next.

e.g. 2 tasks (T0 and T1) have been woken up before an actual
re-schedule takes place. Even if T1 is of lower prio than T0,
task_wake_up_rt() will see the NEED_RESCHED flag and bail out while it
would make sense at this moment to push T1 off this cpu.


p.s. hope you are better today. get well! :-)


-- 
Best regards,
Dmitry Adamushko
