From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: [rt-tests][PATCH] align thread wakeup times
Date: Fri, 4 Oct 2013 18:21:39 +0200
Message-ID: <20131004162139.GD9752@opentech.at>
References: <20130909072948.GA1967@opentech.at> <20131004132207.GF19953@linutronix.de> <20131004133325.GB26223@opentech.at> <524ED838.2060500@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: williams@redhat.com, linux-rt-users@vger.kernel.org,
	C.Emde@osadl.org, tglx@linutronix.de, andi@opentech.at
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:41138 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754636Ab3JDQVk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 4 Oct 2013 12:21:40 -0400
Content-Disposition: inline
In-Reply-To: <524ED838.2060500@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 04 Oct 2013, Sebastian Andrzej Siewior wrote:

> On 10/04/2013 03:33 PM, Nicholas Mc Guire wrote:
> >> I would rather fix current behaviour instead introducing yet another
> >> option. By using -d0 I assume that all threads wakeup at the same time.
> > 
> > Nop they do not -d0 just says that they all use
> > the same period rather than some offset with multiple threads (e.g. -S)
> > 
> >> According to your patch this does not happen due to the thread creating
> >> / starting overhead.
> >> Is there is a reason to keep this "faulty" behavior? If not I would vote
> >> to make this what you suggest the default.
> >>
> > 
> > its not faulty behavior - its a different case
> > in fact we need both.
> > 
> > same period + "random" start time
> > same period + synced start time
> > 
> > it makes a difference on some boxes that is significant.
> 
> So you say with -d0, where d is documented as "distance of thread
> intervals in us", I should not expect that all threads share the exact
> same wakeup time (because their distance is 0)?
>
no why should you - you might want
 
-i 100 -d 50 -A 20

T1 0     100     200     300
T2  20         170
T3   40              240
T4    60                   310

Which is quite a lot different than just stating

that i_1=100 i_2=150, etc... but initial distance "undefined" or random

so in the sense of schedulability tests these are really two seperate
parameters and thus should be configurable independently.

That the current documentation might give the impression that they are
in sync is a bug in the documentation not in the -d implementation.

hofrat
 
