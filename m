From: =?ISO-8859-15?Q?Martin_D=E4umler?= <mdae@cs.tu-chemnitz.de>
Subject: Linux 2.6.31.12-rt21 hangs on AT91 based board
Date: Wed, 21 Sep 2011 11:48:06 +0200
Message-ID: <4E79B2D6.7040503@cs.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nick.hrz.tu-chemnitz.de ([134.109.228.11]:41598 "EHLO
	nick.hrz.tu-chemnitz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752508Ab1IUKTE (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 21 Sep 2011 06:19:04 -0400
Received: from postman.hrz.tu-chemnitz.de ([134.109.133.5] helo=mailbox.hrz.tu-chemnitz.de)
	by nick.hrz.tu-chemnitz.de with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76)
	(envelope-from <martin.daeumler@informatik.tu-chemnitz.de>)
	id 1R6JPZ-0006Dm-Aq
	for linux-rt-users@vger.kernel.org; Wed, 21 Sep 2011 11:48:13 +0200
Received: from camo159-153.hrz.tu-chemnitz.de ([134.109.159.153])
	by mailbox.hrz.tu-chemnitz.de with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <mdae@mailbox.hrz.tu-chemnitz.de>)
	id 1R6JPZ-0004tm-7O
	for linux-rt-users@vger.kernel.org; Wed, 21 Sep 2011 11:48:13 +0200
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

I want to use Linux 2.6.31.12-rt21 with a AT91SAM9G20 based board.
I followed the instructions described in [1] and set the kernel options
that are mentioned there (AEABI=3Dy, OABI_COMPAT=3Dn). Unfortunately,
Linux hangs after mounting the root file system:

#:rtc-pcf8563 0-0051: low voltage detected, date/time is not reliable.
#:rtc-pcf8563 0-0051: retrieved date/time is not valid.
#:rtc-pcf8563 0-0051: hctosys: invalid date/time
#:VFS: Mounted root (jffs2 filesystem) on device 31:3.
#:*********************************************************************=
********
#:*                                                                    =
      =20
*
#:*  REMINDER, the following debugging options are turned on in your=20
=2Econfig: *
#:*                                                                    =
      =20
*
#:*       =20
CONFIG_DEBUG_RT_MUTEXES                                            *
#:*       =20
CONFIG_LOCKDEP                                                     *
#:*                                                                    =
      =20
*
#:*  they may increase runtime overhead and=20
latencies.                        *
#:*                                                                    =
      =20
*
#:*********************************************************************=
********
#:Freeing init memory: 124K

Setting OABI_COMPAT=3Dy leads to the same output. Setting AEABI=3Dn lea=
ds to:

#:rtc-pcf8563 0-0051: low voltage detected, date/time is not reliable.
#:rtc-pcf8563 0-0051: retrieved date/time is not valid.
#:rtc-pcf8563 0-0051: hctosys: invalid date/time
#:VFS: Mounted root (jffs2 filesystem) on device 31:3.
#:*********************************************************************=
********
#:*                                                                    =
      =20
*
#:*  REMINDER, the following debugging options are turned on in your=20
=2Econfig: *
#:*                                                                    =
      =20
*
#:*       =20
CONFIG_DEBUG_RT_MUTEXES                                            *
#:*       =20
CONFIG_LOCKDEP                                                     *
#:*                                                                    =
      =20
*
#:*  they may increase runtime overhead and=20
latencies.                        *
#:*                                                                    =
      =20
*
#:*********************************************************************=
********
#:Freeing init memory: 132K
#:Kernel panic - not syncing: Attempted to kill init!
#:Backtrace:
#:[<c002dd60>] (dump_backtrace+0x0/0xfc) from [<c026a308>]=20
(dump_stack+0x18/0x1c)
#: r6:00000001 r5:c1c1b020 r4:c0352edc
#:[<c026a2f0>] (dump_stack+0x0/0x1c) from [<c026a360>] (panic+0x54/0x12=
c)
#:[<c026a30c>] (panic+0x0/0x12c) from [<c003e2c4>]=20
(find_new_reaper+0x74/0x90)
#: r3:c032d690 r2:c1c1fdc8 r1:00000000 r0:c02e0f22
#:[<c003e250>] (find_new_reaper+0x0/0x90) from [<c003f664>]=20
(forget_original_parent+0x34/0x114)
#: r5:00000001 r4:c1c1b020
#:[<c003f630>] (forget_original_parent+0x0/0x114) from [<c003f75c>]=20
(exit_notify+0x18/0x150)
#: r7:c1c1fee8 r6:00000001 r5:00000001 r4:c1c1b020
#:[<c003f744>] (exit_notify+0x0/0x150) from [<c003fa64>]=20
(do_exit+0x1d0/0x2a8)
#: r5:00000004 r4:c1c1b020
#:[<c003f894>] (do_exit+0x0/0x2a8) from [<c003fbd4>]=20
(do_group_exit+0x98/0xcc)
#:[<c003fb3c>] (do_group_exit+0x0/0xcc) from [<c004ac18>]=20
(get_signal_to_deliver+0x268/0x29c)
#: r7:c1c1fee8 r6:c1c1e000 r5:c1d4d824 r4:0830009f
#:[<c004a9b0>] (get_signal_to_deliver+0x0/0x29c) from [<c002c6e0>]=20
(do_signal+0xa4/0x1d8)
#:[<c002c63c>] (do_signal+0x0/0x1d8) from [<c002c844>]=20
(do_notify_resume+0x30/0x34)
#: r8:00000000 r7:00900000 r6:00000000 r5:40026000 r4:00000000
#:[<c002c814>] (do_notify_resume+0x0/0x34) from [<c0029e4c>]=20
(work_pending+0x1c/0x20)

Do you have a hint how to solve this problem? Is this problem solved in=
=20
later versions, e.g. 2.6.33.7.2-rt30?


With kind regards,
Martin D=E4umler


[1]=20
http://www.at91.com/linux4sam/bin/view/Linux4SAM/BuildRootFAQ#Failed_to=
_mount_rootfs_system_ha
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
