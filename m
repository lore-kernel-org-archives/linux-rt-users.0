From: Stanislav Meduna <stano@meduna.org>
Subject: BUG: sleeping function called from invalid context (do_force_sig_info)
Date: Fri, 23 May 2014 01:09:52 +0200
Message-ID: <537E83C0.9040406@meduna.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi,

this is on a i.MX28 running a 3.12.19-rt30

[27284.008123] BUG: sleeping function called from invalid context at /home/nxtdev/Kernels/linux-stable-rt/kernel/rtmutex.c:673
[27284.008143] in_atomic(): 0, irqs_disabled(): 128, pid: 1335, name: nxt
[27284.008170] CPU: 0 PID: 1335 Comm: nxt Not tainted 3.12.19-rt30+ #178
[27284.008255] [<c0014440>] (unwind_backtrace+0x0/0xf4) from [<c00124cc>] (show_stack+0x10/0x14)
[27284.008306] [<c00124cc>] (show_stack+0x10/0x14) from [<c028b6a8>] (rt_spin_lock+0x18/0x2c)
[27284.008348] [<c028b6a8>] (rt_spin_lock+0x18/0x2c) from [<c002a7ec>] (do_force_sig_info+0x20/0xd8)
[27284.008387] [<c002a7ec>] (do_force_sig_info+0x20/0xd8) from [<c0016720>] (__do_user_fault+0x88/0xc8)
[27284.008419] [<c0016720>] (__do_user_fault+0x88/0xc8) from [<c0016c2c>] (do_bad_area+0x64/0x70)
[27284.008452] [<c0016c2c>] (do_bad_area+0x64/0x70) from [<c0016ca4>] (do_translation_fault+0x6c/0xa8)
[27284.008483] [<c0016ca4>] (do_translation_fault+0x6c/0xa8) from [<c000867c>] (do_DataAbort+0x34/0x98)
[27284.008520] [<c000867c>] (do_DataAbort+0x34/0x98) from [<c0012ebc>] (__dabt_usr+0x3c/0x40)
[27284.008531] Exception stack(0xc1173fb0 to 0xc1173ff8)
[27284.008554] 3fa0:                                     b6634b48 d6634b44 d6634a94 07ffffff
[27284.008583] 3fc0: b6634c1c b6ef1160 b6ef1000 00000152 b6635460 b6ee6b34 00000000 b6634b4c
[27284.008605] 3fe0: 00000152 b6634a80 001f813c 00203888 60000010 ffffffff

There are some changes to the stock 3.12.19-rt30 (added drivers) where
I can not exclude that there is some bug lurking, and a bug in userspace
is even more probable; I am just forwarding it because of the sleeping
from invalid context thing.

After a reboot I am unfortunately not able to easily reproduce it. There
was no core dump (they are enabled) and the application did not exit
(there is no SEGV handler).

Thanks
-- 
                                       Stano
