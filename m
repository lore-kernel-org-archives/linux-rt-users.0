From: Grant Edwards <grant.b.edwards@gmail.com>
Subject: Re: locking changes in tty broke low latency feature
Date: Thu, 20 Feb 2014 22:14:53 +0000 (UTC)
Message-ID: <le5uot$si0$1@ger.gmane.org>
References: <peter@hurleysoftware.com>
 <20140220215541.7D694406062@ip-64-139-1-69.sjc.megapath.net>
Cc: linux-serial@vger.kernel.org, linux-rt-users@vger.kernel.org
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2014-02-20, Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net> wrote:

> Let's go back to the big picture.  In the old old days, time sharing
> systems had lots of serial ports.  It was common for the hardware to
> buffer up several characters before requesting an interrupt in order
> to reduce the CPU load.

There were even serial boards that had a cooked "line mode" which
buffered up a whole line of input: they handled limited line-editing
and didn't interrupt the CPU until they saw 'enter' or 'ctrl-C'.

> There was usually a bit in the hardware to bypass this if you thought
> that response time was more important than CPU load.  I was expecting
> low_latency to set that bit.

It might.  That depends on whether the driver paid any attention to
the low_latency flag.  IIRC, some did, some didn't.

> Is that option even present in modern serial chips?

Sure.  In pretty much all of the UARTs I know of, you can configure
the rx FIFO threshold or disable the rx FIFO altogether [though
setting the threshold to 1 is usually a better idea than disabling the
rx FIFO].  At least one of my serial_core drivers looks at the
low_latency flag and configure a lower rx FIFO threshold if it's set.

> Do the various chips claiming to be 8250/16550 and friends correctly
> implement all the details of the specs?

What specs?

> Many gigabit ethernet controllers have the same issue.  It's often
> called interrupt coalescing.
>
> What/why is the serial/scheduler doing differently in the low_latency
> case?  What case does that help?

Back in the old days, when a serial driver pushed characters up to the
tty layer it didn't immediately wake up a process that was blocking on
a read().  AFAICT, that didn't happen until the next system tick. I'm
not sure if that was just because the scheduler wasn't called until a
tick happened, or if there was some intermediate tty-layer
worker-thread that had to run.

Setting the low_latency flag avoided that.

When the driver pushed characters to the tty layer with the
low_latency flag set, the user-space process that was blocking on
read() would wake up "immediately". This potentially used up a lot
more CPU time, since a user process that is reading a large block of
data _might_ be woken up and then block again for every rx byte --
assuming no rx FIFO.  Without the low_latency flag, the user process
would wake up every 10ms and be handed 10ms worth of data.  (Back then
HZ was always 100.)

At least that's how I remember it...

-- 
Grant Edwards               grant.b.edwards        Yow! My EARS are GONE!!
                                  at               
                              gmail.com            
