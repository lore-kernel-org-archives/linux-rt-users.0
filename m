Return-Path: <SRS0=SXCv=EB=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7142C4363A
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 00:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7354520756
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Oct 2020 00:39:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420873AbgJZAhe (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 25 Oct 2020 20:37:34 -0400
Received: from sleepmap.de ([85.10.206.218]:58262 "EHLO mail.sleepmap.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389864AbgJZAhN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 25 Oct 2020 20:37:13 -0400
Date:   Mon, 26 Oct 2020 01:37:08 +0100
From:   David Runge <dave@sleepmap.de>
To:     linux-rt-users@vger.kernel.org
Subject: Re: 5.9.1-rt18: issues with Firewire card on AMD hardware
Message-ID: <20201026003708.GA21902@hmbx>
References: <20201021175059.GA4989@hmbx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20201021175059.GA4989@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: 5.9.1-rt18: issues with Firewire card on AMD hardware

On 2020-10-21 19:50:59 (+0200), David Runge wrote:
> P.S.: I was trying the 5.6.x series of realtime kernels on this machine
> as well, but although the hardware gets initialized properly (at least
> without crashes) my system completely freezes as soon as I start jackd
> on the firewire interface (this does not happen with a non-rt kernel).

Thanks! 5.9.1-rt19 fixes the crash for me.
Unfortunately I now have the ca. 5.6.x-rt* behavior back. The Firewire
card initializes properly, but as soon as I start jackd using the device
and initialize playback, firewire_core blocks forever and a reboot is
required:

Oct 26 01:13:35 hmbx kernel: firewire_core 0000:05:00.0: created device
fw1: GUID 000a3500ada83262, S800
Oct 26 01:14:47 hmbx kernel: logitech-hidpp-device 0003:046D:101A.0006:
HID++ 1.0 device connected.
Oct 26 01:20:11 hmbx kernel: INFO: task jackd:6873 blocked for more than
122 seconds.
Oct 26 01:20:11 hmbx kernel:       Not tainted 5.9.1-rt19-1-rt #1
Oct 26 01:20:11 hmbx kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 26 01:20:11 hmbx kernel: task:jackd           state:D stack:    0
pid: 6873 ppid:  1664 flags:0x80004086
Oct 26 01:20:11 hmbx kernel: Call Trace:
Oct 26 01:20:11 hmbx kernel:  __schedule+0x2c0/0x8f0
Oct 26 01:20:11 hmbx kernel:  schedule+0x60/0x100
Oct 26 01:20:11 hmbx kernel:  fw_device_op_release+0x230/0x290
[firewire_core]
Oct 26 01:20:11 hmbx kernel:  ? wait_woken+0x80/0x80
Oct 26 01:20:11 hmbx kernel:  __fput+0x8e/0x240
Oct 26 01:20:11 hmbx kernel:  task_work_run+0x5c/0x90
Oct 26 01:20:11 hmbx kernel:  do_exit+0x383/0xaf0
Oct 26 01:20:11 hmbx kernel:  ? finish_task_switch.isra.0+0x91/0x4c0
Oct 26 01:20:11 hmbx kernel:  do_group_exit+0x39/0xb0
Oct 26 01:20:11 hmbx kernel:  get_signal+0x14f/0x990
Oct 26 01:20:11 hmbx kernel:  ? preempt_count_add+0x68/0xa0
Oct 26 01:20:11 hmbx kernel:  ? _raw_spin_lock_irqsave+0x26/0x50
Oct 26 01:20:11 hmbx kernel:  arch_do_signal+0x3d/0x750
Oct 26 01:20:11 hmbx kernel:  ? do_epoll_wait+0xda/0x670
Oct 26 01:20:11 hmbx kernel:  exit_to_user_mode_prepare+0x12d/0x1a0
Oct 26 01:20:11 hmbx kernel:  syscall_exit_to_user_mode+0x2c/0x1b0
Oct 26 01:20:11 hmbx kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 26 01:20:11 hmbx kernel: RIP: 0033:0x7f42186895de
Oct 26 01:20:11 hmbx kernel: Code: Bad RIP value.
Oct 26 01:20:11 hmbx kernel: RSP: 002b:00007fff3dcdea40 EFLAGS: 00000246
ORIG_RAX: 00000000000000e8
Oct 26 01:20:11 hmbx kernel: RAX: fffffffffffffffc RBX: 00005596b98d6310
RCX: 00007f42186895de
Oct 26 01:20:11 hmbx kernel: RDX: 0000000000000020 RSI: 00007fff3dcdea70
RDI: 000000000000000d
Oct 26 01:20:11 hmbx kernel: RBP: 00005596b98d6310 R08: 0000000000000002
R09: 00007fff3dcded80
Oct 26 01:20:11 hmbx kernel: R10: 00000000ffffffff R11: 0000000000000246
R12: 00005596b98f5040
Oct 26 01:20:11 hmbx kernel: R13: 00007fff3dcdea70 R14: 00000000801c0000
R15: 0000000000000001
Oct 26 01:22:13 hmbx kernel: INFO: task jackd:6873 blocked for more than
245 seconds.
Oct 26 01:22:13 hmbx kernel:       Not tainted 5.9.1-rt19-1-rt #1
Oct 26 01:22:13 hmbx kernel: "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 26 01:22:13 hmbx kernel: task:jackd           state:D stack:    0
pid: 6873 ppid:  1664 flags:0x80004086
Oct 26 01:22:13 hmbx kernel: Call Trace:
Oct 26 01:22:13 hmbx kernel:  __schedule+0x2c0/0x8f0
Oct 26 01:22:13 hmbx kernel:  schedule+0x60/0x100
Oct 26 01:22:13 hmbx kernel:  fw_device_op_release+0x230/0x290
[firewire_core]
Oct 26 01:22:13 hmbx kernel:  ? wait_woken+0x80/0x80
Oct 26 01:22:13 hmbx kernel:  __fput+0x8e/0x240
Oct 26 01:22:13 hmbx kernel:  task_work_run+0x5c/0x90
Oct 26 01:22:13 hmbx kernel:  do_exit+0x383/0xaf0
Oct 26 01:22:13 hmbx kernel:  ? finish_task_switch.isra.0+0x91/0x4c0
Oct 26 01:22:13 hmbx kernel:  do_group_exit+0x39/0xb0
Oct 26 01:22:13 hmbx kernel:  get_signal+0x14f/0x990
Oct 26 01:22:13 hmbx kernel:  ? preempt_count_add+0x68/0xa0
Oct 26 01:22:13 hmbx kernel:  ? _raw_spin_lock_irqsave+0x26/0x50
Oct 26 01:22:13 hmbx kernel:  arch_do_signal+0x3d/0x750
Oct 26 01:22:13 hmbx kernel:  ? do_epoll_wait+0xda/0x670
Oct 26 01:22:13 hmbx kernel:  exit_to_user_mode_prepare+0x12d/0x1a0
Oct 26 01:22:13 hmbx kernel:  syscall_exit_to_user_mode+0x2c/0x1b0
Oct 26 01:22:13 hmbx kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Oct 26 01:22:13 hmbx kernel: RIP: 0033:0x7f42186895de
Oct 26 01:22:13 hmbx kernel: Code: Bad RIP value.
Oct 26 01:22:13 hmbx kernel: RSP: 002b:00007fff3dcdea40 EFLAGS: 00000246
ORIG_RAX: 00000000000000e8
Oct 26 01:22:13 hmbx kernel: RAX: fffffffffffffffc RBX: 00005596b98d6310
RCX: 00007f42186895de
Oct 26 01:22:13 hmbx kernel: RDX: 0000000000000020 RSI: 00007fff3dcdea70
RDI: 000000000000000d
Oct 26 01:22:13 hmbx kernel: RBP: 00005596b98d6310 R08: 0000000000000002
R09: 00007fff3dcded80
Oct 26 01:22:13 hmbx kernel: R10: 00000000ffffffff R11: 0000000000000246
R12: 00005596b98f5040
Oct 26 01:22:13 hmbx kernel: R13: 00007fff3dcdea70 R14: 00000000801c0000
R15: 0000000000000001

This does not happen on the vanilla 5.9.x kernel.

Any hints on what to try or which patch to omit would be greatly
appreciated!


Best,
David

--=20
https://sleepmap.de

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEkb2IFf4AQPp/9daHVMKPT/WhqUkFAl+WGjQACgkQVMKPT/Wh
qUlvXg/5AbQM1qOjZEterUKvlUC4x1DlzIbb13yNaP1bxXXp2CME3Jm12BPKM5e3
CHCr8iQn1p5aCl2+v5L1CyF1VWb8GS1qGNNzW64C5SPKdvrM1yGL/EUFVD6a7Gm2
jSKuDCEh1tfnjiaqjpWncaOBF7MeU+P6ftKVvlacPMm2/6s0R7tYMQt5ixDBABXG
EhA2HnLIU3pgusUDKinfNvwc9FFF9jcw7QMy23Zzmv8mVj83rtS8b+ZTnbQRH9XF
L3yZfnOjel1dEtfWoXdnv76O0Qw75sOdg/odu+LCUNVzMiZ4Cxg6PStk0rFFq2/Q
pGtV7Y8WJJoGubgqglHLOcP01mW/UkI4JyeD5BA3DZSzH/Es6AhmT8GM+x6CfCFD
K8FX/uOadZLzUW+pOlWZGcpBJiZ40U6zZ3xvxkrc0labDZD4Wjt6+BOYpsWUTyIJ
UyS30XGhtQBHlL5ry8ofNxe44YtOK3PWpWWH3JudY5mbwb+w46T5lYTe1KWvLOeG
c/zoMWadEJabSmPmfx7V6lVewVmXOHchdZK36OfW9C9qlkPO/nGHEId1H5n2vtj3
TMZMsJg+Ot7xW3EiuRpegSE77eP/j3JQ9SCEo/5xxOeDNLQP96DyP5X4BoYbCUF8
Tsyp3/Rdojlr+32NKVcrAZ6G4mBlDI8Vc6SInbn9dqtqvQ3/knA=
=Iv8i
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
