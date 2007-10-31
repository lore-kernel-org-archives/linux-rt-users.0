From: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Wed, 31 Oct 2007 20:53:25 +0100 (CET)
Message-ID: <14294538.1772991193860405373.JavaMail.www@wwinf6002>
Reply-To: gerritbinnenmars@wanadoo.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Walker <dwalker@mvista.com>, linux-rt-users@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-1.orange.nl ([193.252.22.241]:13527 "EHLO smtp-1.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753782AbXJaTx3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 15:53:29 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6007.orange.nl (SMTP Server) with ESMTP id 669AC7000094
	for <linux-rt-users@vger.kernel.org>; Wed, 31 Oct 2007 20:53:25 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Datum: 31/10/07 01:17 AM
> Van: "Steven Rostedt"=20
> Aan: "Gerrit Binnenmars"=20
> CC: linux-rt-users@vger.kernel.org
> Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
>=20
>=20
> --
> On Tue, 30 Oct 2007, Gerrit Binnenmars wrote:
>=20
> > > Datum: 29/10/07 02:09 PM
> > > Van: "Steven Rostedt"
> > > Aan: "Gerrit Binnenmars"
> > > CC: linux-rt-users@vger.kernel.org
> > > Onderwerp : Re: CONFIG_CRITICAL_IRQSOFF_TIMING
> > >
> > >
> > > --
> > > On Sun, 28 Oct 2007, Gerrit Binnenmars wrote:
> > >
> > > > Hello,
> > > >
> > > > Can someone send me a .config file that shows the options neede=
d to get the interrupt off
> > > > timing values in preempt_max_latency, please. I only see a valu=
e of 0 in this file
> > > > I am using kernel 2.6.22.1 with the corresponding rt patch.
> > > >
> > > > Thanks in advance,
> > >
> > > Make sure you have event trace and latency tracing as well as
> > > "Interrupts-off critical section latency timing".
> > >
> > > Then you need to echo 0 > /proc/sys/kernel/preempt_max_latency.
> > >
> > Hello Steve,
> >
> > Thanks for your quick response, but the preempt_max_latency remains=
 0. Also the latency_hist shows no samples taken.
> > Can you or someone else have a look at the corresponding CONFIG opt=
ions?
> >
> > CONFIG_LTT_PROBE_LOCKING=3Dm
> > # CONFIG_LTT_PROBE_STACK is not set
> >
> > #
> > # Kernel hacking
> > #
>=20
> [...]
>=20
> > CONFIG_INTERRUPT_OFF_HIST=3Dy
> > CONFIG_CRITICAL_LATENCY_HIST=3Dy
> > CONFIG_LATENCY_HIST=3Dy
>=20
> Turn off all histograms. They will kill any measurements you are taki=
ng.
> And yes, you will not get the output from latency_trace that you are
> after.

Steven and Daniel, I tried your suggestion with the following resulsts:
CRITICAL_IRQSOFF_TIMING: preempt_max_latency remains 0 even under load,=
=20
                         cyclictest -b is able to store a trace in /pro=
c/latency_trace
CRITICAL_PREEMPT_TIMING: kernel won=C2=B4t start at all (vmlinuz is rea=
d from tftp server but nothing afterwards)
WAKEUP_TIMING:           is working as expected.

So switching off the histograms is an improvement. For the moment, I ca=
n live with this situation=20
(especially the cyclictest -b option is very useful),
but I wonder if anyone else has the same problems?

Regards, Gerrit

>=20
> -- Steve
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-rt-us=
ers" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
>=20
>
