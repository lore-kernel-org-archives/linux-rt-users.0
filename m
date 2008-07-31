From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH] Fix Bug messages
Date: Thu, 31 Jul 2008 10:00:23 +0200
Message-ID: <20080731100023.0221ec2b@bull.net>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de>
	<alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>
	<alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
	<200807301101.32417.j.mell@t-online.de>
	<20080730171842.GB3420@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: J?rgen Mell <j.mell@t-online.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <williams@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Triplett <josht@linux.vnet.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>
To: Chirag Jog <chirag@linux.vnet.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:46339 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750751AbYGaH7y convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jul 2008 03:59:54 -0400
In-Reply-To: <20080730171842.GB3420@linux.vnet.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 30 Jul 2008 22:48:42 +0530 Chirag Jog <chirag@linux.vnet.ibm.co=
m> wrote:

> * J?rgen Mell <j.mell@t-online.de> [2008-07-30 11:01:32]:
>=20
> > Hello Thomas,
> >=20
> > On Wednesday, 30. July 2008, Thomas Gleixner wrote:
> > > We are pleased to announce the 2.6.26-rt1 tree, which can be
> > > downloaded from the location:
> >=20
> > I have tried the new kernel and have some good news and some bad ne=
ws:
> >=20
> > The good news: The machine boots and seems to run without major pro=
blems.
> >=20
> > The bad news: It produces continuously lots of bug messages in the =
error=20
> > logs (cf. attached dmesg.tgz). The error at rtmutex.c:743 was alrea=
dy=20
> > present in 2.6.25-rt* when ACPI was enabled. The 'using smp_process=
or_id=20
> > ()  in preemptible code' is new here with 2.6.26.
> >=20
> > Machine is an old Athlon XP (single core) on an EPOX mainboard with=
 VIA=20
> > chipset.
> >=20
> > If I can help with testing, please let me know.
> >=20
> > Bye,
> >          J=C3=BCrgen
> >=20
> >=20
> This patch should solve some of the bug messages.
> It does two things:
> 1. Change rt_runtime_lock to be a raw spinlock as the comment above i=
t
> says: it is nested inside the rq lock.
>=20
> 2. Change mnt_writers to be a per_cpu locked variable.
> This eliminates the need for the codepath to disable preemption and
> then potentially sleep, leading to the BUG messages
>=20
> Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>

  Neat, the only remaining BUGs I see are from sock_prot_inuse_add()

BUG: using smp_processor_id() in preemptible [00000000] code: arping/19=
16
caller is .sock_prot_inuse_add+0x30/0x80
Call Trace:
[c0000000eed2f910] [c000000000010304] .show_stack+0x70/0x1bc (unreliabl=
e)
[c0000000eed2f9c0] [c0000000001a2340] .debug_smp_processor_id+0x138/0x1=
68
[c0000000eed2fa70] [c0000000002181f4] .sock_prot_inuse_add+0x30/0x80
[c0000000eed2fb10] [c00000000026d96c] .udp_lib_get_port+0x2a8/0x320
[c0000000eed2fbc0] [c000000000275b30] .inet_bind+0x168/0x248
[c0000000eed2fc60] [c000000000215024] .sys_bind+0x98/0xdc
[c0000000eed2fd90] [c0000000002370bc] .compat_sys_socketcall+0xcc/0x214
[c0000000eed2fe30] [c0000000000086ac] syscall_exit+0x0/0x40
BUG: arping:1916 task might have lost a preemption check!
Call Trace:
[c0000000eed2f890] [c000000000010304] .show_stack+0x70/0x1bc (unreliabl=
e)
[c0000000eed2f940] [c00000000004e298] .preempt_enable_no_resched+0x60/0=
x78
[c0000000eed2f9c0] [c0000000001a2348] .debug_smp_processor_id+0x140/0x1=
68
[c0000000eed2fa70] [c0000000002181f4] .sock_prot_inuse_add+0x30/0x80
[c0000000eed2fb10] [c00000000026d96c] .udp_lib_get_port+0x2a8/0x320
[c0000000eed2fbc0] [c000000000275b30] .inet_bind+0x168/0x248
[c0000000eed2fc60] [c000000000215024] .sys_bind+0x98/0xdc
[c0000000eed2fd90] [c0000000002370bc] .compat_sys_socketcall+0xcc/0x214
[c0000000eed2fe30] [c0000000000086ac] syscall_exit+0x0/0x40

=2E..

  Thanks,

  Sebastien.


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
