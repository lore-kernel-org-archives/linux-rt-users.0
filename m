From: Len Brown <lenb@kernel.org>
Subject: Re: Pin-pointing the root of unusual application latencies
Date: Wed, 25 Jul 2007 13:09:54 -0400
Message-ID: <200707251309.54240.lenb@kernel.org>
References: <469600F7.3060603@free.fr> <20070725133835.GA17616@elte.hu> <46A758B5.9070602@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ingo Molnar <mingo@elte.hu>, linux-rt-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41508 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753481AbXGYRKD (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 25 Jul 2007 13:10:03 -0400
In-Reply-To: <46A758B5.9070602@free.fr>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Wednesday 25 July 2007 10:05, John Sigler wrote:

> # cat /proc/interrupts
>             CPU0
>    0:         37    XT-PIC-XT        timer
>    1:          2    XT-PIC-XT        i8042
>    2:          0    XT-PIC-XT        cascade
>    7:          0    XT-PIC-XT        acpi
>   10:        175    XT-PIC-XT        eth2, Dta1xx
>   11:       1129    XT-PIC-XT        eth0
>   12:          4    XT-PIC-XT        eth1
>   14:      21482    XT-PIC-XT        ide0
> NMI:          0
> LOC:     161632
> ERR:          0
> MIS:          0
> 
> IRQ 10 is shared between a NIC and an I/O board.
> 
> For eth2, the kernel said:
> ACPI: PCI Interrupt 0000:00:0a.0[A] -> Link [LNKC]
>    -> GSI 10 (level, low) -> IRQ 10
> 
> For Dta1xx, the kernel said:
> ACPI: PCI Interrupt 0000:02:0e.0[A] -> Link [LNKC]
>    -> GSI 10 (level, low) -> IRQ 10
> 
> Is it possible to avoid the two boards sharing IRQ 10?

Maybe.  In this configuration, INTA of the two devices
is physically connected to the same wire on the device-side
of the interrupt re-mapper -- so you'd have to change the configuration.
If you have an IOAPIC and can enable it, that will not hurt --
though unless something else changes, these devices are still
tied together on the device-side of the  mapper.
So if you can physically move one of the devices to another slot
that is your best bet.

I'd need a bunch of info from your system to tell you what
you can do ahead of time, including full dmesg, lspci -vv
and acpidump.

-Len
