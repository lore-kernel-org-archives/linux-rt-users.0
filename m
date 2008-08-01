From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: 2.6.26-rt1
Date: Fri, 1 Aug 2008 14:11:17 -0700
Message-ID: <20080801211117.GD14851@linux.vnet.ibm.com>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de> <alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de> <200807301101.32417.j.mell@t-online.de>
Reply-To: paulmck@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@elte.hu>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Carsten Emde <ce@ceag.ch>
To: =?iso-8859-1?Q?J=FCrgen?= Mell <j.mell@t-online.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:49441 "EHLO e4.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761069AbYHAVLU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Aug 2008 17:11:20 -0400
Content-Disposition: inline
In-Reply-To: <200807301101.32417.j.mell@t-online.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Jul 30, 2008 at 11:01:32AM +0200, J=FCrgen Mell wrote:
> Hello Thomas,
>=20
> On Wednesday, 30. July 2008, Thomas Gleixner wrote:
> > We are pleased to announce the 2.6.26-rt1 tree, which can be
> > downloaded from the location:
>=20
> I have tried the new kernel and have some good news and some bad news=
:
>=20
> The good news: The machine boots and seems to run without major probl=
ems.
>=20
> The bad news: It produces continuously lots of bug messages in the er=
ror=20
> logs (cf. attached dmesg.tgz). The error at rtmutex.c:743 was already=
=20
> present in 2.6.25-rt* when ACPI was enabled. The 'using smp_processor=
_id=20
> ()  in preemptible code' is new here with 2.6.26.
>=20
> Machine is an old Athlon XP (single core) on an EPOX mainboard with V=
IA=20
> chipset.
>=20
> If I can help with testing, please let me know.

The following patch should clear things up.  It is against 2.6.25.8-rt7=
,
but should still apply.

-----------------------------------------------------------------------=
-

Disable preemption around statistics for RCU boost and unboost calls.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 rcupreempt-boost.c |   20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff -urpNa -X dontdiff linux-2.6.25.8-rt7/kernel/rcupreempt-boost.c li=
nux-2.6.25.8-rt7-preemptfix/kernel/rcupreempt-boost.c
--- linux-2.6.25.8-rt7/kernel/rcupreempt-boost.c	2008-06-24 14:14:52.00=
0000000 -0700
+++ linux-2.6.25.8-rt7-preemptfix/kernel/rcupreempt-boost.c	2008-06-24 =
14:38:59.000000000 -0700
@@ -205,11 +205,23 @@ RCU_BOOST_TRACE_FUNC_DECL(boost_readers)
 RCU_BOOST_TRACE_FUNC_DECL(try_unboost_readers)
 RCU_BOOST_TRACE_FUNC_DECL(unboost_readers)
 RCU_BOOST_TRACE_FUNC_DECL(over_taken)
+static void rcu_trace_boost_boost_called_preempt(void)
+{
+	preempt_disable();
+	rcu_trace_boost_boost_called(RCU_BOOST_ME);
+	preempt_enable();
+}
+static void rcu_trace_boost_unboost_called_preempt(void)
+{
+	preempt_disable();
+	rcu_trace_boost_unboost_called(RCU_BOOST_ME);
+	preempt_enable();
+}
 #else /* CONFIG_RCU_TRACE */
 /* These were created by the above macro "RCU_BOOST_TRACE_FUNC_DECL" *=
/
-# define rcu_trace_boost_task_boost_called(rbd) do { } while (0)
+# define rcu_trace_boost_task_boost_called_preempt(rbd) do { } while (=
0)
 # define rcu_trace_boost_task_boosted(rbd) do { } while (0)
-# define rcu_trace_boost_boost_called(rbd) do { } while (0)
+# define rcu_trace_boost_boost_called_preempt(rbd) do { } while (0)
 # define rcu_trace_boost_try_boost(rbd) do { } while (0)
 # define rcu_trace_boost_boosted(rbd) do { } while (0)
 # define rcu_trace_boost_unboost_called(rbd) do { } while (0)
@@ -261,7 +273,7 @@ void __rcu_preempt_boost(void)
=20
 	WARN_ON(!current->rcu_read_lock_nesting);
=20
-	rcu_trace_boost_boost_called(RCU_BOOST_ME);
+	rcu_trace_boost_boost_called_preempt();
=20
 	/* check to see if we are already boosted */
 	if (unlikely(rcu_is_boosted(curr)))
@@ -313,7 +325,7 @@ void __rcu_preempt_unboost(void)
 	int prio;
 	unsigned long flags;
=20
-	rcu_trace_boost_unboost_called(RCU_BOOST_ME);
+	rcu_trace_boost_unboost_called_preempt();
=20
 	/* if not boosted, then ignore */
 	if (likely(!rcu_is_boosted(curr)))

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
