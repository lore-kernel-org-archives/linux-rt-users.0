From: Wargreen <wargreen@lebib.org>
Subject: Radeon driver hang with 4.9.0-rt
Date: Thu, 23 Feb 2017 19:03:55 +0100
Message-ID: <68c66c17-149d-d59c-53e8-4499fe0a8143@lebib.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wltF0S7nNkFmJ7F1dpVlfLhSsxUnJo7Xp"
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:52334 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751041AbdBWS3m (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Feb 2017 13:29:42 -0500
Received: from [10.13.10.42] (81-64-127-34.rev.numericable.fr [81.64.127.34])
        by lebib.org (Postfix) with ESMTPSA id 3418B2B3C83D
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Feb 2017 19:02:53 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wltF0S7nNkFmJ7F1dpVlfLhSsxUnJo7Xp
Content-Type: multipart/mixed; boundary="MHRdGGQ8VVtcJSqKeuJRj7UOXCtxMAALC";
 protected-headers="v1"
From: Wargreen <wargreen@lebib.org>
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Message-ID: <68c66c17-149d-d59c-53e8-4499fe0a8143@lebib.org>
Subject: Radeon driver hang with 4.9.0-rt

--MHRdGGQ8VVtcJSqKeuJRj7UOXCtxMAALC
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello linux-rt list,

After swith to a radeon HD5850, i have a full graphic hang when an
application require lot of GPU. Kill this application (via ssh) resume
the normal operation.
I run Debian SID, it's happen with both linux-image-4.9.0.1-rt-amd64 and
linux-image-4.9.0.2-rt-amd64.

Extract of my syslog (full version at
http://kalaj.darktech.org/~wargreen/logs/radeon/syslog)  :

Feb 19 23:17:19 LaChoze kernel: [  605.169580] INFO: task Xorg:2014
blocked for more than 120 seconds.
Feb 19 23:17:19 LaChoze kernel: [  605.169588]       Not tainted
4.9.0-1-rt-amd64 #1
Feb 19 23:17:19 LaChoze kernel: [  605.169590] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 19 23:17:19 LaChoze kernel: [  605.169593] Xorg            D    0=20
2014   2012 0x00000004
Feb 19 23:17:19 LaChoze kernel: [  605.169598]  ffff9235afe24800
0000000000000000 ffff9235b6c69200 ffff9235b12e9f80
Feb 19 23:17:19 LaChoze kernel: [  605.169602]  ffff9235b4e4ee40
ffffa16b023a7be8 ffffffff85a16cbf 00ff9235b12e9f80
Feb 19 23:17:19 LaChoze kernel: [  605.169606]  ffff9235b6c69200
ffff9235b12e9f80 ffff9235b12e9f80 0000000000000000
Feb 19 23:17:19 LaChoze kernel: [  605.169611] Call Trace:
Feb 19 23:17:19 LaChoze kernel: [  605.169620]  [<ffffffff85a16cbf>] ?
__schedule+0x26f/0x5b0
Feb 19 23:17:19 LaChoze kernel: [  605.169623]  [<ffffffff85a17043>] ?
schedule+0x43/0xc0
Feb 19 23:17:19 LaChoze kernel: [  605.169625]  [<ffffffff85a18aa3>] ?
__rt_mutex_slowlock+0x83/0x150
Feb 19 23:17:19 LaChoze kernel: [  605.169628]  [<ffffffff85a18fcc>] ?
rt_mutex_slowlock+0x11c/0x2a0
Feb 19 23:17:19 LaChoze kernel: [  605.169633]  [<ffffffff854cd9d4>] ?
rt_down_read+0x24/0x30
Feb 19 23:17:19 LaChoze kernel: [  605.169663]  [<ffffffffc0b2eaf7>] ?
radeon_gem_create_ioctl+0x37/0x100 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169680]  [<ffffffffc09f9b9a>] ?
drm_ioctl+0x1ea/0x470 [drm]
Feb 19 23:17:19 LaChoze kernel: [  605.169703]  [<ffffffffc0b2eac0>] ?
radeon_gem_pwrite_ioctl+0x30/0x30 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169706]  [<ffffffff8547dc82>] ?
unpin_current_cpu+0x12/0x70
Feb 19 23:17:19 LaChoze kernel: [  605.169723]  [<ffffffffc0afd049>] ?
radeon_drm_ioctl+0x49/0x80 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169726]  [<ffffffff856257bf>] ?
do_vfs_ioctl+0x9f/0x610
Feb 19 23:17:19 LaChoze kernel: [  605.169730]  [<ffffffff858f2e4d>] ?
__sys_recvmsg+0x7d/0x90
Feb 19 23:17:19 LaChoze kernel: [  605.169733]  [<ffffffff85625da4>] ?
SyS_ioctl+0x74/0x80
Feb 19 23:17:19 LaChoze kernel: [  605.169736]  [<ffffffff85a1b27b>] ?
system_call_fast_compare_end+0xc/0x9b
Feb 19 23:17:19 LaChoze kernel: [  605.169770] INFO: task
E.d3d9.OpenGL:4263 blocked for more than 120 seconds.
Feb 19 23:17:19 LaChoze kernel: [  605.169773]       Not tainted
4.9.0-1-rt-amd64 #1
Feb 19 23:17:19 LaChoze kernel: [  605.169774] "echo 0 >
/proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 19 23:17:19 LaChoze kernel: [  605.169776] E.d3d9.OpenGL   D    0=20
4263   4243 0x20020000
Feb 19 23:17:19 LaChoze kernel: [  605.169779]  ffff9235b0839b00
0000000000000000 ffff9235b6ce9200 ffff92341d6a4ec0
Feb 19 23:17:19 LaChoze kernel: [  605.169783]  ffff9235b4e4af40
ffffa16b020a3b40 ffffffff85a16cbf 0000000000000000
Feb 19 23:17:19 LaChoze kernel: [  605.169787]  ffff9235b6ce9200
ffff92341d6a4ec0 ffff92341d6a4ec0 0000000000000000
Feb 19 23:17:19 LaChoze kernel: [  605.169791] Call Trace:
Feb 19 23:17:19 LaChoze kernel: [  605.169795]  [<ffffffff85a16cbf>] ?
__schedule+0x26f/0x5b0
Feb 19 23:17:19 LaChoze kernel: [  605.169798]  [<ffffffff85a17043>] ?
schedule+0x43/0xc0
Feb 19 23:17:19 LaChoze kernel: [  605.169800]  [<ffffffff85a18aa3>] ?
__rt_mutex_slowlock+0x83/0x150
Feb 19 23:17:19 LaChoze kernel: [  605.169802]  [<ffffffff85a18fcc>] ?
rt_mutex_slowlock+0x11c/0x2a0
Feb 19 23:17:19 LaChoze kernel: [  605.169805]  [<ffffffff854cd9d4>] ?
rt_down_read+0x24/0x30
Feb 19 23:17:19 LaChoze kernel: [  605.169827]  [<ffffffffc0b1becd>] ?
radeon_bo_create+0x15d/0x280 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169849]  [<ffffffffc0b2e6ce>] ?
radeon_gem_object_create+0xbe/0x1a0 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169870]  [<ffffffffc0b2eb29>] ?
radeon_gem_create_ioctl+0x69/0x100 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169884]  [<ffffffffc09f9b9a>] ?
drm_ioctl+0x1ea/0x470 [drm]
Feb 19 23:17:19 LaChoze kernel: [  605.169905]  [<ffffffffc0b2eac0>] ?
radeon_gem_pwrite_ioctl+0x30/0x30 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169908]  [<ffffffff8547dc82>] ?
unpin_current_cpu+0x12/0x70
Feb 19 23:17:19 LaChoze kernel: [  605.169924]  [<ffffffffc0afd049>] ?
radeon_drm_ioctl+0x49/0x80 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169950]  [<ffffffffc0be89c0>] ?
radeon_kms_compat_ioctl+0x10/0x20 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169953]  [<ffffffff8566e4ec>] ?
compat_SyS_ioctl+0xbc/0x1140
Feb 19 23:17:19 LaChoze kernel: [  605.169956]  [<ffffffff85a1704d>] ?
schedule+0x4d/0xc0
Feb 19 23:17:19 LaChoze kernel: [  605.169959]  [<ffffffff85403e1d>] ?
do_fast_syscall_32+0x8d/0x170
Feb 19 23:17:19 LaChoze kernel: [  605.169962]  [<ffffffff85a1caac>] ?
entry_SYSENTER_compat+0x4c/0x5b
[...]

Is there a workaround ?
I'm here for more informations or tests.

Thanks for the RT !



--MHRdGGQ8VVtcJSqKeuJRj7UOXCtxMAALC--

--wltF0S7nNkFmJ7F1dpVlfLhSsxUnJo7Xp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCAAxFiEEhe8tJb5+nGkdrJsqDnSv7tOnn7gFAlivJBATHHdhcmdyZWVu
QGxlYmliLm9yZwAKCRAOdK/u06efuK9hEADO+EumS5CeKCUKvHKYpZUOWInDz82M
QWoPxB6IcfvDAfGJGj9DtFtJ+L0VzSvhlesUDvqgjwUNzwu0z0o1jrEUrC71Z6DO
BcFVmNNA+5iDJ7lW7yge+dkgcPIeabgL4faAIIXPymNENCrP8hzN4YaZGUWzRsdX
lTtjOVokoNjmIzk6qtg7+gfZmwh8e1/CaYNERVY5UyE8G93z0EzbwZF7czS/L1M0
YCZc9iiqS07eN108uZtiYsTprvVe87QdIfJrbrwV34F50RyRpivAsRO69JKcIpfn
ietXMJNEI75PjzNiNgz8ecmS3UGyW7DpXBuHoO+M6lKqPIrpBxccReUzsSLSiNH0
ZC3WbYlB0ZtObPqvPyH3mbztyQLP6wZk75qc4osSlCuG7BrNUmpuhAkXevn65oMu
WjGNyZ1dqwg3thkaf04LLzQOgqXAB9l6jVGz3YFkyhPBAJFAxpC8nMjese8BvBQx
2bpDYSRcUb/AlqsfdZuft+FFduuc9DqAXJxkgFjg5X43Qfp9EJZZV0lAQm7XnQNw
wR/g4BbkLoOqdaEK10uwl3l29QM7z4C+jBKX+Kw0B5iRHer4ofMUH/VUHzo+2a+Q
aFTqcztH2IBg63CMVOdtKcyNCTufnDpbdp8RI0UDGOeUJpjmiw3v/A1kernzeNoX
CS+ocb0wDTHcdQ==
=mMMR
-----END PGP SIGNATURE-----

--wltF0S7nNkFmJ7F1dpVlfLhSsxUnJo7Xp--
