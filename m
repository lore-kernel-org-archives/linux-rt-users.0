From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: trace/latency-hist: Consider new argument when probing the
 sched_switch tracer
Date: Wed, 13 Jan 2016 17:08:33 +0100
Message-ID: <56967681.9070204@linutronix.de>
References: <568B8B37.9070804@osadl.org>
 <20160113154526.GJ29964@linutronix.de>
 <20160113105135.3334856c@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carsten Emde <C.Emde@osadl.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50906 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbcAMQIf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 13 Jan 2016 11:08:35 -0500
In-Reply-To: <20160113105135.3334856c@gandalf.local.home>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/13/2016 04:51 PM, Steven Rostedt wrote:
> On Wed, 13 Jan 2016 16:45:26 +0100
> Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>=20
>> Is it somehow possible to detect this kind of bugs at compile time? =
Is
>> there an easy way to do this?
>=20
> There should have been a warning. Wasn't there one?

Sorry, my bad. I didn't enable it=85 Yes, there is one.

>> What is blocking the latency-hist tracer from entering mainline?
>=20
> Has it been submitted. Like lots of things in -rt, it just takes the
> effort of pushing out an RFC for inclusion.

Not that I recall. But this means that there is nothing specific that
you are aware of that needs to be changed before RFC.

So, Carsten do you mind taking the latency-hist patch and submitting it
as RFC for upstream inclusion?

> -- Steve
>=20
Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
