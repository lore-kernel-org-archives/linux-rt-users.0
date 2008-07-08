From: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [PATCH 2/3] sched: terminate newidle balancing once at least one task has moved over
Date: Tue, 8 Jul 2008 15:00:17 +1000
Message-ID: <200807081500.18245.nickpiggin@yahoo.com.au>
References: <20080627202444.3829.21595.stgit@lsg.lsg.lab.novell.com> <20080627202955.3829.78937.stgit@lsg.lsg.lab.novell.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: mingo@elte.hu, peterz@infradead.org, npiggin@suse.de,
	rostedt@goodmis.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp116.mail.mud.yahoo.com ([209.191.84.165]:47405 "HELO
	smtp116.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751276AbYGHFAl (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 8 Jul 2008 01:00:41 -0400
In-Reply-To: <20080627202955.3829.78937.stgit@lsg.lsg.lab.novell.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Saturday 28 June 2008 06:29, Gregory Haskins wrote:
> Inspired by Peter Zijlstra.
>
> Signed-off-by: Gregory Haskins <ghaskins@novell.com>

What happened to the feedback I sent about this?

It is still nack from me.


> ---
>
>  kernel/sched.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/kernel/sched.c b/kernel/sched.c
> index 56722b1..0b9f90e 100644
> --- a/kernel/sched.c
> +++ b/kernel/sched.c
> @@ -2863,6 +2863,10 @@ static int move_tasks(struct rq *this_rq, int
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
