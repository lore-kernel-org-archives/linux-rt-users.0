From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Changing Kernel thread priorities
Date: Tue, 07 Jun 2011 16:14:40 +0200
Message-ID: <1307456080.2322.264.camel@twins>
References: <17185480.5304.1307435255996.JavaMail.root@WARSBL214.highway.telekom.at>
	 <alpine.LFD.2.02.1106071033350.11814@ionos> <4DEDF1F2.2080204@steinhoff.de>
	 <1307439469.2322.235.camel@twins>
	 <BANLkTi=KPyds_BWYpXHeUkAg000FGSuJOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Armin Steinhoff <armin@steinhoff.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Johannes Bauer <hannes_bauer@aon.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	Rolando Martins <rolando.martins@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BANLkTi=KPyds_BWYpXHeUkAg000FGSuJOQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2011-06-07 at 13:02 +0200, Remy Bohmer wrote:
> Hi All,
> 
> 2011/6/7 Peter Zijlstra <peterz@infradead.org>:
> > On Tue, 2011-06-07 at 11:40 +0200, Armin Steinhoff wrote:
> >> Hi,
> >>
> >> when I read all these confusing statements here ( in german it looks
> >> like an "Eiertanz")  ... I can only say:
> >>
> >> - do the basic stuff in a minimal kernel driver
> >> - use UIO (or VFIO for PCI devices)
> >
> > I see no requirement for any of those horrid things to be used. You can
> > write a full on proper kernel driver, it just cannot set kernel thread
> > priorities to a sane value (let them all default to 50 or so).
> >
> > Then have a user space script or whatever set the kthread priorities.
> >> and you get clean control about your real-time priorities.
> >> I think changing the priorities of "interrupt threads" inside the kernel
> >> could lead to strange race conditions in the kernel.
> 
> Well, I 100% agree that it must be under full userspace control to be
> able to set the priorities. But, the kernel default assumption of
> starting everything at 50 is wrong as well.
> Imagine the following situation:
> * Realtime application is running and has threads active in the range
> of prios 20 - 90.
> * Now bring up a network device, it immediately starts spamming the
> system at prio 50 _before_ you have the chance to set it below 20 by
> means of chrt.
> * RT behaviour is gone!

Good point I guess, Thomas should we default to 1 for everything?
