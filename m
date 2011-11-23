From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Wed, 23 Nov 2011 08:52:43 -0500
Message-ID: <1322056363.20742.45.camel@frodo>
References: <4ECCE979.5080109@cedwards.geek.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Chris Edwards <cedwards.linux@cedwards.geek.nz>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.125]:39108 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755399Ab1KWNwq (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 23 Nov 2011 08:52:46 -0500
In-Reply-To: <4ECCE979.5080109@cedwards.geek.nz>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, 2011-11-24 at 01:39 +1300, Chris Edwards wrote:
> Hi all,
> 
> Problem:
> IRQ-related "nobody cared" kernel call traces not long after bootup on 
> Linux 3.0.10-rt27.  I thought I'd try a -rt kernel to see if it would 
> resolve the audio drop-outs on my new Firewire audio interface.

I wonder if this is another bad irq chipset. Does it go away if you boot
with noapic in the kernel command line?

> 
> System:
> Dual Opteron 244 processors on an Iwill DK8N (AMD 8131 and nForce3 250Gb)
> Ubuntu 10.04.3 LTS
> 

> I did try the "irqpoll" kernel command-line option as suggested in the 
> error messages, but the kernel messages say that it's not supported in -rt.

Right. There's an issue on some chipsets that running interrupts as
threads causes the chipset to go into legacy mode, and interrupts coming
in on one apic line, appear on another line. There is a work around for
it (I believe), and we black list these chipsets, but as with all black
lists, we only list those that we know about. Yours may be a new one.


> 
> Needless to say, the Firewire audio is a no-go.
> 
> I'm also having trouble getting dual-head X to work, but that's another 
> issue, most likely.  I'm also wondering if I can get the HPET timer 
> enabled: AFAICT (from looking at other BIOSes) the nForce3 has one, but 
> this system's ACPI tables don't advertise it.

Keep us posted. Thanks!

-- Steve


