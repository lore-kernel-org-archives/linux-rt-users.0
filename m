From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Subject: Re: [PATCH] expand /proc/interrupts to include missing vectors, v2
Date: Wed, 1 Aug 2007 09:29:04 -0400
Message-ID: <20070801132904.GA14084@csclub.uwaterloo.ca>
References: <20070726180522.GA1486@tsunami.ccur.com> <46A8EE78.4040702@zytor.com> <1185816797.3170.1.camel@sven.thebigcorporation.com> <20070730123206.abeab890.akpm@linux-foundation.org> <20070731001718.GA14295@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Sven-Thorsten Dietrich <sdietrich@novell.com>,
	"H. Peter Anvin" <hpa@zytor.com>, mingo@elte.hu,
	tglx@linutronix.de, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, jason.baietto@ccur.com
To: Joe Korty <joe.korty@ccur.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764908AbXHAN31@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070731001718.GA14295@tsunami.ccur.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Mon, Jul 30, 2007 at 08:17:18PM -0400, Joe Korty wrote:
> Add missing IRQs and IRQ descriptions to /proc/interrupts.
> 
> /proc/interrupts is most useful when it displays every
> IRQ vector in use by the system, not just those somebody
> thought would be interesting.
> 
> This patch inserts the following vector displays to the
> i386 and x86_64 platforms, as appropriate:
> 	
> 	rescheduling interrupts
> 	TLB flush interrupts
> 	function call interrupts
> 	thermal event interrupts
> 	threshold interrupts
> 	spurious interrupts
> 
> A threshold interrupt occurs when ECC memory correction
> is occuring at too high a frequency.  Thresholds are used
> by the ECC hardware as occasional ECC failures are part
> of normal operation, but long sequences of ECC failures
> usually indicate a memory chip that is about to fail.
> 
> Thermal event interrupts occur when a temperature threshold
> has been exceeded for some CPU chip.  IIRC, a thermal
> interrupt is also generated when the temperature drops
> back to a normal level.
> 
> A spurious interrupt is an interrupt that was raised then
> lowered by the device before it could be fully processed
> by the APIC.  Hence the apic sees the interrupt but does
> not know what device it came from.  For this case the APIC
> hardware will assume a vector of 0xff.
> 
> Rescheduling, call, and TLB flush interrupts are sent from
> one CPU to another per the needs of the OS.  Typically,
> their statistics would be used to discover if an
> interrupt flood of the given type has been occuring.

Since you are playing with /proc/interrupts, is there any chance you
could make it make sense too?

Right now I have the annoying issue that /proc/interrupts only shows
interrupts that it sees a handler for, and ignores the rest.  For some
reason irq 3 never shows up in /proc/interrupts on my system, even
though I have serial ports on both IRQ 3 and 4.  Only irq 4 shows
'serial' as the handler, and is the only one shown.  irq 3 is getting
lots of interrupts, and the serial driver is handling them, it just
doesn't show up in /proc/interrupts.  procinfo does show irq 3 although
with no handler listed.  I think any interrupt with a handler AND any
interrupt with a non zero count ought to be shown.  I only happened to
try procinfo by chance and discover that while I thought IRQ 3 wasn't
working, the only issue was that /proc/interrupts simply wasn't showing
all the relevant information.

Of course I would also love to know why irq 3 isn't showing serial as
the handler, but I have no idea why that is.  This is all using Debian's
2.6.18 kernel.

--
Len Sorensen
