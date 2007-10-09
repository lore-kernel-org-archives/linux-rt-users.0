From: John Sigler <linux.kernel@free.fr>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 11:39:08 +0200
Message-ID: <470B4C3C.3000406@free.fr>
References: <470B44A1.7080007@free.fr> <alpine.LFD.0.9999.0710091117020.25146@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp4-g19.free.fr ([212.27.42.30]:59324 "EHLO smtp4-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752084AbXJIJjK (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Oct 2007 05:39:10 -0400
In-Reply-To: <alpine.LFD.0.9999.0710091117020.25146@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:

> On Tue, 9 Oct 2007, John Sigler wrote:
> 
>> I'm using a -rt kernel with high resolution timer support.
>> http://rt.wiki.kernel.org/index.php/Main_Page
>> Linux version 2.6.22.1-rt9 (root@venus) (gcc version 3.4.6) #1 PREEMPT RT Tue
>> Oct 9 10:02:45 CEST 2007
>>
>> I enabled high resolution timer support and disabled ACPI support.
>> ...
>> High resolution timers do not work in this configuration.
> 
> Correct
> 
>> Any idea why?
> 
> Yes
> 
>> # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
>> tsc pit jiffies
>>
>> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
>> tsc
>>
>> My timestamp counter is good. Why do I need ACPI for hrt?
> 
> We do not trust TSC at all. Never ever.
> 
> The kernel refuses to switch to high resolution mode, when there is no
> reliable backup clock source available. ACPI enables the acpi_pm
> timer, which is a trusted clock source and is used by the kernel to
> verify the correctness of the TSC. You might try to enable HPET.

OK. I seem to remember that you had a patch to enable HPET on ICH4?
Is it still available somewhere?

Regards.
