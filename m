From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] 3.6.1-rt1
Date: Tue, 09 Oct 2012 13:13:53 -0400
Message-ID: <1349802833.24256.25.camel@gandalf.local.home>
References: <alpine.LFD.2.02.1210091535140.10988@ionos>
	 <1349795389.24256.20.camel@gandalf.local.home>
	 <alpine.LFD.2.02.1210091811540.10988@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Carsten Emde <cbe@osadl.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:31958 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373Ab2JIRN4 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2012 13:13:56 -0400
In-Reply-To: <alpine.LFD.2.02.1210091811540.10988@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, 2012-10-09 at 18:19 +0200, Thomas Gleixner wrote:
>  
> > I've started looking at playing with the NAPI code again, and trying to
> > see if I can add an ENAPI interface (Even Newer API), where the driver
> > uses its own interrupt thread, and instead of having the polling in the
> > network softirq, it can do the polling in its own thread.
> 
> It's pretty close to the behaviour I enforced with this change. Let's
> play with that and figure out what influence it has on the network
> throughput performance on RT. That needs probably a different
> scheduling scheme than what Carsten needs for his deterministic
> behaviour.
> 

I was actually looking at the change for mainline, not for -rt ;-)

-- Steve


