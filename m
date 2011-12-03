From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Sat, 3 Dec 2011 17:29:05 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1112031726370.2735@ionos>
References: <4ECCE979.5080109@cedwards.geek.nz>  <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo> <4ED9EEB2.6070401@ripples.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Chris Edwards <cedwards@ripples.dyndns.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:50918 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751807Ab1LCQ3J (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Dec 2011 11:29:09 -0500
In-Reply-To: <4ED9EEB2.6070401@ripples.dyndns.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Sat, 3 Dec 2011, Chris Edwards wrote:
> linux-3.0.9 mainline, with "threadirqs":
> 
>     IRQs:
>         17    Firewire
>         18    Radeon
>         19    Gina24
> 
>     IRQ 17 is definitely noisier now, with ~500,000 interrupts during 4 mins
> uptime without JACK running, but no "nobody cared" errors observed.
> 
>     JACK/FFADO runs OK, ~3200 interrupts/s on IRQ 17 (--rate 96000 --period
> 128 --nperiods 3).  DSP load 30%.
> 
>     PROBLEM: Audio drop-outs and JACK XRUNs while playing back in Ardour.
> These seem to coincide with extra bursts of interrupt activity on IRQ 17
> (4,000-10,000 per second, above the 3,200 baseline).  Same problem observed
> using mplayer with JACK playback.

Ok, that tells us something. So there is something unhappy in your
system about the way how the threaded irq handling works. Can you
please provide the output of lspci -vvv and a full boot log (any
3.0/3.2 kernel you have handy)?

Thanks,

	tglx
