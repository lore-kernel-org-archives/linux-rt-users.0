From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: ltp-20080229 crashes the kernel during the "shmctl04" test
Date: Sat, 1 Mar 2008 18:43:49 +0100
Message-ID: <c384c5ea0803010943ya8a6717wdf09b13e2071694e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:30164 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755236AbYCARnv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 1 Mar 2008 12:43:51 -0500
Received: by an-out-0708.google.com with SMTP id d31so1036103and.103
        for <linux-rt-users@vger.kernel.org>; Sat, 01 Mar 2008 09:43:50 -0800 (PST)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

with LTP 20080229 released, I ran it against my target MPC8313E-RDB
(powerpc) board, running a 2.6.24.3-rt3 kernel with nohz, preempt rt,
hrtimers enabled.
(http://ltp.sourceforge.net/)

It reliably crashes during the "shmctl04" test, see the oops with a
manual function backtrace here:

$/usr/libexec/ltp/runltp

...
<<<test_start>>>
tag=shmctl02 stime=8030
cmdline="shmctl02"
contacts=""
analysis=exit
initiation_status="ok"
<<<test_output>>>
shmctl02    1  PASS  :  expected failure - errno = 13 : Permission denied
shmctl02    2  PASS  :  expected failure - errno = 14 : Bad address
shmctl02    3  PASS  :  expected failure - errno = 14 : Bad address
shmctl02    4  PASS  :  expected failure - errno = 22 : Invalid argument
shmctl02    5  PASS  :  expected failure - errno = 22 : Invalid argument
shmctl02    6  CONF  :  shmctl() did not fail for non-root user.This
may be okay for your distribution.
shmctl02    7  CONF  :  shmctl() did not fail for non-root user.This
may be okay for your distribution.
<<<execution_status>>>
duration=0 termination_type=exited termination_id=0 corefile=no
cutime=0 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=shmctl03 stime=8030
cmdline="shmct[ 8030.335495] Oops: Exception in kernel mode, sig: 5 [#1]
[ 8030.340842] PREEMPT MPC8313 RDB
[ 8030.343977] Modules linked in: ledtrig_heartbeat ledtrig_timer
ledtrig_cpu leds_mpc8313e_rdb led_class
[ 8030.353299] NIP: c00461f0 LR: c0046184 CTR: 00000000
[ 8030.358248] REGS: c5a31cf0 TRAP: 0700   Not tainted  (2.6.24.3-rt3)
[ 8030.364491] MSR: 00021032 <ME,IR,DR>  CR: 22000464  XER: 20000000
[ 8030.370607] TASK = c7012ab0[7657] 'shmctl04' THREAD: c5a30000
[ 8030.376157] GPR00: c75dcab4 c5a31da0 c7012ab0 c7012ab0 00000078
00000000 00009032 100184c8
[ 8030.384540] GPR08: c75dcac0 00000001 c75dcab3 c5a31dfc 00000000
1001d564 00000000 10017e08
[ 8030.392921] GPR16: 00000000 10019e40 0000000b 00000111 00000000
00000000 0000005c 100184e0
[ 8030.401301] GPR24: 00000000 00009032 c75dcaac c75dcab4 c5a30000
c75dcac2 c5a30000 c5a31ddc
[ 8030.409859] Call Trace:
[ 8030.412296] [c5a31da0] [c0046184]  (unreliable)
[ 8030.416821] [c5a31dd0] [c02a2984]
[ 8030.420215] [c5a31e30] [c01345b4]
[ 8030.423610] [c5a31f10] [c0004ed8]
[ 8030.427003] [c5a31f40] [c00105b8]
[ 8030.430396] --- Exception: c01Instruction dump:
[ 8030.434922] 381b0008 917f0020 91290004 916b0004 813b0008 7f804800
419e001c 3b49fff4
[ 8030.442694] 801a002c 7f600278 3140ffff 7d2a0110 <0f090000> 7fe3fb78
7f64db78 4810d65d


$ powerpc-axon-linux-addr2line -i -e ./vmlinux c0045f8c
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/kernel/rtmutex.c:440
$ powerpc-axon-linux-addr2line -i -e ./vmlinux c029e1a8
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/kernel/rtmutex.c:720
$ powerpc-axon-linux-addr2line -i -e ./vmlinux c012fdf8
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/include/asm/atomic.h:22
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/include/asm-generic/atomic.h:148
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/include/linux/fs.h:530
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/ipc/shm.c:635
$ powerpc-axon-linux-addr2line -i -e ./vmlinux c0004ed8
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/arch/powerpc/kernel/syscalls.c:132
$ powerpc-axon-linux-addr2line -i -e ./vmlinux c00103d8
/home/leon/sandbox/mpc8313rdk/openembedded/build/tmp/work/linux-rt-2.6.24-r3/linux-2.6.24.3/arch/powerpc/kernel/entry_32.S:223

If any further info is required to track this one down.


Regards,
-- 
Leon
