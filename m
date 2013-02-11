From: Staffan Tjernstrom <stjernstrom@eagleseven.com>
Subject: How to decode output from sysrq - t
Date: Mon, 11 Feb 2013 09:12:06 -0600
Message-ID: <7A2FC0CD30EF4745AE15F485252D38AC2F45B93E9E@clark>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.eagleseven.com ([38.98.183.218]:23465 "EHLO
	mail.eagleseven.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757255Ab3BKPR1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 11 Feb 2013 10:17:27 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'm trying to plow through the output from sysrq - t on a system where =
I think we may have a rouge high-priority call to the file system from =
userspace causing a priority inversion issue.

=46or the particular instance I'm looking at, it would appear that the =
"other" half of the hang is the auditd daemon.

My question is this - is the format of the output between the task name=
 and the call trace documented anywhere? Or where in the code should I =
look for it?

auditd          S ffff880418b967c0     0  2998      1 0x00000000       =
                                   << This is what I'm wondering about
 ffff880418479bf8 0000000000000086 00000000000000d0 ffff880418478000   =
  << This is what I'm wondering about
 ffff880418478010 ffff880418478010 ffff880418479fd8 ffff880418478000   =
       << This is what I'm wondering about
 ffff880418478000 ffff880418478000 ffff88041e3380c0 ffff880418b96400   =
       << This is what I'm wondering about
Call Trace:
 [<ffffffff814e1aae>] schedule+0x2e/0xa0
 [<ffffffff810898dc>] futex_wait_queue_me+0xcc/0x110
 [<ffffffff81089ba5>] futex_wait+0x195/0x290
 [<ffffffff8104b4fb>] ? migrate_enable+0xdb/0x1d0
 [<ffffffff810892a6>] ? futex_wake+0x126/0x140
 [<ffffffff8108ab34>] do_futex+0x124/0xaf0
 [<ffffffff8104b4fb>] ? migrate_enable+0xdb/0x1d0
 [<ffffffffa019463f>] ? ext2_statfs+0xef/0x180 [ext2]
 [<ffffffff8117c388>] ? do_statfs_native+0x98/0xb0
 [<ffffffff8108b57b>] sys_futex+0x7b/0x170
 [<ffffffff814eab2b>] system_call_fastpath+0x16/0x1b

Abby            S ffff8804181849c0     0 30761  30740 0x00000080
 ffff880418ac9bf8 0000000000000086 ffff880400000000 ffff880418ac8000
 ffff880418ac8010 ffff880418ac8010 ffff880418ac9fd8 ffff880418ac8000
 ffff880418ac8000 ffff880418ac8000 ffffffff81a10020 ffff880418184600
Call Trace:
 [<ffffffff814e1aae>] schedule+0x2e/0xa0
 [<ffffffff810898dc>] futex_wait_queue_me+0xcc/0x110
 [<ffffffff81089ba5>] futex_wait+0x195/0x290
 [<ffffffff81079410>] ? update_rmtp+0x80/0x80
 [<ffffffff8108ab34>] do_futex+0x124/0xaf0
 [<ffffffff8114b5ca>] ? do_sync_write+0xea/0x130
 [<ffffffff8114cc57>] ? fget_light+0x97/0xf0
 [<ffffffff8118a7ea>] ? fsnotify+0x1ea/0x320
 [<ffffffff8108b57b>] sys_futex+0x7b/0x170
 [<ffffffff814eab2b>] system_call_fastpath+0x16/0x1b

Kind Regards,
Staffan Tjernstr=F6m
Senior Software Engineer
Eagle Seven, LLC
141 West Jackson Boulevard #1575
Chicago, IL 60604
Tel: +1 312 385 2600 ext 2627
Mobile: +1 515 770 5158

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
