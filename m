From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: locking changes in tty broke low latency feature
Date: Tue, 18 Feb 2014 09:57:33 +0000
Message-ID: <20140218095733.0da5b56f@alan.etchedpixels.co.uk>
References: <20140218093829.GC1741@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Hurley <peter@hurleysoftware.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Stanislaw Gruszka <sgruszka@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140218093829.GC1741@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> spin_lock's there. Maybe we can create WQ_HIGHPRI workqueue and schedule
> flush_to_ldisc() work there. Or perhaps users that need to low latency,
> should switch to thread irq and prioritize serial irq to meat
> retirements. Anyway setserial low_latency is now broken and all who use
> this feature in the past can not do this any longer on 3.12+ kernels.

Historically speaking it was never allowed to use low_latency from a port
that did tty_flip_buffer_push from an IRQ as opposed to scheduling work.
The code also rather pre-dates threaded IRQ but that may well be a better
approach.

IMHO the right fix is to fastpath most of the tty layer (non N_TTY ldisc,
N_TTY without ICANON or ECHO*). Most of the remaining tty locking would
then go away almost entirely for these cases and we'd massively improve
things like our dismal 3G modem performance.

Likewise the termios lock can go by using RCU and passing the termios
struct into the driver as a copy of the RCU managed object (so we can
deal with sleeping drivers). Termios structs are tiny so the copying
overhead is basically nil.

It just needs someone sufficiently crazy and with a fair bit of time to
actually do the heavy lifting. I've been poking at bits of it but the
changes when switching ldisc are not entirely trivial and the N_TTY
fastpaths are quite a lot of work. Thankfully the non N_TTY ones are
simple.

Alan
