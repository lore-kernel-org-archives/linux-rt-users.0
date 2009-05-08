From: Cliff Brake <cliff.brake@gmail.com>
Subject: BUG: sleeping function called from invalid context at
	kernel/rtmutex.c
Date: Fri, 8 May 2009 15:49:29 -0400
Message-ID: <f96d234e0905081249n1e5445c4p62c0636cde8adcd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.228]:64653 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754813AbZEHTt3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 8 May 2009 15:49:29 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1290988rvb.1
        for <linux-rt-users@vger.kernel.org>; Fri, 08 May 2009 12:49:30 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Any ideas what this might be?

- 2.6.29.2-rt10
- ARM PXA270 CPU

BUG: sleeping function called from invalid context at
kernel/rtmutex.c:685
in_atomic(): 0, irqs_disabled(): 128, pid: 1469, name: Xfbdev
[<c00288f8>] (dump_stack+0x0/0x14) from [<c00316fc>]
(__might_sleep+0xe0/0x104)
[<c003161c>] (__might_sleep+0x0/0x104) from [<c024d380>]
(rt_spin_lock+0x38/0x68)
 r4:c780bc80
[<c024d348>] (rt_spin_lock+0x0/0x68) from [<c004a774>]
(__queue_work+0x18/0x34)
 r4:c780bc80
[<c004a75c>] (__queue_work+0x0/0x34) from [<c004a820>]
(queue_work_on+0x68/0x70)
 r5:00000000 r4:20000013
[<c004a7b8>] (queue_work_on+0x0/0x70) from [<c004a868>]
(queue_work+0x1c/0x20)
[<c004a84c>] (queue_work+0x0/0x20) from [<c004a888>]
(schedule_work+0x1c/0x24)
[<c004a86c>] (schedule_work+0x0/0x24) from [<c01537e4>]
(pxafb_set_par+0x350/0x36c)
[<c0153494>] (pxafb_set_par+0x0/0x36c) from [<c0146238>]
(fb_set_var+0x1ac/0x258)
[<c014608c>] (fb_set_var+0x0/0x258) from [<c01468f8>]
(fb_ioctl+0x4e8/0x678)
[<c0146410>] (fb_ioctl+0x0/0x678) from [<c00a1290>]
(vfs_ioctl+0x38/0x98)
 r8:c0025044 r7:c7a4fe20 r6:0011a6a0 r5:00004601 r4:c7a4fe20
[<c00a1258>] (vfs_ioctl+0x0/0x98) from [<c00a18f4>]
(do_vfs_ioctl+0x50c/0x55c)
 r6:0011a6a0 r5:c6f279d0 r4:c7a4fe20
[<c00a13e8>] (do_vfs_ioctl+0x0/0x55c) from [<c00a1984>]
(sys_ioctl+0x40/0x64)
 r9:c7918000 r8:c0025044 r7:c7a4fe20 r6:00004601 r5:0011a6a0
r4:00000005
[<c00a1944>] (sys_ioctl+0x0/0x64) from [<c0024ec0>]
(ret_fast_syscall+0x0/0x2c)
 r7:00000036 r6:0011aec0 r5:0011a5f8 r4:0011a6a0

Thanks,
Cliff

-- 
=======================
Cliff Brake
http://bec-systems.com
