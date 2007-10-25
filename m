From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 2/3] RT: Cache cpus_allowed weight for optimizing migration
Date: Thu, 25 Oct 2007 15:58:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710251556130.5152@gandalf.stny.rr.com>
References: <20071025144456.19876.94333.stgit@novell1.haskins.net>
 <20071025144628.19876.35583.stgit@novell1.haskins.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dmitry Adamushko <dmitry.adamushko@gmail.com>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Ingo Molnar <mingo@elte.hu>, Darren Hart <dvhltc@us.ibm.com>
To: Gregory Haskins <ghaskins@novell.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-05.nyroc.rr.com ([24.24.2.59]:44769 "EHLO
	ms-smtp-05.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755386AbXJYT6L (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 25 Oct 2007 15:58:11 -0400
In-Reply-To: <20071025144628.19876.35583.stgit@novell1.haskins.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
> @@ -5371,7 +5372,13 @@ int set_cpus_allowed(struct task_struct *p, cpumask_t new_mask)
>  		goto out;
>  	}
>
> -	p->cpus_allowed = new_mask;
> +	if (p->sched_class->set_cpus_allowed)
> +		p->sched_class->set_cpus_allowed(p, new_mask);
> +	else {
> +		p->cpus_allowed    = new_mask;
> +		p->nr_cpus_allowed = cpus_weight(new_mask);
> +	}
> +

OK, forget everything I said on this topic. I must have replied while low
on caffeine.

I see here that you do the set_cpus_allowed code if defined _ELSE_ you
just update the weight.

So you do do what I asked.

/me slaps himself to wakeup.

-- Steve
