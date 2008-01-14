From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: 2.6.24-rc7-rt2
Date: Mon, 14 Jan 2008 17:30:41 -0500 (EST)
Message-ID: <Pine.LNX.4.58.0801141730150.3109@gandalf.stny.rr.com>
References: <1200336080.318.8.camel@localhost.localdomain>
 <200801142316.39330.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: LKML <linux-kernel@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
	Thomas Gleixner <tglx@linutronix.de>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758112AbYANWbb@vger.kernel.org>
In-Reply-To: <200801142316.39330.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


On Mon, 14 Jan 2008, Mariusz Kozlowski wrote:

> Hello,
>
> > We are pleased to announce the 2.6.24-rc7-rt2 tree, which can be
> > downloaded from the location:
> >
> >   http://rt.et.redhat.com/download/
>
> Compiles fine but I run into another problem. On startup kernel oopses
> early and this 'oops' loops over and over again on the screen until you
> shut down the box. So I can't (easily) capture the output. I tried different
> boot_delay values but it seems that it doesn't work as intended. Seems that
> it delays only the first printk from oops, then the rest loops over the screen
> without delay - again it becomes unreadable. I used my usual config with a bunch
> of debug options enabled so that maybe is not real rt system case. Also tried to
> bisect it with quilt but that is hard. Lots of patches depends on another patches
> so bisection brakes things. I'll look into this tommorow and reply if I get
> anything substantial.
>
> I attached my config in case anybody wants to try to reproduce that.
>

Turn off LOCKDEP and see if you still have the same problems. This might
be fixed with Daniel's patch.

-- Steve

