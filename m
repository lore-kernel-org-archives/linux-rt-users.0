From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH] rcutree: Fix v3.4-rc2-rt2 build break
Date: Thu, 12 Apr 2012 16:11:53 -0700
Message-ID: <20120412231153.GG2394@linux.vnet.ibm.com>
References: <1334155379-18088-1-git-send-email-jkacur@redhat.com>
 <alpine.LFD.2.02.1204122142180.2542@ionos>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Kacur <jkacur@redhat.com>,
	lkml <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:52375 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab2DLXMC (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 12 Apr 2012 19:12:02 -0400
Received: from /spool/local
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-rt-users@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
	Thu, 12 Apr 2012 17:12:02 -0600
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1204122142180.2542@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Apr 12, 2012 at 09:46:16PM +0200, Thomas Gleixner wrote:
> On Wed, 11 Apr 2012, John Kacur wrote:
>=20
> > Fix build break of the following types.
> >=20
> > linux-rt/kernel/rcutree_plugin.h: In function =E2=80=98print_cpu_st=
all_fast_no_hz=E2=80=99:
> > linux-rt/kernel/rcutree_plugin.h:2195: error: =E2=80=98rcu_idle_gp_=
timer=E2=80=99 undeclared (first use in this function)
> > linux-rt/kernel/rcutree_plugin.h:2195: error: (Each undeclared iden=
tifier is reported only once
> > linux-rt/kernel/rcutree_plugin.h:2195: error: for each function it =
appears in.)
> >=20
> > The build break only occurs with the PREEMPT_RT_FULL patch applied,=
 however
> > the patch is meant to go upstream and be applied to v3.4-rc2 as wel=
l because
> > it makes the code more legible there, and will reduce the number of=
 places
> > where #ifdef PREEMPT_RT_FULL is required should that go upstream so=
meday.

OK, I will bite...

What is PREEMPT_RT_FULL doing to make rcu_idle_gp_timer, which is under
CONFIG_RCU_FAST_NO_HZ, inaccessible to print_cpu_stall_fast_no_hz() whi=
ch
is under both CONFIG_RCU_FAST_NO_HZ and CONFIG_RCU_CPU_STALL_INFO?

> -ENOPARSE
>=20
> I really have no idea what the patch is solving and which particular
> combination of config items is causing the above.
>=20
> If you think that the patch should go upstream then please send a
> separate one with a changelog which explains the simplifcation.
>=20
> I agree that this ifdef maze can do with simplification, but providin=
g
> a changelog which tells nothing at all does not make it easier to gro=
k
> the problem and understand what's simplified.

I must confess that I have been considering re-organizing the #ifdefs
in kernel/rcutree_plugin.h so that all variants of a given function are
adjacent, but I have not yet felt quite masochistic enough to insert
quite that many extra #ifdefs.

The current organization is as follows:

o	Boot-time announce functions.

o	A large number of plugin functions that have real code
	for CONFIG_TREE_PREEMPT_RCU and trivial definitions for
	CONFIG_TREE_RCU.  In the 3.3 kernel, this region extends from line
	73 to line 1135, and used to be the whole point of this file.
	This region contains additional #ifdefs for CONFIG_HOTPLUG_CPU,
	CONFIG_RCU_BOOST (which cannot go into the next region because
	they are used in this region) CONFIG_RCU_CPU_STALL_VERBOSE,
	and CONFIG_PROVE_LOCKING.

o	Another set of plugin functions that have real code for
	CONFIG_RCU_BOOST and trivial definitions otherwise.  In the
	3.3 kernel, this region extends from line 1137 to line 1824,
	and contains additional #ifdefs for CONFIG_HOTPLUG_CPU and
	CONFIG_RCU_TRACE.

o	Yet another set of plugin functions that have real code for
	CONFIG_SMP and trivial definitions otherwise.  In the 3.3
	kernel this region extends from line 1826 to 1950.  This
	is going away, as CONFIG_TREE_RCU&!CONFIG_SMP will no longer
	be an option.

o	The next set of plugin functions have real code for
	CONFIG_RCU_FAST_NO_HZ and trivial definitions otherwise.
	In the 3.3 kernel, this region extends from line 1952 to
	line 2199.  This region contains additional #ifdefs for
	CONFIG_TREE_PREEMPT_RCU.

o	A new set of plugin functions is going in for
	CONFIG_RCU_CPU_STALL_INFO.

So that is the organization.  I might contemplate small changes such
as moving a function or two to save a #ifdef, but I would have to be
convinced that any wholesale reorganization would actually produce
better results.  Given the amount of code, don't expect me to be easy
to convince.  ;-)

							Thanx, Paul

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
