From: "David Bahi" <dbahi@novell.com>
Subject: nmi_watchdog in latest 22 and 23-rc -rt series
Date: Mon, 10 Sep 2007 20:10:20 -0600
Message-ID: <46E5A4AC0200006C0001822B@sinclair.provo.novell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part2E09801C.0__="
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from sinclair.provo.novell.com ([137.65.248.137]:35575 "EHLO
	sinclair.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965388AbXIKCaf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 10 Sep 2007 22:30:35 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

--=__Part2E09801C.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

trying to get a crashdump in a clean -rt series kernel which hardlocks
on the ltp openposix conformance interfaces sched_yield 1-1.test ...

i was trying with nmi_watchdog =3D 1 (x86_64 machine, dual cpu, quad core,
HT enabled) and it would report NMI LOCKUP on presentation of the login
prompt - no chance to run the test.

                           linux-2.6.22.1-rt9   linux-2.6.23-rc4-rt1
lockup on openposix=20
sched_yield test occurs            yes                  yes

crash on login prompt
with nmi_watchdog=3D1                yes*                 yes*

  (*) console logs attached




--=__Part2E09801C.0__=
Content-Type: text/plain; name="nmi_watchdog_linux-2.6.22.1-rt9.crash.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="nmi_watchdog_linux-2.6.22.1-rt9.crash.log"

 Kernel 2.6.22.1-rt9-rt (ttyS0).


luge login: NMI Watchdog detected LOCKUP on CPU 5
 <<EOE>>
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208cd7>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)
.. [<ffffffff8046416e>] .... __spin_lock+0xe/0x20
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)

NMI show regs on CPU#2:
apic_timer_irqs: 31713
CPU 2:
Modules linked in: ipv6 snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device =
af_packet button battery ac nls_utf8 ntfs loop dm_mod shpchp e752x_edac =
iTCO_wdt snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm floppy ehci_hcd =
uhci_hcd edac_mc i2c_i801 snd_timer iTCO_vendor_support rng_core pci_hotplu=
g snd soundcore snd_page_alloc e1000 usbcore i2c_core rtc_cmos ide_cd =
rtc_core cdrom rtc_lib parport_pc lp parport ext3 mbcache jbd edd fan =
thermal processor ide_generic sg ata_piix libata piix sd_mod scsi_mod =
ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.22.1-rt9-rt #1
RIP: 0010:[<ffffffff80208dc6>]  [<ffffffff80208dc6>] mwait_idle+0x56/0x60
RSP: 0018:ffff810124401f30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff80208d70 RCX: 0000000000000000
RDX: ffff810124401fd8 RSI: ffff810124400010 RDI: ffffffff8052c858
RBP: ffffffff80722100 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003a R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810124bbbd40(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaacf17670 CR3: 000000011e4d7000 CR4: 00000000000006e0

Call Trace:
 <IRQ>  [<ffffffff8026bbb4>] add_preempt_count+0x14/0x110
 [<ffffffff8026bbb4>] add_preempt_count+0x14/0x110
 [<ffffffff8022eb87>] enqueue_task+0x47/0x80
 [<ffffffff8046416e>] __spin_lock+0xe/0x20
 [<ffffffff8023122c>] task_rq_lock+0x4c/0x90
 [<ffffffff8023410c>] try_to_wake_up+0x8c/0x510
 [<ffffffff8023410c>] try_to_wake_up+0x8c/0x510
 [<ffffffff8026bbb4>] add_preempt_count+0x14/0x110
 [<ffffffff8026bbb4>] add_preempt_count+0x14/0x110
 [<ffffffff8022f170>] __rq_clock+0x20/0x90
 [<ffffffff80240a6b>] trigger_softirqs+0x2b/0x40
 [<ffffffff8020b1dc>] call_softirq+0x1c/0x30
 [<ffffffff802414a5>] irq_exit+0x45/0x50
 [<ffffffff8021cc97>] smp_apic_timer_interrupt+0x47/0x70
 [<ffffffff80208d70>] mwait_idle+0x0/0x60
 [<ffffffff8020ac86>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff8046714f>] __atomic_notifier_call_chain+0x4f/0x70
 [<ffffffff80208d70>] mwait_idle+0x0/0x60
 [<ffffffff80208c9c>] cpu_idle+0x7c/0xf0

---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208cd7>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)
.. [<ffffffff8046416e>] .... __spin_lock+0xe/0x20
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)

NMI show regs on CPU#7:
apic_timer_irqs: 31352
CPU 7:
Modules linked in: ipv6 snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device =
af_packet button battery ac nls_utf8 ntfs loop dm_mod shpchp e752x_edac =
iTCO_wdt snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm floppy ehci_hcd =
uhci_hcd edac_mc i2c_i801 snd_timer iTCO_vendor_support rng_core pci_hotplu=
g snd soundcore snd_page_alloc e1000 usbcore i2c_core rtc_cmos ide_cd =
rtc_core cdrom rtc_lib parport_pc lp parport ext3 mbcache jbd edd fan =
thermal processor ide_generic sg ata_piix libata piix sd_mod scsi_mod =
ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.22.1-rt9-rt #1
RIP: 0010:[<ffffffff80208dc6>]  [<ffffffff80208dc6>] mwait_idle+0x56/0x60
RSP: 0018:ffff810124603f30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff80208d70 RCX: 0000000000000000
RDX: ffff810124603fd8 RSI: ffff810124602010 RDI: ffffffff8052c858
RBP: ffffffff80722100 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000039 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8101245151c0(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaac2c5520 CR3: 000000011c844000 CR4: 00000000000006e0
r
Call Trace:
 <#MC>  <<EOE>>
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208cd7>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)
.. [<ffffffff8046416e>] .... __spin_lock+0xe/0x20
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)

NMI show regs on CPU#6:
apic_timer_irqs: 31424
CPU 6:
Modules linked in: ipv6 snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device =
af_packet button battery ac nls_utf8 ntfs loop dm_mod shpchp e752x_edac =
iTCO_wdt snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm floppy ehci_hcd =
uhci_hcd edac_mc i2c_i801 snd_timer iTCO_vendor_support rng_core pci_hotplu=
g snd soundcore snd_page_alloc e1000 usbcore i2c_core rtc_cmos ide_cd =
rtc_core cdrom rtc_lib parport_pc lp parport ext3 mbcache jbd edd fan =
thermal processor ide_generic sg ata_piix libata piix sd_mod scsi_mod =
ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.22.1-rt9-rt #1
RIP: 0010:[<ffffffff80208dc6>]  [<ffffffff80208dc6>] mwait_idle+0x56/0x60
RSP: 0018:ffff8101245adf30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff80208d70 RCX: 0000000000000000
RDX: ffff8101245adfd8 RSI: ffff8101245ac010 RDI: ffffffff8052c858
RBP: ffffffff80722100 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003a R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8101245159c0(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaac4f0000 CR3: 000000011e75c000 CR4: 00000000000006e0

Call Trace:
 <#MC>  <<EOE>>
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208cd7>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)
.. [<ffffffff8046416e>] .... __spin_lock+0xe/0x20
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)

NMI show regs on CPU#3:
apic_timer_irqs: 31641
CPU 3:
Modules linked in: ipv6 snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device =
af_packet button battery ac nls_utf8 ntfs loop dm_mod shpchp e752x_edac =
iTCO_wdt snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm floppy ehci_hcd =
uhci_hcd edac_mc i2c_i801 snd_timer iTCO_vendor_support rng_core pci_hotplu=
g snd soundcore snd_page_alloc e1000 usbcore i2c_core rtc_cmos ide_cd =
rtc_core cdrom rtc_lib parport_pc lp parport ext3 mbcache jbd edd fan =
thermal processor ide_generic sg ata_piix libata piix sd_mod scsi_mod =
ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.22.1-rt9-rt #1
RIP: 0010:[<ffffffff80208dc6>]  [<ffffffff80208dc6>] mwait_idle+0x56/0x60
RSP: 0018:ffff810124453f30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff80208d70 RCX: 0000000000000000
RDX: ffff810124453fd8 RSI: ffff810124452010 RDI: ffffffff8052c858
RBP: ffffffff80722100 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000038 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810124bbb540(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000000a96448 CR3: 0000000000201000 CR4: 00000000000006e0

Call Trace:
 <#MC>  <<EOE>>
---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208cd7>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)
.. [<ffffffff8046416e>] .... __spin_lock+0xe/0x20
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)

CPU 5
Modules linked in: ipv6 snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device =
af_packet button battery ac nls_utf8 ntfs loop dm_mod shpchp e752x_edac =
iTCO_wdt snd_intel8x0 snd_ac97_codec ac97_bus snd_pcm floppy ehci_hcd =
uhci_hcd edac_mc i2c_i801 snd_timer iTCO_vendor_support rng_core pci_hotplu=
g snd soundcore snd_page_alloc e1000 usbcore i2c_core rtc_cmos ide_cd =
rtc_core cdrom rtc_lib parport_pc lp parport ext3 mbcache jbd edd fan =
thermal processor ide_generic sg ata_piix libata piix sd_mod scsi_mod =
ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.22.1-rt9-rt #1
RIP: 0010:[<ffffffff80208dc6>]  [<ffffffff80208dc6>] mwait_idle+0x56/0x60
RSP: 0018:ffff81012453bf30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff80208d70 RCX: 0000000000000000
RDX: ffff81012453bfd8 RSI: ffff81012453a010 RDI: ffffffff8052c858
RBP: ffffffff80722100 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003e R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810124490340(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 0000000041cf2000 CR3: 000000011e75c000 CR4: 00000000000006e0
Process swapper (pid: 0, threadinfo ffff81012453a000, task ffff810124539540=
)
Stack:  ffffffff80208c9c 0000000000000000 0000000000000000 0000000000000000=

 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff80208c9c>] cpu_idle+0x7c/0xf0

---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff80208cd7>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf9000/0x20)


Code: c3 fb c3 66 66 66 90 66 66 90 65 48 8b 0c 25 00 00 00 00 48

--=__Part2E09801C.0__=
Content-Type: text/plain; name="nmi_watchdog_linux-2.6.23-rc4-rt1.crash.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="nmi_watchdog_linux-2.6.23-rc4-rt1.crash.log"

Kernel 2.6.23-rc4-rt1-rt (ttyS0).


luge login: stopped custom tracer.
NMI Watchdog detected LOCKUP on CPU 5
CPU 5
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device ipv6 =
af_packet button battery ac nls_utf8 ntfs loop dm_mod ehci_hcd uhci_hcd =
usbcore iTCO_wdt floppy i2c_i801 snd_intel8x0 snd_ac97_codec ac97_bus =
iTCO_vendor_support snd_pcm rng_core snd_timer shpchp snd soundcore ide_cd =
pci_hotplug snd_page_alloc cdrom e1000 rtc_cmos i2c_core rtc_core rtc_lib =
parport_pc lp parport ext3 mbcache jbd edd fan thermal processor sg =
ide_generic ata_piix libata piix sd_mod scsi_mod ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.23-rc4-rt1-rt #1
RIP: 0010:[<ffffffff8020adf6>]  [<ffffffff8020adf6>] mwait_idle+0x56/0x60
RSP: 0018:ffff81012453bf30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff8020ada0 RCX: 0000000000000000
RDX: ffff81012453bfd8 RSI: ffff81012453a010 RDI: ffffffff805374d0
RBP: ffffffff8072f080 R08: 0000000000000000 R09: ffff81000506a968
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8101244422c0(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaabcbe000 CR3: 000000011edfa000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 0, threadinfo ffff81012453a000, task ffff810124539540=
)
Stack:  ffffffff8020accc 0000000000000000 0000000000000000 0000000000000000=

 0000000000000000 0000000000000000 0000000000000000 0000000000000000
 0000000000000000 0000000000000000 0000000000000000 0000000000000000
Call Trace:
 [<ffffffff8020accc>] cpu_idle+0x7c/0xf0

---------------------------
| preempt count: 00010001 ]
| 1-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8020ad07>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf7000/0x20)


Code: c3 fb c3 66 66 66 90 66 66 90 65 48 8b 0c 25 00 00 00 00 48
 [<ffffffff80232f49>] __update_rq_clock+0x49/0x120
 [<ffffffff8024399b>] trigger_softirqs+0x2b/0x40
 [<ffffffff8020d25c>] call_softirq+0x1c/0x30
 [<ffffffff80243e12>] irq_exit+0x62/0x90
 [<ffffffff8021edf7>] smp_apic_timer_interrupt+0x47/0x70
 [<ffffffff8020ada0>] mwait_idle+0x0/0x60
 [<ffffffff8020cd06>] apic_timer_interrupt+0x66/0x70
 <EOI>  [<ffffffff8046e2d5>] notifier_call_chain+0x45/0x90
 [<ffffffff8046e36f>] __atomic_notifier_call_chain+0x4f/0x70
 [<ffffffff8020ada0>] mwait_idle+0x0/0x60
 [<ffffffff8020accc>] cpu_idle+0x7c/0xf0

---------------------------
| preempt count: 00010002 ]
| 2-level deep critical section nesting:
----------------------------------------
.. [<ffffffff8020ad07>] .... cpu_idle+0xb7/0xf0
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf7000/0x20)
.. [<ffffffff8046b2de>] .... __spin_lock+0xe/0x20
.....[<00000000>] ..   ( <=3D run_init_process+0x7fdf7000/0x20)

NMI show regs on CPU#3:
apic_timer_irqs: 29907
CPU 3:
Modules linked in: snd_pcm_oss snd_mixer_oss snd_seq snd_seq_device ipv6 =
af_packet button battery ac nls_utf8 ntfs loop dm_mod ehci_hcd uhci_hcd =
usbcore iTCO_wdt floppy i2c_i801 snd_intel8x0 snd_ac97_codec ac97_bus =
iTCO_vendor_support snd_pcm rng_core snd_timer shpchp snd soundcore ide_cd =
pci_hotplug snd_page_alloc cdrom e1000 rtc_cmos i2c_core rtc_core rtc_lib =
parport_pc lp parport ext3 mbcache jbd edd fan thermal processor sg =
ide_generic ata_piix libata piix sd_mod scsi_mod ide_disk ide_core
Pid: 0, comm: swapper Not tainted 2.6.23-rc4-rt1-rt #1
RIP: 0010:[<ffffffff8020adf6>]  [<ffffffff8020adf6>] mwait_idle+0x56/0x60
RSP: 0018:ffff810124473f30  EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffffff8020ada0 RCX: 0000000000000000
RDX: ffff810124473fd8 RSI: ffff810124472010 RDI: ffffffff805374d0
RBP: ffffffff8072f080 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff810124bc44c0(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0018 ES: 0018 CR0: 000000008005003b
CR2: 00002aaaabca7018 CR3: 000000011f8b1000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400

--=__Part2E09801C.0__=
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEuNC4yIChHTlUv
TGludXgpCgppRDhEQlFCRzVmaDRIMjhKSFlhekxhUVJBcTgwQUtDK2RjeEMvYWI5MlE1eHFUMGU2
RXhmb29MR3ZRQ2ZaZWJIClZYRm1TRElsNnpzOXFjbXEweUQ2UTgwPQo9T0JqaQotLS0tLUVORCBQ
R1AgU0lHTkFUVVJFLS0tLS0KCg==

--=__Part2E09801C.0__=--
