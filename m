From: John Sigler <linux.kernel@free.fr>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 12:35:29 +0200
Message-ID: <470B5971.40601@free.fr>
References: <470B44A1.7080007@free.fr> <1191921343.13628.0.camel@godzilla.tecnorama.it> <470B49BD.4070506@free.fr> <alpine.LFD.0.9999.0710091131400.25146@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.0.9999.0710091131400.25146@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Thomas Gleixner wrote:
> On Tue, 9 Oct 2007, John Sigler wrote:
>> Alessio Igor Bogani wrote: 
>>> On Tue, 2007-10-09 at 11:06 +0200, John Sigler wrote:
>>> 
>>>> I enabled high resolution timer support and disabled ACPI support.
>>> 
>>> http://www.mail-archive.com/linux-rt-users@vger.kernel.org/msg00375.html
>>
>> There are other clock sources on my system.
>> The timestamp counter is reliable (as far as I can tell).
> 
> See previous mail.
> 
>> The LAPIC timer is reliable.
> 
> LAPIC timer is a clock event device, not a clock source. It can be
> used to program the next event, but not to read the time.
> 
>> (I've just disabled the PM timer.)
> 
> Yup, which in turn disables highres.

OK. I have two more questions.

Can the kernel verify the correctness of the TSC with the PIT?

When I enable the ACPI PM timer, the kernel tells me:

* The chipset may have PM-Timer Bug. Due to workarounds for a bug,
* this clock source is slow. If you are sure your timer does not have
* this bug, please use "acpi_pm_good" to disable the workaround

How can I tell whether my PM timer has this bug or not?
(Specific revision? Test app?)

Regards.
