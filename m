From: Nicholas Mc Guire <der.herr@hofr.at>
Subject: Re: rt file i/o
Date: Wed, 4 Nov 2009 18:09:28 +0100
Message-ID: <20091104170928.GA1702@opentech.at>
References: <hcs6dr$235$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
To: Tim Blechmann <tim@klingt.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hofr.at ([212.69.189.236]:54976 "EHLO mail.hofr.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757170AbZKDRRN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 4 Nov 2009 12:17:13 -0500
Content-Disposition: inline
In-Reply-To: <hcs6dr$235$1@ger.gmane.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 04 Nov 2009, Tim Blechmann wrote:

> hi all,
> 
> having read the howto build an rt-application, i am trying to think of a
> way to handle disk i/o in my application.
> 
> the howto suggest to avoid file i/o in non-rt helper threads, but to
> move them to another process. while the howto suggests using network
> socket, i'm curious, if other ipc primitives like shared memory would
> give better throughput? or would i experience any issues, like is it
> possible to lock shared memory to physical ram?
>
this is probably a bit off topic - but both RTLinux/GPL (RTLFS) and L4 have 
implemented RT IDE drivers - limited to dedicated discs - the performance
is really bad (aprox. 800k/s) - so determinism on a device that really 
lives from cache/pre-fetch and large-block access is very expensive.
What such a driver can give you at best is a guaranteed bandwidth, and
a worst case latency that is not really too atractive (tens of milliseconds)

So probably the best option is to have a user-space/non-RT driver access the
disk and pre-fetch/cache a "large" chunk of what you want to read/write to
de-couple RT from non-RT - this has been the model used i.e. for RAT (Real-time 
Audio Tools see proceedings of the 6th Real Time Linux Workshop - Singapur)
quite successfully - as long as the I/O rate your RT-app expects is 
sufficiently much smaller than the I/O capability of the device driver AND you
ensure the bandwidth (i.e. by raising the respective irq-thread priority, and
restricting other I/O to that controler/disk) this is actually a quite 
deterministic approach provided your buffering is not too small.

Generally you will not be able to analyze paths of complex hardware/software
like disk-subsystems in a GPOS to the point were you can give absolute 
guarantees - what you can achieve though is statistic guarantees, and in
combination with monitoring of the cached data you can (atleast for 
some access patters) give guarantees about the behavior of the system.

hofrat

RAT http://www.osadl.org/Papers.rtlws-2004-papers.0.html#PAPER_2590
RTLFS http://www.osadl.org/Papers.rtlws-2004-papers.0.html#PAPER_1889


