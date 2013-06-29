From: Georg Gast <georg@schorsch-tech.de>
Subject: Searching a Bug on Raspberry Pi
Date: Sat, 29 Jun 2013 20:28:38 +0200
Message-ID: <51CF2756.5080509@schorsch-tech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from schorsch-tech.de ([88.198.48.118]:34459 "EHLO schorsch-tech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752058Ab3F2Sje (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 29 Jun 2013 14:39:34 -0400
Received: from [192.168.178.16] (p57A325B0.dip0.t-ipconnect.de [87.163.37.176])
	by schorsch-tech.de (Postfix) with ESMTPSA id ABA1F84CE3
	for <linux-rt-users@vger.kernel.org>; Sat, 29 Jun 2013 20:30:36 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi there!

Currently i try to locate a bug in sdhci.c on RaspberryPi. I know it is 
not the mainline kernel...

Currently i use Kernel 3.8.13 and RT Patch 3.8.13-rt12 on the kernel 
found at git://github.com/raspberrypi/linux.git on branch rpi-3.8.y.

The bug shows up as booting and after 3 seconds of booting as it wants 
to mount the rootfs in a deadlock. as i compiled sdhci_bcm2708 as a 
module i can boot the kernel and system as i pushed the system to a usb 
stick. As far as good.

Now i try to find the bug, if the rootfs is on the sdcard. I narrowd the 
deadlock down to the following lines:

void sdhci_spin_lock_irqsave(struct sdhci_host *host,unsigned long *flags)
{
     return;
#ifdef CONFIG_PREEMPT
     if(enable_llm)
     {
         while(sdhci_locked)
         {
             preempt_schedule();
         }
         spin_lock_irqsave(&host->lock,*flags);
         disable_irq(host->irq);
         if(host->second_irq)
             disable_irq(host->second_irq);
         local_irq_enable();
     }
     else
#endif
         spin_lock_irqsave(&host->lock,*flags);
}

void sdhci_spin_unlock_irqrestore(struct sdhci_host *host,unsigned long 
flags)
{
     return;
#ifdef CONFIG_PREEMPT
     if(enable_llm)
     {
         local_irq_disable();
         if(host->second_irq)
             enable_irq(host->second_irq);
         enable_irq(host->irq);
     }
#endif
     spin_unlock_irqrestore(&host->lock,flags);
}

in drivers/mmc/host/sdhci.c . The both return statements are added by 
me. Now i can boot the RT Preempt kernel but it is for sure not the 
right fix.

My problem is, that i dont know how those both functions should work 
with the rt preempt patch.

What can you suggest me to fix that deadlock? I already bought the book 
"Linux Kernel Development" but i dont know how the kernel works exaktly 
with the PREEMPT patch. Can you point me to a site which shows how 
RTPREEMPT works in the irqsave/restore functions or can you please 
describe it to me?

Thank you
Georg
