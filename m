From: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal
 latencies
Date: Sun, 22 May 2011 12:34:22 +0100
Message-ID: <1306064062.10494.42.camel@laika>
References: <1305886116.10494.30.camel@laika>  <4DD82514.3070407@cfl.rr.com>
	 <1306011102.10494.34.camel@laika>
	 <1306025059.2169.16.camel@hermosa.morreale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: dmarkh@cfl.rr.com, linux-rt-users@vger.kernel.org
To: pmorreale@novell.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from relay8.mail.ox.ac.uk ([129.67.1.171]:50230 "EHLO
	relay8.mail.ox.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab1EVLe3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 May 2011 07:34:29 -0400
In-Reply-To: <1306025059.2169.16.camel@hermosa.morreale.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 2011-05-21 at 18:44 -0600, Peter W. Morreale wrote:
> Do you use any pthread* primitives involving scheduling?  

I'm not quite sure what you mean by scheduling functions... I only use
the basic pthread_mutex_* and pthread_cond_* functions.

> How do you start your process?  How many threads?  What else is on the
> machine? 

The main thread starts several threads with pthread_create. I have a
barrier which uses pthread_mutex's and pthead_cond's to synchronize the
threads. This is where the delays happen.

I observed these latencies both on my own laptop (loads of stuff running
in the background) and on multi-core servers on which I was alone. 

I should probably note that I also use OpenMP for some simple
parallelization as well. Eg. after releasing the threads and waiting for
them all to return to the barrier, some things are computed with OpenMP
(OMP_WAIT_POLICY=PASSIVE).

The kernels on which I have seen this are the Ubuntu -generic kernels
2.6.31--2.3.35. I have also tried running the simulations on a Ubuntu
2.6.31-11-rt kernel. This, however, caused the whole simulation to run
twice as slow, even when only using one single thread (on a 6-core
machine).

Please do let me know if you need any more specific information!

Cheers, Pedro



