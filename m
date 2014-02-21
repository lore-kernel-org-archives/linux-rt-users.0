From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: locking changes in tty broke low latency feature
Date: Fri, 21 Feb 2014 15:43:54 +0000
Message-ID: <20140221154354.5b1d8969@alan.etchedpixels.co.uk>
References: <peter@hurleysoftware.com>
	<20140220215541.7D694406062@ip-64-139-1-69.sjc.megapath.net>
	<le5uot$si0$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <le5uot$si0$1@ger.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> Back in the old days, when a serial driver pushed characters up to the
> tty layer it didn't immediately wake up a process that was blocking on
> a read().  AFAICT, that didn't happen until the next system tick. I'm
> not sure if that was just because the scheduler wasn't called until a
> tick happened, or if there was some intermediate tty-layer
> worker-thread that had to run.

Historically the interrupt handler tried to get out of the interrupt as
fast as possible and to do the minimum instruction count, because a 56K
modem on a 486 with a typical 16450A UART was *tight* and also a use case
everyone cared about.

So historically the code worked on the basis that there were two buffers
per tty. Each timer tick the kernel flipped the buffers over (hence the
legancy flip naming here and thre), and processed the data.

We do need low latency to the drivers, for FIFO setting, DMA watermarks
and for some USB dongles for configuring the packetising

Alan
