From: Mark Hounschell <dmarkh@cfl.rr.com>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal latencies
Date: Sat, 21 May 2011 16:48:20 -0400
Message-ID: <4DD82514.3070407@cfl.rr.com>
References: <1305886116.10494.30.camel@laika>
Reply-To: dmarkh@cfl.rr.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.123]:48556 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753768Ab1EUUsW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 21 May 2011 16:48:22 -0400
In-Reply-To: <1305886116.10494.30.camel@laika>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 05/20/2011 06:08 AM, Pedro Gonnet wrote:
>
> Hi guys,
>
> I'm currently working on a shared-memory parallel Molecular Dynamics
> simulation library (http://mdcore.sourceforge.net/) geared towards
> multi-core systems.
>
> The library uses pthreads (plus some OpenMP for some simple loops) and
> uses pthread_cond_wait and pthread_cond_signal to coordinate a group of
> worker threads.
>
> I've been profiling the library on different machines and kernels and
> have noticed that in many cases there are significant (several ms,
> measured with Intel's Vtune-thing) lags between calls to
> pthread_cond_signal and the waiting thread actually getting back to
> work.
>
> I've tried the Ubuntu -rt and -preempt kernels, and the whole simulation
> runs twice as slowly, despite following the advice given here:
>
>          https://rt.wiki.kernel.org/index.php/HOWTO:_Build_an_RT-application
>
> My question is the following: which kernel (or set of configuration
> options) will minimize these latencies? And if linux-rt is the answer,
> in what ways do I have to be careful when porting the simulation for
> this kernel?
>

Are you saying several ms latency from pthread_cond_signal to waking up a 
thread in pthread_cond_wait?

Mark

