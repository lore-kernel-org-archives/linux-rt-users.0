From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: CONFIG_CRITICAL_IRQSOFF_TIMING
Date: Wed, 31 Oct 2007 16:03:53 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710311601290.20084@gandalf.stny.rr.com>
References: <14294538.1772991193860405373.JavaMail.www@wwinf6002>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Walker <dwalker@mvista.com>, linux-rt-users@vger.kernel.org
To: Gerrit Binnenmars <gerritbinnenmars@wanadoo.nl>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:46001 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754054AbXJaUEE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 31 Oct 2007 16:04:04 -0400
In-Reply-To: <14294538.1772991193860405373.JavaMail.www@wwinf6002>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


--
> > [...]
> >
> > > CONFIG_INTERRUPT_OFF_HIST=3Dy
> > > CONFIG_CRITICAL_LATENCY_HIST=3Dy
> > > CONFIG_LATENCY_HIST=3Dy
> >
> > Turn off all histograms. They will kill any measurements you are ta=
king.
> > And yes, you will not get the output from latency_trace that you ar=
e
> > after.
>
> Steven and Daniel, I tried your suggestion with the following resulst=
s:
> CRITICAL_IRQSOFF_TIMING: preempt_max_latency remains 0 even under loa=
d,
>                          cyclictest -b is able to store a trace in /p=
roc/latency_trace
> CRITICAL_PREEMPT_TIMING: kernel won=C2=B4t start at all (vmlinuz is r=
ead from tftp server but nothing afterwards)
> WAKEUP_TIMING:           is working as expected.
>
> So switching off the histograms is an improvement. For the moment, I =
can live with this situation
> (especially the cyclictest -b option is very useful),
> but I wonder if anyone else has the same problems?

critcal irqs off timings wont start with wakeup timing on. You need to
disable that. But that you can do from the command line.

echo 0 > /proc/sys/kernel/wakeup_timing

-- Steve
