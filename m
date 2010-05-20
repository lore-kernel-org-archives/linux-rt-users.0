From: "Nikita V. Youshchenko" <yoush@cs.msu.su>
Subject: Re: PREEMPT_RT (2.6.33-rt17) disabled printk-to-console after console_init
Date: Thu, 20 May 2010 15:40:40 +0400
Message-ID: <201005201540.42113@zigzag.lvk.cs.msu.su>
References: <AANLkTimxLHngWamPvWt-htGoZ7Nub72rvJAnmGtw4Eqw@mail.gmail.com> <201005201512.40304@zigzag.lvk.cs.msu.su> <alpine.LFD.2.00.1005201317490.3368@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Sujit K M <sjt.kar@gmail.com>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from gate.lvk.cs.msu.su ([158.250.17.1]:37262 "EHLO
	mail.lvk.cs.msu.su" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab0ETLky (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 20 May 2010 07:40:54 -0400
In-Reply-To: <alpine.LFD.2.00.1005201317490.3368@localhost.localdomain>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> > > > 3) I believe that 8250 serial driver is aware of preempt-rt.
> > > > Could you please comment on my "2.6.33.2-rt13: RFC: fix serial
> > > > console" post to linux-rt-users list
> > > > (http://eeek.borgchat.net/lists/linux-rt-users/msg05569.html)
> > >
> > > While that can work due to the trylock, it can introduce massive
> > > latencies just in case some driver reports a status change or what
> > > ever.
> >
> > Isn't it better just manually disable console (with 'quiet' kernel
> > command line option) when running in production? This may be
> > recommended in proper guidelines.
>
> No, anything which needs extra parameters for normal operation is
> wrong as it affects users.
>
> Adding a "I'm debugging, I don't care" flag for developers is the
> right thing to do.

Not sure.

We are not having 'good latency' vs 'bad latency' alternative here.
Alternative is 'better latency, broken console' vs 'worse latency, woring 
console'.

Since RT system has to be tuned anyway to get best possible latencies (e.g. 
prio of IRQ threads), having to tune console as well here looks like 
acceptable solution for me.

Nikita
