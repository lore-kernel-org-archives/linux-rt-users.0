From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: kernel-rt rcuc lock contention problem
Date: Thu, 29 Jan 2015 10:11:23 -0800
Message-ID: <20150129181123.GF19109@linux.vnet.ibm.com>
References: <20150126141403.469dc92f@redhat.com>
 <20150127203752.GD19109@linux.vnet.ibm.com>
 <20150128015508.GA12233@amt.cnet>
 <20150128180335.GR19109@linux.vnet.ibm.com>
 <20150128182512.GB1259@amt.cnet>
 <20150128185552.GT19109@linux.vnet.ibm.com>
 <20150129120644.1d052e16@gandalf.local.home>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	Luiz Capitulino <lcapitulino@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e31.co.us.ibm.com ([32.97.110.149]:46556 "EHLO
	e31.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751615AbbA2SR6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 29 Jan 2015 13:17:58 -0500
Received: from /spool/local
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 29 Jan 2015 11:17:58 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
	by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id E32871FF0049
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2015 11:09:06 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id t0TIHtx542139882
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2015 11:18:03 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id t0TIHLVk007065
	for <linux-rt-users@vger.kernel.org>; Thu, 29 Jan 2015 11:17:22 -0700
Content-Disposition: inline
In-Reply-To: <20150129120644.1d052e16@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Jan 29, 2015 at 12:06:44PM -0500, Steven Rostedt wrote:
> On Wed, 28 Jan 2015 10:55:53 -0800
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
> > Then your only hope is to prevent the host (and other guests) from
> > preempting the real-time guest.
> 
> Right!
> 
> I think there's a miscommunication here.

I can easily believe that!

> Basically what is needed is to run the RT guest on a CPU by itself. We
> can all agree on that. That guest runs at a high priority where nothing
> should preempt it. We should enable NO_HZ_FULL, and move as much off of
> that CPU as possible (including rcu callbacks).
> 
> I'm not sure if the code does this or not, but I believe it does. When
> we enter the guest, the host should be in an RCU quiescent state, where
> RCU will ignore the CPU that is running the guest. Remember, we are only
> talking about interactions of the host, not the workings of the guest.

NO_HZ_FULL will automatically tell RCU about the guest-execution quiescent
state because the guest is seen by the host as user-mode execution.
(Right?  Or is KVM treating this specially such that RCU doesn't see
guest execution as a quiescent state?  I think this is currently handled
correctly, because if it wasn't, you would get RCU CPU stall warning
messages.)

> Once this isolation happens, then the guest should be running in a
> state that it could handle RT reaction times for its own processes (if
> the guest OS supports it). The guest shouldn't be preempted by anything
> unless it does something that requires a service (interacting with the
> network or other baremetal device), then it will need to do the same
> things that any RT task must do.

Agreed!

> I think all this is feasible.

The one thing that gives me pause is the high contention on the root
(AKA only) rcu_node structure's ->lock field.  If this persists, one
thing to try would be to build with CONFIG_RCU_FANOUT_LEAF=8 (or 4).
If that helps, it would be worthwhile to do some tracing or lock
profiling to see about reducing the ->lock contention for the default
CONFIG_RCU_FANOUT_LEAF=16.

My first thought when I saw the high contention was to introduce
funnel locking for grace-period start, but that is unlikely to help
in cases where there is only one rcu_node structure.  ;-)

							Thanx, Paul

