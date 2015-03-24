From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH RT 2/4] Revert "timers: do not raise softirq
 unconditionally"
Date: Tue, 24 Mar 2015 19:10:34 +0100
Message-ID: <20150324181034.GD1321@linutronix.de>
References: <20150317163541.080310081@goodmis.org>
 <20150317163617.218582800@goodmis.org>
 <20150317163551.3093b6c2@gandalf.local.home>
 <1426753029.4168.80.camel@gmail.com>
 <20150319122611.0d002d48@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Galbraith <umgwanakikbuti@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	John Kacur <jkacur@redhat.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:48387 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753910AbbCXSKk (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 24 Mar 2015 14:10:40 -0400
Content-Disposition: inline
In-Reply-To: <20150319122611.0d002d48@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2015-03-19 12:26:11 [-0400]:

>On Thu, 19 Mar 2015 09:17:09 +0100
>Mike Galbraith <umgwanakikbuti@gmail.com> wrote:
>
>
>> (aw crap, let's go shopping)... so why is the one in timer.c ok?
>
>It's not. Sebastian, you said there were no other cases of rt_mutexes
>being taken in hard irq context. Looks like timer.c has one.

If you refer to switch_timer_base() then this one is not taken in
hard-irq context. The callchain is:

lock_timer_base() (with spin_lock_irqsave(&base->lock, *flags) which
                   makes it a sleeping lock or lockdep would scream)
  -> switch_timer_base()
     -> spin_trylock() (not in hardirq conteyt)

>So perhaps the real fix is to get that special case of ownership in
>hard interrupt context?

I'm really not sure we want to keep doing this.

>
>-- Steve

Sebastian
