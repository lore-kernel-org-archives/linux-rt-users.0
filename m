From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [v4.4-rt PATCH] rt: trace: add rcuidle version macro for
 preemptirqsoff_hist and hrtimer_interrupt
Date: Wed, 9 Mar 2016 10:08:29 -0500
Message-ID: <20160309100829.334edfe4@gandalf.local.home>
References: <1457394338-11865-1-git-send-email-yang.shi@windriver.com>
	<56DE88FC.5080500@linutronix.de>
	<20160308141713.30814feb@gandalf.local.home>
	<20160309144623.GA25186@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Yang Shi <yang.shi@windriver.com>, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:34157 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751316AbcCIPId (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2016 10:08:33 -0500
In-Reply-To: <20160309144623.GA25186@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 9 Mar 2016 15:46:23 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2016-03-08 14:17:13 [-0500]:
> 
> >> > index 6122e42..37f6eb8 100644
> >> > --- a/include/trace/events/hist.h
> >> > +++ b/include/trace/events/hist.h
> >> > @@ -9,6 +9,7 @@
> >> >  
> >> >  #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
> >> >  #define trace_preemptirqsoff_hist(a, b)
> >> > +#define trace_preemptirqsoff_hist_rcuidle(a, b)
> >> >  #else
> >> >  TRACE_EVENT(preemptirqsoff_hist,    
> >> 
> >> I have this piece already in my tree.  
> >
> >I don't see it in your git repo.  
> https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.4.y-rt&id=bb2d8f27070df470619f216b02261b10dcc5161d

OK, *now* it's in your tree ;-)

-- Steve
