From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH-v2] tty: prevent unnecessary work queue lock checking on
 flip buffer copy
Date: Tue, 25 Sep 2012 14:06:27 +0100
Message-ID: <20120925140627.5aea6ad7@pyramind.ukuu.org.uk>
References: <CAMSQXEGEf8xSYZa+0N77K-Ld5xHLefyMHtK6FxcKCqNhpnMp6g@mail.gmail.com>
	<1348574506-23625-1-git-send-email-meltedpianoman@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Alan Cox <alan@linux.intel.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	<linux-serial@vger.kernel.org>, RT <linux-rt-users@vger.kernel.org>
To: Ivo Sieben <meltedpianoman@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <1348574506-23625-1-git-send-email-meltedpianoman@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> instead of using a work queue in the background. Therefor only in case a
> workqueue is actually used for copying data to the line discipline
> we'll have to check & wait for the workqueue to finish.
> 
> This prevents unnecessary spin lock/unlock on the workqueue spin lock that can
> cause additional scheduling overhead on a PREEMPT_RT system. On a 240 MHz
> AT91SAM9261 processor setup this fixes about 100us of scheduling overhead on the
> TTY read call.

This seems incredibly convoluted and complicated as well as asking for
races and weirdness with the divisibility between the schedule_work and
the atomic operation.

If the only cases are:

	tty->low_latency = 0
				call flush_work
	tty->low_latency = 1
				don't call

	tty->low_latency changes
				call flush_work

then surely the right fix is

	if (tty->low_latency == 0)
		flush_work(&tty->buf.work);

and making the couple of spots we set/unset low latency on a running port
somewhat smarter ?

That avoids an expensive atomic operation as well (and atomic ops are
very expensive on some platforms).

Alan
