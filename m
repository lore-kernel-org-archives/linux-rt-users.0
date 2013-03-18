From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: workqueue code needing preemption disabled
Date: Mon, 18 Mar 2013 14:57:30 -0400
Message-ID: <1363633050.25967.210.camel@gandalf.local.home>
References: <1363617383.25967.152.camel@gandalf.local.home>
	 <20130318160652.GA20133@mtj.dyndns.org>
	 <1363623799.25967.172.camel@gandalf.local.home>
	 <1363624020.25967.175.camel@gandalf.local.home>
	 <1363624243.25967.178.camel@gandalf.local.home>
	 <20130318164351.GA21516@mtj.dyndns.org>
	 <1363626487.25967.186.camel@gandalf.local.home>
	 <20130318182130.GA3042@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Clark Williams <clark@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Tejun Heo <tj@kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:16426 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab3CRS5b (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 18 Mar 2013 14:57:31 -0400
In-Reply-To: <20130318182130.GA3042@htj.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, 2013-03-18 at 11:21 -0700, Tejun Heo wrote:

> I've been thinking about it and AFAICS the only way that BUG_ON()
> could trigger from preemption is if preemption happens while the
> idle_list head is becoming or stopping being empty.
> ie. pool->worklist is half updated so list_empty() isn't true but the
> first next entry is already pointing back to itself.  If there's a
> crashdump, it shouldn't be too difficult to verify and wrapping the
> above two functions should resolve it.

I like the theory, but it has one flaw. I agree that the update should
be wrapped in preempt_disable() but since this bug happens on the same
CPU, the state of the list will be the same when it was preempted to
when it bugged. That said:

static inline int list_empty(const struct list_head *head)
{
	return head->next == head;
}

That means when the task was preempted, head->next will either be
pointing to the next element or back to the list head. Which means if we
get preempted while updating the list, it will either see the head->next
== head or head->next == the next element.

first_worker() returns list_first_entry() which returns head->next. I
can't see how it would see the list_head and have list_empty() return
false.

-- Steve


