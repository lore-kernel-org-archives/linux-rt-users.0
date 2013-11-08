From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: UDP jitter
Date: Fri, 8 Nov 2013 03:07:53 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1311080134050.23353@ionos.tec.linutronix.de>
References: <20130429222238.2b440d8c@sanja.asnn.org> <517FE1A5.1090702@osadl.org> <20130430192653.5c6c08b6@sanja.asnn.org> <12C1B74BDFD05D40B2356A9B12DFA33967BEB68107@KEBMXSPMB01.keba.co.at> <20131106125709.2e091182@sth491dt.servo.net>
 <alpine.DEB.2.02.1311061910240.23353@ionos.tec.linutronix.de> <12C1B74BDFD05D40B2356A9B12DFA33967BEB683CF@KEBMXSPMB01.keba.co.at> <20131107103325.65938975@sanja.asnn.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-450531392-1383874710=:23353"
Cc: eg Engleder Gerhard <eg@keba.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: =?ISO-8859-2?Q?Neboj=B9a_=C6osi=E6?= <nebojsa@asnn.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:55108 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753320Ab3KHCH6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 7 Nov 2013 21:07:58 -0500
In-Reply-To: <20131107103325.65938975@sanja.asnn.org>
Content-ID: <alpine.DEB.2.02.1311080240040.23353@ionos.tec.linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-450531392-1383874710=:23353
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.02.1311080240041.23353@ionos.tec.linutronix.de>

On Thu, 7 Nov 2013, Neboj¹a Æosiæ wrote:
> On Thu, 7 Nov 2013 eg Engleder Gerhard wrote:
> > On Wed, 6 Nov 2013, Thomas Gleixner wrote:
> > > Utter nonsense.
> > 
> > In my situation if a first thread is preempted in dev_hard_start_xmit, then a second
> > thread which transmits over the same interface sees a none empty queue and
> > just enqueue the skb in the queue. No transmit (HARD_TX_LOCK) is necessary
> > because the first thread is already working on the queue. Please correct me if I'm
> > not right.

You are right. When the queue is active, there is no contention or
trylock on the xmit lock. And the resulting queuing operation is
documented behaviour.

> > For my case the first thread does normal SSH communication and the second
> > thread does real-time UDP communication. This results in a priority inversion for
> > the transmission of skb's over the same network interface.

That's the nature of a single queue which has very primitive fifo
odering constraints. There is no priority inversion. It's documented
behaviour. Just because you set the prio of your task to uberimportant
does not magically change the behaviour of everything to your favour.

> > Is there any chance to get rid of this priority inversion? Maybe
> > with priority qdisc?

See below.

> And this is precisely what this hack is trying to work around. Original
> thread was a call for a discussion in order to find real solution to the
> problem.

By providing a problem description which is completely useless? And
"solving" the issue by violating the locking rules of the networking
code?

> New messages arriving to the queue should somehow raise
> priority of thread sitting in dev_hard_start_xmit according to their
> own thread priority. Or can priority of a thread currently in
> dev_hard_start_xmit temporarily be raised to some configurable value. 
> This hack is effectively shutting down queuing of skbs, and instead
> forces queuing of threads.

Are you really believing that a generic fifo based queueing mechanism
just needs a random locking/priority tweak to become deterministic?

There is a damned good reason why the networking folks have spent a
lot of time to implement queueing, filtering and traffic shaping
mechanisms which allow you to influence the order and bandwidth
consumed by outgoing packets.

But understanding this seems to be way harder than wasting precious
time to debug the "shortcomings" of RT and babbling about priorities
and priority inversions.

Just a simple example why your reasoning is completely bogus:

 Assume a network device which has a tx ring size of 256, which is
 quite common.

 Now assume the following event flow:

 highprio_app() -> send package()

 	Queues ONE package which is enqueued into the TX ring right away

 lowprio_app() -> sendfile()
 
	The file length results in 255 packages. These are enqueued
	into the TX_RING right away WITHOUT congesting qdisc

 highprio_app() -> send package()

 	Queues ONE package which is enqueued into the TX ring right away


 NOTE: Neither operations are running into your observed scenario!

 Now the package of the high prio app is at the end of the TX ring and
 it has to wait for all other packages queued by the low prio app to
 be sent out over the wire.

 Let's do some rough math:

 100MB: Package size 1542 Bytes

 	time per package = ~15us

	time for 255 packages = ~3ms

 So now, assume that the low prio task is taking less than 1 msec to
 queue 255 packages and your high prio task is required to send every
 1ms with a maximum latency of 0.5 ms.

 How is your bogus hack going to solve that problem?

Not at all. Period. 

And none of your ideas to prevent that alleged priority inversion is
going to solve that.

WHY?

Simply because it has nothing to do with priority inversion. It's just
the nature of a single unmanaged queue. The behaviour is completely
correct.

Just for the record. I'm really frightened by the phrase "UDP
realtime" which was mentioned in this thread more than once. Looking
at the desperation level of these posts I fear, that there are going
to be real world products out already or available in the near future
which are based on the profound lack of understanding of the
technology they are based on.

This just confirms my theory, that most parts of this industry just
work by chance.

Thanks,

	tglx

--8323329-450531392-1383874710=:23353--
