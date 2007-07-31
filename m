From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: BIOS implementors disabling the LAPIC
Date: Tue, 31 Jul 2007 11:27:25 +0100 (BST)
Message-ID: <Pine.LNX.4.64N.0707311119350.16158@blysk.ds.pg.gda.pl>
References: <46AEED9E.1050904@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758163AbXGaK1e@vger.kernel.org>
In-Reply-To: <46AEED9E.1050904@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 31 Jul 2007, John Sigler wrote:

> As far as I understand, the Local APIC was integrated directly to the CPU
> 12-15 years ago. Why would a BIOS implementor choose to disable it?

 Because they are lazy/incapable/out-of-time/select-your-favourite-excuse.  
For the chip to work you have to provide some minimal support in the 
firmware, in particular for the trickier paths of execution in the system 
management mode.  The system still works with the Local APIC disabled, so 
why bother?

> (And what does it mean to "disable" the LAPIC?)

 The LINT0 and LINT1 inputs of the APIC are routed straight to the INT and 
NMI inputs of the CPU respectively and the rest of the APIC logic becomes 
inactive (tri-stated, etc.).

  Maciej
