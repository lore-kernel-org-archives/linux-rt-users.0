From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.0.14-rt31 - ksoftirq running wild - FEC ethernet
 driver to blame?
Date: Tue, 17 Jan 2012 09:42:05 -0500
Message-ID: <1326811325.17534.48.camel@gandalf.stny.rr.com>
References: <1324525237.5916.114.camel@gandalf.stny.rr.com>
	 <201201121757.25467.tim.sander@hbm.com>
	 <201201131042.08323.tim.sander@hbm.com>
	 <201201171527.19165.tstone@iss.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Tim Sander <tim.sander@hbm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
To: Tim Sander <tstone@iss.tu-darmstadt.de>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.124]:46658 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab2AQOmI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 17 Jan 2012 09:42:08 -0500
In-Reply-To: <201201171527.19165.tstone@iss.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-01-17 at 15:27 +0100, Tim Sander wrote:
> Hi
> 
> I have further input to the ksoftirq/0 using as much cpu as available on a
> arm i.mx pcm043 platform without load with a 3.0.14-rt31 kernel and some local 
> platform adaptions.
> 
> > I was thinking about this ksoftirq0 running on max cpu. The context:
> > > > > and the running wild ksoftirqd0 most probably after the kernel
> > > > > message: "sched: RT throttling activated"

> I think that the message  "sched: RT throttling activated" and the ksoftirqd 
> running on full cpu are possibly to seperate errors. Btw. is there a way to 
> find out which processes where conuming this timeframe. It would be nice to add 
> info output which processes caused the throtteling. Is it possible to get this 
> information out of the scheduler structure?
> 

Peter,

This is your territory.

-- Steve


