From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC][PATCH RT] rtmutex: Use raw_spin_trylock() in
 rt_mutex_slowlock() to ease possible live locks
Date: Thu, 20 Dec 2012 13:02:01 -0500
Message-ID: <1356026521.5896.55.camel@gandalf.local.home>
References: <1355967118.5896.52.camel@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <cbe@osadl.org>,
	Clark Williams <clark@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Mike Galbraith <bitbucket@online.de>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:24621 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505Ab2LTSCF (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 Dec 2012 13:02:05 -0500
In-Reply-To: <1355967118.5896.52.camel@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2012-12-19 at 20:31 -0500, Steven Rostedt wrote:

Talking with Thomas, the proper solution is:

> Then we have this lovely code:
> 
> block/blk-ioc.c: put_io_context_active()
> 
> retry:
>         spin_lock_irqsave_nested(&ioc->lock, flags, 1);
>         hlist_for_each_entry(icq, n, &ioc->icq_list, ioc_node) {
>                 if (icq->flags & ICQ_EXITED)
>                         continue;
>                 if (spin_trylock(icq->q->queue_lock)) {
>                         ioc_exit_icq(icq);
>                         spin_unlock(icq->q->queue_lock);
>                 } else {
>                         spin_unlock_irqrestore(&ioc->lock, flags);
>                         cpu_relax();

s/cpu_relax/cpu_chill/

-- Steve

>                         goto retry;
>                 }
>         }
> 


