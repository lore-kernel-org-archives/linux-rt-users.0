From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal
 latencies
Date: Sat, 21 May 2011 18:44:19 -0600
Message-ID: <1306025059.2169.16.camel@hermosa.morreale.net>
References: <1305886116.10494.30.camel@laika>  <4DD82514.3070407@cfl.rr.com>
	 <1306011102.10494.34.camel@laika>
Reply-To: pmorreale@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: dmarkh@cfl.rr.com, linux-rt-users@vger.kernel.org
To: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:48728 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752483Ab1EVBE1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 May 2011 21:04:27 -0400
In-Reply-To: <1306011102.10494.34.camel@laika>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-05-21 at 21:51 +0100, Pedro Gonnet wrote:
> On Sat, 2011-05-21 at 16:48 -0400, Mark Hounschell wrote:
> > On 05/20/2011 06:08 AM, Pedro Gonnet wrote:
> > >
> > > Hi guys,
> > >
> > > I'm currently working on a shared-memory parallel Molecular Dynamics
> > > simulation library (http://mdcore.sourceforge.net/) geared towards
> > > multi-core systems.
> > >
> > > The library uses pthreads (plus some OpenMP for some simple loops) and
> > > uses pthread_cond_wait and pthread_cond_signal to coordinate a group of
> > > worker threads.
> > >
> > > I've been profiling the library on different machines and kernels and
> > > have noticed that in many cases there are significant (several ms,
> > > measured with Intel's Vtune-thing) lags between calls to
> > > pthread_cond_signal and the waiting thread actually getting back to
> > > work.
> > >
> > > I've tried the Ubuntu -rt and -preempt kernels, and the whole simulation
> > > runs twice as slowly, despite following the advice given here:
> > >
> > >          https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
> > >
> > > My question is the following: which kernel (or set of configuration
> > > options) will minimize these latencies? And if linux-rt is the answer,
> > > in what ways do I have to be careful when porting the simulation for
> > > this kernel?
> > >
> > 
> > Are you saying several ms latency from pthread_cond_signal to waking up a 
> > thread in pthread_cond_wait?
> > 
> 
> Yes. Or at least, this is what Vtune says. It could also be a fluke in
> Vtune, but I would still be interested in knowing what kernel or what
> kernel options can make these operations as fast as possible.
> 
> Cheers, Pedro

Do you use any pthread* primitives involving scheduling?  

How do you start your process?  How many threads?  What else is on the
machine? 

IOW, can you describe your environment more completely.


Best
-PWM



> 
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


