From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: cyclic test results on 8 way (2.6.23.1-rt7 through 2.6.23.1-rt11)
Date: Tue, 13 Nov 2007 12:13:06 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0711131211480.2072@gandalf.stny.rr.com>
References: <200711072334.40216.dvhltc@us.ibm.com>
 <1985e0f60711130540j43eac275p4f77bb373bb4c958@mail.gmail.com>
 <Pine.LNX.4.58.0711130914500.369@gandalf.stny.rr.com> <200711130815.44329.dvhltc@us.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jaswinder Singh <jaswinderlinuxrt@gmail.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Gregory Haskins <ghaskins@novell.com>
To: Darren Hart <dvhltc@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:40248 "EHLO
	ms-smtp-03.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbXKMRNU (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2007 12:13:20 -0500
In-Reply-To: <200711130815.44329.dvhltc@us.ibm.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On Tue, 13 Nov 2007, Darren Hart wrote:

> On Tuesday 13 November 2007 06:15:03 Steven Rostedt wrote:
> > On Tue, 13 Nov 2007, Jaswinder Singh wrote:
> > > On Nov 8, 2007 1:04 PM, Darren Hart <dvhltc@us.ibm.com> wrote:
> > > > # ./cyclictest -n -i 10000 -l 10000 -p 95
> > >
> > > 10000 (10 milliseconds) interval seems to be quite big for current
> > > machine. 10 milliseconds is good for 10 to 15 years old machine but
> > > not for latest machines.
> > >
> > > I think we should try -i 1000 or -i 4000 .
> >
> > heh, I test with -i 250.
>
> Someone, I'm sorry I can't recall who atm, suggested that using a larger
> interval would allow for more variance to be introduced - not keeping the
> caches so hot for this particular test by not spending so much time on the
> cpu.  Is this a valid approach?  Perhaps running multiple runs with both very
> tight intervals (like Steve's case) and some longer intervals to ensure we
> can handle both cases - since both are common in practice.
>

I don't think it would hurt to test both cases. Perhaps three kinds.

  -i 250
  -i 1000
  -i 10000

do them separately, and that should give us a good idea of running fast as
well as cache cold.

-- Steve
