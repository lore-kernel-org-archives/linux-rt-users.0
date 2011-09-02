From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Issue (NOT RELATED TO RT-PATCH) with clock_gettime / clock_nanosleep
 APIs with high resolution timer on panda board
Date: Fri, 2 Sep 2011 09:37:53 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1109020937190.2723@ionos>
References: <CAFQPvXfaisNL9YN+pUp_cYCRp4YZFCEPt33ZUAZ-Sa6VieAing@mail.gmail.com> <alpine.LFD.2.02.1109012121580.2723@ionos> <CA+zZMHFhJ81EjM09jRkfyGXtucASf3Ac1KS65TuYw4VDaJ5jFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sankara Muthukrishnan <sankara.m@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Michael Mueller <ss7box@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:38092 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755718Ab1IBHhz (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Sep 2011 03:37:55 -0400
In-Reply-To: <CA+zZMHFhJ81EjM09jRkfyGXtucASf3Ac1KS65TuYw4VDaJ5jFQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Mike,

On Thu, 1 Sep 2011, Michael Mueller wrote:
> On Thu, Sep 1, 2011 at 3:33 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> >
> > That looks like a problem in the clocksource. i.e. time is going
> > backward or having weird momentary jumps. You could verify that by
> > running one ore more tight loops which do
> >
> >        clock_gettime(CLOCK_MONOTONIC, &prev);
> >        while (1) {
> >              clock_gettime(CLOCK_MONOTONIC, &curr);
> >              if (curr < prev) /* Use a proper compare function for
> > timespec! */
> >                       printf(.....);
> >              prev = curr;
> >        }
> >
> > If that triggers on RT or on a vanilla kernel, then the problem is
> > definitely somewhere in the timekeeping/clocksource area.
> 
> 
> have seen this problem in vanilla kernels; developed a work-around that
> calls
> clock_gettime(CLOCK_MONOTONIC, &curr); until curr>prev
> a couple of times, and if that doesn't work, then it gets a new prev value
> and a new curr value; rinse and repeat until curr<prev; not sure what
> precipitates the problem; will post workaround code if wanted

Is that on a Panda board as well?

Thanks,

	tglx
