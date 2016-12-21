From: Ralf Mardorf <ralf.mardorf@alice-dsl.net>
Subject: Re: PreSonus AudioBox 1818VSL
Date: Wed, 21 Dec 2016 17:24:29 +0100
Message-ID: <20161221172429.435a7eb2@archlinux.localdomain>
References: <36yxloh9es4k88jayas26nhu.1482244704762@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: linux-rt users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail227c50.megamailservers.eu ([91.136.10.237]:51368 "EHLO
        mail36c50.megamailservers.eu" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758459AbcLUQkG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Dec 2016 11:40:06 -0500
Received: from archlinux.localdomain (x5ce0d178.dyn.telefonica.de [92.224.209.120])
        (authenticated bits=0)
        by mail36c50.megamailservers.eu (8.14.9/8.13.1) with ESMTP id uBLGOSdE013628
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
        for <linux-rt-users@vger.kernel.org>; Wed, 21 Dec 2016 16:24:31 +0000
In-Reply-To: <36yxloh9es4k88jayas26nhu.1482244704762@email.android.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Intermediate result:

Analog out  1,  2,  3,  4,  5,  6,  7,  8 and
ADAT   out 11, 12, 13, 14, 15, 16, 17, 18 are available, there is audio
output.
Outputs     9, 10  are not tested.

I did listen to one after the other, not to all at the same time, so
they might or might not be in sync.

ALSA mixer is useless, the channels are stereo pairs, so you cannot
adjust a single channel. I don't care, I keep them at max output
and use the DAW's mixer, since you anyway can't rout monitoring. The
analog outputs 7 and 8 are assigned to the phones output, if you want
to use head phones, then you need to use jack to route all channels to
7 and 8. IOW seemingly you need to decide, if you want 8 analog outputs
or 6 outputs and headphones. "Main" seems to be unused. ALSA mixer
allows to set up the clock, available are "ADAT", "SPDIF" or "internal".
I chose "internal" and sync the ADA8000 by wc.

I made a Qtractor loop with 16 instances of fluidsynth DSSI and 2
instances of hexter DSSI, IOW just MIDI, no audio tracks. I used one
output of each DSSI instrument, by jack I assigned 9 DSSI outputs to
playback_7 and 9 DSSI outputs to playback_8.

Usually I use rt patched kernels, for the test I'm using a default
kernel from the official Arch repositories.

The CPU is an AMD dual-core 2.1 GHz, on an ASUS M2A-VM HDMI mobo,
without the HDMI thingy mounted.

Very seldom I get an inaudible xrun (quasi never) with the below jackd
settings.

[rocketmouse@archlinux ~]$ /home/music/presonus_test_2016-Dec/start.sh 
[sudo] password for rocketmouse: 
  Model: 15.107.2 "AMD Athlon(tm) X2 Dual Core Processor BE-2350"
  Memory Size: 3 GB + 512 MB

#free
              total        used        free      shared  buff/cache   available
Mem:        3792432      306800      967076        3648     2518556     3176340
Swap:       4819424           0     4819424

jack2 1.9.10.r202.gf2ece24-1

# grep VSL $0
jackd -Xalsarawmidi -dalsa -dhw:VSL -r48000 -p256 -n2 >/dev/null 2>&1 &

# uname -a
Linux archlinux 4.8.13-1-ARCH #1 SMP PREEMPT Fri Dec 9 07:24:34 CET 2016 x86_64 GNU/Linux

# rtirq status

  PID CLS RTPRIO  NI PRI %CPU STAT COMMAND	
  125 FF      90   - 130  3.1 S    irq/19-ehci_hcd	
  130 FF      90   - 130  0.0 S    irq/16-ohci_hcd	
  151 FF      89   - 129  0.0 S    irq/17-ohci_hcd	
  154 FF      88   - 128  0.0 S    irq/18-ohci_hcd	
  155 FF      88   - 128  0.0 S    irq/17-ohci_hcd	
  157 FF      87   - 127  0.0 S    irq/18-ohci_hcd	
  279 FF      85   - 125  0.0 S    irq/18-snd_hdsp	
   32 FF      50   -  90  0.0 S    irq/9-acpi	
   48 FF      50   -  90  0.0 S    irq/8-rtc0	
   78 FF      50   -  90  0.0 S    irq/26-radeon	
  116 FF      50   -  90  0.0 S    irq/1-i8042	
  129 FF      50   -  90  0.0 S    irq/22-firewire	
  132 FF      50   -  90  0.0 S    irq/22-ahci[000	
  141 FF      50   -  90  0.0 S    irq/14-pata_ati	
  143 FF      50   -  90  0.0 S    irq/15-pata_ati	
  256 FF      50   -  90  0.0 S    irq/7-parport0	
  483 FF      50   -  90  0.0 S    irq/27-enp3s0	
    3 TS       -   0  19  0.0 S    ksoftirqd/0	
   17 TS       -   0  19  0.0 S    ksoftirqd/1	

# zgrep PREE /proc/config.gz

CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_NOTIFIERS=y
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
# CONFIG_DEBUG_PREEMPT is not set
# CONFIG_PREEMPT_TRACER is not set

# zgrep HRT  /proc/config.gz

CONFIG_SCHED_HRTICK=y
CONFIG_SND_HRTIMER=m
CONFIG_SND_SEQ_HRTIMER_DEFAULT=y
# CONFIG_IIO_HRTIMER_TRIGGER is not set

# zgrep _HZ  /proc/config.gz

CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
# CONFIG_NO_HZ is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300


#!/bin/dash

#clear
#killall -q -9 qtractor qjackctl jackd

echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor >/dev/null

hwinfo --cpu    |grep Model | sort -u
hwinfo --memory |grep Size

echo
echo "#free"
free

echo
pacman -Q jack2
printf "\n# "
grep VSL $0
echo 

echo "# uname -a"
uname -a

echo
echo "# rtirq status"
rtirq status

echo "# zgrep PREE /proc/config.gz"
echo
zgrep PREE /proc/config.gz
echo
echo "# zgrep HRT  /proc/config.gz"
echo
zgrep HRT  /proc/config.gz
echo
echo "# zgrep _HZ  /proc/config.gz"
echo
zgrep _HZ  /proc/config.gz

sleep 1
jackd -Xalsarawmidi -dalsa -dhw:VSL -r48000 -p256 -n2 >/dev/null 2>&1 &
sleep 2
qjackctl >/dev/null 2>&1 &
sleep 2
qtractor /home/music/presonus_test_2016-Dec/presonus_test_phones.qtr >/dev/null 2>&1 &
sleep 5

echo
echo
cat $0

exit

Regards,
Ralf
