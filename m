From: Mike Galbraith <bitbucket@online.de>
Subject: 3.8.11-rt8 NFS triggered seizures
Date: Mon, 13 May 2013 11:31:05 +0200
Message-ID: <1368437465.11686.60.camel@marge.simpson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: RT <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:61655 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751223Ab3EMJbQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 13 May 2013 05:31:16 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Letting my little Toshiba Satellite download an opensuse install DVD (at
20 KiB/s so I can use the other half of my wonderful bandwidth for
work), after it has been up over night, if I mount my desktop box, and
try to install a kernel to later test, laptop goes comatose.  It might
be workqueue related.  Interrupts are still happening, I can ping and
poke sysrq-c, but box is completely useless.

I got kdump working again (finally), and crashed it this morning.  Now a
few hours later, it fails to repeat of course, _seems_ it requires me
leaving it alone for an extended period to repeat.

I've switched kernels a few times, and it _seems_ to only happen with
3.8-rt, though I can't really be rock solid about that, can only say
3.8-rt has jammed up a few times, and no other kernel has. 

When make modules_install install hung first thing this morning, box was
responsive enough to fire up top, which displayed nada.  Desktop then
froze, so I crashed it.  Seems completion ain't gonna happen.

Trying to repeat, now that I can crashdump the thing again.

      KERNEL: vmlinux                         
    DUMPFILE: vmcore
        CPUS: 2
        DATE: Mon May 13 07:56:02 2013
      UPTIME: 15:27:46
LOAD AVERAGE: 1.84, 0.89, 0.38
       TASKS: 308
    NODENAME: maggy
     RELEASE: 3.8.11-rt8-smp
     VERSION: #35 SMP PREEMPT RT Tue May 7 15:11:32 CEST 2013
     MACHINE: x86_64  (1296 Mhz)
      MEMORY: 3.8 GB
       PANIC: "Oops: 0002 [#1] PREEMPT SMP " (check log for details)
         PID: 44
     COMMAND: "irq/1-i8042"
        TASK: ffff880134f760c0  [THREAD_INFO: ffff8801349b2000]
         CPU: 0
       STATE: TASK_RUNNING (PANIC)

crash> ps|grep UN
   3465      1   0  ffff880137d72600  UN   0.7  495440  37744  konsole
   8743   3684   1  ffff8800a645c200  UN   0.0    9000    948  make
crash> bt 8743
PID: 8743   TASK: ffff8800a645c200  CPU: 1   COMMAND: "make"
 #0 [ffff8800aace1828] __schedule at ffffffff8143b975
 #1 [ffff8800aace18b0] schedule at ffffffff8143bfb9
 #2 [ffff8800aace18c0] rpc_wait_bit_killable at ffffffffa06b6fa9 [sunrpc]
 #3 [ffff8800aace18e0] __wait_on_bit at ffffffff8143ae7f
 #4 [ffff8800aace1930] out_of_line_wait_on_bit at ffffffff8143af2c
 #5 [ffff8800aace19a0] __rpc_wait_for_completion_task at ffffffffa06b6f6d [sunrpc]
 #6 [ffff8800aace19b0] nfs4_run_open_task.isra.37 at ffffffffa07d3504 [nfsv4]
 #7 [ffff8800aace1a40] _nfs4_proc_open at ffffffffa07d393b [nfsv4]
 #8 [ffff8800aace1a70] _nfs4_do_open at ffffffffa07d5c58 [nfsv4]
 #9 [ffff8800aace1b10] nfs4_do_open at ffffffffa07d5f82 [nfsv4]
#10 [ffff8800aace1bb0] nfs4_atomic_open at ffffffffa07d6070 [nfsv4]
#11 [ffff8800aace1be0] nfs4_file_open at ffffffffa07e2c62 [nfsv4]
#12 [ffff8800aace1c80] do_dentry_open.isra.16 at ffffffff81159676
#13 [ffff8800aace1cd0] finish_open at ffffffff81159722
#14 [ffff8800aace1cf0] do_last at ffffffff8116a1d9
#15 [ffff8800aace1da0] path_openat at ffffffff8116a5d3
#16 [ffff8800aace1e50] do_filp_open at ffffffff8116add2
#17 [ffff8800aace1f10] do_sys_open at ffffffff8115aade
#18 [ffff8800aace1f70] sys_open at ffffffff8115abe1
#19 [ffff8800aace1f80] system_call_fastpath at ffffffff814451c2
    RIP: 00007f250a821fd0  RSP: 00007fff1755c4d8  RFLAGS: 00000202
    RAX: 0000000000000002  RBX: ffffffff814451c2  RCX: ffffffffffffffff
    RDX: 00000000000001b6  RSI: 0000000000000000  RDI: 0000000000647a0e
    RBP: 00007fff1755c4c0   R8: 0000000000000008   R9: 0000000000000001
    R10: 000000000041fef0  R11: 0000000000000246  R12: ffffffff8115abe1
    R13: ffff8800aace1f78  R14: 00000000006474c0  R15: 0000000000000000
    ORIG_RAX: 0000000000000002  CS: 0033  SS: 002b
crash> bt 8748
PID: 8748   TASK: ffff8800a675a280  CPU: 1   COMMAND: "top"
 #0 [ffff8800b148fd68] __schedule at ffffffff8143b975
 #1 [ffff8800b148fdf0] schedule at ffffffff8143bfb9
 #2 [ffff8800b148fe00] n_tty_write at ffffffff812c22bb
 #3 [ffff8800b148fe90] tty_write at ffffffff812bf0e1
 #4 [ffff8800b148ff00] vfs_write at ffffffff8115b49f
 #5 [ffff8800b148ff30] sys_write at ffffffff8115b7a2
 #6 [ffff8800b148ff80] system_call_fastpath at ffffffff814451c2
    RIP: 00007f162d275220  RSP: 00007fff7fa2ef90  RFLAGS: 00000296
    RAX: 0000000000000001  RBX: ffffffff814451c2  RCX: 0000000000000005
    RDX: 0000000000000800  RSI: 0000000000616820  RDI: 0000000000000001
    RBP: 0000000000616820   R8: 0000000000000020   R9: 00007f162db7b700
    R10: 00007f162d1e626a  R11: 0000000000000246  R12: 0000000000000000
    R13: 0000000000000800  R14: 00007f162d53d140  R15: 0000000000000800
    ORIG_RAX: 0000000000000001  CS: 0033  SS: 002b
crash> bt 3465
PID: 3465   TASK: ffff880137d72600  CPU: 0   COMMAND: "konsole"
 #0 [ffff880133361838] __schedule at ffffffff8143b975
 #1 [ffff8801333618c0] schedule at ffffffff8143bfb9
 #2 [ffff8801333618d0] schedule_timeout at ffffffff8143abed
 #3 [ffff880133361980] wait_for_common at ffffffff8143b4af
 #4 [ffff880133361a00] wait_for_completion at ffffffff8143b5ed
 #5 [ffff880133361a10] flush_work at ffffffff8105bf79
 #6 [ffff880133361a60] tty_flush_to_ldisc at ffffffff812c7d94
 #7 [ffff880133361a70] n_tty_poll at ffffffff812c1eea
 #8 [ffff880133361ab0] tty_poll at ffffffff812bed82
 #9 [ffff880133361af0] do_poll.isra.7 at ffffffff8116e175
#10 [ffff880133361b80] do_sys_poll at ffffffff8116f149
#11 [ffff880133361f40] sys_poll at ffffffff8116f28b
#12 [ffff880133361f80] system_call_fastpath at ffffffff814451c2
    RIP: 00007fefe00b913f  RSP: 00007fff7a198f70  RFLAGS: 00000202
    RAX: 0000000000000007  RBX: ffffffff814451c2  RCX: 0000000000e96368
    RDX: 0000000000000007  RSI: 0000000000000020  RDI: 0000000000e69ed0
    RBP: 0000000000000020   R8: 0000000000000000   R9: 0000000000000d89
    R10: 0000000000000000  R11: 0000000000000293  R12: 0000000000000007
    R13: 0000000000e69ed0  R14: 0000000000612eb0  R15: 0000000000727cb8
    ORIG_RAX: 0000000000000007  CS: 0033  SS: 002b
crash> ps|grep kworker
      5      2   0  ffff88013b306140  IN   0.0       0      0  [kworker/0:0H]
      7      2   0  ffff88013b3101c0  IN   0.0       0      0  [kworker/u:0H]
     18      2   1  ffff88013b36c4c0  IN   0.0       0      0  [kworker/1:0]
     19      2   1  ffff88013b370500  IN   0.0       0      0  [kworker/1:0H]
    192      2   0  ffff88013476e380  IN   0.0       0      0  [kworker/0:1H]
    194      2   1  ffff88013397e300  IN   0.0       0      0  [kworker/1:1H]
    824      2   1  ffff880139662580  IN   0.0       0      0  [kworker/u:1H]
   5371      2   0  ffff88009bae86c0  IN   0.0       0      0  [kworker/0:0]
   5375      2   0  ffff8800a73b07c0  IN   0.0       0      0  [kworker/0:2]
   8478      2   1  ffff8800378ac340  IN   0.0       0      0  [kworker/u:2]
   8485      2   1  ffff88009c2b03c0  IN   0.0       0      0  [kworker/1:1]
   8537      2   0  ffff8800b1660200  IN   0.0       0      0  [kworker/u:0]
   8731      2   0  ffff8800a667c0c0  IN   0.0       0      0  [kworker/u:1]


