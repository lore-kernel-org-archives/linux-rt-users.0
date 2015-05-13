From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [OSADL QA 3.18.9-rt5 #1]
Date: Wed, 13 May 2015 11:23:56 -0400
Message-ID: <20150513112356.1e1ebfb8@gandalf.local.home>
References: <55245FC8.9090509@osadl.org>
	<5526AE86.7030708@linutronix.de>
	<20150410123634.GA3057@linutronix.de>
	<20150511201506.29a5c3e2@gandalf.local.home>
	<20150513081236.GA21106@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Carsten Emde <C.Emde@osadl.org>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay0009.hostedemail.com ([216.40.44.9]:41437 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S934488AbbEMPYA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 May 2015 11:24:00 -0400
In-Reply-To: <20150513081236.GA21106@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 13 May 2015 10:12:36 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2015-05-11 20:15:06 [-0400]:
> 
> >I'm backporting this to the stable releases, and I'm a bit worried
> >about the above comment. The new Scheduler IPI code uses work queues and
> >requires it to be done in a hard irq.
> 
> The IPI part is only done for the high-prio which is only used by NOHZ.
> Everyone else gets in via softiq as we did it before.
> 

My push/pull RT tasks via IPI, uses the irq_work to do this. It has
nothing to do with NOHZ, and will cause serious latencies if it is done
by softirq.

-- Steve
