Return-Path: <SRS0=TBiY=D4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4B3C388F9
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Oct 2020 17:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 209AF223BF
	for <linux-rt-users@archiver.kernel.org>; Wed, 21 Oct 2020 17:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391710AbgJUR7O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 21 Oct 2020 13:59:14 -0400
Received: from sleepmap.de ([85.10.206.218]:54770 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391484AbgJUR7O (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 21 Oct 2020 13:59:14 -0400
X-Greylist: delayed 490 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Oct 2020 13:59:12 EDT
Date:   Wed, 21 Oct 2020 19:50:59 +0200
From:   David Runge <dave@sleepmap.de>
To:     linux-rt-users@vger.kernel.org
Subject: 5.9.1-rt18: issues with Firewire card on AMD hardware
Message-ID: <20201021175059.GA4989@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: 5.9.1-rt18: issues with Firewire card on AMD hardware

Hi!

I'm currently trying to get the latest linux-rt kernel (v5.9.1-rt18) to
work on my AMD hardware. I'm providing the kernel as a prebuilt binary
to the Arch Linux community, as we do not have that specific kernel in
the repositories (yet).

I'm facing issues in regards to hardware discovery and crashes, which I
do not get on the vanilla kernel (now at 5.9.1) on Arch Linux.

I have a PCIe Firewire card that I use for an external audio interface
(RME Fireface800):

05:00.0 FireWire (IEEE 1394): Texas Instruments XIO2213A/B/XIO2221
IEEE-1394b OHCI Controller [Cheetah Express] (rev 01)

Unfortunately the card does not show up anymore and instead I run into a
bug:

Oct 21 19:08:03 hmbx kernel: ------------[ cut here ]------------
Oct 21 19:08:03 hmbx kernel: DEBUG_LOCKS_WARN_ON(val > preempt_count())
Oct 21 19:08:03 hmbx kernel: WARNING: CPU: 19 PID: 0 at
kernel/sched/core.c:4763 preempt_count_sub+0x5a/0x90
Oct 21 19:08:03 hmbx kernel: Modules linked in: crypto_user ip_tables
x_tables dm_crypt encrypted_keys trusted tpm hid_logitech_hidpp
hid_logitech_dj sd_mod hid_generic usbhid hid amdgpu gpu_sched ttm
drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops
crct10dif_pclmul cec ahci r8169 crc32_pclmul ghash_clmuln
i_intel libahci realtek aesni_intel mdio_devres crypto_simd dm_mod btrfs
of_mdio firewire_ohci blake2b_generic drm libcrc32c cryptd libata ccp
xhci_pci fixed_phy crc32c_generic ehci_pci igb glue_helper firewire_core
crc32c_intel agpgart rng_core crc_itu_t scsi_mod xhci_hcd xor dca libphy
ehci_hcd i2c_algo_bit wmi raid
6_pq
Oct 21 19:08:03 hmbx kernel: CPU: 19 PID: 0 Comm: swapper/19 Tainted: G
W         5.9.1-rt18-1-rt #1
Oct 21 19:08:03 hmbx kernel: Hardware name: System manufacturer System
Product Name/Pro WS X570-ACE, BIOS 1302 01/20/2020
Oct 21 19:08:03 hmbx kernel: RIP: 0010:preempt_count_sub+0x5a/0x90
Oct 21 19:08:03 hmbx kernel: Code: 2d d5 62 c3 e8 a7 2d 8c 00 85 c0 74
f6 8b 15 55 77 50 01 85 d2 75 ec 48 c7 c6 df 5c 30 9e 48 c7 c7 ea e9 2e
9e e8 ab ee fc ff <0f> 0b c3 84 c0 75 c9 e8 7a 2d 8c 00 85 c0 74 c9 8b
05 28 77 50 01
Oct 21 19:08:03 hmbx kernel: RSP: 0018:ffff9304401e7dc0 EFLAGS: 00010082
Oct 21 19:08:03 hmbx kernel: RAX: 0000000000000000 RBX: ffff90e257e53f00
RCX: 0000000000000000
Oct 21 19:08:03 hmbx kernel: RDX: 0000000000000001 RSI: ffffffff9e313727
RDI: 00000000ffffffff
Oct 21 19:08:03 hmbx kernel: RBP: ffff9304401e7df8 R08: ffffffff9ed443e0
R09: 0000000000000001
Oct 21 19:08:03 hmbx kernel: R10: ffff9304401e7ce8 R11: 3fffffffffffffff
R12: 0000000000000001
Oct 21 19:08:03 hmbx kernel: R13: 0000000000000000 R14: 0000000000000000
R15: 0000000000000000
Oct 21 19:08:03 hmbx kernel: FS:  0000000000000000(0000)
GS:ffff90e25eec0000(0000) knlGS:0000000000000000
Oct 21 19:08:03 hmbx kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
Oct 21 19:08:03 hmbx kernel: CR2: 00007f085fb38c20 CR3: 0000000fb829c000
CR4: 0000000000350ee0
Oct 21 19:08:03 hmbx kernel: Call Trace:
Oct 21 19:08:03 hmbx kernel:  irq_exit_rcu+0x28/0xe0
Oct 21 19:08:03 hmbx kernel:  sysvec_call_function_single+0x47/0xe0
Oct 21 19:08:03 hmbx kernel:  asm_sysvec_call_function_single+0x12/0x20
Oct 21 19:08:03 hmbx kernel: RIP: 0010:cpuidle_enter_state+0xd9/0x440
Oct 21 19:08:03 hmbx kernel: Code: 95 ff 49 89 c5 8b 05 6e ad e2 00 85
c0 0f 8f f1 01 00 00 31 ff e8 c7 26 95 ff 45 84 f6 0f 85 9f 01 00 00 fb
66 0f 1f 44 00 00 <45> 85 e4 0f 88 de 00 00 00 49 63 d4 4d 29 fd 48 8d
04 52 48 8d 04
Oct 21 19:08:03 hmbx kernel: RSP: 0018:ffff9304401e7ea0 EFLAGS: 00000246
Oct 21 19:08:03 hmbx kernel: RAX: ffff90e25eec0000 RBX: ffff90e240dc7400
RCX: 000000000000001f
Oct 21 19:08:03 hmbx kernel: RDX: 0000000000000001 RSI: ffffffff9e313727
RDI: ffffffff9e340fb6
Oct 21 19:08:03 hmbx kernel: RBP: ffffffff9e745bc0 R08: 0000000000000002
R09: 0000000000000020
Oct 21 19:08:03 hmbx kernel: R10: 0000000000000165 R11: 0000000000006045
R12: 0000000000000002
Oct 21 19:08:03 hmbx kernel: R13: 0000000398671b89 R14: 0000000000000000
R15: 00000003986701bf
Oct 21 19:08:03 hmbx kernel:  cpuidle_enter+0x29/0x40
Oct 21 19:08:03 hmbx kernel:  do_idle+0x232/0x2d0
Oct 21 19:08:03 hmbx kernel:  cpu_startup_entry+0x19/0x20
Oct 21 19:08:03 hmbx kernel:  secondary_startup_64+0xb6/0xc0
Oct 21 19:08:03 hmbx kernel: ---[ end trace 0000000000000002 ]---

I have the kernel log and lspci output (from the working vanilla kernel)
here: https://pkgbuild.com/~dvzrv/bugs/linux-rt-5.9.1.18/

Any pointers or help would be much appreciated! If you need more
information, just ask! :)

Best,
David

P.S.: I was trying the 5.6.x series of realtime kernels on this machine
as well, but although the hardware gets initialized properly (at least
without crashes) my system completely freezes as soon as I start jackd
on the firewire interface (this does not happen with a non-rt kernel).

--=20
https://sleepmap.de

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAl+QdQMACgkQVMKPT/Wh
qUkC8Q/+Ju1aMkLEoxPD9z3HTbyBeug8jRyyLfIzN+YMFic3d/dc88ukBPHOxRJM
i0gERK9a3TYzRizOKSvJUGI6zf0JE75AIwRE09IQzRh9Bf8jpHq0f2k+qsCNgmIP
5613gtuz2e8zvg1EHniZ1b3WDuPMWXr6j489jEoQ6NsEacVy2l8a0dB+tU21cgRR
99chQx38J58P3HcIFtjGH/w6HQwIVKITXeTb32rduCVpWJHlDVf2BwQK4rgxo8PW
7EgF9ApzlRQXCvB6c8zZ8TnJx/kvOYldzDPeBKs2N0eqnSp8BN1XBWIN9BdISvqh
dgGEXaVsoXupJpNCaROKd00qmZBEf9sh4v1Fp31sI5jexj0gQABTtmv2o751XuVi
NZ8btMFw2L+I3xVJikYsjISiTnG5tZZX0kMity/19WaPT6b9Ys7xe3ToqC0FPe0I
4W9xBHZ9M5itTKnXAeNoxGP75qqAyETZHJyjGKpvE9mu3fw8VTDEIewnJxjU3ukc
/ktecK5YnaTW4T7W7BJZyppQunq1gdWLbwQsPbLr4v5Lq7KSK5muCHrLeeNO88QW
aV5wn7bqHWqIdYm5dxdyEFk3wszxrF1PCr5uwQINBMZoYXR+znIyqhpoFQN8PYaj
FmAXWoV3AxIzt/rCYgJYt68x/Q10olusrHzXchYo41ciWLhMNUQ=
=S3ch
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
