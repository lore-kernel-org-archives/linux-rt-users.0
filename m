From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: locking changes in tty broke low latency feature
Date: Wed, 19 Feb 2014 15:22:14 -0500
Message-ID: <53051276.2070601@hurleysoftware.com>
References: <20140218093829.GC1741@redhat.com>	<5303DABD.9000302@hurleysoftware.com>	<20140219130308.GC1851@redhat.com>	<le2nmd$p1$1@ger.gmane.org>	<5304EC33.5040502@hurleysoftware.com> <20140219191717.486ac4d0@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Grant Edwards <grant.b.edwards@gmail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20140219191717.486ac4d0@alan.etchedpixels.co.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 02/19/2014 02:17 PM, One Thousand Gnomes wrote:
>> How can the requirement be for both must-handle-in-minimum-time data
>> (low_latency) and the-userspace-reader-isn't-reading-fast-enough-
>> so-its-ok-to-halt-transmission ?
>
> Because low latency is about *turn around* time. There are plenty of
> protocols that can flow control, do flow control and want low latency
> because they are not windowed. It's not mutually exclusive by any means.

But if it's all about turn around time, how can the situation devolve to
needing throttling in the first place?  For N_TTY, throttling only happens
when the read queue is close to overflow (only 128 bytes left in 4k buffer).

If the reader isn't pulling _all_ the data out the instant it's woken,
trying to trim off one worker wakeup (by processing input at interrupt time)
is pointless.

>> But first I'd like some hard data on whether or not a low latency
>> mode is even necessary (at least for user-space).
>
> The easy way to simulate the annoying as crap worst cases from dumbass
> firmware downloaders and the like is to set up a link between two PCs and
> time 2000+ repetitions of
>
> send 64 bytes
> wait for a Y
> send 64 bytes
> wait for a Y
> ....
>
> and the matching far end being a box running an existing kernel or a PIC
> or something doing the responses.

Well this is easy enough to mock up.

> Historically we used to lose about 20mS per cycle which over 2000 got to
> be a bit of a PITA.
>
> Low latency goes back to the days of flip buffers, bottom halves an a
> 100Hz clock. There are certainly better ways to do it now if its needed.

Still, as you've pointed out a couple of times, maybe there's a limited
fastpath that's easy and simple. That's why I was asking about throttling
because it's evaluated even for raw mode.

Regards,
Peter Hurley



