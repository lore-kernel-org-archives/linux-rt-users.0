From: <Matthias.Buehler@de.trumpf.com>
Subject: CPU stall on 3.12.13-rt21
Date: Thu, 28 May 2015 07:55:16 +0000
Message-ID: <AFDC53D21F2F1F4782A16D848C737357266239EE@srv01mail6.corp.trumpf.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
	boundary="PGP_Universal_2260E0CF_096C206C_11B1D29F_0ED9E427";
	protocol="application/pgp-signature"; micalg=pgp-sha1
To: <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp1.trumpf.com ([160.44.248.162]:48079 "EHLO smtp1.trumpf.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbbE1IFA (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 28 May 2015 04:05:00 -0400
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--PGP_Universal_2260E0CF_096C206C_11B1D29F_0ED9E427
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

I am running two real-time processes on a 3.12.13.rt21.
The first process receives start commands from an external control
via network and relays these starts to the second process. This second
process does the actual job and tells the result back to the first.
This cycle is repeated several times a second.

After some time (half an hour or so) the system stalls. There is no
network connection available. A parallel running GUI is also frozen.

I tried this scenario with 3.12.40-rt55 and 3.18.13-rt9 with the same
result.

Running the second process as SCHED_RR does not lead to this situation.

On the serial console I can see the following output:

[ 2673.830598] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D1500=
0 jiffi
es g=3D102078 c=3D102077 q=3D63)
[ 2673.830599] sending NMI to all CPUs:
[ 2673.830604] NMI backtrace for cpu 0
[ 2673.830610] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 2673.830611] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 2673.830614] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 2673.830617] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 2673.830624] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 2673.830626] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 2673.830628] ESI: c168d580 EDI: f62ce080 EBP: f265fe70 ESP: f265fe68
[ 2673.830630]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 2673.830632] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 2673.830633] Stack:
[ 2673.830638]  c15e278f 0000003f f265feb8 c10a504d c15f48cc 00003a98 00018=
ebe 0
0018ebd
[ 2673.830642]  0000003f f265fe98 00200086 f62d16c0 f265fea0 c1044998 f265e=
000 0
0000000
[ 2673.830647]  c168d580 f13de1c0 00000001 00000000 f265fecc c104b3fb 00000=
000 0
0000000
[ 2673.830648] Call Trace:
[ 2673.830656]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 2673.830661]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 2673.830666]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 2673.830671]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 2673.830676]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 2673.830680]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 2673.830683]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 2673.830689]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 2673.830692]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 2673.830695]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 2673.830700]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 2673.830728] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 2673.830736] NMI backtrace for cpu 1
[ 2673.830743] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 2673.830745] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 2673.830747] task: f4075640 ti: f409c000 task.ti: f409c000
[ 2673.830750] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 2673.830758] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 2673.830761] EAX: 8cacbc00 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 2673.830762] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 2673.830764]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 2673.830766] CR0: 8005003b CR2: b5a3d768 CR3: 35df9000 CR4: 000007d0
[ 2673.830767] Stack:
[ 2673.830774]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 21788d95 00000=
26e 0
0000002
[ 2673.830778]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 2673.830783]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 2673.830784] Call Trace:
[ 2673.830792]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 2673.830796]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 2673.830801]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 2673.830805]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 2673.830810]  [<c102a944>] start_secondary+0x184/0x200
[ 2673.830839] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 2853.956743] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D6000=
3 jiffi
es g=3D102078 c=3D102077 q=3D65)
[ 2853.956744] sending NMI to all CPUs:
[ 2853.956747] NMI backtrace for cpu 0
[ 2853.956750] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 2853.956751] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 2853.956753] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 2853.956755] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 2853.956758] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 2853.956759] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 2853.956761] ESI: c168d580 EDI: f62ce080 EBP: f265fe64 ESP: f265fe5c
[ 2853.956763]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 2853.956765] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 2853.956765] Stack:
[ 2853.956770]  c15e278f 00000041 f265feac c10a504d c15f48cc 0000ea63 00018=
ebe 0
0018ebd
[ 2853.956775]  00000041 f265fe8c 00200086 f62d16c0 f265fe94 c1044998 f265e=
000 0
0000000
[ 2853.956779]  c168d580 f13de1c0 00000000 00000000 f265fec0 c104b3fb 00000=
000 0
0000000
[ 2853.956780] Call Trace:
[ 2853.956784]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 2853.956788]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 2853.956792]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 2853.956795]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 2853.956799]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 2853.956803]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 2853.956806]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 2853.956810]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 2853.956813]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 2853.956816]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 2853.956819]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 2853.956822]  [<c14afb0c>] ? resume_kernel+0x44/0x44
[ 2853.956849] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 2853.956857] NMI backtrace for cpu 1
[ 2853.956864] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 2853.956866] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 2853.956868] task: f4075640 ti: f409c000 task.ti: f409c000
[ 2853.956872] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 2853.956880] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 2853.956882] EAX: 7cf49100 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 2853.956883] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 2853.956885]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 2853.956887] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 2853.956888] Stack:
[ 2853.956895]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 0af28c63 00000=
298 0
0000002
[ 2853.956899]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 2853.956904]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 2853.956905] Call Trace:
[ 2853.956913]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 2853.956916]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 2853.956922]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 2853.956926]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 2853.956931]  [<c102a944>] start_secondary+0x184/0x200
[ 2853.956959] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 3034.082897] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D1050=
06 jiff
ies g=3D102078 c=3D102077 q=3D69)
[ 3034.082898] sending NMI to all CPUs:
[ 3034.082900] NMI backtrace for cpu 0
[ 3034.082903] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 3034.082904] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3034.082906] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 3034.082908] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 3034.082910] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 3034.082912] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 3034.082913] ESI: c168d580 EDI: f62ce080 EBP: f265fd10 ESP: f265fd08
[ 3034.082915]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 3034.082917] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 3034.082917] Stack:
[ 3034.082922]  c15e278f 00000045 f265fd58 c10a504d c15f48cc 00019a2e 00018=
ebe 0
0018ebd
[ 3034.082926]  00000045 f265fd38 00200086 f62d16c0 f265fd40 c1044998 f265e=
000 0
0000000
[ 3034.082930]  c168d580 f13de1c0 00000000 00000000 f265fd6c c104b3fb 00000=
000 0
0000000
[ 3034.082931] Call Trace:
[ 3034.082935]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 3034.082939]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 3034.082942]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 3034.082946]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 3034.082950]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 3034.082953]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 3034.082956]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 3034.082960]  [<c1069a40>] ? wake_up_process+0x30/0x40
[ 3034.082965]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 3034.082967]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 3034.082971]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 3034.082974]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 3034.082977]  [<c14af588>] ? _raw_spin_unlock_irqrestore+0x8/0x40
[ 3034.082980]  [<c1060311>] __hrtimer_start_range_ns+0x191/0x2b0
[ 3034.082983]  [<c1060452>] hrtimer_start_range_ns+0x22/0x30
[ 3034.082987]  [<c14acd97>] do_nanosleep+0xa7/0x130
[ 3034.082991]  [<c10604e8>] __hrtimer_nanosleep+0x88/0x110
[ 3034.082994]  [<c105f440>] ? hrtimer_init_sleeper+0x20/0x20
[ 3034.082997]  [<c1060eab>] hrtimer_nanosleep+0x1b/0x30
[ 3034.083000]  [<c1060f09>] SyS_nanosleep+0x49/0x70
[ 3034.083003]  [<c14afb54>] syscall_call+0x7/0xb
[ 3034.083029] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 3034.083037] NMI backtrace for cpu 1
[ 3034.083044] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 3034.083046] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3034.083049] task: f4075640 ti: f409c000 task.ti: f409c000
[ 3034.083052] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 3034.083060] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 3034.083062] EAX: 6d333b00 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 3034.083064] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 3034.083066]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3034.083068] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 3034.083069] Stack:
[ 3034.083075]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 f46361fb 00000=
2c1 0
0000002
[ 3034.083080]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 3034.083084]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 3034.083085] Call Trace:
[ 3034.083093]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 3034.083097]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 3034.083102]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 3034.083106]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 3034.083111]  [<c102a944>] start_secondary+0x184/0x200
[ 3034.083140] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 3214.209051] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D1500=
09 jiff
ies g=3D102078 c=3D102077 q=3D72)
[ 3214.209052] sending NMI to all CPUs:
[ 3214.209054] NMI backtrace for cpu 0
[ 3214.209056] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 3214.209057] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3214.209059] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 3214.209061] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 3214.209064] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 3214.209065] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 3214.209067] ESI: c168d580 EDI: f62ce080 EBP: f265fd10 ESP: f265fd08
[ 3214.209069]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 3214.209070] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 3214.209071] Stack:
[ 3214.209076]  c15e278f 00000048 f265fd58 c10a504d c15f48cc 000249f9 00018=
ebe 0
0018ebd
[ 3214.209080]  00000048 f265fd38 00200086 f62d16c0 f265fd40 c1044998 f265e=
000 0
0000000
[ 3214.209084]  c168d580 f13de1c0 00000000 00000000 f265fd6c c104b3fb 00000=
000 0
0000000
[ 3214.209085] Call Trace:
[ 3214.209089]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 3214.209092]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 3214.209096]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 3214.209100]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 3214.209103]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 3214.209107]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 3214.209110]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 3214.209113]  [<c106966b>] ? try_to_wake_up+0x5b/0x400
[ 3214.209117]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 3214.209120]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 3214.209123]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 3214.209126]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 3214.209129]  [<c14af588>] ? _raw_spin_unlock_irqrestore+0x8/0x40
[ 3214.209132]  [<c1060311>] __hrtimer_start_range_ns+0x191/0x2b0
[ 3214.209136]  [<c1060452>] hrtimer_start_range_ns+0x22/0x30
[ 3214.209139]  [<c14acd97>] do_nanosleep+0xa7/0x130
[ 3214.209142]  [<c10604e8>] __hrtimer_nanosleep+0x88/0x110
[ 3214.209145]  [<c105f440>] ? hrtimer_init_sleeper+0x20/0x20
[ 3214.209148]  [<c1060eab>] hrtimer_nanosleep+0x1b/0x30
[ 3214.209151]  [<c1060f09>] SyS_nanosleep+0x49/0x70
[ 3214.209154]  [<c14afb54>] syscall_call+0x7/0xb
[ 3214.209181] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 3214.209188] NMI backtrace for cpu 1
[ 3214.209195] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 3214.209197] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3214.209200] task: f4075640 ti: f409c000 task.ti: f409c000
[ 3214.209203] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 3214.209211] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 3214.209213] EAX: 5daef900 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 3214.209215] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 3214.209217]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3214.209218] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 3214.209219] Stack:
[ 3214.209226]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 de1140f7 00000=
2eb 0
0000002
[ 3214.209231]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 3214.209235]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 3214.209236] Call Trace:
[ 3214.209244]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 3214.209247]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 3214.209253]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 3214.209257]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 3214.209262]  [<c102a944>] start_secondary+0x184/0x200
[ 3214.209291] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 3394.335204] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D1950=
12 jiff
ies g=3D102078 c=3D102077 q=3D76)
[ 3394.335205] sending NMI to all CPUs:
[ 3394.335207] NMI backtrace for cpu 0
[ 3394.335209] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 3394.335211] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3394.335212] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 3394.335214] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 3394.335217] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 3394.335218] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 3394.335220] ESI: c168d580 EDI: f62ce080 EBP: f265fd10 ESP: f265fd08
[ 3394.335222]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 3394.335224] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 3394.335224] Stack:
[ 3394.335229]  c15e278f 0000004c f265fd58 c10a504d c15f48cc 0002f9c4 00018=
ebe 0
0018ebd
[ 3394.335233]  0000004c f265fd38 00200086 f62d16c0 f265fd40 c1044998 f265e=
000 0
0000000
[ 3394.335237]  c168d580 f13de1c0 00000000 00000000 f265fd6c c104b3fb 00000=
000 0
0000000
[ 3394.335238] Call Trace:
[ 3394.335242]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 3394.335245]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 3394.335249]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 3394.335253]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 3394.335256]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 3394.335260]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 3394.335263]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 3394.335266]  [<c1069a40>] ? wake_up_process+0x30/0x40
[ 3394.335270]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 3394.335273]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 3394.335276]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 3394.335279]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 3394.335282]  [<c14af588>] ? _raw_spin_unlock_irqrestore+0x8/0x40
[ 3394.335285]  [<c1060311>] __hrtimer_start_range_ns+0x191/0x2b0
[ 3394.335288]  [<c1060452>] hrtimer_start_range_ns+0x22/0x30
[ 3394.335292]  [<c14acd97>] do_nanosleep+0xa7/0x130
[ 3394.335295]  [<c10604e8>] __hrtimer_nanosleep+0x88/0x110
[ 3394.335298]  [<c105f440>] ? hrtimer_init_sleeper+0x20/0x20
[ 3394.335301]  [<c1060eab>] hrtimer_nanosleep+0x1b/0x30
[ 3394.335304]  [<c1060f09>] SyS_nanosleep+0x49/0x70
[ 3394.335306]  [<c14afb54>] syscall_call+0x7/0xb
[ 3394.335333] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 3394.335341] NMI backtrace for cpu 1
[ 3394.335348] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 3394.335350] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3394.335353] task: f4075640 ti: f409c000 task.ti: f409c000
[ 3394.335356] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 3394.335364] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 3394.335366] EAX: 4e229900 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 3394.335368] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 3394.335370]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3394.335371] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 3394.335372] Stack:
[ 3394.335379]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 c7b70474 00000=
315 0
0000002
[ 3394.335383]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 3394.335388]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 3394.335389] Call Trace:
[ 3394.335397]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 3394.335400]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 3394.335406]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 3394.335410]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 3394.335415]  [<c102a944>] start_secondary+0x184/0x200
[ 3394.335443] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 3574.461358] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D2400=
15 jiff
ies g=3D102078 c=3D102077 q=3D78)
[ 3574.461359] sending NMI to all CPUs:
[ 3574.461361] NMI backtrace for cpu 0
[ 3574.461363] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 3574.461365] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3574.461366] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 3574.461368] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 3574.461370] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 3574.461372] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 3574.461374] ESI: c168d580 EDI: f62ce080 EBP: f265fd68 ESP: f265fd60
[ 3574.461376]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 3574.461377] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 3574.461378] Stack:
[ 3574.461382]  c15e278f 0000004e f265fdb0 c10a504d c15f48cc 0003a98f 00018=
ebe 0
0018ebd
[ 3574.461387]  0000004e f265fd90 00200086 f62d16c0 f265fd98 c1044998 f265e=
000 0
0000000
[ 3574.461391]  c168d580 f13de1c0 00000000 00000000 f265fdc4 c104b3fb 00000=
000 0
0000000
[ 3574.461391] Call Trace:
[ 3574.461395]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 3574.461399]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 3574.461402]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 3574.461406]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 3574.461410]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 3574.461413]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 3574.461416]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 3574.461421]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 3574.461423]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 3574.461427]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 3574.461430]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 3574.461433]  [<c1060439>] ? hrtimer_start_range_ns+0x9/0x30
[ 3574.461436]  [<c14acd97>] do_nanosleep+0xa7/0x130
[ 3574.461439]  [<c10604e8>] __hrtimer_nanosleep+0x88/0x110
[ 3574.461442]  [<c105f440>] ? hrtimer_init_sleeper+0x20/0x20
[ 3574.461446]  [<c1060eab>] hrtimer_nanosleep+0x1b/0x30
[ 3574.461448]  [<c1060f09>] SyS_nanosleep+0x49/0x70
[ 3574.461451]  [<c14afb54>] syscall_call+0x7/0xb
[ 3574.461478] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 3574.461486] NMI backtrace for cpu 1
[ 3574.461493] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 3574.461495] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3574.461497] task: f4075640 ti: f409c000 task.ti: f409c000
[ 3574.461501] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 3574.461509] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 3574.461511] EAX: 3e498f00 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 3574.461512] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 3574.461514]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3574.461516] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 3574.461517] Stack:
[ 3574.461524]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 b1102914 00000=
33f 0
0000002
[ 3574.461528]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 3574.461532]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 3574.461533] Call Trace:
[ 3574.461542]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 3574.461545]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 3574.461551]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 3574.461555]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 3574.461560]  [<c102a944>] start_secondary+0x184/0x200
[ 3574.461588] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 3754.587512] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D2850=
18 jiff
ies g=3D102078 c=3D102077 q=3D82)
[ 3754.587513] sending NMI to all CPUs:
[ 3754.587515] NMI backtrace for cpu 0
[ 3754.587517] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 3754.587519] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3754.587520] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 3754.587522] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 3754.587524] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 3754.587526] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 3754.587528] ESI: c168d580 EDI: f62ce080 EBP: f265fda0 ESP: f265fd98
[ 3754.587530]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 3754.587532] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 3754.587532] Stack:
[ 3754.587537]  c15e278f 00000052 f265fde8 c10a504d c15f48cc 0004595a 00018=
ebe 0
0018ebd
[ 3754.587541]  00000052 f265fdc8 00200086 f62d16c0 f265fdd0 c1044998 f265e=
000 0
0000000
[ 3754.587545]  c168d580 f13de1c0 00000000 00000000 f265fdfc c104b3fb 00000=
000 0
0000000
[ 3754.587546] Call Trace:
[ 3754.587550]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 3754.587553]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 3754.587557]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 3754.587560]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 3754.587564]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 3754.587567]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 3754.587570]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 3754.587575]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 3754.587578]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 3754.587581]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 3754.587584]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 3754.587587]  [<c1060499>] ? __hrtimer_nanosleep+0x39/0x110
[ 3754.587590]  [<c105f440>] ? hrtimer_init_sleeper+0x20/0x20
[ 3754.587594]  [<c1060eab>] hrtimer_nanosleep+0x1b/0x30
[ 3754.587596]  [<c1060f09>] SyS_nanosleep+0x49/0x70
[ 3754.587599]  [<c14afb54>] syscall_call+0x7/0xb
[ 3754.587626] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 3754.587634] NMI backtrace for cpu 1
[ 3754.587641] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 3754.587642] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3754.587645] task: f4075640 ti: f409c000 task.ti: f409c000
[ 3754.587648] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 3754.587656] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 3754.587658] EAX: 2e9fd400 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 3754.587660] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 3754.587662]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3754.587664] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 3754.587665] Stack:
[ 3754.587672]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 9a9895db 00000=
369 0
0000002
[ 3754.587676]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 3754.587680]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 3754.587681] Call Trace:
[ 3754.587690]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 3754.587693]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 3754.587698]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 3754.587703]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 3754.587707]  [<c102a944>] start_secondary+0x184/0x200
[ 3754.587736] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89
[ 3934.713666] INFO: rcu_preempt self-detected stall on CPU { 0}  (t=3D3300=
21 jiff
ies g=3D102078 c=3D102077 q=3D85)
[ 3934.713667] sending NMI to all CPUs:
[ 3934.713669] NMI backtrace for cpu 0
[ 3934.713671] CPU: 0 PID: 3637 Comm: VisionLineDaemo Not tainted 3.12.13-r=
t21pa
nel+ #25
[ 3934.713672] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3934.713674] task: f13de1c0 ti: f265e000 task.ti: f265e000
[ 3934.713676] EIP: 0060:[<c102e040>] EFLAGS: 00200006 CPU: 0
[ 3934.713678] EIP is at arch_trigger_all_cpu_backtrace+0x40/0x70
[ 3934.713680] EAX: 00000800 EBX: 00002710 ECX: c1689b60 EDX: 00000c00
[ 3934.713682] ESI: c168d580 EDI: f62ce080 EBP: f265fd10 ESP: f265fd08
[ 3934.713684]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
[ 3934.713685] CR0: 80050033 CR2: a8c33000 CR3: 35aee000 CR4: 000007d0
[ 3934.713686] Stack:
[ 3934.713690]  c15e278f 00000055 f265fd58 c10a504d c15f48cc 00050925 00018=
ebe 0
0018ebd
[ 3934.713694]  00000055 f265fd38 00200086 f62d16c0 f265fd40 c1044998 f265e=
000 0
0000000
[ 3934.713699]  c168d580 f13de1c0 00000000 00000000 f265fd6c c104b3fb 00000=
000 0
0000000
[ 3934.713699] Call Trace:
[ 3934.713703]  [<c10a504d>] rcu_check_callbacks+0x28d/0x550
[ 3934.713707]  [<c1044998>] ? raise_softirq_irqoff+0x8/0x40
[ 3934.713711]  [<c104b3fb>] update_process_times+0x3b/0x70
[ 3934.713714]  [<c108e679>] tick_sched_timer+0x49/0x230
[ 3934.713718]  [<c105fd77>] __run_hrtimer.isra.29+0x67/0x100
[ 3934.713721]  [<c108e630>] ? tick_init_highres+0x10/0x10
[ 3934.713724]  [<c10608a7>] hrtimer_interrupt+0x297/0x320
[ 3934.713727]  [<c1085042>] ? ktime_get+0x42/0x120
[ 3934.713731]  [<c102bf6d>] local_apic_timer_interrupt+0x2d/0x60
[ 3934.713734]  [<c1044e9c>] ? irq_enter+0x3c/0x60
[ 3934.713738]  [<c102c35e>] smp_apic_timer_interrupt+0x2e/0x50
[ 3934.713740]  [<c14afe11>] apic_timer_interrupt+0x2d/0x34
[ 3934.713743]  [<c14af588>] ? _raw_spin_unlock_irqrestore+0x8/0x40
[ 3934.713746]  [<c1060311>] __hrtimer_start_range_ns+0x191/0x2b0
[ 3934.713750]  [<c1060452>] hrtimer_start_range_ns+0x22/0x30
[ 3934.713753]  [<c14acd97>] do_nanosleep+0xa7/0x130
[ 3934.713756]  [<c10604e8>] __hrtimer_nanosleep+0x88/0x110
[ 3934.713759]  [<c105f440>] ? hrtimer_init_sleeper+0x20/0x20
[ 3934.713763]  [<c1060eab>] hrtimer_nanosleep+0x1b/0x30
[ 3934.713765]  [<c1060f09>] SyS_nanosleep+0x49/0x70
[ 3934.713768]  [<c14afb54>] syscall_call+0x7/0xb
[ 3934.713795] Code: 10 27 00 00 52 a1 3c 95 4b c1 8b 00 c7 04 24 8f 27 5e =
c1 a3
 e0 8e 6b c1 e8 55 d4 47 00 8b 15 40 9b 68 c1 b8 02 00 00 00 ff 52 7c <eb> =
13 8d
 b6 00 00 00 00 b8 58 89 41 00 e8 ee 51 1d 00 4b 74 09
[ 3934.713803] NMI backtrace for cpu 1
[ 3934.713810] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 3.12.13-rt21panel+=
 #25
[ 3934.713811] Hardware name: AAEON GENE-HD05/GENE-HD05, BIOS 4.6.4 10/22/2=
013
[ 3934.713814] task: f4075640 ti: f409c000 task.ti: f409c000
[ 3934.713817] EIP: 0060:[<c126deb2>] EFLAGS: 00200093 CPU: 1
[ 3934.713825] EIP is at acpi_idle_enter_simple+0x89/0xab
[ 3934.713827] EAX: 1f114a00 EBX: f414e094 ECX: c171a608 EDX: 00001771
[ 3934.713829] ESI: f414e000 EDI: 00000002 EBP: f409df48 ESP: f409df3c
[ 3934.713830]  DS: 007b ES: 007b FS: 00d8 GS: 0000 SS: 0068
[ 3934.713832] CR0: 8005003b CR2: b7567a68 CR3: 35df9000 CR4: 000007d0
[ 3934.713833] Stack:
[ 3934.713840]  f42c9000 c1699ca0 00000026 f409df68 c13c9232 843c2f30 00000=
393 0
0000002
[ 3934.713844]  f42c9000 00000002 00000000 f409df80 c13c9372 c1699ca0 f409c=
000 c
16b8fe8
[ 3934.713849]  00000000 f409df88 c100ad98 f409df98 c107f093 c171b6e0 00000=
000 f
409dfb4
[ 3934.713850] Call Trace:
[ 3934.713858]  [<c13c9232>] cpuidle_enter_state+0x32/0xe0
[ 3934.713861]  [<c13c9372>] cpuidle_idle_call+0x92/0x150
[ 3934.713867]  [<c100ad98>] arch_cpu_idle+0x8/0x20
[ 3934.713871]  [<c107f093>] cpu_startup_entry+0xd3/0x120
[ 3934.713876]  [<c102a944>] start_secondary+0x184/0x200
[ 3934.713904] Code: 08 a8 08 74 cf eb c0 e8 ed e0 df ff 8a 43 08 3c 01 75 =
09 89
 d8 e8 3f b5 db ff eb 16 3c 02 75 07 e8 94 f7 ff ff eb 0b 8b 53 04 ec <8b> =
15 74
 a6 94 c1 ed 31 c0 31 d2 e8 ae e1 df ff 89 f0 31 c9 89

Showing all blocked tasks results in:

[ 3989.650550] SysRq : Changing Loglevel
[ 3989.654215] Loglevel set to 9
[ 3989.657588] [sched_delayed] sched: RT throttling activated
[ 4006.690064] SysRq : HELP : loglevel(0-9) reboot(b) crash(c) terminate-al=
l-tas
ks(e) memory-full-oom-kill(f) kill-all-tasks(i) thaw-filesystems(j) sak(k) =
show-
backtrace-all-active-cpus(l) show-memory-usage(m) nice-all-RT-tasks(n) powe=
roff(
o) show-registers(p) show-all-timers(q) unraw(r) sync(s) show-task-states(t=
) unm
ount(u) force-fb(V) show-blocked-tasks(w)=20
[ 4009.443482] SysRq : Show Blocked State
[ 4009.447251]   task                PC stack   pid father
[ 4009.452472] systemd         D c106712b     0     1      0 0x00000000
[ 4009.458844]  f406bc54 00000086 f406bbe4 c106712b 00000001 c1719000 d2f29=
15a 0
000026a
[ 4009.466680]  f62dd6c0 c106db4a f62dd6c0 f62ce5d4 f4070000 f62ce5d4 f694a=
c80 f
406bc88
[ 4009.474515]  c10e6322 c14bc200 f406bc84 f406bc8c f62da424 f406bc80 f406b=
c30 c
14af592
[ 4009.482350] Call Trace:
[ 4009.484801]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4009.489592]  [<c106db4a>] ? check_preempt_wakeup+0xea/0x1f0
[ 4009.495166]  [<c10e6322>] ? __slab_alloc.isra.62.constprop.71+0xf2/0x780
[ 4009.501863]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4009.507953]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4009.513782]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4009.519089]  [<c14adc40>] schedule+0x20/0x70
[ 4009.523357]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4009.528841]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4009.533455]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4009.538330]  [<c10b2f30>] add_to_page_cache_lru+0x30/0x50
[ 4009.543728]  [<c1123642>] mpage_readpages+0x92/0x110
[ 4009.548692]  [<c10ba631>] ? __alloc_pages_nodemask+0xd1/0x6f0
[ 4009.554434]  [<c106cacf>] ? update_cfs_rq_blocked_load+0x9f/0x120
[ 4009.560525]  [<c1164490>] ? ext2_bmap+0x20/0x20
[ 4009.565050]  [<c11644a9>] ext2_readpages+0x19/0x20
[ 4009.569837]  [<c1164e00>] ? ext2_nobh_write_begin+0x90/0x90
[ 4009.575406]  [<c10bd74e>] __do_page_cache_readahead+0x15e/0x1f0
[ 4009.581323]  [<c10bd9cd>] ondemand_readahead+0xdd/0x290
[ 4009.586545]  [<c10bdbf9>] page_cache_async_readahead+0x79/0xa0
[ 4009.592372]  [<c10b5138>] filemap_fault+0x298/0x3f0
[ 4009.597247]  [<c10ce9c0>] __do_fault+0x50/0x500
[ 4009.601774]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4009.607081]  [<c10d1a4b>] handle_mm_fault+0xeb/0x6f0
[ 4009.612043]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4009.617353]  [<c104088e>] ? unpin_current_cpu+0xe/0x60
[ 4009.622488]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4009.627535]  [<c10eb06f>] ? vfs_read+0xdf/0x140
[ 4009.632062]  [<c10eb72a>] ? SyS_read+0x4a/0xb0
[ 4009.636502]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4009.641807]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4009.646422]  [<c14b003a>] error_code+0x5a/0x60
[ 4009.650864]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4009.656180] cron            D c106712b     0   833      1 0x00000000
[ 4009.662553]  f5d33df0 00000086 f5d33d80 c106712b f5d33d88 c1719000 f28b6=
000 0
0000272
[ 4009.670387]  b5a46a56 00000272 f5ad5400 00000272 f5d95c00 f5d95c00 f5d33=
db8 c
106886e
[ 4009.678223]  f62da380 34bbe000 f5d33e20 f5d33e28 f62da424 f5d33e1c f5d33=
dcc c
14af592
[ 4009.686059] Call Trace:
[ 4009.688504]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4009.693291]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4009.698338]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4009.704426]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4009.710253]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4009.715561]  [<c14adc40>] schedule+0x20/0x70
[ 4009.719827]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4009.725309]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4009.729921]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4009.734796]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4009.739411]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4009.744896]  [<c10cfde4>] do_wp_page+0x1c4/0x7c0
[ 4009.749508]  [<c10d1dff>] handle_mm_fault+0x49f/0x6f0
[ 4009.754557]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4009.759607]  [<c103f6b2>] ? do_fork+0xf2/0x2d0
[ 4009.764047]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4009.769354]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4009.773967]  [<c14b003a>] error_code+0x5a/0x60
[ 4009.778408]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4009.783716] agetty          D 00000000     0   977      1 0x00000000
[ 4009.790088]  f5859cb4 00000086 c171b7c0 00000000 f5859c4c c1719000 a9ac8=
603 0
000039f
[ 4009.797925]  f62dd6c0 fffa5000 f62dd6c0 00000000 f2a761c0 c10ce784 f5859=
c7c c
103bc33
[ 4009.805760]  fffa5000 f7564ac0 f5859ce4 f5859cec f62da424 f5859ce0 f5859=
c90 c
14af592
[ 4009.813598] Call Trace:
[ 4009.816046]  [<c10ce784>] ? pagefault_enable+0x14/0x20
[ 4009.821181]  [<c103bc33>] ? __kunmap_atomic+0x33/0x90
[ 4009.826231]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4009.832319]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4009.838145]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4009.843455]  [<c14af5d1>] ? _raw_spin_unlock_irq+0x11/0x40
[ 4009.848934]  [<c14adc40>] schedule+0x20/0x70
[ 4009.853202]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4009.858684]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4009.863302]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4009.868178]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4009.872793]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4009.878272]  [<c10d2005>] handle_mm_fault+0x6a5/0x6f0
[ 4009.883319]  [<c10689c2>] ? __wake_up+0x42/0x50
[ 4009.887847]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4009.892896]  [<c1281b1c>] ? set_termios+0x18c/0x210
[ 4009.897771]  [<c109301e>] ? __rt_down_read.isra.1+0x1e/0x30
[ 4009.903341]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4009.908651]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4009.913265]  [<c14b003a>] error_code+0x5a/0x60
[ 4009.917705]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4009.923014]  [<c10b53ce>] ? file_read_actor+0x2e/0xd0
[ 4009.928063]  [<c10b56e6>] generic_file_aio_read+0x276/0x770
[ 4009.933635]  [<c10ea850>] ? default_llseek+0x190/0x190
[ 4009.938768]  [<c10ea8b8>] do_sync_read+0x68/0x90
[ 4009.943384]  [<c10eb008>] vfs_read+0x78/0x140
[ 4009.947737]  [<c10eb72a>] SyS_read+0x4a/0xb0
[ 4009.952005]  [<c14afb54>] syscall_call+0x7/0xb
[ 4009.956447] Xorg            D 00000000     0  1025      1 0x00000000
[ 4009.962819]  f2bdde30 00200086 c171b7c0 00000000 f2bdddc8 c1719000 8c340=
f68 0
000039a
[ 4009.970655]  f62dd6c0 fffa5000 f62dd6c0 00000000 f5d93f40 c10ce784 f2bdd=
df8 c
103bc33
[ 4009.978494]  fffa5000 f7564aa0 f2bdde60 f2bdde68 f62da424 f2bdde5c f2bdd=
e0c c
14af592
[ 4009.986328] Call Trace:
[ 4009.988774]  [<c10ce784>] ? pagefault_enable+0x14/0x20
[ 4009.993908]  [<c103bc33>] ? __kunmap_atomic+0x33/0x90
[ 4009.998956]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4010.005042]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4010.010869]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.016177]  [<c14adc40>] schedule+0x20/0x70
[ 4010.020448]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4010.025930]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4010.030543]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4010.035415]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4010.040030]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4010.045512]  [<c10d2005>] handle_mm_fault+0x6a5/0x6f0
[ 4010.050557]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4010.055344]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.060652]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4010.065703]  [<c1204b7c>] ? copy_to_user+0x2c/0x40
[ 4010.070491]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4010.075806]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4010.080420]  [<c14b003a>] error_code+0x5a/0x60
[ 4010.084862]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4010.090165] munin-node      D c106712b     0  1028      1 0x00000000
[ 4010.096535]  f2bd3df0 00000086 f2bd3d80 c106712b f2bd3d88 c1719000 f3a10=
000 0
0000281
[ 4010.104371]  020420ea 00000281 f5ad4400 00000281 f5d96780 f5d96780 f2bd3=
db8 c
106886e
[ 4010.112204]  f62da380 34bbe000 f2bd3e20 f2bd3e28 f62da424 f2bd3e1c f2bd3=
dcc c
14af592
[ 4010.120041] Call Trace:
[ 4010.122486]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4010.127273]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4010.132319]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4010.138406]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4010.144235]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.149542]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4010.154330]  [<c14adc40>] schedule+0x20/0x70
[ 4010.158596]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4010.164078]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4010.168690]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4010.173565]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4010.178177]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4010.183660]  [<c10cfde4>] do_wp_page+0x1c4/0x7c0
[ 4010.188277]  [<c10d1dff>] handle_mm_fault+0x49f/0x6f0
[ 4010.193326]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4010.198377]  [<c103f6b2>] ? do_fork+0xf2/0x2d0
[ 4010.202821]  [<c104ee8c>] ? SyS_rt_sigprocmask+0x9c/0xb0
[ 4010.208126]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4010.213435]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4010.218049]  [<c14b003a>] error_code+0x5a/0x60
[ 4010.222490]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4010.227797] smbd            D c106712b     0  1444      1 0x00000004
[ 4010.234167]  f12e9df0 00200086 f12e9d80 c106712b f12e9d88 c1719000 f3ad6=
000 0
000026d
[ 4010.242003]  48d05d1f 0000026d f5ad4600 0000026d f2a74500 f2a74500 f12e9=
db8 c
106886e
[ 4010.249838]  f62da380 34bbe000 f12e9e20 f12e9e28 f62da424 f12e9e1c f12e9=
dcc c
14af592
[ 4010.257678] Call Trace:
[ 4010.260125]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4010.264914]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4010.269964]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4010.276052]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4010.281881]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.287186]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4010.291976]  [<c14adc40>] schedule+0x20/0x70
[ 4010.296245]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4010.301728]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4010.306345]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4010.311217]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4010.315832]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4010.321313]  [<c10cfde4>] do_wp_page+0x1c4/0x7c0
[ 4010.325930]  [<c10d1dff>] handle_mm_fault+0x49f/0x6f0
[ 4010.330977]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4010.336025]  [<c103f6b2>] ? do_fork+0xf2/0x2d0
[ 4010.340466]  [<c10f3819>] ? SyS_pipe2+0x59/0x90
[ 4010.344996]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4010.350303]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4010.354917]  [<c14b003a>] error_code+0x5a/0x60
[ 4010.359357]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4010.364664] VisionLineGui   D f6973840     0  1730   1524 0x00000000
[ 4010.371036]  f5afde98 00000086 f62da5d4 f6973840 f5afdea0 c1719000 d6860=
69a 0
0000265
[ 4010.378873]  f62dd6c0 f5c97600 f62dd6c0 c13de309 f5a8cac0 000000d0 00000=
000 f
62dd6c0
[ 4010.386709]  f5afc000 00000292 f62dde90 f3ac2540 f4001d80 f5afde74 c1067=
12b 0
0000001
[ 4010.394545] Call Trace:
[ 4010.396992]  [<c13de309>] ? sock_alloc_inode+0x29/0x90
[ 4010.402129]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4010.406918]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.412228]  [<c1102553>] ? inode_init_always+0x103/0x1a0
[ 4010.417621]  [<c14adc40>] schedule+0x20/0x70
[ 4010.421889]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4010.427199]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4010.432336]  [<c1106500>] ? __alloc_fd+0x110/0x110
[ 4010.437125]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4010.441825]  [<c1092f58>] rt_down_write+0x8/0x10
[ 4010.446438]  [<c10c8176>] vm_mmap_pgoff+0x26/0x80
[ 4010.451139]  [<c10d5054>] SyS_mmap_pgoff+0x54/0xe0
[ 4010.455925]  [<c14afb54>] syscall_call+0x7/0xb
[ 4010.460365] VisionLineGui   D f263de0c     0  4225   1524 0x00000000
[ 4010.466737]  f263de58 00000086 f62ddec0 f263de0c c10e7335 c1719000 f5afc=
000 0
0000265
[ 4010.474573]  3db50969 00000265 f5daac00 00000265 f5af2e00 f263dee4 f263d=
e18 c
13e5314
[ 4010.482407]  f3a22180 f3a22180 f263de24 c14af2f8 f263deac c1474c6f 00000=
000 0
0000000
[ 4010.490242] Call Trace:
[ 4010.492688]  [<c10e7335>] ? kmem_cache_free+0x75/0x130
[ 4010.497821]  [<c13e5314>] ? kfree_skbmem+0x34/0x90
[ 4010.502608]  [<c14af2f8>] ? _mutex_unlock+0x8/0x10
[ 4010.507395]  [<c1474c6f>] ? unix_stream_recvmsg+0x61f/0x6d0
[ 4010.512964]  [<c14adc40>] schedule+0x20/0x70
[ 4010.517235]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4010.522547]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4010.527682]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4010.532731]  [<c1091400>] ? exit_robust_list+0x100/0x110
[ 4010.538039]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4010.646885]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4010.652285]  [<c1093038>] rt_down_read+0x8/0x10
[ 4010.656815]  [<c10ce674>] SyS_madvise+0x564/0x640
[ 4010.661519]  [<c1091ebd>] ? SyS_futex+0x8d/0x160
[ 4010.666138]  [<c14afb54>] syscall_call+0x7/0xb
[ 4010.670579] QThread         D f5a4ddfc     0  2006   1524 0x00000000
[ 4010.676955]  f5a4de58 00000086 00000001 f5a4ddfc c10671d3 c1719000 363a0=
59e 0
0000262
[ 4010.684789]  f62dd6c0 f7569cc0 f62dd6c0 c10c33d7 f1067300 0005a6a7 00000=
000 0
00000e2
[ 4010.692624]  0005a5c5 00000000 f5a4de84 c10b3c3e 0005a5c5 00000000 00000=
0e2 0
00000e2
[ 4010.700460] Call Trace:
[ 4010.702907]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.708217]  [<c10c33d7>] ? shmem_write_end+0xc7/0x2b0
[ 4010.713351]  [<c10b3c3e>] ? generic_file_buffered_write+0x15e/0x240
[ 4010.719613]  [<c110848b>] ? __mnt_drop_write_file+0xb/0x10
[ 4010.725093]  [<c14adc40>] schedule+0x20/0x70
[ 4010.729361]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4010.734671]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4010.739806]  [<c10f974a>] ? user_path_at_empty+0x4a/0x90
[ 4010.745119]  [<c10feb00>] ? dentry_lru_isolate_shrink+0x30/0x70
[ 4010.751036]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4010.755734]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4010.761131]  [<c1093038>] rt_down_read+0x8/0x10
[ 4010.765662]  [<c10ce674>] SyS_madvise+0x564/0x640
[ 4010.770368]  [<c1064600>] ? lg_local_unlock+0x20/0x30
[ 4010.775417]  [<c1084f2e>] ? __getnstimeofday+0x2e/0x100
[ 4010.780641]  [<c1204b7c>] ? copy_to_user+0x2c/0x40
[ 4010.785431]  [<c1043d39>] ? SyS_gettimeofday+0x29/0x70
[ 4010.790567]  [<c14afb54>] syscall_call+0x7/0xb
[ 4010.795006] QThread         D f5819dfc     0  2007   1524 0x00000000
[ 4010.801378]  f5819e58 00000086 00000001 f5819dfc c10671d3 c1719000 3dbe6=
1fc 0
0000265
[ 4010.809212]  f62dd6c0 f7569cc0 f62dd6c0 c10c33d7 f1061700 0005a784 00000=
000 0
00000dd
[ 4010.817048]  0005a6a7 00000000 f5819e84 c10b3c3e 0005a6a7 00000000 00000=
0dd 0
00000dd
[ 4010.824885] Call Trace:
[ 4010.827332]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.832639]  [<c10c33d7>] ? shmem_write_end+0xc7/0x2b0
[ 4010.837775]  [<c10b3c3e>] ? generic_file_buffered_write+0x15e/0x240
[ 4010.844039]  [<c110848b>] ? __mnt_drop_write_file+0xb/0x10
[ 4010.849523]  [<c14adc40>] schedule+0x20/0x70
[ 4010.853791]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4010.859101]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4010.864239]  [<c10f974a>] ? user_path_at_empty+0x4a/0x90
[ 4010.869547]  [<c10feb00>] ? dentry_lru_isolate_shrink+0x30/0x70
[ 4010.875464]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4010.880164]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4010.885557]  [<c1093038>] rt_down_read+0x8/0x10
[ 4010.890086]  [<c10ce674>] SyS_madvise+0x564/0x640
[ 4010.894787]  [<c1064600>] ? lg_local_unlock+0x20/0x30
[ 4010.899836]  [<c1084f2e>] ? __getnstimeofday+0x2e/0x100
[ 4010.905059]  [<c1204b7c>] ? copy_to_user+0x2c/0x40
[ 4010.909850]  [<c1043d39>] ? SyS_gettimeofday+0x29/0x70
[ 4010.914982]  [<c14afb54>] syscall_call+0x7/0xb
[ 4010.919422] VisionLineDaemo D c14af592     0  3576   3572 0x00000000
[ 4010.925793]  f3a1fd28 00200086 f3a1fcb4 c14af592 f3a1fd04 c1719000 f1046=
000 0
0000261
[ 4010.933629]  d6159fd6 00000261 d61b2b02 00000261 f13df8c0 00000001 f3a1f=
cf8 c
10671d3
[ 4010.941463]  f62da420 00000002 00000000 f3a1fd74 f62da420 f3a1fd04 c14af=
480 0
0000000
[ 4010.949300] Call Trace:
[ 4010.951745]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4010.957833]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4010.963144]  [<c14af480>] ? _raw_spin_lock+0x10/0x50
[ 4010.968105]  [<c10925b5>] ? task_blocks_on_rt_mutex+0x135/0x200
[ 4010.974020]  [<c14adc40>] schedule+0x20/0x70
[ 4010.978289]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4010.983773]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4010.988389]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4010.993261]  [<c10c58f8>] shmem_getpage_gfp+0x4f8/0x790
[ 4010.998483]  [<c10c5c37>] shmem_write_begin+0x37/0x40
[ 4011.003530]  [<c10b3baa>] generic_file_buffered_write+0xca/0x240
[ 4011.009532]  [<c10b4ad8>] __generic_file_aio_write+0x338/0x500
[ 4011.015359]  [<c10b4cfc>] generic_file_aio_write+0x5c/0xb0
[ 4011.020842]  [<c10ea8e0>] ? do_sync_read+0x90/0x90
[ 4011.025631]  [<c10ea948>] do_sync_write+0x68/0x90
[ 4011.030333]  [<c10eb164>] vfs_write+0x94/0x1a0
[ 4011.034777]  [<c10eb7da>] SyS_write+0x4a/0xb0
[ 4011.039133]  [<c14afb54>] syscall_call+0x7/0xb
[ 4011.043572] VisionLineDaemo D f5a8170c     0  3636   3572 0x00000000
[ 4011.049953]  f5d87e0c 00200086 c1074528 f5a8170c c171f6c0 c1719000 f59b0=
000 0
0000260
[ 4011.057788]  92435d32 00000260 9275dfef 00000260 f13d9140 f5d87de0 c1068=
bca 0
0000078
[ 4011.065623]  c14bc200 00000027 c171f600 f5d87e38 c16b6700 f5d87e38 f5d87=
de8 c
14af592
[ 4011.073458] Call Trace:
[ 4011.075905]  [<c1074528>] ? push_rt_task.part.27+0x188/0x390
[ 4011.081559]  [<c1068bca>] ? rt_mutex_setprio+0xda/0x1d0
[ 4011.086778]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4011.092865]  [<c109261f>] ? task_blocks_on_rt_mutex+0x19f/0x200
[ 4011.098780]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.104089]  [<c14adc40>] schedule+0x20/0x70
[ 4011.108355]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4011.113838]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4011.118454]  [<c10be80e>] pagevec_lru_move_fn+0x7e/0xe0
[ 4011.123674]  [<c10bde90>] ? SyS_readahead+0xe0/0xe0
[ 4011.128548]  [<c10be946>] __lru_cache_add+0xb6/0xd0
[ 4011.133422]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4011.138035]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4011.143516]  [<c10d2005>] handle_mm_fault+0x6a5/0x6f0
[ 4011.148565]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4011.153614]  [<c10d68f7>] ? do_mmap_pgoff+0x2c7/0x370
[ 4011.158664]  [<c10c81a7>] ? vm_mmap_pgoff+0x57/0x80
[ 4011.163541]  [<c10d5054>] ? SyS_mmap_pgoff+0x54/0xe0
[ 4011.168501]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.173806]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4011.178423]  [<c14b003a>] error_code+0x5a/0x60
[ 4011.182860]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.188169] VisionLineDaemo D 00000001     0  3641   3572 0x00000000
[ 4011.194540]  f286be98 00200086 f5af33c0 00000001 f5af33c0 c1719000 f28b0=
000 0
0000265
[ 4011.202374]  7647b98b 00000265 f5c97600 00000265 f13db980 f286be54 c1074=
747 0
0000000
[ 4011.210210]  f286be5c 00000000 f286bee0 c14ad847 f3a35f40 f286be74 c1067=
12b 0
0000001
[ 4011.218047] Call Trace:
[ 4011.220496]  [<c1074747>] ? push_rt_tasks+0x17/0x30
[ 4011.225369]  [<c14ad847>] ? __schedule+0x417/0x7f0
[ 4011.230159]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4011.234946]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.240254]  [<c1102553>] ? inode_init_always+0x103/0x1a0
[ 4011.245647]  [<c14adc40>] schedule+0x20/0x70
[ 4011.249917]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4011.255227]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4011.260363]  [<c1106500>] ? __alloc_fd+0x110/0x110
[ 4011.265152]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4011.269852]  [<c1092f58>] rt_down_write+0x8/0x10
[ 4011.274467]  [<c10c8176>] vm_mmap_pgoff+0x26/0x80
[ 4011.279168]  [<c10d5054>] SyS_mmap_pgoff+0x54/0xe0
[ 4011.283956]  [<c14afb54>] syscall_call+0x7/0xb
[ 4011.288398] VisionLineDaemo D 00000001     0  4223   3572 0x00000000
[ 4011.294768]  f2677e58 00200086 f13d81ac 00000001 f62d9c30 c1719000 f2656=
000 0
0000264
[ 4011.302604]  dd853db1 00000264 f2bdee00 00000264 f40cae00 c1074528 f13d8=
00c c
171f6c0
[ 4011.310440]  00000003 f62dd6c0 f13db980 f62dd6c0 f2677e30 c1074747 00000=
027 f
2677e3c
[ 4011.318276] Call Trace:
[ 4011.320723]  [<c1074528>] ? push_rt_task.part.27+0x188/0x390
[ 4011.326379]  [<c1074747>] ? push_rt_tasks+0x17/0x30
[ 4011.331255]  [<c1074853>] ? task_woken_rt+0x53/0x60
[ 4011.336130]  [<c1066c8e>] ? ttwu_do_wakeup+0x2e/0xc0
[ 4011.341092]  [<c14adc40>] schedule+0x20/0x70
[ 4011.345360]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4011.350669]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4011.355802]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4011.360852]  [<c1091400>] ? exit_robust_list+0x100/0x110
[ 4011.366162]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4011.370862]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4011.376255]  [<c1093038>] rt_down_read+0x8/0x10
[ 4011.380782]  [<c10ce674>] SyS_madvise+0x564/0x640
[ 4011.385484]  [<c1091ebd>] ? SyS_futex+0x8d/0x160
[ 4011.390099]  [<c14afb54>] syscall_call+0x7/0xb
[ 4011.394539] VisionLineDaemo D 00000001     0  4330   3572 0x00000000
[ 4011.400917]  f5dbde58 00200086 f13d81ac 00000001 f62d9c30 c1719000 f2656=
000 0
0000264
[ 4011.408754]  e73f91d8 00000264 f2bdee00 00000264 f13e05c0 c1074528 f13d8=
00c c
171f6c0
[ 4011.416591]  00000003 f62dd6c0 f13e5080 f62dd6c0 f5dbde30 c1074747 00000=
027 f
5dbde3c
[ 4011.424424] Call Trace:
[ 4011.426872]  [<c1074528>] ? push_rt_task.part.27+0x188/0x390
[ 4011.432531]  [<c1074747>] ? push_rt_tasks+0x17/0x30
[ 4011.437407]  [<c1074853>] ? task_woken_rt+0x53/0x60
[ 4011.442279]  [<c1066c8e>] ? ttwu_do_wakeup+0x2e/0xc0
[ 4011.447247]  [<c14adc40>] schedule+0x20/0x70
[ 4011.451512]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4011.456821]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4011.461954]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4011.467002]  [<c1091400>] ? exit_robust_list+0x100/0x110
[ 4011.472313]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4011.477014]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4011.482407]  [<c1093038>] rt_down_read+0x8/0x10
[ 4011.486935]  [<c10ce674>] SyS_madvise+0x564/0x640
[ 4011.491636]  [<c1091ebd>] ? SyS_futex+0x8d/0x160
[ 4011.496254]  [<c14afb54>] syscall_call+0x7/0xb
[ 4011.500696] processScriptTh D c10671d3     0  2003   3572 0x00000000
[ 4011.507072]  f2675e5c 00200086 f2675dfc c10671d3 c106712b c1719000 f3a34=
000 0
0000263
[ 4011.514908]  0a27e736 00000263 f2bdee00 00000263 f13dd080 c14af592 f2675=
e60 c
1092113
[ 4011.522741]  f36d9be0 00000041 f2675e2c c1064600 f2675ea8 f2675e38 c1067=
12b 0
0000001
[ 4011.530578] Call Trace:
[ 4011.533020]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.538330]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4011.543115]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4011.649341]  [<c1092113>] ? rt_mutex_adjust_prio_chain+0xd3/0x440
[ 4011.655436]  [<c1064600>] ? lg_local_unlock+0x20/0x30
[ 4011.660488]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4011.665277]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.670588]  [<c14adc40>] schedule+0x20/0x70
[ 4011.674856]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4011.680165]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4011.685303]  [<c10f974a>] ? user_path_at_empty+0x4a/0x90
[ 4011.690613]  [<c10ef900>] ? cp_new_stat64+0xe0/0x110
[ 4011.695573]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4011.700274]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4011.705667]  [<c1093038>] rt_down_read+0x8/0x10
[ 4011.710194]  [<c1036ca6>] __do_page_fault+0x1d6/0x4e0
[ 4011.715241]  [<c10efd13>] ? SyS_stat64+0x23/0x30
[ 4011.719856]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.725163]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4011.729775]  [<c14b003a>] error_code+0x5a/0x60
[ 4011.734217]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.739527] QThread         D c14af592     0  4248   4174 0x00000000
[ 4011.745899]  f5a47e30 00200086 f5a47dbc c14af592 f5a47e0c c1719000 f3a58=
000 0
0000260
[ 4011.753733]  925e9dfb 00000260 f5c97600 00000260 f5af5c00 00000001 f5a47=
e00 c
10671d3
[ 4011.761569]  f62da420 f756c920 00000000 f5a47e7c f62da420 f5a47e0c c14af=
480 0
0000000
[ 4011.769405] Call Trace:
[ 4011.771851]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4011.777942]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.783249]  [<c14af480>] ? _raw_spin_lock+0x10/0x50
[ 4011.788209]  [<c10925b5>] ? task_blocks_on_rt_mutex+0x135/0x200
[ 4011.794123]  [<c14adc40>] schedule+0x20/0x70
[ 4011.798392]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4011.803878]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4011.808496]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4011.813372]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4011.817987]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4011.823472]  [<c10d2005>] handle_mm_fault+0x6a5/0x6f0
[ 4011.828524]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4011.833573]  [<c10d68f7>] ? do_mmap_pgoff+0x2c7/0x370
[ 4011.838623]  [<c10c81a7>] ? vm_mmap_pgoff+0x57/0x80
[ 4011.843499]  [<c10d5054>] ? SyS_mmap_pgoff+0x54/0xe0
[ 4011.848459]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.853764]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4011.858380]  [<c14b003a>] error_code+0x5a/0x60
[ 4011.862819]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.868127] QThread         D c10671d3     0  4266   4174 0x00000000
[ 4011.874498]  f5ae1e5c 00200086 f5ae1dfc c10671d3 c10671d3 c1719000 f5aba=
000 0
0000260
[ 4011.882333]  940d93f7 00000260 f5c97600 00000260 f5af2280 c14af592 f5ae1=
e60 c
1092113
[ 4011.890168]  f5ae1e34 c10671d3 c171b7c0 00000000 f5ae1e34 f5ae1e38 c1067=
12b 0
0000001
[ 4011.898003] Call Trace:
[ 4011.900450]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.905754]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.911064]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4011.917153]  [<c1092113>] ? rt_mutex_adjust_prio_chain+0xd3/0x440
[ 4011.923242]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.928552]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4011.933337]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4011.938648]  [<c14adc40>] schedule+0x20/0x70
[ 4011.942915]  [<c14ae56d>] __rt_mutex_slowlock+0x9d/0x170
[ 4011.948224]  [<c14ae98a>] rt_mutex_slowlock+0xea/0x200
[ 4011.953360]  [<c14aeae3>] rt_mutex_lock+0x43/0x50
[ 4011.958062]  [<c109301e>] __rt_down_read.isra.1+0x1e/0x30
[ 4011.963455]  [<c1093038>] rt_down_read+0x8/0x10
[ 4011.967984]  [<c1036ca6>] __do_page_fault+0x1d6/0x4e0
[ 4011.973029]  [<c14af4de>] ? _raw_spin_lock_irqsave+0x1e/0x70
[ 4011.978687]  [<c1067dd8>] ? __sched_setscheduler+0x1c8/0x4d0
[ 4011.984343]  [<c106816a>] ? do_sched_setscheduler+0x6a/0xd0
[ 4011.989911]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4011.995217]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4011.999833]  [<c14b003a>] error_code+0x5a/0x60
[ 4012.004272]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.009579] smbd            D c106712b     0  2008   1444 0x00000000
[ 4012.015950]  f3ad7d9c 00200086 f3ad7d2c c106712b f3ad7d34 c1719000 48d08=
a93 0
000026d
[ 4012.023785]  f62dd6c0 c171b7c0 f62dd6c0 f3ad7d50 f1065640 f1065640 f3ad7=
d64 c
106886e
[ 4012.031621]  f62da380 34bbe000 f3ad7dcc f3ad7dd4 f62da424 f3ad7dc8 f3ad7=
d78 c
14af592
[ 4012.039455] Call Trace:
[ 4012.041899]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4012.046687]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4012.051735]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4012.057822]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4012.063651]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4012.068959]  [<c14adc40>] schedule+0x20/0x70
[ 4012.073225]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4012.078706]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4012.083319]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4012.088192]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4012.092805]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4012.098289]  [<c10cfde4>] do_wp_page+0x1c4/0x7c0
[ 4012.102907]  [<c10d1dff>] handle_mm_fault+0x49f/0x6f0
[ 4012.107957]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4012.113006]  [<c10a41f7>] ? call_rcu+0x17/0x20
[ 4012.117448]  [<c10415bf>] ? release_task+0x1ef/0x350
[ 4012.122408]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4012.127197]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.132505]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4012.137119]  [<c14b003a>] error_code+0x5a/0x60
[ 4012.141561]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.146869]  [<c120424c>] ? __put_user_4+0x14/0x1c
[ 4012.151655]  [<c1066efd>] ? schedule_tail+0x5d/0xa0
[ 4012.156528]  [<c14b0206>] ret_from_fork+0x6/0x1c
[ 4012.161142] cron            D c106712b     0  2009    833 0x00000000
[ 4012.167514]  f28b7d9c 00000086 f28b7d2c c106712b f28b7d34 c1719000 b5a49=
2bb 0
0000272
[ 4012.175348]  f62dd6c0 c171b7c0 f62dd6c0 f28b7d50 f10605c0 f10605c0 f28b7=
d64 c
106886e
[ 4012.183184]  f62da380 34bbe000 f28b7dcc f28b7dd4 f62da424 f28b7dc8 f28b7=
d78 c
14af592
[ 4012.191019] Call Trace:
[ 4012.193464]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4012.198252]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4012.203300]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4012.209391]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4012.215218]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4012.220528]  [<c14adc40>] schedule+0x20/0x70
[ 4012.224796]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4012.230278]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4012.234890]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4012.239766]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4012.244379]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4012.249861]  [<c10cfde4>] do_wp_page+0x1c4/0x7c0
[ 4012.254478]  [<c10d1dff>] handle_mm_fault+0x49f/0x6f0
[ 4012.259524]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4012.264572]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.269878]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4012.274491]  [<c14b003a>] error_code+0x5a/0x60
[ 4012.278932]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.284241]  [<c120424c>] ? __put_user_4+0x14/0x1c
[ 4012.289026]  [<c1066efd>] ? schedule_tail+0x5d/0xa0
[ 4012.293901]  [<c14b0206>] ret_from_fork+0x6/0x1c
[ 4012.298512] munin-node      D c106712b     0  2010   1028 0x00000000
[ 4012.304885]  f3a11d9c 00000086 f3a11d2c c106712b f3a11d34 c1719000 02044=
b14 0
0000281
[ 4012.312720]  f62dd6c0 c171b7c0 f62dd6c0 f3a11d50 f1062280 f1062280 f3a11=
d64 c
106886e
[ 4012.320556]  f62da380 34bbe000 f3a11dcc f3a11dd4 f62da424 f3a11dc8 f3a11=
d78 c
14af592
[ 4012.328400] Call Trace:
[ 4012.330848]  [<c106712b>] ? get_parent_ip+0xb/0x40
[ 4012.335638]  [<c106886e>] ? migrate_enable+0xae/0x1c0
[ 4012.340688]  [<c14af592>] ? _raw_spin_unlock_irqrestore+0x12/0x40
[ 4012.346774]  [<c109253c>] ? task_blocks_on_rt_mutex+0xbc/0x200
[ 4012.352603]  [<c10671d3>] ? add_preempt_count+0x73/0x100
[ 4012.357910]  [<c14adc40>] schedule+0x20/0x70
[ 4012.362176]  [<c14ae6f5>] rt_spin_lock_slowlock+0xb5/0x260
[ 4012.367661]  [<c14af187>] rt_spin_lock+0x27/0x30
[ 4012.372277]  [<c10be8c4>] __lru_cache_add+0x34/0xd0
[ 4012.377155]  [<c10becd8>] lru_cache_add+0x8/0x10
[ 4012.381767]  [<c10d886d>] page_add_new_anon_rmap+0x7d/0xe0
[ 4012.387247]  [<c10cfde4>] do_wp_page+0x1c4/0x7c0
[ 4012.391864]  [<c10d1dff>] handle_mm_fault+0x49f/0x6f0
[ 4012.396914]  [<c1036c4b>] __do_page_fault+0x17b/0x4e0
[ 4012.401963]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.407271]  [<c10370d8>] do_page_fault+0x8/0x10
[ 4012.411886]  [<c14b003a>] error_code+0x5a/0x60
[ 4012.416326]  [<c10370d0>] ? vmalloc_sync_all+0x120/0x120
[ 4012.421634]  [<c120424c>] ? __put_user_4+0x14/0x1c
[ 4012.426420]  [<c1066efd>] ? schedule_tail+0x5d/0xa0
[ 4012.431295]  [<c14b0206>] ret_from_fork+0x6/0x1c
[ 4012.435908] Sched Debug Version: v0.10, 3.12.13-rt21panel+ #25
[ 4012.441735] ktime                                   : 4009788.990838
[ 4012.448081] sched_clk                               : 4012435.905238
[ 4012.454429] cpu_clk                                 : 4012435.905472
[ 4012.460777] jiffies                                 : 927454
[ 4012.466431] sched_clock_stable                      : 1
[ 4012.471652]=20
[ 4012.473142] sysctl_sched
[ 4012.475672]   .sysctl_sched_latency                    : 12.000000
[ 4012.481847]   .sysctl_sched_min_granularity            : 1.500000
[ 4012.487934]   .sysctl_sched_wakeup_granularity         : 2.000000
[ 4012.494021]   .sysctl_sched_child_runs_first           : 0
[ 4012.499502]   .sysctl_sched_features                   : 22139
[ 4012.505330]   .sysctl_sched_tunable_scaling            : 1 (logaritmic)
[ 4012.511938]=20
[ 4012.513430] cpu#0, 1649.949 MHz
[ 4012.516568]   .nr_running                    : 8
[ 4012.521180]   .load                          : 3072
[ 4012.526052]   .nr_switches                   : 19742568
[ 4012.531272]   .nr_load_updates               : 1002233
[ 4012.536403]   .nr_uninterruptible            : -107
[ 4012.541278]   .next_balance                  : 0.578008
[ 4012.546497]   .curr->pid                     : 3637
[ 4012.651525]   .clock                         : 4012651.055136
[ 4012.657268]   .cpu_load[0]                   : 0
[ 4012.661879]   .cpu_load[1]                   : 0
[ 4012.666490]   .cpu_load[2]                   : 0
[ 4012.671102]   .cpu_load[3]                   : 0
[ 4012.675716]   .cpu_load[4]                   : 0
[ 4012.680331]   .yld_count                     : 24
[ 4012.685029]   .sched_count                   : 19775489
[ 4012.690247]   .sched_goidle                  : 5349077
[ 4012.695380]   .avg_idle                      : 794323
[ 4012.700425]   .ttwu_count                    : 8992874
[ 4012.705558]   .ttwu_local                    : 5050282
[ 4012.710693]=20
[ 4012.710693] cfs_rq[0]:
[ 4012.714525]   .exec_clock                    : 577980.346355
[ 4012.720181]   .MIN_vruntime                  : 1513493.594716
[ 4012.725921]   .min_vruntime                  : 1513499.594716
[ 4012.731662]   .max_vruntime                  : 1513493.594716
[ 4012.737403]   .spread                        : 0.000000
[ 4012.742621]   .spread0                       : 0.000000
[ 4012.747838]   .nr_spread_over                : 33564
[ 4012.752795]   .nr_running                    : 3
[ 4012.757409]   .load                          : 3072
[ 4012.762283]   .runnable_load_avg             : 0
[ 4012.766896]   .blocked_load_avg              : 0
[ 4012.771509]=20
[ 4012.771509] rt_rq[0]:
[ 4012.775255]   .rt_nr_running                 : 5
[ 4012.779864]   .rt_throttled                  : 0
[ 4012.784473]   .rt_time                       : 1021.987265
[ 4012.789951]   .rt_runtime                    : 1000.000000
[ 4012.795430]   .rt_nr_migratory               : 1
[ 4012.800040]=20
[ 4012.800040] runnable tasks:
[ 4012.800040]             task   PID         tree-key  switches  prio     =
exec-
runtime         sum-exec        sum-sleep
[ 4012.800040] ------------------------------------------------------------=
-----
-----------------------------------------
[ 4012.825647]      ksoftirqd/0     3        -3.000000    655617    98     =
   -3
.000000      8702.785784         0.000000
[ 4012.836376]           rcuc/0    15        -3.000000    278716    98     =
   -3
.000000      5810.323312         0.000000
[ 4012.847109]  systemd-journal   196   1513493.594716      2449   120   15=
13493
.594716       273.461656   2623283.352271
[ 4012.857844]    VisionLineGui  1622         0.000000   2388301    39     =
    0
.000000    384277.128155   1916449.569945
[ 4012.868572]    VisionLineGui  1724   1513493.594716    102610   120   15=
13493
.594716      1919.879611   2587477.132774
[ 4012.879296]           screen  3572   1513493.594716     45227   120   15=
13493
.594716      1808.874962    769084.691362
[ 4012.890018] RVisionLineDaemo  3637         0.000000      4339    39     =
    0
.000000   1405501.394654         0.000000
[ 4012.900740]          QThread  4224         0.000000    151421    59     =
    0
.000000     15053.995468         0.000000
[ 4012.911463]=20
[ 4012.912953] cpu#1, 1649.949 MHz
[ 4012.916091]   .nr_running                    : 10
[ 4012.920788]   .load                          : 0
[ 4012.925402]   .nr_switches                   : 21072462
[ 4012.930621]   .nr_load_updates               : 1002304
[ 4012.935757]   .nr_uninterruptible            : 128
[ 4012.940544]   .next_balance                  : 0.926701
[ 4012.945764]   .curr->pid                     : 1146
[ 4012.950639]   .clock                         : 4012947.567484
[ 4012.956379]   .cpu_load[0]                   : 0
[ 4012.960992]   .cpu_load[1]                   : 0
[ 4012.965605]   .cpu_load[2]                   : 0
[ 4012.970219]   .cpu_load[3]                   : 0
[ 4012.974833]   .cpu_load[4]                   : 0
[ 4012.979447]   .yld_count                     : 24
[ 4012.984147]   .sched_count                   : 21104354
[ 4012.989367]   .sched_goidle                  : 5773547
[ 4012.994496]   .avg_idle                      : 1000000
[ 4012.999627]   .ttwu_count                    : 14233182
[ 4013.004847]   .ttwu_local                    : 7991802
[ 4013.009981]=20
[ 4013.009981] cfs_rq[1]:
[ 4013.013816]   .exec_clock                    : 596531.947140
[ 4013.019470]   .MIN_vruntime                  : 0.000001
[ 4013.024690]   .min_vruntime                  : 1491325.441421
[ 4013.030431]   .max_vruntime                  : 0.000001
[ 4013.035649]   .spread                        : 0.000000
[ 4013.040869]   .spread0                       : -22174.153295
[ 4013.046521]   .nr_spread_over                : 33132
[ 4013.051481]   .nr_running                    : 0
[ 4013.056095]   .load                          : 0
[ 4013.060704]   .runnable_load_avg             : 0
[ 4013.065318]   .blocked_load_avg              : 0
[ 4013.069931]=20
[ 4013.069931] rt_rq[1]:
[ 4013.073677]   .rt_nr_running                 : 10
[ 4013.078375]   .rt_throttled                  : 0
[ 4013.082987]   .rt_time                       : 432.165071
[ 4013.088377]   .rt_runtime                    : 900.000000
[ 4013.093771]   .rt_nr_migratory               : 8
[ 4013.098380]=20
[ 4013.098380] runnable tasks:
[ 4013.098380]             task   PID         tree-key  switches  prio     =
exec-
runtime         sum-exec        sum-sleep
[ 4013.098380] ------------------------------------------------------------=
-----
-----------------------------------------
[ 4013.123981]      ksoftirqd/1    18        -1.946987   1004171    98     =
   -1
.946987     17419.388675         0.000000
[ 4013.134702]    irq/42-radeon   105        -6.000000    311332    49     =
   -6
.000000     26569.685291         0.000000
[ 4013.145423]      irq/40-eth0   636        -6.000000    180222    49     =
   -6
.000000      8511.244262         0.000000
[ 4013.156146] R   irq/4-serial  1146        -6.000000       666    49     =
   -6
.000000      6168.409656         0.000000
[ 4013.166871]  OpcServerThread  4193         0.000000      8483    59     =
    0
.000000       316.261207         0.000000
[ 4013.177595]          QThread  4199         0.000000      1691    59     =
    0
.000000        60.778681         0.000000
[ 4013.188313]          QThread  4205         0.000000     33710    59     =
    0
.000000      1121.380584         0.000000
[ 4013.199034]          QThread  4228         0.000000    172083    59     =
    0
.000000      5312.727093         0.000000
[ 4013.209755]          QThread  4247         0.000000      3526    59     =
    0
.000000       239.422532         0.000000
[ 4013.220476]          QThread  4259         0.000000    164547    59     =
    0
.000000     10400.676999         0.000000
[ 4013.231199]

Any help or advice appreciated, thanks in advance,

Matthias B=C3=BChler

--PGP_Universal_2260E0CF_096C206C_11B1D29F_0ED9E427
Content-Type: application/pgp-signature; name="PGP.sig"
Content-Transfer-Encoding: 7BIT
Content-Disposition: attachment; filename="PGP.sig"

-----BEGIN PGP SIGNATURE-----
Version: 10.2.0 (Build 1672)

iQA/AwUBVWbJ41ebCIQswlWaEQIzugCdH2YHObONlLT9CX8anddWrU+h7QYAoPfT
wzXE03TYzIZnFmBoyh/INvyi
=Y89D
-----END PGP SIGNATURE-----

--PGP_Universal_2260E0CF_096C206C_11B1D29F_0ED9E427--
