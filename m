From: Lukasz Majewski <majess1982@gmail.com>
Subject: [Vortex86] Preempt-rt on Vortex86DX SoC - HIGH_RESOLUTION_TIMER
Date: Mon, 11 Apr 2011 23:26:31 +0200
Message-ID: <20110411232631.12fde0c6@mig>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lukasz Majewski <majess1982@gmail.com>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53495 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755662Ab1DKV0i convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Apr 2011 17:26:38 -0400
Received: by ewy4 with SMTP id 4so1846630ewy.19
        for <linux-rt-users@vger.kernel.org>; Mon, 11 Apr 2011 14:26:36 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I'd like to kindly ask for some help.
I'm using the Vortex86DX SoC (it's a x86 32 clone) on my PC104 board.

I've managed to apply and run the 2.6.33.7.2-rt30 RT linux.

It supports the full preemption (PREEMPT_RT enabled).

I've run the cyclictest and then I've realized, than the
HIGH_RESOLUTION_TIMER is not supported on this SoC (yet... I hope :-) )=
=2E

Moreove the low-res counter resolution is 1ms (as shown at
cat /proc/timer_list), which is unacceptable for the application.=20

I've searched deeper in the spec and I've found, that the Vortex86DX
supports two i8254 timers. One is used for DMA, interrupt controller
and disk, but the second seems to be free :-).

root@lukma:~# cat /proc/ioports=20
0000-001f : dma1
0020-0021 : pic1
0040-0043 : timer0
0050-0053 : timer1 -> for use?


On the i8254 spec it is written, that it is possible to feed the counte=
r
with 10MHz, which would be sufficient.=20

I've poked around in the 2.6.33.7.2-rt30 source code and I've found,
that mostly the COMEDI "staged driver" supports this chip. It looks
that this driver has some issues and should not be used (it looks
rather old).

I have got following questions:
1. It seems, that i8254/53 is in some kind standard timer chip (like
8237- DMA chip) and should already HAVE driver (for x86).

2. It should be possible to use it as a source for HIGH RESOLUTION
TIMER to provide 1/10 MHz =3D 100 ns resolution. (for me 1us is enough)=
=2E
I suppose, that "only" proper callbacks should be provided for
HIGH_RESOLUTION_TIMER framework.

3. It should be a common problem for x86 arch clones to provide one or
another source for HIGH RESOLUTION TIMERS to achieve proper schedule.
How this problem is tackled on the other x86 variants? There MUST be
either Local Advanced Programmable Interrupt Controller (Local APIC) or
High Precision Event Timer. The vortex86DX SoC has 800MHz clock freq,
so 1us timer precision shall be achievable. Is there any Time Stamp
Counter (TSC)?

4. I'd be glad to have an opportunity to solve this problem (I mean to
write a driver for i8254) but I don't want to reinvent the wheel :-)

Any help/ideas/hints are very welcome. I've got some experience with
ARM/PXA cores, so x86 SoC is somewhat new for my real-time adventure.


Thanks in advance and regards,
=C5=81ukasz Majewski
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
