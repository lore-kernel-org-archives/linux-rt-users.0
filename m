From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Changing Kernel thread priorities
Date: Tue, 07 Jun 2011 11:37:49 +0200
Message-ID: <1307439469.2322.235.camel@twins>
References: <17185480.5304.1307435255996.JavaMail.root@WARSBL214.highway.telekom.at>
	 <alpine.LFD.2.02.1106071033350.11814@ionos> <4DEDF1F2.2080204@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Johannes Bauer <hannes_bauer@aon.at>,
	Monica Puig-Pey <puigpeym@unican.es>,
	Rolando Martins <rolando.martins@gmail.com>,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4DEDF1F2.2080204@steinhoff.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 2011-06-07 at 11:40 +0200, Armin Steinhoff wrote:
> Hi,
> 
> when I read all these confusing statements here ( in german it looks 
> like an "Eiertanz")  ... I can only say:
> 
> - do the basic stuff in a minimal kernel driver
> - use UIO (or VFIO for PCI devices)

I see no requirement for any of those horrid things to be used. You can
write a full on proper kernel driver, it just cannot set kernel thread
priorities to a sane value (let them all default to 50 or so).

Then have a user space script or whatever set the kthread priorities.

> and you get clean control about your real-time priorities.
> 
> I think changing the priorities of "interrupt threads" inside the kernel 
> could lead to strange race conditions in the kernel.

No, changing the priority in the kernel is a perfectly sound operation,
it just doesn't make any sense to do so since its impossible to
determine a proper priority.

Therefore setting a priority is a pure user policy and should not be
done by the driver itself -- it simply cannot do it right so why bother
doing it.
