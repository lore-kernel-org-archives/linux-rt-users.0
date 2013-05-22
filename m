From: "Koehrer Mathias (ETAS/ESS2)" <mathias.koehrer@etas.com>
Subject: Kernel 3.6.11.3-rt35 : umount blocks for more than 200seconds
Date: Wed, 22 May 2013 12:00:48 +0000
Message-ID: <F9467A784CC48947B1D879F07370839E1DEFEC8E@fe20099s.ecn.etasgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:43521 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345Ab3EVMBE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 May 2013 08:01:04 -0400
Received: from vsmta14.fe.internet.bosch.com (unknown [10.4.98.54])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 07E381580015
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2013 14:01:01 +0200 (CEST)
Received: from localhost (vsgw2.fe.internet.bosch.com [10.4.98.13])
	by vsmta14.fe.internet.bosch.com (Postfix) with SMTP id 7B0CDA40665
	for <linux-rt-users@vger.kernel.org>; Wed, 22 May 2013 14:00:57 +0200 (CEST)
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi everybody,

I am still searching for the reason why the umount of a hdd partition takes very often more than 200seconds.

I regularly got a kernel message "task umount blocked for more than 120 seconds":
The addresses within the message are always the very same. This seems to be the indication that the very same issue occurs again and again.
After nearly 5 minutes the umount command  finally finishes (according to the time output).

--------------- BEGIN MESSAGE ------------------
INFO: task umount:4923 blocked for more than 120 seconds.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
umount          D 00000000     0  4645   4465 0x00000000
 e2cc9e3c 00000086 f3ca8160 00000000 00000000 00000000 f5cdd980 c095e980
 c095e980 00000000 e2cc9df4 f5cdd980 e6319950 e2cc9e50 00000000 e2cc9e94
 c01e50db 00000000 0000000e f5d99980 00000000 00000000 00000001 00000000
Call Trace:
 [<c01e50db>] ? write_cache_pages+0xdb/0x3b0
 [<c061c7dd>] ? _raw_spin_unlock_irqrestore+0x1d/0x40
 [<c01e4750>] ? mapping_tagged+0x20/0x20
 [<c061a365>] ? schedule_timeout+0x165/0x230
 [<c01641a8>] ? get_parent_ip+0x8/0x20
 [<c061fac7>] ? add_preempt_count+0x67/0xb0
 [<c01641a8>] ? get_parent_ip+0x8/0x20
 [<c061fac7>] ? add_preempt_count+0x67/0xb0
 [<c061ab7a>] ? wait_for_common+0xaa/0xf0
 [<c023f211>] ? sync_inodes_sb+0x81/0x1a0
 [<c01d0101>] ? ftrace_raw_event_rpm_return_int+0x21/0x110
 [<c0243864>] ? sync_filesystem+0x54/0x90
 [<c021b5f1>] ? generic_shutdown_super+0x31/0xd0
 [<c021b6b9>] ? kill_block_super+0x29/0x70
 [<c021b9fb>] ? deactivate_locked_super+0x3b/0x70
 [<c0235c79>] ? sys_umount+0x69/0x330
 [<c0235f5e>] ? sys_oldumount+0x1e/0x20
 [<c0622b9f>] ? sysenter_do_call+0x12/0x28
--------------- END MESSAGE ------------------


Here is the script I use to get this message:
--------------- BEGIN SCRIPT  ------------------
#!/bin/bash
MNTDIR=/tmp/mnt.$$
mkdir -p $MNTDIR
DEV=/dev/sda5
FILE=/tmp/huge-file..tgz

title()
{
        echo "-----------------------"
        echo "$1"
}

mountCopy()
{
        local pass=$1
        title "mount"
        time mount $DEV $MNTDIR
        (
            cd $MNTDIR
            title "tar"
            time tar -xzp --numeric-owner  -f $FILE
        )
        title "umount"
        time umount $MNTDIR
}

main()
{
        for (( i=0 ; i<20 ; i++ )) ; do
                echo "****** $i ******"
                title "mkfs"
                time mkfs.ext3 -q $DEV
                mountCopy $i
        done
}

main 2>&1
--------------- END SCRIPT  ------------------


When I disable the swap partition on my PC, the probably of getting this messages gets down, however it still occurs occasionally.
Setup: Core i7, 4 GB RAM, 32 bit mode, no PAE.

Also, syncing instead of "umount" takes often very long as well. Especially if two "sync" commands are executed in parallel.

Any help or feedback on this issue is highly appreciated.
Thanks a lot.

Best Regards

Mathias

