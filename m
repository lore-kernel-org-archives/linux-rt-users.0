From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: locking changes in tty broke low latency feature
Date: Sun, 23 Feb 2014 23:33:21 +0100 (CET)
Message-ID: <alpine.DEB.2.02.1402232330190.21251@ionos.tec.linutronix.de>
References: <20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net> <53056E99.9070900@hurleysoftware.com> <53064672.3000807@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net>,
	One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Hurley <peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <53064672.3000807@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Thu, 20 Feb 2014, Peter Hurley wrote:

> On 02/19/2014 09:55 PM, Peter Hurley wrote:
> > On 02/19/2014 06:06 PM, Hal Murray wrote:
> > > > Can you give me an idea of your device's average and minimum required
> > > > latency (please be specific)?  Is your target arch x86 [so I can
> > > > evaluate the
> > > > the impact of bus-locked instructions relative to your expected]?
> > > 
> > > The code I'm familiar with is ntpd and gpsd.  They run on almost any
> > > hardware
> > > or OS and talk to a wide collection of devices.
> > > 
> > > There is no hard requirement for latency.  They just work better with
> > > lower
> > > latency.  The lower the better.
> > > 
> > > People gripe about the latency due to USB polling which is about a ms.
> > 
> > Have you tried 3.12+ without low_latency? I ripped out a lot of locks
> > from 3.12+ so it's possible it already meets your requirements.
> 
> Using Alan's idea to mock up a latency test, I threw together a test jig
> using two computers running 3.14-rc1 and my fwserial driver (modified to
> not aggregrate writes) in raw mode where the target does this:

This is a complete pointless test. Use a bog standard 8250 UART on the
PC and connect a microcontroller on the other end which serves you an
continous stream of data at 115200 Baud.

There is no way you can keep up with that without the low latency
option neither on old and nor on new machines if you have enough other
stuff going on in the system.

Thanks,

	tglx



