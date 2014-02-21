From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: locking changes in tty broke low latency feature
Date: Fri, 21 Feb 2014 10:58:17 -0500
Message-ID: <53077799.6030700@hurleysoftware.com>
References: <20140218093829.GC1741@redhat.com>	<5303DABD.9000302@hurleysoftware.com>	<20140219130308.GC1851@redhat.com>	<le2nmd$p1$1@ger.gmane.org>	<5304EC33.5040502@hurleysoftware.com>	<20140219191717.486ac4d0@alan.etchedpixels.co.uk>	<53051276.2070601@hurleysoftware.com>	<20140219214242.406e705b@alan.etchedpixels.co.uk>	<5305664C.7080701@hurleysoftware.com> <20140221153946.2bda2ef0@alan.etchedpixels.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Grant Edwards <grant.b.edwards@gmail.com>,
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140221153946.2bda2ef0@alan.etchedpixels.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Alan,

On 02/21/2014 10:39 AM, One Thousand Gnomes wrote:
>> Ok, so this is still only about "best effort", and really bad
>> worst case behavior (that the tty core has no control over) is ok.
>>
>> Going to great lengths to trim one wakeup when nouveau disables interrupts
>> for 2ms seemed like a waste of time.
>
> If it used to work and it doesn't now it's a regression. It's also a
> nasty one if you've removed the facility for it.

I think the consensus is to leave the low_latency facility in, but
remove it's connection to the tty buffers.

If the known-to-be-already-in-non-interrupt-context drivers want,
I can add a different function for executing flush_to_ldisc()
directly. But I don't want to do that without a use-case and test
subject.

>> This change makes flush_to_ldisc() itself safely callable from
>> interrupt context, and:
>> 1. doesn't lose data (ie., buffers if the ldisc is filling up)
>> 2. automatically picks the optimum handling whether the input worker
>>      is running or not
>> 3. doesn't require more locks to exclude flushing or the input worker
>
> Yep
>
>> Putting aside for a moment the issue of termios safety inside
>> the throttle and unthrottle driver methods, the exclusion locks here could
>> be spinlocks if the drivers can be audited/fixed to not sleep here.
>
> That was basically insoluble when the lock first went in. We tried with a
> spinlock but a lot of USB widgets need to go and chatter with the device
> when you do flow control. Flow control is fundamentally ordered but
> asynchronous however so if the right fix was to make the USB dongles
> queue the work then no harm is done (and the queued flow control
> assertion would worst case be no different to a non queued one from a
> queued flush_to_ldisc)

Oh. That's not something I want to take on.

>> Then that just leaves the termios lock, which is a non-trivial problem, and
>> I'm not convinced RCU will magically fix it.
>
> If you pass a snapshot of the termios state down then I think it does,
> but it's still not remotely trivial.

That was my thought too -- that only dependency injection would work.
Which would require adding that to most, if not all, driver methods, which
seems way too painful.

> First question though comes before all of this - and that is do we need
> low_latency at all any more or is the current scheduling logic now good
> enough to do the job anyway.

Right.

Based on my recent test, I think low_latency doesn't need to be a knob for
the tty core. Drivers can continue to use it to mess with their rx fifo
settings and such like.

I plan on sending Greg a patch to do just that, probably this weekend.

Regards,
Peter Hurley
