From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: Enabling function trace on call during module init
Date: Fri, 11 Oct 2013 08:35:53 -0400
Message-ID: <20131011083553.3557f104@gandalf.local.home>
References: <CA+P49ArN2Nki5oy5MdwKGdcCUYv4i7oEJkypkKWB618T9nHvug@mail.gmail.com>
	<20130907204811.5d52a6b1@gandalf.local.home>
	<20131011101531.GD6983@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Venkat Subbiah <venkat.mlist@gmail.com>,
	linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.226]:26559 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751968Ab3JKMfy (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 11 Oct 2013 08:35:54 -0400
In-Reply-To: <20131011101531.GD6983@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 11 Oct 2013 12:15:31 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> * Steven Rostedt | 2013-09-07 20:48:11 [-0400]:
> 
> >You wont be able to trace any function that is annotated with "__init",
> >or even "__exit". That's because the init section does not have a
> >standard way of cleaning them up (for boot, modules are different, but
> >are still affected by it).
> 
> Is this even required / wanted? Usually the module just hooks itself
> into subsystem like pci_register_driver() and is usually not
> interresting. The interresting part starts from ->probe() (I think) and
> this is captured, right?

Only if the ->probe() is not marked __init

There's a white list of sections that the function tracer traces. See
is_mcounted_section_name() in scripts/recordmcount.c.

-- Steve
