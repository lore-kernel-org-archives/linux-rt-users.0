From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patchlet] locking/rt: fix rt_read_lock() lockdep annotation.
Date: Fri, 9 May 2014 10:39:10 -0400
Message-ID: <20140509103910.64544b48@gandalf.local.home>
References: <20140503170110.GA10652@linutronix.de>
	<1399449247.5142.14.camel@marge.simpson.net>
	<20140507094807.229d88d8@gandalf.local.home>
	<1399471264.5248.5.camel@marge.simpson.net>
	<1399472415.5248.15.camel@marge.simpson.net>
	<20140509132713.GH29014@linutronix.de>
	<1399645080.31219.14.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Mike Galbraith <umgwanakikbuti@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-outbound-snat.email.rr.com ([107.14.166.228]:13760 "EHLO
	cdptpa-oedge-vip.email.rr.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753459AbaEIOjM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 9 May 2014 10:39:12 -0400
In-Reply-To: <1399645080.31219.14.camel@marge.simpson.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 09 May 2014 16:18:00 +0200
Mike Galbraith <umgwanakikbuti@gmail.com> wrote:


> No, I had done the right thing in the first patch, as confirmed by what
> landed in 12-rt.  The lock ain't "shared" is why I whacked it.  You saw
> what happened to my confidence in that logic when Steven spoke.  Eek :)

I was confused because the patch didn't apply to my tree :-)

-- Steve
