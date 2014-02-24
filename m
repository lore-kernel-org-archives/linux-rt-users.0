From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: locking changes in tty broke low latency feature
Date: Mon, 24 Feb 2014 13:23:34 +0000
Message-ID: <20140224132334.313f2527@alan.etchedpixels.co.uk>
References: <20140219230623.736E8406062@ip-64-139-1-69.sjc.megapath.net>
	<53056E99.9070900@hurleysoftware.com>
	<53064672.3000807@hurleysoftware.com>
	<alpine.DEB.2.02.1402232330190.21251@ionos.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Hal Murray <murray+fedora@ip-64-139-1-69.sjc.megapath.net>,
	Stanislaw Gruszka <sgruszka@redhat.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-rt-users@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.02.1402232330190.21251@ionos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

> This is a complete pointless test. Use a bog standard 8250 UART on the
> PC and connect a microcontroller on the other end which serves you an
> continous stream of data at 115200 Baud.
> 
> There is no way you can keep up with that without the low latency
> option neither on old and nor on new machines if you have enough other
> stuff going on in the system.

Sorry but having done this in the past the reverse is true. On ancient
machines with crap uarts the low_latency case would routinely overrun
while the non low_latency case did not. That was half of the point of
deferred processing - it pushed tty processing out of the IRQ handler so
bytes were not lost and a 486DX could cope with a 56Kbit modem.

Alan
