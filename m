From: Scot Salmon <scot.salmon@ni.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Thu, 15 Nov 2012 13:28:00 -0600
Message-ID: <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: John Stultz <johnstul@us.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:52522 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1768765Ab2KOT2N (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2012 14:28:13 -0500
In-Reply-To: <alpine.LFD.2.02.1210311949400.2756@ionos>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thomas Gleixner <tglx@linutronix.de> wrote on 10/31/2012 03:08:45 PM:
> What you are concerned about is keeping the machines in sync on a
> common global timeline. Though your more fundamental requirement is
> that you get the wakeup on each machine in the given cycle time. The
> global synchronization mechanism just adjusts that local periodic
> schedule.
[...]
> What you really want is an atomic readout facility for CLOCK_MONOTONIC
> and CLOCK_REALTIME. That allows you to align the CLOCK_MONOTONIC based
> timer with the global CLOCK_REALTIME based time line and in the event
> that the CLOCK_REALTIME clock was set and jumped forward/backward you
> have full software control over the aligning mechanism including the
> ability to do sanity checking.

This works for me.  We discussed it on IRC and agreed on "something
like clock_gettime2(id, id, *t1, *t2) with a sanity check on the ids,
that allows us other combinations than MONO/REAL as well".

-Scot

