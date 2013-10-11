From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Enabling function trace on call during module init
Date: Fri, 11 Oct 2013 12:15:31 +0200
Message-ID: <20131011101531.GD6983@linutronix.de>
References: <CA+P49ArN2Nki5oy5MdwKGdcCUYv4i7oEJkypkKWB618T9nHvug@mail.gmail.com>
 <20130907204811.5d52a6b1@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Venkat Subbiah <venkat.mlist@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:60254 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752191Ab3JKKPd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 06:15:33 -0400
Content-Disposition: inline
In-Reply-To: <20130907204811.5d52a6b1@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Steven Rostedt | 2013-09-07 20:48:11 [-0400]:

>You wont be able to trace any function that is annotated with "__init",
>or even "__exit". That's because the init section does not have a
>standard way of cleaning them up (for boot, modules are different, but
>are still affected by it).

Is this even required / wanted? Usually the module just hooks itself
into subsystem like pci_register_driver() and is usually not
interresting. The interresting part starts from ->probe() (I think) and
this is captured, right?

>As ftrace modifies code, and it modifies locations of functions, it can
>not safely modify code that suddenly disappeared without it knowing it,
>otherwise you may end up with broken NIC cards.
Hmmm. This sounds like you know what you are talking about :)

>-- Steve

Sebastian
