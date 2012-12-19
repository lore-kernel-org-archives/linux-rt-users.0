From: Scot Salmon <scot.salmon@ni.com>
Subject: Re: Detecting shift of CLOCK_REALTIME with clock_nanosleep (again)
Date: Wed, 19 Dec 2012 14:43:37 -0600
Message-ID: <OF701783A6.DD321DA8-ON86257AD9.0065C5C7-86257AD9.0071DB52@ni.com>
References: <OFB404C2D9.B6E5E0B9-ON86257AA8.0054900F-86257AA8.005761C4@ni.com> <alpine.LFD.2.02.1210311949400.2756@ionos> <OF0AC62D08.8289F39F-ON86257AB7.0067DE83-86257AB7.006AEF36@ni.com> <50A55664.2090605@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: John Stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mailserver6.natinst.com ([130.164.80.6]:42609 "EHLO
	spamkiller06.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2LSUnu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 Dec 2012 15:43:50 -0500
In-Reply-To: <50A55664.2090605@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

John Stultz wrote on 11/15/2012 02:53:56 PM:
> On 11/15/2012 11:28 AM, Scot Salmon wrote:
> > Thomas Gleixner wrote on 10/31/2012 03:08:45 PM:
> > > What you are concerned about is keeping the machines in sync on a
> > > common global timeline. Though your more fundamental requirement is
> > > that you get the wakeup on each machine in the given cycle time. The
> > > global synchronization mechanism just adjusts that local periodic
> > > schedule.
> > [...]
> > > What you really want is an atomic readout facility for 
> > > CLOCK_MONOTONIC and CLOCK_REALTIME. That allows you to align the 
> > > CLOCK_MONOTONIC based timer with the global CLOCK_REALTIME based 
> > > time line and in the event that the CLOCK_REALTIME clock was set 
> > > and jumped forward/backward you have full software control over 
> > > the aligning mechanism including the ability to do sanity checking.
> > This works for me.  We discussed it on IRC and agreed on "something
> > like clock_gettime2(id, id, *t1, *t2) with a sanity check on the ids,
> > that allows us other combinations than MONO/REAL as well".
> Yea, there's been a few times that folks have brought up the need, and 
> this sort of interface is probably the best way to go.

I spent a few days working on clock_gettime2 this week, and I've hit a 
snag.  I tried an implementation where I look up the two kclocks from 
their clockid and call kc1->clock_get() and kc2->clock_get() with the 
timekeeping data locked.  The problem is, if id1 and id2 are the obvious 
choices of MONO and REAL, their clock_get's end up calling 
timekeeping_get_ns which samples the clock source synchronously, so I 
get two discrete samples of the underlying clock even if I have locked 
out any changes to the timekeeping data.

This implementation does work for the _COARSE clockid variants, but it 
seems from some quick checks that those aren't going to be suitable for 
my needs (too coarse).

Since there's nothing I can do to keep the underlying hardware clock 
source from ticking, it seems like my options are pretty limited.  I 
can't do anything that will lead to two samples of the clock source. 
All I can think of is to sample it for the first clockid, then derive 
the value for the second from the first, for example by offsetting a 
CLOCK_MONOTONIC read with tk->offs_real and returning that as the 
synchronized value for CLOCK_REALTIME.  Which isn't incredibly horrible 
for those two, but making it general would get very ugly.

Any thoughts?

-Scot

