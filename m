From: John Sigler <linux.kernel@free.fr>
Subject: Re: High resolution timers on ACPI-less kernel
Date: Tue, 09 Oct 2007 11:20:44 +0200
Message-ID: <470B47EC.20604@free.fr>
References: <470B44A1.7080007@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <470B44A1.7080007@free.fr>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

John Sigler wrote:

> I'm using a -rt kernel with high resolution timer support.
> http://rt.wiki.kernel.org/index.php/Main_Page
> Linux version 2.6.22.1-rt9 (root@venus) (gcc version 3.4.6) #1 PREEMPT 
> RT Tue Oct 9 10:02:45 CEST 2007
> 
> I enabled high resolution timer support and disabled ACPI support.
> 
> CONFIG_TICK_ONESHOT=y
> # CONFIG_NO_HZ is not set
> CONFIG_HIGH_RES_TIMERS=y
> CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
> # CONFIG_SMP is not set
> ...
> CONFIG_PREEMPT_RT=y
> CONFIG_PREEMPT=y
> CONFIG_PREEMPT_SOFTIRQS=y
> CONFIG_PREEMPT_HARDIRQS=y
> CONFIG_PREEMPT_BKL=y
> # CONFIG_CLASSIC_RCU is not set
> CONFIG_PREEMPT_RCU=y
> # CONFIG_RCU_TRACE is not set
> CONFIG_X86_UP_APIC=y
> CONFIG_X86_UP_IOAPIC=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> ...
> CONFIG_MTRR=y
> CONFIG_REGPARM=y
> # CONFIG_SECCOMP is not set
> CONFIG_HZ_100=y
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=100
> 
> High resolution timers do not work in this configuration.
> 
> Any idea why?
> 
> # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> tsc pit jiffies
> 
> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> tsc
> 
> My timestamp counter is good. Why do I need ACPI for hrt?

I noticed something strange about IRQ0.
It keeps firing even after the system has booted.

# cat /proc/interrupts ; sleep 10 ; cat /proc/interrupts
            CPU0
   0:     312530   IO-APIC-edge      timer
   2:          0    XT-PIC-XT        cascade
   4:         73   IO-APIC-edge      serial
   8:          1   IO-APIC-edge      rtc
  15:      16085   IO-APIC-edge      ide1
  16:       3302   IO-APIC-fasteoi   eth0
  17:       1560   IO-APIC-fasteoi   eth1
  18:       1560   IO-APIC-fasteoi   eth2
  19:       1560   IO-APIC-fasteoi   eth3
NMI:          0
LOC:     312489
ERR:          0
MIS:          0

            CPU0
   0:     313532   IO-APIC-edge      timer
   2:          0    XT-PIC-XT        cascade
   4:         73   IO-APIC-edge      serial
   8:          1   IO-APIC-edge      rtc
  15:      16109   IO-APIC-edge      ide1
  16:       3309   IO-APIC-fasteoi   eth0
  17:       1565   IO-APIC-fasteoi   eth1
  18:       1565   IO-APIC-fasteoi   eth2
  19:       1565   IO-APIC-fasteoi   eth3
NMI:          0
LOC:     313492
ERR:          0
MIS:          0

IRQ0 is still firing. (1002 times in 10 s = 100 Hz)
When high resolution timers work, the IRQ0 counter stops incrementing 
after the system has booted. (When the system switches from the PIT to 
the APIC timer AFAIU.) The APIC timer (is that what LOC counts?) also 
fired 1003 times in 10 s = 100 Hz.

Is it normal that both the PIT and the APIC timer keep firing?

Regards.
