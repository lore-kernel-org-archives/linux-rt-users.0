From: "Peter W. Morreale" <pmorreale@novell.com>
Subject: Re: Question regarding pthread_cond_wait/pthread_cond_signal
 latencies
Date: Sun, 22 May 2011 07:51:28 -0600
Message-ID: <1306072288.2169.78.camel@hermosa.morreale.net>
References: <1305886116.10494.30.camel@laika>  <4DD82514.3070407@cfl.rr.com>
	 <1306011102.10494.34.camel@laika>
	 <1306025059.2169.16.camel@hermosa.morreale.net>
	 <1306064062.10494.42.camel@laika>
Reply-To: pmorreale@novell.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: dmarkh@cfl.rr.com, linux-rt-users@vger.kernel.org
To: Pedro Gonnet <gonnet@maths.ox.ac.uk>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:38371 "EHLO
	nat.nue.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753623Ab1EVNvg (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 22 May 2011 09:51:36 -0400
In-Reply-To: <1306064062.10494.42.camel@laika>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sun, 2011-05-22 at 12:34 +0100, Pedro Gonnet wrote:
> On Sat, 2011-05-21 at 18:44 -0600, Peter W. Morreale wrote:
> > Do you use any pthread* primitives involving scheduling?  
> 
> I'm not quite sure what you mean by scheduling functions... I only use
> the basic pthread_mutex_* and pthread_cond_* functions.
> 

So you are not defining scheduling parameters with calls like
pthread_attr_setsched_policy() and pthread_attr_setschedparam().  

All this means is that your threads are inheriting their scheduling
attributes from the main thread. 

You might use the above calls if you had differing priorities between
your threads and wanted to ensure various scheduling polices.  


> > How do you start your process?  How many threads?  What else is on the
> > machine? 
> 
> The main thread starts several threads with pthread_create. I have a
> barrier which uses pthread_mutex's and pthead_cond's to synchronize the
> threads. This is where the delays happen.
> 

Try starting your application like this:

% chrt -f 20 <name-of-app>

This starts your application in the SCHED_FIFO class with a priority of
20 and all your threads will inherit this class and priority.  

You can choose any priority you like, however if you are dependent upon
external (to your app) daemons and/or kernel tasks (Think networking,
for example) and choose a priority higher than them, you will hang
potentially hang your system.  The default priority is (IIRC) 50, so
choosing any value lower than that will be safe. 

Note that choosing a priority of 25 over 20 makes no difference unless
there are other threads you are competing with.  Doesn't sound like it
from your description, so whether you choose a priority of 1 or 49 will
not make a difference for your app.   Just get it in SCHED_FIFO.

Currently you are running in SCHED_OTHER, which has a timeslice
associated with it.  This means your tasks will give up the CPU
periodically.

> I observed these latencies both on my own laptop (loads of stuff running
> in the background) and on multi-core servers on which I was alone. 
> 
> I should probably note that I also use OpenMP for some simple
> parallelization as well. Eg. after releasing the threads and waiting for
> them all to return to the barrier, some things are computed with OpenMP
> (OMP_WAIT_POLICY=PASSIVE).

Hummm  not completely familiar with OpenMP.  Are there OpenMP daemons
that your threads will contact for data exchange?  If so, then ensure
you modify their startup scripts to start the daemons in SCHED_FIFO at a
similar priority as well, just like above.  If not, no worries, OpenMP
probably has no effect.

The next steps would be to partition the CPUs of your multi-core machine
into sets of CPUs.  The idea here is to move (almost) all system tasks
to a root set of CPUs, and have a set of CPUs dedicated for your
threads.

This is easier than it sounds if you use the cset utility.  I'm unclear
whether it is available via Ubuntu distribution channels, but you can
get a copy of this python script from the RT wiki:

 https://rt.wiki.kernel.org/index.php/Cpuset_management_utility

Read through that page.  To create a set of shielded CPUs, and migrate
existing tasks to the root set, do something like this:

% cset shield --cpu 1-3 --kthread on
 
(assuming a 4-way box) 

The above creates two CPU sets, CPU-0, and CPUs1-3.  In addition the
cset command will migrate virtually all currently running tasks to CPU0.
The caveat is that tasks that have a CPU affinity already set are not
migrated by cset.  Likely none of those will hurt your performance too
much...

To start your application (in SCHED_FIFO as above) within the shielded
set: 

% cset shield --exec chrt -f 20 <name-of-your-app>

Now all of the threads within your app will only run on CPUs 1-3, and
(virtually) all system tasks will run on CPU0.

Bear in mind that the shielding created by cset if not persistent, if
you reboot, you have to re-create the shielding again. 

This is only the tip of what you can do to tune the system for your
application.  The basic idea here is to start thinking about the system
as a whole, and tune the system as well as your app for best
performance.  Think in terms of:

1 - running your application in the RT sched class - SCHED_FIFO

2 - Partition your multi-core machine to get dedicated CPUs for your
app.  

I'd be surprised if you do not see a significant improvement in
latencies.  

Even if your box has only two cores, you may see an improvement in using
cset.  Whether or not you will comes down to that age-old computing
adage:

"Try it."

Best,
-PWM

   
> 
> The kernels on which I have seen this are the Ubuntu -generic kernels
> 2.6.31--2.3.35. I have also tried running the simulations on a Ubuntu
> 2.6.31-11-rt kernel. This, however, caused the whole simulation to run
> twice as slow, even when only using one single thread (on a 6-core
> machine).
> 
> Please do let me know if you need any more specific information!
> 
> Cheers, Pedro
> 
> 
> 


