From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 3/3] sched: terminate newidle balancing once at least one task has moved over
Date: Tue, 24 Jun 2008 10:50:11 +1000
Message-ID: <200806241050.12028.nickpiggin@yahoo.com.au>
References: <20080623225645.31515.36393.stgit@lsg.lsg.lab.novell.com> <20080623230450.31515.75112.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, rostedt@goodmis.org, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, peterz@infradead.org,
	linux-rt-users@vger.kernel.org, dbahi@novell.com
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp120.mail.mud.yahoo.com ([209.191.84.77]:35414 "HELO
	smtp120.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751241AbYFXAuX (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Jun 2008 20:50:23 -0400
In-Reply-To: <20080623230450.31515.75112.stgit@lsg.lsg.lab.novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tuesday 24 June 2008 09:04, Gregory Haskins wrote:
> Inspired by Peter Zijlstra.

Is this really getting tested well? Because at least for SCHED_OTHER
tasks, the newidle balancer is still supposed to be relatively
conservative and not over balance too much. By the time you have
done all this calculation and reached here, it will be a loss to only
move one task if you could have moved two and halved your newidle
balance rate...

> Signed-off-by: Gregory Haskins <ghaskins@novell.com>
> ---
>
>  kernel/sched.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 3efbbc5..c8e8520 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2775,6 +2775,10 @@ static int move_tasks(struct rq *this_rq, int
> this_cpu, struct rq *busiest, max_load_move - total_load_moved,
>  				sd, idle, all_pinned, &this_best_prio);
>  		class = class->next;
> +
> +		if (idle == CPU_NEWLY_IDLE && this_rq->nr_running)
> +			break;
> +
>  	} while (class && max_load_move > total_load_moved);
>
>  	return total_load_moved > 0;
>
> --
