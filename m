From: Thavatchai Makphaibulchoke <thavatchai.makpahibulchoke@hp.com>
Subject: Re: [PATCH 3.14.25-rt22 1/2] rtmutex Real-Time Linux: Fixing kernel
 BUG at kernel/locking/rtmutex.c:997!
Date: Mon, 23 Feb 2015 17:16:27 -0700
Message-ID: <54EBC2DB.3050904@hp.com>
References: <1424395866-81589-1-git-send-email-tmac@hp.com>	<1424395866-81589-2-git-send-email-tmac@hp.com> <20150223133719.2b7c604e@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>,
	Thavatchai Makphaibulchoke <tmac@hp.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from g9t1613g.houston.hp.com ([15.240.0.71]:48611 "EHLO
	g9t1613g.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBXARY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 23 Feb 2015 19:17:24 -0500
In-Reply-To: <20150223133719.2b7c604e@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 02/23/2015 11:37 AM, Steven Rostedt wrote:
> 
> OK, I believe I understand the issue. Perhaps it would be much better
> to create a fake task per CPU that we use when grabbing locks in
> interrupt mode. And make these have a priority of 0 (highest), since
> they can not be preempted, they do have such a priority.
> 
> Then in the fast trylock and unlock code, we can add:
> 
> 	struct task_struct *curr = current;
> 
> 	if (unlikely(in_irq()))
> 		curr = this_cpu_read(irq_task);
> 
> This way the priority inheritance will stop when it hits this task (no
> need to boost a task of highest priority), and we can leave that code
> alone.
> 

Thanks again for the comments and suggestion.

Yes, creating a per cpu fake task was one of the alternative considered.
 I believe one of the reasons I did not purse is the amount of extra
storage it requires (sizeof(struct task_struct) * number of cpus.
Though the changes may not be as intrusive as the one I sent, some are
still required, mainly with current (one in particular came to mind is
in wakeup_next-watier()).

If I'm not mistaken, another reason could also be due to the rate of the
timer interrupt, in the case that the mutex is highly contested IH could
stall the non-real-time requester for a long time, even to the point of
the cpu is perceived as hung.

Anyway, I'll retry the fake task approach a try and report back if there
is any issue.

Thanks,
Mak.


> -- Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
