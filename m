From: Tim Blechmann <tim@klingt.org>
Subject: BUG: sleeping function called from invalid context at kernel/rtmutex.c:683
Date: Tue, 07 Apr 2009 12:48:36 +0200
Message-ID: <grfb2b$dps$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAEFA54F90B02628FAA9BBF7A"
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:59835 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458AbZDGKtB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Apr 2009 06:49:01 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Lr8rS-0000Ks-9b
	for linux-rt-users@vger.kernel.org; Tue, 07 Apr 2009 10:48:58 +0000
Received: from 85-127-253-53.dynamic.xdsl-line.inode.at ([85.127.253.53])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2009 10:48:58 +0000
Received: from tim by 85-127-253-53.dynamic.xdsl-line.inode.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Apr 2009 10:48:58 +0000
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAEFA54F90B02628FAA9BBF7A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

using kernel 2.6.29-rt3, i get the following BUG, when waking from
suspend-to-ram:

[13899.995628] BUG: sleeping function called from invalid context at
kernel/rtmutex.c:683
[13899.995630] in_atomic(): 0, irqs_disabled(): 1, pid: 15817, name:
pm-suspend
[13899.995632] Pid: 15817, comm: pm-suspend Not tainted 2.6.29-rt3-tip #2=
9
[13899.995634] Call Trace:
[13899.995642]  [<ffffffff80242a2c>] __might_sleep+0xfc/0x100
[13899.995647]  [<ffffffff8052c151>] rt_spin_lock+0x81/0x90
[13899.995651]  [<ffffffff80219555>] read_persistent_clock+0x15/0x40
[13899.995655]  [<ffffffff802779ee>] timekeeping_suspend+0xe/0x90
[13899.995658]  [<ffffffff8044cf89>] sysdev_suspend+0xc9/0x220
[13899.995663]  [<ffffffff802880b5>] suspend_devices_and_enter+0x1a5/0x22=
0
[13899.995666]  [<ffffffff802882c6>] enter_state+0x166/0x1e0
[13899.995668]  [<ffffffff802883fa>] state_store+0xba/0x100
[13899.995672]  [<ffffffff803bb217>] kobj_attr_store+0x17/0x20
[13899.995675]  [<ffffffff8035e0e5>] sysfs_write_file+0xc5/0x140
[13899.995679]  [<ffffffff802fb4db>] vfs_write+0xcb/0x190
[13899.995682]  [<ffffffff802fb690>] sys_write+0x50/0x90
[13899.995686]  [<ffffffff802120c2>] system_call_fastpath+0x16/0x1b

best, tim

--=20
tim@klingt.org
http://tim.klingt.org

Avoid the world, it's just a lot of dust and drag and means nothing in
the end.
  Jack Kerouac


--------------enigAEFA54F90B02628FAA9BBF7A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbL4gACgkQdL+4qsZfVssl8QCeLLvNZlDEaLiHiTd70/51NGPO
MMgAn1IBKeRTJRB6vhrkkyxYaldcFegS
=n5Zv
-----END PGP SIGNATURE-----

--------------enigAEFA54F90B02628FAA9BBF7A--

