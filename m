From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 9 Oct 2007 11:22:13 +0200 (CEST)
Message-ID: <alpine.LFD.0.9999.0710091117020.25146@localhost.localdomain>
References: <470B44A1.7080007@free.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, linux-acpi@vger.kernel.org
To: John Sigler <linux.kernel@free.fr>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <470B44A1.7080007@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 9 Oct 2007, John Sigler wrote:
> Hello everyone,
> 
> I'm using a -rt kernel with high resolution timer support.
> http://rt.wiki.kernel.org/index.php/Main_Page
> Linux version 2.6.22.1-rt9 (root@venus) (gcc version 3.4.6) #1 PREEMPT RT Tue
> Oct 9 10:02:45 CEST 2007
> 
> I enabled high resolution timer support and disabled ACPI support.
> ...
> High resolution timers do not work in this configuration.

Correct

> Any idea why?

Yes

> # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> tsc pit jiffies
> 
> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> tsc
> 
> My timestamp counter is good. Why do I need ACPI for hrt?

We do not trust TSC at all. Never ever.

The kernel refuses to switch to high resolution mode, when there is no
reliable backup clock source available. ACPI enables the acpi_pm
timer, which is a trusted clock source and is used by the kernel to
verify the correctness of the TSC. You might try to enable HPET.

       tglx
