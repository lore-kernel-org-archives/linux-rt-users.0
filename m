From: Georg Gast <georg@schorsch-tech.de>
Subject: Re: Searching a Bug on Raspberry Pi
Date: Sun, 30 Jun 2013 06:42:07 +0200
Message-ID: <51CFB71F.5090401@schorsch-tech.de>
References: <51CF4035.8090100@schorsch-tech.de> <CAFSh4Uz7B8L5Y0nsp1bW4pgPkyqHtXDSM0R-PiRLZQfd+URFYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Tom Cook <tom.k.cook@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from schorsch-tech.de ([88.198.48.118]:34846 "EHLO schorsch-tech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737Ab3F3EoH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 30 Jun 2013 00:44:07 -0400
In-Reply-To: <CAFSh4Uz7B8L5Y0nsp1bW4pgPkyqHtXDSM0R-PiRLZQfd+URFYw@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Tom,

the problem occurs even if i set enable_llm=0. The while loop is now not 
touched and the rpi deadlocks too.

As far as i understand it, the sdhci.c is the base for all sdhci card 
readers and the sdhci-*.c implement the ops for the specific hardware.

My problem is, that i dont have an other sdhci card reader here. It wont 
be possible to boot from, but i could try to read from it on a rt 
kernel. If i compile the sdhci_bcm2708 as a module, i could not get a 
device info from the rpi reader. Maybe an other reader works, then the 
real problem sits in sdhci_bcm2708.c (or at bad luck, it shows an bigger 
problem in sdhci.c).

Georg


Am 29.06.2013 23:36, schrieb Tom Cook:
> This is as far as I've got too.  I think you need to make the while loop
> conditional on CONFIG_PREEMPT_RT_FULL but I haven't had a chance to try it.
>
> Tom
>
> On 29 Jun 2013 21:16, "Georg Gast" <georg@schorsch-tech.de
> <mailto:georg@schorsch-tech.de>> wrote:
>
>     Hi there!
>
>     Currently i try to locate a bug in drivers/mmc/host/sdhci.c on
>     RaspberryPi. I know it is not the mainline kernel...
>
>     Currently i use Kernel 3.8.13 and RT Patch 3.8.13-rt12 on the kernel
>     found at git://github.com/raspberrypi/__linux.git
>     <http://github.com/raspberrypi/linux.git> on branch rpi-3.8.y.
>
>     The bug shows up at booting and after 3 seconds of booting as it
>     wants to mount the rootfs in a deadlock. as i compiled sdhci_bcm2708
>     as a module i can boot the kernel and system as i pushed the system
>     to a usb stick. As far as good.
>
>     Now i try to find the bug, if the rootfs is on the sdcard. I narrowd
>     the deadlock down to the following lines:
>
>     void sdhci_spin_lock_irqsave(struct sdhci_host *host,unsigned long
>     *flags)
>     {
>          return;
>     #ifdef CONFIG_PREEMPT
>          if(enable_llm)
>          {
>              while(sdhci_locked)
>              {
>                  preempt_schedule();
>              }
>              spin_lock_irqsave(&host->lock,__*flags);
>              disable_irq(host->irq);
>              if(host->second_irq)
>                  disable_irq(host->second_irq);
>              local_irq_enable();
>          }
>          else
>     #endif
>              spin_lock_irqsave(&host->lock,__*flags);
>     }
>
>     void sdhci_spin_unlock_irqrestore(__struct sdhci_host *host,unsigned
>     long flags)
>     {
>          return;
>     #ifdef CONFIG_PREEMPT
>          if(enable_llm)
>          {
>              local_irq_disable();
>              if(host->second_irq)
>                  enable_irq(host->second_irq);
>              enable_irq(host->irq);
>          }
>     #endif
>          spin_unlock_irqrestore(&host->__lock,flags);
>     }
>
>     in drivers/mmc/host/sdhci.c . The both return statements are added
>     by me. Now i can boot the RT Preempt kernel but it is for sure not
>     the right fix.
>
>     My problem is, that i dont know how those both functions should work
>     with the rt preempt patch.
>
>     What can you suggest me to fix that deadlock? I already bought the
>     book "Linux Kernel Development" but i dont know how the kernel works
>     exaktly with the PREEMPT patch. Can you point me to a site which
>     shows how RTPREEMPT works in the irqsave/restore functions or can
>     you please describe it to me?
>
>     Thank you
>     Georg
>     --
>     To unsubscribe from this list: send the line "unsubscribe
>     linux-rt-users" in
>     the body of a message to majordomo@vger.kernel.org
>     <mailto:majordomo@vger.kernel.org>
>     More majordomo info at http://vger.kernel.org/__majordomo-info.html
>     <http://vger.kernel.org/majordomo-info.html>
>

