From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 0/6] Linux 3.14.48-rt49-rc1
Date: Sat, 8 Aug 2015 19:23:46 -0400
Message-ID: <20150808192346.740ece60@grimm.local.home>
References: <20150806221736.555188732@goodmis.org>
	<20150808231017.GG5998@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150808231017.GG5998@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Sat, 8 Aug 2015 19:10:17 -0400
Paul Gortmaker <paul.gortmaker@windriver.com> wrote:


> So we took 20 IRQs in 5s, or 4/s ; not quite the 1/s minimum, but definitely not
> the HZ/s we'd get w/o NOHZ_FULL.  Re-running it got consistently 18-20 IRQ / 5s.

OK, so NO_HZ_FULL still isn't great on -rt, but this shows that it
keeps disturbances much lower than without it.

Thanks for the report!

-- Steve

> 
> I specifically did NOT unplug and replug cores to "clean" them of tasks; the
> hotplug code just seems to unstable for that from what I've seen in the past,
> and by the looks of the irq counts above, there was no need to either.
> 
> The rootfs was basically a ubu 14.10 server install (no X11/gfx) -- not that
> it should matter - so long as other tasks weren't running on the nohz cores.
> 
> Paul.
> --
> 
> >
> > Enjoy,
> >
> > -- Steve
> >
