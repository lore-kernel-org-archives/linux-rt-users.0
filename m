From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: Does anyone use CONFIG_TINY_PREEMPT_RCU?
Date: Tue, 13 Nov 2012 13:20:34 -0800
Message-ID: <20121113212034.GD2489@linux.vnet.ibm.com>
References: <20121113004906.GA10557@linux.vnet.ibm.com>
 <201211132122.30259.tim01@vlsi.informatik.tu-darmstadt.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	mingo@elte.hu, laijs@cn.fujitsu.com, dipankar@in.ibm.com,
	akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
	josh@joshtriplett.org, niv@us.ibm.com, tglx@linutronix.de,
	peterz@infradead.org, rostedt@goodmis.org, Valdis.Kletnieks@vt.edu,
	dhowells@redhat.com, edumazet@google.com, darren@dvhart.com,
	fweisbec@gmail.com, sbw@mit.edu, patches@linaro.org
To: Tim Sander <tim01@vlsi.informatik.tu-darmstadt.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e39.co.us.ibm.com ([32.97.110.160]:58353 "EHLO
	e39.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751469Ab2KMV2X (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 16:28:23 -0500
Received: from /spool/local
	by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Tue, 13 Nov 2012 14:28:23 -0700
Content-Disposition: inline
In-Reply-To: <201211132122.30259.tim01@vlsi.informatik.tu-darmstadt.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Tue, Nov 13, 2012 at 09:22:29PM +0100, Tim Sander wrote:
> Hi Paul
> > I know of people using TINY_RCU, TREE_RCU, and TREE_PREEMPT_RCU, but I
> > have not heard of anyone using TINY_PREEMPT_RCU for whom TREE_PREEMPT_RCU
> > was not a viable option (in contrast, the people running Linux on
> > tiny-memmory systems typically use TINY_RCU).  Of course, if no one
> > really needs it, the proper thing to do is to remove it.
> > 
> > So, if you need TINY_PREEMPT_RCU, please let me know.  Otherwise, I will
> > remove it, probably in the 3.9 timeframe.
> I am using TINY_PREEMPT_RCU on the i.mx35 platform. I am currently on 3.4-rt 
> since the 3.6 compile failed due to for my config? Some strange device tree 
> stuff which i haven't had the time to figure out why.

OK, how much memory does your device have?

							Thanx, Paul

