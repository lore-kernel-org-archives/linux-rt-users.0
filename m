From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [v4.4-rt PATCH] rt: trace: add rcuidle version macro for
 preemptirqsoff_hist and hrtimer_interrupt
Date: Wed, 9 Mar 2016 15:46:23 +0100
Message-ID: <20160309144623.GA25186@linutronix.de>
References: <1457394338-11865-1-git-send-email-yang.shi@windriver.com>
 <56DE88FC.5080500@linutronix.de>
 <20160308141713.30814feb@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yang Shi <yang.shi@windriver.com>, tglx@linutronix.de,
	linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56741 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679AbcCIOq3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 9 Mar 2016 09:46:29 -0500
Content-Disposition: inline
In-Reply-To: <20160308141713.30814feb@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2016-03-08 14:17:13 [-0500]:

>> > index 6122e42..37f6eb8 100644
>> > --- a/include/trace/events/hist.h
>> > +++ b/include/trace/events/hist.h
>> > @@ -9,6 +9,7 @@
>> >  
>> >  #if !defined(CONFIG_PREEMPT_OFF_HIST) && !defined(CONFIG_INTERRUPT_OFF_HIST)
>> >  #define trace_preemptirqsoff_hist(a, b)
>> > +#define trace_preemptirqsoff_hist_rcuidle(a, b)
>> >  #else
>> >  TRACE_EVENT(preemptirqsoff_hist,  
>> 
>> I have this piece already in my tree.
>
>I don't see it in your git repo.
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git/commit/?h=linux-4.4.y-rt&id=bb2d8f27070df470619f216b02261b10dcc5161d

Sebastian
