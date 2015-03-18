From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: [ANNOUNCE] 3.18.9-rt5
Date: Wed, 18 Mar 2015 10:08:17 +0100
Message-ID: <20150318100817.73a5e32a@archlinux>
References: <20150316210146.GG28130@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail158c50.megamailservers.eu ([91.136.10.168]:47719 "EHLO
	mail51c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932742AbbCRJIY (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Mar 2015 05:08:24 -0400
Received: from archlinux (g224210139.adsl.alicedsl.de [92.224.210.139])
	(authenticated bits=0)
	by mail51c50.megamailservers.eu (8.13.6/8.13.1) with ESMTP id t2I98HJZ032025
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <linux-rt-users@vger.kernel.org>; Wed, 18 Mar 2015 09:08:20 +0000
In-Reply-To: <20150316210146.GG28130@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

if the powernow-k8 module is loaded my Athlon BE-2350 dual-core machine
hangs at startup. After building the kernel with
"CONFIG_X86_POWERNOW_K8 is not set" startup finishes.

For older linux-rt versions I could unbind 2 USB ports sharing an IRQ
with my sound card, by one and the same script, now it doesn't work
anymore.

The status of rtirq reports one IRQ with a "cryptic" name.
I'm still using rtirq 20130402, not the current version 20150216, but the
version of rtirq seems not to be the culprit.

[1] rtirq status for 3.18.9-rt5
[2] rtirq status for an older kernel

Regards,
Ralf


[1]

[rocketmouse@archlinux ~]$ grep 0000 /usr/local/sbin/tuning
echo -n "0000:00:13.2" > /sys/bus/pci/drivers/ohci_hcd/unbind
echo -n "0000:00:13.4" > /sys/bus/pci/drivers/ohci_hcd/unbind

[rocketmouse@archlinux ~]$ sudo tuning
[sudo] password for rocketmouse: 
/usr/local/sbin/tuning: line 28: /sys/bus/pci/drivers/ohci_hcd/unbind: No such file or directory
/usr/local/sbin/tuning: line 29: /sys/bus/pci/drivers/ohci_hcd/unbind: No such file or directory

########################################################################

# service rtirq status           

  PID CLS RTPRIO  NI PRI %CPU STAT COMMAND	
   46 FF      90   - 130  0.0 S    irq/8-rtc0	
  224 FF      85   - 125  0.0 S    irq/18-snd_hdsp	
  220 FF      80   - 120  0.0 S    irq/20-snd_ice1	
  221 FF      79   - 119  0.0 S    irq/21-snd_ice1	
   78 FF      75   - 115  0.0 S    irq/1-i8042	
   35 FF      50   -  90  0.0 S    irq/9-acpi	
   64 FF      50   -  90  0.0 S    irq/26-radeon	
   84 FF      50   -  90  0.0 S    irq/14-pata_ati	
   85 FF      50   -  90  0.0 S    irq/15-pata_ati	
   92 FF      50   -  90  0.0 S    irq/22-0000:00:	
  102 FF      50   -  90  0.0 S    irq/19-ehci_hcd	
  106 FF      50   -  90  0.0 S    irq/16-ohci_hcd	
  107 FF      50   -  90  0.0 S    irq/17-ohci_hcd	
  109 FF      50   -  90  0.0 S    irq/18-ohci_hcd	
  110 FF      50   -  90  0.0 S    irq/17-ohci_hcd	
  112 FF      50   -  90  0.0 S    irq/18-ohci_hcd	
  205 FF      50   -  90  0.0 S    irq/7-parport0	
  399 FF      50   -  90  0.0 S    irq/27-enp3s0	
    3 FF       1   -  41  0.2 S    ksoftirqd/0	
   19 FF       1   -  41  0.2 S    ksoftirqd/1	

# grep 18: /proc/interrupts
 18:          0          2   IO-APIC  18-fasteoi   ohci_hcd:usb4, ohci_hcd:usb6, snd_hdspm

Tue Mar 17 23:46:10 CET 2015 - 3.18.9-rt5-2-rt - Arch Linux \r (\l)





[2]

[rocketmouse@archlinux ~]$ sudo tuning
[sudo] password for rocketmouse: 

########################################################################

# service rtirq status           

  PID CLS RTPRIO  NI PRI %CPU STAT COMMAND	
   43 FF      90   - 130  0.0 S    irq/8-rtc0	
  197 FF      85   - 125  0.0 S    irq/18-snd_hdsp	
  198 FF      80   - 120  0.0 S    irq/20-snd_ice1	
  199 FF      79   - 119  0.0 S    irq/21-snd_ice1	
   41 FF      75   - 115  0.0 S    irq/1-i8042	
   30 FF      50   -  90  0.0 S    irq/9-acpi	
   61 FF      50   -  90  0.0 S    irq/42-radeon	
   78 FF      50   -  90  0.5 S    irq/22-ahci	
   87 FF      50   -  90  0.0 S    irq/14-pata_ati	
   89 FF      50   -  90  0.0 S    irq/15-pata_ati	
   94 FF      50   -  90  0.0 S    irq/19-ehci_hcd	
   98 FF      50   -  90  0.0 S    irq/16-ohci_hcd	
   99 FF      50   -  90  0.1 S    irq/17-ohci_hcd	
  101 FF      50   -  90  0.0 S    irq/17-ohci_hcd	
  188 FF      50   -  90  0.0 S    irq/7-parport0	
  366 FF      50   -  90  0.0 S    irq/43-enp3s0	
    3 FF       1   -  41  0.5 S    ksoftirqd/0	
   19 FF       1   -  41  0.5 S    ksoftirqd/1	

# grep 18: /proc/interrupts
 18:          0          4   IO-APIC-fasteoi   snd_hdspm

Tue Mar 17 23:59:35 CET 2015 - 3.10.61-rt65-1-rt-lts - Arch Linux \r (\l)
