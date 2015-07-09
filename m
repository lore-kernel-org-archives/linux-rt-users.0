From: Josh Cartwright <joshc@ni.com>
Subject: Re: BUG: unable to handle kernel NULL pointer dereference on
 3.18.13-rt10
Date: Thu, 9 Jul 2015 13:35:43 -0500
Message-ID: <20150709183543.GA20085@jcartwri.amer.corp.natinst.com>
References: <453aa7881ded41e7a843795863ac1712@FE-MBX1012.de.bosch.com>
 <alpine.DEB.2.11.1507091605410.5134@nanos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:48890 "EHLO ni.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751976AbbGISf6 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 9 Jul 2015 14:35:58 -0400
In-Reply-To: <alpine.DEB.2.11.1507091605410.5134@nanos>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2015 at 04:11:41PM +0200, Thomas Gleixner wrote:
> On Thu, 9 Jul 2015, Koehrer Mathias (ETAS/ESW5) wrote:
> > BUG: unable to handle kernel NULL pointer dereference at 0000001c
> > IP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100
> > *pde = 00000000
> > Oops: 0000 [#1] PREEMPT SMP
> > Modules linked in: rtpc_dma(O) es53xx(O) nfsd nfs lockd grace sunrpc bridge stp llc e100 mii e1000 e1000e igb i2c_algo_bit ixgbe mdio ptp pps_core dca kvm_intel kvm ecikm(O) i2c_i801 pcspkr i2c_core video backlight processor coretemp autofs4 reiserfs microcode sg sd_mod ahci libahci ehci_pci ehci_hcd xhci_pci xhci_hcd fan thermal_sys hwmon
> > CPU: 0 PID: 1522 Comm: systemd-journal Tainted: G           O   3.18.13-rt10-2 #2
> > Hardware name: Supermicro X9SAE/X9SAE, BIOS 2.0b 07/10/2013
> > task: dff76000 ti: f4760000 task.ti: f4760000
> > EIP: 0060:[<c107fb62>] EFLAGS: 00010282 CPU: 0
> > EIP is at __try_to_take_rt_mutex+0x52/0x100
> > EAX: 00000000 EBX: 00000000 ECX: f4761df4 EDX: 00000000
> > ESI: dff76000 EDI: dfdec944 EBP: f4761dd4 ESP: f4761dc4
> > DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> > CR0: 80050033 CR2: f8b5cbc0 CR3: 344ad000 CR4: 001407d0
> > Stack:
> > dff76000 dfdec944 dff764b0 f4761df4 f4761e28 c1404169 00000001 f4761fec
> > f3ba9201 dff76000 dff764b0 dff76000 00000001 00000000 00000000 f4761e00
> > 00000000 00000000 dff76000 dfdec944 c1045b01 00000078 dff76000 f3bae000
> > Call Trace:
> > [<c1404169>] rt_spin_lock_slowlock+0xf9/0x240
> > [<c1045b01>] ? pin_current_cpu+0x31/0x1a0
> > [<c1405567>] rt_spin_lock+0x27/0x30
> > [<c1051508>] __lock_task_sighand+0x38/0x70
> > [<c119768b>] proc_pid_status+0x33b/0x620
> > [<c1193312>] proc_single_show+0x42/0x80
> > [<c1163d12>] seq_read+0x82/0x380
> > [<c11283fa>] ? do_mmap_pgoff+0x27a/0x350
> > [<c1080abd>] ? rt_up_write+0xd/0x10
> > [<c1163c90>] ? seq_lseek+0x1c0/0x1c0
> > [<c1142684>] vfs_read+0x74/0x140
> > [<c1142ca6>] SyS_read+0x46/0x90
> > [<c1405c54>] sysenter_do_call+0x12/0x12
> > Code: 83 cb 01 f0 0f b1 1e 39 d0 75 ee 8b 5f 0c 31 c0 83 e3 fe 74 0c 83 c4 04 5b 5e 5f 5d c3 8d 74 26 00 8b 75 f0 85 c9 74 1d 8b 57 08 <3b> 7a 1c 0f 85 93 00 00 00 89 d8 39 d1 75 db 89 ca 89 f8 e8 c6
> > EIP: [<c107fb62>] __try_to_take_rt_mutex+0x52/0x100 SS:ESP 0068:f4761dc4
> > CR2: 000000000000001c
> > ---[ end trace 0000000000

I was able to trigger a similar-looking OOPs; not sure if it provides
any more meaningful data, but here it is:

 Unable to handle kernel NULL pointer dereference at virtual address 0000001c
 pgd = dd998000
 [0000001c] *pgd=1da24831, *pte=00000000, *ppte=00000000
 Internal error: Oops: 17 [#1] PREEMPT SMP ARM
 Modules linked in: ipv6 ehci_hcd
 CPU: 1 PID: 1169 Comm: busybox Not tainted 3.18.13-rt10-ni-00623-g6a5191f-dirty #8
 task: ded1cac0 ti: dea78000 task.ti: dea78000
 PC is at __try_to_take_rt_mutex+0x6c/0x150
 LR is at rt_spin_lock_slowlock+0x10c/0x29c
 pc : [<c00583bc>]    lr : [<c05291c0>]    psr: a00d0013
 sp : dea79d48  ip : 00000000  fp : dea79d64
 r10: dea79d68  r9 : dea79d68  r8 : dea79d68
 r7 : 00000000  r6 : 00000000  r5 : ded1cac0  r4 : dd93af04
 r3 : 00000000  r2 : dea79d68  r1 : dd93af10  r0 : 00000000
 Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
 Control: 18c5387d  Table: 1d99804a  DAC: 00000015
 Process busybox (pid: 1169, stack limit = 0xdea78240)
 Stack: (0xdea79d48 to 0xdea7a000)
 9d40:                   dd93af04 ded1cac0 dea78000 ded1cf50 dea79dbc dea79d68
 9d60: c05291c0 c005835c 00000001 00000000 00000000 dea79d74 00000000 00000000
 9d80: ded1cac0 dd93af04 dea79d01 00000078 dea79dac dd93aa00 debacac0 dd93af04
 9da0: dea79e60 c0768138 00000001 000003ff dea79dcc dea79dc0 c052a9d8 c05290c0
 9dc0: dea79dec dea79dd0 c0030110 c052a98c deb14580 debacac0 dee65180 deb14580
 9de0: dea79eb4 dea79df0 c01675d8 c00300d4 c011f8dc c011aae4 dea79e14 dda5bb00
 9e00: ded1cac0 df24a550 de921800 00000044 dea79e34 c012f8fc df41c600 ded9f180
 9e20: dea79e44 dea79e30 c012f8fc 002da000 dea79ee8 de921800 dea79e54 dea79e48
 9e40: beb7a178 b6e429f0 dea79e6c dea79e58 c0768138 c028f464 00000000 00000000
 9e60: 60000013 dea79e70 00000000 00000000 00000000 00000000 6c706669 2e646775
 9e80: 69746361 00006e6f 00001000 debacac0 dcafea40 dda5bb00 deb14580 c0768138
 9ea0: dea79f78 000003ff dea79ecc dea79eb8 c01684a8 c01674f8 00000001 dcafea40
 9ec0: dea79ef4 dea79ed0 c0162dd0 c0168490 c0162d7c 00000000 00000000 dea79f08
 9ee0: 00000001 deb14580 dea79f44 dea79ef8 c0133a64 c0162d88 dea79f44 deb145b0
 9f00: de921800 bec627d0 00000000 00000000 dea78000 dcafea40 dea79f3c 000003ff
 9f20: de921800 bec627d0 dea79f78 000003ff dea78000 bec627d0 dea79f74 dea79f48
 9f40: c011248c c0133888 c012d13c c012d0ac 00000000 00000000 de921800 de921800
 9f60: 000003ff bec627d0 dea79fa4 dea79f78 c0112588 c01123fc 00000000 00000000
 9f80: 0009a0a0 bec627d0 00000004 00000003 c000f384 00000000 00000000 dea79fa8
 9fa0: c000f140 c0112548 0009a0a0 bec627d0 00000004 bec627d0 000003ff 00000000
 9fc0: 0009a0a0 bec627d0 00000004 00000003 00081984 00000220 00099988 0000000b
 9fe0: 00000000 bec62784 00076be4 b6e8612c 60000010 00000004 00000000 00000000
 Backtrace:
 [<c0058350>] (__try_to_take_rt_mutex) from [<c05291c0>] (rt_spin_lock_slowlock+0x10c/0x29c)
  r7:ded1cf50 r6:dea78000 r5:ded1cac0 r4:dd93af04
 [<c05290b4>] (rt_spin_lock_slowlock) from [<c052a9d8>] (rt_spin_lock+0x58/0x5c)
  r10:000003ff r9:00000001 r8:c0768138 r7:dea79e60 r6:dd93af04 r5:debacac0
  r4:dd93aa00
 [<c052a980>] (rt_spin_lock) from [<c0030110>] (__lock_task_sighand+0x48/0x78)
 [<c00300c8>] (__lock_task_sighand) from [<c01675d8>] (do_task_stat+0xec/0x85c)
  r7:deb14580 r6:dee65180 r5:debacac0 r4:deb14580
 [<c01674ec>] (do_task_stat) from [<c01684a8>] (proc_tgid_stat+0x24/0x2c)
  r10:000003ff r9:dea79f78 r8:c0768138 r7:deb14580 r6:dda5bb00 r5:dcafea40
  r4:debacac0
 [<c0168484>] (proc_tgid_stat) from [<c0162dd0>] (proc_single_show+0x54/0xa4)
 [<c0162d7c>] (proc_single_show) from [<c0133a64>] (seq_read+0x1e8/0x468)
  r8:deb14580 r7:00000001 r6:dea79f08 r5:00000000 r4:00000000 r3:c0162d7c
 [<c013387c>] (seq_read) from [<c011248c>] (vfs_read+0x9c/0x14c)
  r10:bec627d0 r9:dea78000 r8:000003ff r7:dea79f78 r6:bec627d0 r5:de921800
  r4:000003ff
 [<c01123f0>] (vfs_read) from [<c0112588>] (SyS_read+0x4c/0x8c)
  r10:bec627d0 r8:000003ff r7:de921800 r6:de921800 r5:00000000 r4:00000000
 [<c011253c>] (SyS_read) from [<c000f140>] (ret_fast_syscall+0x0/0x30)
  r10:00000000 r8:c000f384 r7:00000003 r6:00000004 r5:bec627d0 r4:0009a0a0
 Code: 1a000036 e3520000 0a000009 e5943008 (e593101c)
 ---[ end trace 0000000000000002 ]---
 note: busybox[1169] exited with preempt_count 1

I hit it once before, but wasn't in any position to capture the logs.
The two times I hit the oops were both at boot.  I haven't seen this in
(yet?) in 4.0.5-rt4.

  Josh

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJVnr78AAoJEKp7ZBKwQFAr4akH/RRUDfO6ZTMNy2TQpp4sCUmc
3HndDTSk5ObbB9AR3YpgdPnHNMN/paC8EpxKvVdosglVe88W0lpwA1ihNQgZTFab
kP6Rq9St5AohLDAHqnpbHoISopM6GWBAruo0x1XNI4u3nwtD3PcElCeoDb7xl3S5
izxcGvkanwKFbqnNw4/MBuIx+4seSaBZuUHi2npj5ICX0DbapJRC5OxE+biOoqQr
z+gnK/nuAf99Y5JgrVw0ahrOFccESbGjTG6BTRBRETw3CgwfMqhKyvvJCaaozgqN
tUTPzolOBVHxwrzU10I/BgWoHDI0lBmdOoB6CEmNfGK8wlbvl6+XS3riGHx8fYg=
=kzYo
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
