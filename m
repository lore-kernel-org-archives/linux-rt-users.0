From: Guennadi Liakhovetski <gl@dsa-ac.de>
Subject: Re: changes to task_blocks_on_rt_mutex between 18-rt6 and 20-rc5-rt3
Date: Wed, 17 Jan 2007 11:46:54 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701171127030.16286@pcgl.dsa-ac.de>
References: <Pine.LNX.4.63.0701161642470.16286@pcgl.dsa-ac.de>
 <1169025704.2941.215.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.dsa-ac.de ([62.112.80.99]:51245 "EHLO mail.dsa-ac.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932270AbXAQKq4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 17 Jan 2007 05:46:56 -0500
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <1169025704.2941.215.camel@localhost.localdomain>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Thomas,

On Wed, 17 Jan 2007, Thomas Gleixner wrote:

> On Tue, 2007-01-16 at 16:46 +0100, Guennadi Liakhovetski wrote:
>> I noticed that the above function in kernel/rtmutex.c has changed a lot,
>> and I do have a problem in that function under some realtime load.
>
> Which problem do you have ? Can you describe it a bit more detailed ? Do
> you have a testcase to reproduce it ?

Ok, I have a real-time kernel thread and an interrupt handler (running as 
thread), the ISR wakes the task up with a wake_up, the task sleeps on a 
hr-timer. So far the ISR has a lower rt-priority than the task. I'll 
change it in the future, just haven't figured out yet how to do it 
"immediately" on request_irq(), and if there's an API at all to get to 
IRQ's thread without going over irq_desc or whatever struct it is in.

Normally it works, but sometimes I get Oopses like this one:

Unable to handle kernel paging request at virtual address 00025d87
pgd = c0004000
[00025d87] *pgd=00000000
Internal error: Oops: f3 [#1]
Modules linked in: vci_bus_log j1939 j1939_tp uds_sim uds iso15765_2
pr2000 prtp prtp20 kw1281 lin_zkl k_line vci_uart can_zkl vci_can
vdm_can vci_core vdm_lib ohci_hcd rtx logiuart hw_setup_core rfcomm
l2cap hci_usb bluetooth zd1211rw firmware_class ieee80211softmac
ieee80211 ieee80211_crypt colibri_bl backlight rtc_dev rtc_pcf8583
rtc_core i2c_dev i2c_pxa i2c_core uinput fpga_kbd spartan2 evdev
snd_pxa2xx_ac97 snd_pxa2xx_pcm snd_ac97_codec snd_pcm snd_timer snd
soundcore snd_page_alloc ucb1x00_ts ucb1400_core snd_ac97_bus usbcore
dm9000 mii
CPU: 0
PC is at task_blocks_on_rt_mutex+0xb8/0x2a8
LR is at __rt_mutex_adjust_prio+0x14/0x30
pc : [<c005c14c>]    lr : [<c005b764>]    Tainted: P
sp : c052dd4c  ip : c052dda0  fp : c052dd84
r10: 00028164  r9 : c052dd88  r8 : 00000000
r7 : c14896f0  r6 : c052c000  r5 : c052dd88  r4 : 60000013
r3 : c052dda8  r2 : c14896f8  r1 : 00025d67  r0 : 00025d5b
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  Segment kernel
Control: 397F  Table: A2864000  DAC: 00000017
Process vdm (pid: 16983, stack limit = 0xc052c258)
Stack: (0xc052dd4c to 0xc052e000)
dd40:                            00000000 c026f8b0 00000000 00000000 c052c000
dd60: c14896f0 c14896f0 ffffffff 00000000 c052de1c c1489714 c052ddd8 c052dd88
dd80: c01ddee0 c005c0a0 00000012 c052dd8c c052dd8c c052dd94 c052dd94 00000012
dda0: c052dda0 c052dda0 c052dda8 c052dda8 c08e6060 c14896f0 c052de28 c052de1c
ddc0: c14896f0 00000000 c14896f0 c052dde8 c052dddc c01de284 c01dddac c052de04
dde0: c052ddec c0053510 c01de24c 00000000 00000000 00000000 c052de58 c052de08
de00: bf112314 c00534e0 00000000 c08e6060 c0053544 c052de28 c052de28 00000000
de20: c08e6060 c0053544 c1489708 c1489708 00101dbe 00000000 c14896f0 c1489600
de40: c14896f0 00000000 c14896b8 c052de74 c052de5c bf11237c bf1121dc 00000000
de60: 7ad755bb 00000010 c052def8 c052de78 bf133db8 bf112354 c052de8c f0180000
de80: bf135264 80000013 ffffffff c052dedc c052de9c bf135620 bf135248 c052ded4
dea0: c15dcd40 00000001 00000000 000ea600 0000000a c1489600 00000005 c1489600
dec0: 00000080 c486d000 00000000 0004f588 00101dfa 00000000 00000001 00000080
dee0: c486d000 00000000 0004f588 c052df14 c052defc bf133910 bf133cb4 00000000
df00: 00000001 c1489600 c052df4c c052df18 bf13c3ec bf1338d8 00000000 c052df3c
df20: c052df2c c486d2dc c486d198 c486d000 c4877000 bf11e9e0 00000000 00000000
df40: c052df74 c052df50 bf13cee4 bf13c35c c110d660 c4877000 bf11e9e0 c486d000
df60: 00000004 c110d660 c052dfa0 c052df78 bf11d168 bf13ce94 bf11e9e0 00000004
df80: c486d000 c110d660 c1649dd0 bf11c4d4 fffffffc c052dfc4 c052dfa4 bf11c51c
dfa0: bf11d100 c052dfb0 c01dc908 c01dc04c c110d660 c052c000 c052dff4 c052dfc8
dfc0: c005303c bf11c4e0 00000001 ffffffff ffffffff 00000000 00000000 00000000
dfe0: 00000000 00000000 00000000 c052dff8 c003fde8 c0052f3c 3738206e eccc200a
Backtrace:
[<c005c094>] (task_blocks_on_rt_mutex+0x0/0x2a8) from [<c01ddee0>] (rt_spin_lock_slowlock+0x140/0x1c8)
[<c01ddda0>] (rt_spin_lock_slowlock+0x0/0x1c8) from [<c01de284>] (__lock_text_start+0x44/0x48)
  r8 = C14896F0  r7 = 00000000  r6 = C14896F0  r5 = C052DE1C
  r4 = C052DE28
[<c01de240>] (__lock_text_start+0x0/0x48) from [<c0053510>] (finish_wait+0x3c/0x70)
[<c00534d4>] (finish_wait+0x0/0x70) from [<bf112314>] (rtpreempt_sem_wait_timed+0x144/0x178 [vdm_lib])
  r6 = 00000000  r5 = 00000000  r4 = 00000000
[<bf1121d0>] (rtpreempt_sem_wait_timed+0x0/0x178 [vdm_lib]) from [<bf11237c>] (rtpreempt_sem_wait_until+0x34/0x38 [vdm_lib])
[<bf112348>] (rtpreempt_sem_wait_until+0x0/0x38 [vdm_lib]) from [<bf133db8>] (bdGetBaudrate+0x110/0x768 [vci_uart])
  r6 = 00000010  r5 = 7AD755BB  r4 = 00000000
[<bf133ca8>] (bdGetBaudrate+0x0/0x768 [vci_uart]) from [<bf133910>] (UART_get_baudrate+0x44/0x4c [vci_uart])
[<bf1338cc>] (UART_get_baudrate+0x0/0x4c [vci_uart]) from [<bf13c3ec>] (K_line_sync_char_recv+0x9c/0x168 [k_line])
  r6 = C1489600  r5 = 00000001  r4 = 00000000
[<bf13c350>] (K_line_sync_char_recv+0x0/0x168 [k_line]) from [<bf13cee4>] (PoSyncByte+0x5c/0xd0 [k_line])
[<bf13ce88>] (PoSyncByte+0x0/0xd0 [k_line]) from [<bf11d168>] (Scheduler+0x74/0xe0 [vci_core])
  r6 = C110D660  r5 = 00000004  r4 = C486D000
[<bf11d0f4>] (Scheduler+0x0/0xe0 [vci_core]) from [<bf11c51c>] (vci_driver_task+0x48/0x54 [vci_core])
  r8 = FFFFFFFC  r7 = BF11C4D4  r6 = C1649DD0  r5 = C110D660
  r4 = C486D000
[<bf11c4d4>] (vci_driver_task+0x0/0x54 [vci_core]) from [<c005303c>] (kthread+0x10c/0x138)
  r5 = C052C000  r4 = C110D660
[<c0052f30>] (kthread+0x0/0x138) from [<c003fde8>] (do_exit+0x0/0x9b4)
  r8 = 00000000  r7 = 00000000  r6 = 00000000  r5 = 00000000
  r4 = 00000000
Code: e1510002 e5833004 0a000007 e241000c (e590302c)

(yes, tainted, you know, it's the software that has been written before 
Linux...) I understand this happens when the IST and the task content on 
the mutex. If I set task's priority below that of ISR, this crash doesn't 
happen. As you will understand, unfortunately, I don't have a test case.

Ideas?

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
