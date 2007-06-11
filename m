From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: v2.6.21.4-rt11
Date: Mon, 11 Jun 2007 07:44:02 -0700
Message-ID: <20070611144401.GA9102@linux.vnet.ibm.com>
References: <20070609210507.GA29194@elte.hu> <20070611011954.GG27982@linux.vnet.ibm.com> <20070611073634.GB32446@elte.hu>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:42816 "EHLO e2.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483AbXFKOoI (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Jun 2007 10:44:08 -0400
Content-Disposition: inline
In-Reply-To: <20070611073634.GB32446@elte.hu>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jun 11, 2007 at 09:36:34AM +0200, Ingo Molnar wrote:
> 
> * Paul E. McKenney <paulmck@linux.vnet.ibm.com> wrote:
> 
> > 2.6.21.4-rt12 boots on 4-CPU Opteron and passes several hours of 
> > rcutorture.  However, if I simply do "modprobe rcutorture", the kernel 
> > threads do not spread across the CPUs as I would expect them to, even 
> > given CFS.  Instead, the readers all stack up on a single CPU, and I 
> > have to use the "taskset" command to spread them out manually.  Is 
> > there some config parameter I am missing out on?
> 
> hm, what affinity do they start out with? Could they all be pinned to 
> CPU#0 by default?

They start off with affinity masks of 0xf on a 4-CPU system.  I would
expect them to load-balance across the four CPUs, but they stay all
on the same CPU until long after I lose patience (many minutes).

Since there are eight readers, I use the following commands:

	taskset -p 3 pid1
	taskset -p 3 pid2
	taskset -p 6 pid3
	taskset -p 6 pid4
	taskset -p c pid5
	taskset -p c pid6
	taskset -p 9 pid7
	taskset -p 9 pid8

where the "pidn" are all replaced by the pids of the torture readers.

Before I do this, the processes are all sharing a single CPU.  After I
do this, they are spread reasonably nicely over the CPUs.  I do need to
allow some migration in order to fully test the realtime RCU variants
in the various preemption scenarios.

							Thanx, Paul
