From: Clark Williams <williams@redhat.com>
Subject: [RT] RCU splat on 2.6.33.4-rt20
Date: Wed, 19 May 2010 21:19:11 -0500
Message-ID: <20100519211911.5450c1dd@torg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_//fur=EKJpQNu65jVUZy8Zaf"; protocol="application/pgp-signature"
Cc: RT <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	"Paul E. McKenney" <paulmck@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49578 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752890Ab0ETCzZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 May 2010 22:55:25 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

--Sig_//fur=EKJpQNu65jVUZy8Zaf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Thomas/Paul,

Resumed my laptop (T60, 64-bit kernel) and after about five
minutes of doing nothing but surfing with firefox, got the following
RCU stall notification from a 2.6.33.4-rt20 kernel:

INFO: RCU detected CPU 1 stall (t=3D0 jiffies)
sending NMI to all CPUs:
NMI backtrace for cpu 1
CPU 1=20
Pid: 0, comm: swapper Not tainted 2.6.33.4-rt20 #37        /      =20
RIP: 0010:[<ffffffff8120f188>]  [<ffffffff8120f188>]
__const_udelay+0x37/0x44 RSP: 0018:ffff88000a303dc8  EFLAGS: 00000002
RAX: 0000000001062560 RBX: 0000000000000001 RCX: ffff88000a300000
RDX: 000000001dba61d0 RSI: 0000000000000002 RDI: 0000000000418958
RBP: ffff88000a303dc8 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff88000a30b8b0
R13: ffffffff81a7c800 R14: ffff88000a303f48 R15: ffff88000a30b5e0
FS:  0000000000000000(0000) GS:ffff88000a300000(0000)
knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007f5fedd4b000 CR3: 0000000001a56000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process swapper (pid: 0, threadinfo ffff8800bf1d8000, task
ffff8800bf1d67c0) Stack:
 ffff88000a303de8 ffffffff810185aa 000000000000088e ffffffff81a7c800
<0> ffff88000a303e38 ffffffff81092650 ffff8800bf1d9dc8 0000000000000001
<0> ffff88000a303e58 0000000000000001 0000000000000001 0000000000000000
Call Trace:
 <IRQ>=20
 [<ffffffff810185aa>] arch_trigger_all_cpu_backtrace+0x56/0x62
 [<ffffffff81092650>] __rcu_pending+0x6e/0x2d3
 [<ffffffff81092909>] rcu_check_callbacks+0x54/0x15b
 [<ffffffff8104972e>] update_process_times+0x46/0x5b
 [<ffffffff810656ed>] tick_sched_timer+0x7a/0xa4
 [<ffffffff8105b7ca>] __run_hrtimer+0x130/0x1bd
 [<ffffffff81065673>] ? tick_sched_timer+0x0/0xa4
 [<ffffffff8105bb9f>] hrtimer_interrupt+0xdc/0x1dd
 [<ffffffff8143bcb4>] smp_apic_timer_interrupt+0x89/0x9c
 [<ffffffff81003593>] apic_timer_interrupt+0x13/0x20
 <EOI>=20
 [<ffffffff81275cd8>] ? acpi_idle_enter_bm+0x2b0/0x2db
 [<ffffffff81275cce>] ? acpi_idle_enter_bm+0x2a6/0x2db
 [<ffffffff81370a67>] cpuidle_idle_call+0x96/0x11f
 [<ffffffff81001da9>] cpu_idle+0xab/0xee
 [<ffffffff81430232>] start_secondary+0x1a5/0x1a9
Code: 00 ff 00 00 48 8d 04 bd 00 00 00 00 65 8b 0c 25 78 ac 00 00 48 63
c9 48 8b 0c cd 60 23 af 81 48 69 94 0a 98 00 00 00 fa 00 00 00 <f7> e2
48 8d 7a 01 e8 ad ff ff ff c9 c3 55 48 89 e5 0f 1f 44 00 Call Trace:
<#MC>  <<EOE>> Pid: 0, comm: swapper Not tainted 2.6.33.4-rt20 #37 Call
Trace: <NMI>  [<ffffffff81001a9c>] ? show_regs+0x2b/0x30
 [<ffffffff814380bd>] nmi_watchdog_tick+0xc2/0x1a6
 [<ffffffff814376c3>] do_nmi+0xb5/0x25b
 [<ffffffff814371aa>] nmi+0x1a/0x20
 [<ffffffff8120f188>] ? __const_udelay+0x37/0x44
 <<EOE>>  <IRQ>  [<ffffffff810185aa>]
arch_trigger_all_cpu_backtrace+0x56/0x62 [<ffffffff81092650>]
__rcu_pending+0x6e/0x2d3 [<ffffffff81092909>]
rcu_check_callbacks+0x54/0x15b [<ffffffff8104972e>]
update_process_times+0x46/0x5b [<ffffffff810656ed>]
tick_sched_timer+0x7a/0xa4 [<ffffffff8105b7ca>]
__run_hrtimer+0x130/0x1bd [<ffffffff81065673>] ?
tick_sched_timer+0x0/0xa4 [<ffffffff8105bb9f>]
hrtimer_interrupt+0xdc/0x1dd [<ffffffff8143bcb4>]
smp_apic_timer_interrupt+0x89/0x9c [<ffffffff81003593>]
apic_timer_interrupt+0x13/0x20 <EOI>  [<ffffffff81275cd8>] ?
acpi_idle_enter_bm+0x2b0/0x2db [<ffffffff81275cce>] ?
acpi_idle_enter_bm+0x2a6/0x2db [<ffffffff81370a67>]
cpuidle_idle_call+0x96/0x11f [<ffffffff81001da9>] cpu_idle+0xab/0xee
 [<ffffffff81430232>] start_secondary+0x1a5/0x1a9
NMI backtrace for cpu 0
CPU 0=20
Pid: 31, comm: events/0 Not tainted 2.6.33.4-rt20 #37        /      =20
RIP: 0010:[<ffffffff813c124d>]  [<ffffffff813c124d>]
rt_worker_func+0xd3/0x2de RSP: 0018:ffff8800bf1ddd80  EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000002770 RCX: ffff8800b8a13b80
RDX: 0000000000002770 RSI: ffff8800bf1ddfd8 RDI: ffff8800b893a760
RBP: ffff8800bf1dddf0 R08: ffff8800bf1dc000 R09: ffff8800bf1da800
R10: ffff88000a210000 R11: 0000000000000001 R12: 0000000000006666
R13: 0000000000000000 R14: 00000000000062b0 R15: 0000000000013b80
FS:  0000000000000000(0000) GS:ffff88000a200000(0000)
knlGS:0000000000000000 CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 00007fbe40a86000 CR3: 0000000001a56000 CR4: 00000000000006f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Process events/0 (pid: 31, threadinfo ffff8800bf1dc000, task
ffff8800bf1da800) Stack:
 ffff8800bf1dddc0 ffff8800b8a135a0 0000000000000000 ffff8800bf1ddfd8
<0> 0000000000002760 00000000000493e0 0000000000000000 00000000000493e0
<0> ffff8800bf1dc000 ffff88000a212ac0 ffff8800bf1da800 ffff8800bf1dc000
Call Trace:
 [<ffffffff81053f0f>] worker_thread+0x206/0x2a3
 [<ffffffff813c117a>] ? rt_worker_func+0x0/0x2de
 [<ffffffff81058360>] ? autoremove_wake_function+0x0/0x39
 [<ffffffff81053d09>] ? worker_thread+0x0/0x2a3
 [<ffffffff81053d09>] ? worker_thread+0x0/0x2a3
 [<ffffffff81057fbd>] kthread+0x7f/0x87
 [<ffffffff810039d4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81057f3e>] ? kthread+0x0/0x87
 [<ffffffff810039d0>] ? kernel_thread_helper+0x0/0x10
Code: 00 00 00 00 4c 89 f9 48 03 0d 98 63 73 00 a8 08 74 15 48 89 55 90
48 89 4d 98 e8 67 3c 07 00 48 8b 4d 98 48 8b 55 90 48 83 39 00 <0f> 84
86 01 00 00 48 63 45 c8 48 89 4d 98 48 89 45 b8 81 e2 ff Call Trace:
<#MC>  <<EOE>> Pid: 31, comm: events/0 Not tainted 2.6.33.4-rt20 #37
Call Trace: <NMI>  [<ffffffff81001a9c>] ? show_regs+0x2b/0x30
 [<ffffffff814380bd>] nmi_watchdog_tick+0xc2/0x1a6
 [<ffffffff814376c3>] do_nmi+0xb5/0x25b
 [<ffffffff814371aa>] nmi+0x1a/0x20
 [<ffffffff813c124d>] ? rt_worker_func+0xd3/0x2de
 <<EOE>>  [<ffffffff81053f0f>] worker_thread+0x206/0x2a3
 [<ffffffff813c117a>] ? rt_worker_func+0x0/0x2de
 [<ffffffff81058360>] ? autoremove_wake_function+0x0/0x39
 [<ffffffff81053d09>] ? worker_thread+0x0/0x2a3
 [<ffffffff81053d09>] ? worker_thread+0x0/0x2a3
 [<ffffffff81057fbd>] kthread+0x7f/0x87
 [<ffffffff810039d4>] kernel_thread_helper+0x4/0x10
 [<ffffffff81057f3e>] ? kthread+0x0/0x87
 [<ffffffff810039d0>] ? kernel_thread_helper+0x0/0x10

--Sig_//fur=EKJpQNu65jVUZy8Zaf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.13 (GNU/Linux)

iEYEARECAAYFAkv0nCIACgkQHyuj/+TTEp0/JgCgo/PC7NqONvLswB70tTN368Rh
alwAoNVmDqmMgHugHds9pmRxcZzvMIUT
=k0MU
-----END PGP SIGNATURE-----

--Sig_//fur=EKJpQNu65jVUZy8Zaf--
