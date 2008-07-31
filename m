From: Sebastien Dugue <sebastien.dugue@bull.net>
Subject: Re: [PATCH] Fix Bug messages
Date: Thu, 31 Jul 2008 13:23:36 +0200
Message-ID: <20080731132336.362bd487@bull.net>
References: <alpine.LFD.1.10.0807252141420.574@apollo.tec.linutronix.de>
	<alpine.LFD.1.10.0807291440240.14925@apollo.tec.linutronix.de>
	<alpine.LFD.1.10.0807300006180.14925@apollo.tec.linutronix.de>
	<200807301101.32417.j.mell@t-online.de>
	<20080730171842.GB3420@linux.vnet.ibm.com>
	<20080731100023.0221ec2b@bull.net>
	<520f0cf10807310313q45599221q3db1b6fd7e7c722f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Chirag Jog" <chirag@linux.vnet.ibm.com>,
	"J?rgen Mell" <j.mell@t-online.de>,
	"Thomas Gleixner" <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>,
	rt-users <linux-rt-users@vger.kernel.org>,
	"Steven Rostedt" <rostedt@goodmis.org>,
	"Clark Williams" <williams@redhat.com>,
	"Peter Zijlstra" <peterz@infradead.org>,
	"Josh Triplett" <josht@linux.vnet.ibm.com>,
	"Timothy R. Chavez" <tim.chavez@linux.vnet.ibm.com>
To: "John Kacur" <jkacur@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:57733 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYGaLXP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 31 Jul 2008 07:23:15 -0400
In-Reply-To: <520f0cf10807310313q45599221q3db1b6fd7e7c722f@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  Hi John,

On Thu, 31 Jul 2008 12:13:24 +0200 "John Kacur" <jkacur@gmail.com> wrot=
e:

> On Thu, Jul 31, 2008 at 10:00 AM, Sebastien Dugue
> <sebastien.dugue@bull.net> wrote:
> > On Wed, 30 Jul 2008 22:48:42 +0530 Chirag Jog <chirag@linux.vnet.ib=
m.com> wrote:
> >
> >> * J?rgen Mell <j.mell@t-online.de> [2008-07-30 11:01:32]:
> >>
> >> > Hello Thomas,
> >> >
> >> > On Wednesday, 30. July 2008, Thomas Gleixner wrote:
> >> > > We are pleased to announce the 2.6.26-rt1 tree, which can be
> >> > > downloaded from the location:
> >> >
> >> > I have tried the new kernel and have some good news and some bad=
 news:
> >> >
> >> > The good news: The machine boots and seems to run without major =
problems.
> >> >
> >> > The bad news: It produces continuously lots of bug messages in t=
he error
> >> > logs (cf. attached dmesg.tgz). The error at rtmutex.c:743 was al=
ready
> >> > present in 2.6.25-rt* when ACPI was enabled. The 'using smp_proc=
essor_id
> >> > ()  in preemptible code' is new here with 2.6.26.
> >> >
> >> > Machine is an old Athlon XP (single core) on an EPOX mainboard w=
ith VIA
> >> > chipset.
> >> >
> >> > If I can help with testing, please let me know.
> >> >
> >> > Bye,
> >> >          J=C3=BCrgen
> >> >
> >> >
> >> This patch should solve some of the bug messages.
> >> It does two things:
> >> 1. Change rt_runtime_lock to be a raw spinlock as the comment abov=
e it
> >> says: it is nested inside the rq lock.
> >>
> >> 2. Change mnt_writers to be a per_cpu locked variable.
> >> This eliminates the need for the codepath to disable preemption an=
d
> >> then potentially sleep, leading to the BUG messages
> >>
> >> Signed-Off-By: Chirag <chirag@linux.vnet.ibm.com>
> >
> >  Neat, the only remaining BUGs I see are from sock_prot_inuse_add()
> >
> > BUG: using smp_processor_id() in preemptible [00000000] code: arpin=
g/1916
> > caller is .sock_prot_inuse_add+0x30/0x80
> > Call Trace:
> > [c0000000eed2f910] [c000000000010304] .show_stack+0x70/0x1bc (unrel=
iable)
> > [c0000000eed2f9c0] [c0000000001a2340] .debug_smp_processor_id+0x138=
/0x168
> > [c0000000eed2fa70] [c0000000002181f4] .sock_prot_inuse_add+0x30/0x8=
0
> > [c0000000eed2fb10] [c00000000026d96c] .udp_lib_get_port+0x2a8/0x320
> > [c0000000eed2fbc0] [c000000000275b30] .inet_bind+0x168/0x248
> > [c0000000eed2fc60] [c000000000215024] .sys_bind+0x98/0xdc
> > [c0000000eed2fd90] [c0000000002370bc] .compat_sys_socketcall+0xcc/0=
x214
> > [c0000000eed2fe30] [c0000000000086ac] syscall_exit+0x0/0x40
> > BUG: arping:1916 task might have lost a preemption check!
> > Call Trace:
> > [c0000000eed2f890] [c000000000010304] .show_stack+0x70/0x1bc (unrel=
iable)
> > [c0000000eed2f940] [c00000000004e298] .preempt_enable_no_resched+0x=
60/0x78
> > [c0000000eed2f9c0] [c0000000001a2348] .debug_smp_processor_id+0x140=
/0x168
> > [c0000000eed2fa70] [c0000000002181f4] .sock_prot_inuse_add+0x30/0x8=
0
> > [c0000000eed2fb10] [c00000000026d96c] .udp_lib_get_port+0x2a8/0x320
> > [c0000000eed2fbc0] [c000000000275b30] .inet_bind+0x168/0x248
> > [c0000000eed2fc60] [c000000000215024] .sys_bind+0x98/0xdc
> > [c0000000eed2fd90] [c0000000002370bc] .compat_sys_socketcall+0xcc/0=
x214
> > [c0000000eed2fe30] [c0000000000086ac] syscall_exit+0x0/0x40
> >
>=20
> Does this simple fix do the trick for you?
>
>Signed-off-by: John Kacur <jkacur@gmail.com>
>
>Index: linux-2.6.26-rt1/net/core/sock.c
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>--- linux-2.6.26-rt1.orig/net/core/sock.c
>+++ linux-2.6.26-rt1/net/core/sock.c
>@@ -1943,7 +1943,7 @@ static DECLARE_BITMAP(proto_inuse_idx, P
> #ifdef CONFIG_NET_NS
> void sock_prot_inuse_add(struct net *net, struct proto *prot, int val=
)
> {
>-	int cpu =3D smp_processor_id();
>+	int cpu =3D raw_smp_processor_id();
> 	per_cpu_ptr(net->core.inuse, cpu)->val[prot->inuse_idx] +=3D val;
> }
> EXPORT_SYMBOL_GPL(sock_prot_inuse_add);

  Nope, still the same BUGs, I do not have the net namespaces configure=
d, so the
version of sock_prot_inuse_add() which is used is defined a few lines b=
elow:

static DEFINE_PER_CPU(struct prot_inuse, prot_inuse);

void sock_prot_inuse_add(struct net *net, struct proto *prot, int val)
{
	__get_cpu_var(prot_inuse).val[prot->inuse_idx] +=3D val;
}
EXPORT_SYMBOL_GPL(sock_prot_inuse_add);

  Looks like another case of percpu variables Chirag has benn fixing.

  Sebastien.


--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
