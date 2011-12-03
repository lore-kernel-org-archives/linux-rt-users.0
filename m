From: Chris Edwards <cedwards@ripples.dyndns.org>
Subject: Re: IRQ "nobody cared...Disabling" errors on linux-3.0.10-rt27 on
 SMP AMD64 system
Date: Sat, 03 Dec 2011 22:41:06 +1300
Message-ID: <4ED9EEB2.6070401@ripples.dyndns.org>
References: <4ECCE979.5080109@cedwards.geek.nz>	 <1322056363.20742.45.camel@frodo>  <4ECD7DCC.3000505@ripples.dyndns.org> <1322691017.24563.9.camel@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.kinect.co.nz ([202.74.33.69]:42260 "EHLO kinect.co.nz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753446Ab1LCJl0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Dec 2011 04:41:26 -0500
In-Reply-To: <1322691017.24563.9.camel@frodo>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 01/12/11 11:10, Steven Rostedt wrote:
> On Thu, 2011-11-24 at 12:12 +1300, Chris Edwards wrote:
>> Thanks for the quick reply, Steven.  Booting with "noapic" does seem to
>> avoid the problem with IRQs 17 and 18, and the Firewire audio now works,
>> but the "nobody cared" error now appears for IRQ 7:
> A couple of things:
>
> Could you also try mainline, with "threadirqs" on the command line and
> see if it gives you the same issue. It should also tell you if it is a
> chipset problem or not. Try v3.0, and then v3.2.
>


Thanks - and sorry it's taken a while to finish testing these!  I had 
some problems building and running some of the 3.2 versions.

(BTW, one (possibly useful) thing I found during testing was that the 
burst of interrupt activity on the Firewire IRQ (IRQ 17 when running in 
APIC mode) coincided with network activity, with interrupts on IRQ 26 
apparently being duplicated on IRQ 17.  The Ethernet controller is an 
Intel 82545GM card, on the 64-bit PCI (not the PCI-X) bus on the AMD 8131.)


Here are my testing results:


linux-3.0.9 mainline (no "noapic" or "threadirqs"):

     IRQs:
         17    Firewire
         18    Radeon
         19    Gina24

     Almost no interrupts on IRQ 17 (only 126 in total after 4 minutes 
uptime).

     JACK/FFADO runs OK, ~3200 interrupts/s on IRQ 17 (--rate 96000 
--period 128 --nperiods 3).  DSP load 30%.

     No CAL interrupt storms on GTK text redrawing (which I'd seen on 
2.6), or "irq ... nobody cared" errors.

     Ardour plays nicely.



linux-3.0.9 mainline, with "threadirqs":

     IRQs:
         17    Firewire
         18    Radeon
         19    Gina24

     IRQ 17 is definitely noisier now, with ~500,000 interrupts during 4 
mins uptime without JACK running, but no "nobody cared" errors observed.

     JACK/FFADO runs OK, ~3200 interrupts/s on IRQ 17 (--rate 96000 
--period 128 --nperiods 3).  DSP load 30%.

     PROBLEM: Audio drop-outs and JACK XRUNs while playing back in 
Ardour.  These seem to coincide with extra bursts of interrupt activity 
on IRQ 17 (4,000-10,000 per second, above the 3,200 baseline).  Same 
problem observed using mplayer with JACK playback.



linux-3.2.0-rc4:

     Seemingly OK; same behaviour as for 3.0.9 without "threadirqs".



linux-3.2.0-rc4 with "threadirqs":

     ~40,000 interrupts on IRQ 17 (Firewire) in 4 minutes.

     "nobody cared" message after running NetPIPE to exercise the 
Ethernet controller, having finally identified that as a/the source of 
extraneous IRQs.



linux-3.0.12-rt30-rc1:

     This looks to have the back-ported changes for 3.0-rt that you sent 
as a patch already applied.

     This one seems to have fixed things!  No sign of spurious interrupt 
activity on IRQ 17, and no "nobody cared" messages, even when running 
NetPIPE and gtkperf.  JACK/FFADO and Ardour run pretty reliably.

     I do still have some problems with scratchy audio and excessive CPU 
use when running Pure Data when its graphics get busy, but it seems 
likely this is a Pure Data (or maybe Tk) issue.

     I also fired up LatencyTop to see what sorts of figures it was 
reporting.  The one unusual thing it showed was latencies on the order 
of 50-90 ms for "drm_mode_cursor_ioctl" in Xorg - similar behaviour to 
that described here:

     
http://lists.linuxfoundation.org/pipermail/bugme-new/2011-August/027897.html

     I may have to do some more testing to identify if that's an -rt 
thing or a kernel version thing...


Hope this is helpful. :)  It is for me - I have a pretty usable system 
now. :)

Thanks again,
Chris
