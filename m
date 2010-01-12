From: Sven-Thorsten Dietrich <thebigcorporation@gmail.com>
Subject: Re: [RFC] [rt-tests] change to cyclictest behavior
Date: Tue, 12 Jan 2010 11:59:50 -0500
Message-ID: <1263315590.374.6.camel@sven.thebigcorporation.com>
References: <20100106130400.7f30ae55@torg>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:53598 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751669Ab0ALRAD (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jan 2010 12:00:03 -0500
In-Reply-To: <20100106130400.7f30ae55@torg>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, 2010-01-06 at 13:04 -0600, Clark Williams wrote:
> RT-ers,

Hi Clark,

sorry to be late to this, I have been out on a sailboat in the Bahamas.

When using the histogram feature, cyclictest already behaves the way you
describe below.

Sven

> 
> I have a problem with the way cyclictest sets up measurement threads,
> but before I went and changed things I thought I would ask if people
> cherished this particular behavior. 
> 
> Currently, when cyclictest is run with multiple threads (i.e. -t
> option) it distributes both the sample interval and the realtime
> priority by adding the 'distance' parameter to the interval and
> decrementing the priority by one. This means if you have a distance of
> 500us (default), a specified RT priority of 95 and start four threads,
> they will be started with the following parameters:
> 
> $ cyclictest -t4 -p95
> 
> Will give you:
> 
> thread		priority	sample interval
> 0		95		500
> 1		94		1000
> 2		93		1500
> 3		92		2000
> 
> What I'd like to do is modify this logic so that when '-a' (affinity) is
> specified, the priority and sample interval will not be altered. I
> don't think there's any point in distributing the priority's and
> sample intervals when the measurement threads are pinned to their own
> CPU. 
> 
> So:
> 
> $ cyclictest -t4 -p95 -a
> 
> Would have each thread at SCHED_FIFO 95 and a sample interval of 500us.
> 
> Note that this behavior also occurs when the histogram (-h) option is
> specified).
> 
> Thoughts?
> 
> Clark


