From: Rolf Wojtech <rolf.wojtech@fos4x.de>
Subject: Re: [PATCH-rt] rtmutex/rt: don't BUG for -EDEADLK when =?utf-8?b?ZGV0ZWN0X2RlYWRsb2Nr?= is off
Date: Thu, 18 Dec 2014 13:02:44 +0000 (UTC)
Message-ID: <loom.20141218T134759-778@post.gmane.org>
References: <1413418164-9405-1-git-send-email-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34035 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751470AbaLRNUG (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 18 Dec 2014 08:20:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glru-linux-rt-users@m.gmane.org>)
	id 1Y1azs-0007BQ-Fj
	for linux-rt-users@vger.kernel.org; Thu, 18 Dec 2014 14:20:04 +0100
Received: from pd907f7af.dip0.t-ipconnect.de ([217.7.247.175])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 14:20:04 +0100
Received: from rolf.wojtech by pd907f7af.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-rt-users@vger.kernel.org>; Thu, 18 Dec 2014 14:20:04 +0100
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Paul Gortmaker <paul.gortmaker <at> windriver.com> writes:

> 
> The stable cherry pick of commit 3d5c9340d1949733eb37616abd15db36aef9a57c
> ("rtmutex: Handle deadlock detection smarter")  essentially makes the
> deadlock_detect flag a no-op, as it says:
> 
>     Even in the case when deadlock detection is not requested by the
>     caller, we can detect deadlocks. Right now the code stops the lock
>     chain walk and keeps the waiter enqueued, even on itself. Silly not to
>     yell when such a scenario is detected and to keep the waiter enqueued.
> 
>     Return -EDEADLK unconditionally and handle it at the call sites.
> 
> So, as part of that change, we see this:
> 
>   <at>  <at>  -453,7 +453,7  <at>  <at>  static int 
task_blocks_on_rt_mutex(struct rt_mutex *lock,
>           * which is wrong, as the other waiter is not in a deadlock
>           * situation.
>           */
>  -       if (detect_deadlock && owner == task)
>  +       if (owner == task)
>                  return -EDEADLK;
> 
> However, as part of the -rt baseline patches, there exists this change
> within rt-mutex-add-sleeping-spinlocks-support.patch:
> 
> 	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
> 	BUG_ON(ret);
> 
> Note that the zero in the call to task_blocks_on_rt_mutex is the value
> of detect_deadlock; off, but now ignored, and so we get ret = -EDEADLK
> which triggers the BUG_ON().
> 
> Per the quoted commit above, we handle EDEADLK at the call site, by
> not triggering the BUG_ON for it, and instead it will fall through
> to the existing for(;;) { ... debug_rt_mutex_print_deadlock() ...}
> code immediately below.
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker <at> windriver.com>
> ---
> 
> Notes:
> 
>  -this patch is against 3.10-rt, but the code for all recent -rt
>   that include the recent linux-stable rtmutex changes should have
>   the same issue.  [The 3.14-rt has a trivial path change where the
>   kernel/rtmutex.c of v3.10 becomes kernel/locking/rtmutex.c but
>   aside from that it applies to 3.14 too]
> 
>  -I'd got a report of this BUG_ON triggering on a v3.4-rt based
>   kernel; that kernel was using my integration of the tglx rtmutex
>   stable changes into 3.4-rt as described here:
> 	https://lkml.org/lkml/2014/9/23/944
>   but the related code in rostedt's 3.10.53-rt56 (in linux-stable-rt)
>   and in tglx's 3.14.12-rt9 patch queue is AFAICT identical.  So I
>   have to conclude that anything using the stable rtmutex changes
>   can inadvertently suffer the same BUG trigger.
> 
>  -this change gets us back to the pre-rtmutex stable commit behaviour,
>   but I suspect that smarter people than me can advise on a way to
>   achieve the same end result.  So I'll wait before adding anything
>   to the linux-stable-rt branches I'd put here at:
> 	https://git.kernel.org/cgit/linux/kernel/git/paulg/linux-stable-
rt.git
> 
>  kernel/rtmutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rtmutex.c b/kernel/rtmutex.c
> index 5f17f55c562d..70edaaee60dc 100644
> --- a/kernel/rtmutex.c
> +++ b/kernel/rtmutex.c
>  <at>  <at>  -887,7 +887,7  <at>  <at>  static void  noinline __sched 
rt_spin_lock_slowlock(struct rt_mutex *lock)
>  	pi_unlock(&self->pi_lock);
> 
>  	ret = task_blocks_on_rt_mutex(lock, &waiter, self, 0);
> -	BUG_ON(ret);
> +	BUG_ON(ret && ret != -EDEADLK);
> 
>  	for (;;) {
>  		/* Try to acquire the lock again. */

We have two independant machines where we observe this error after a couple 
of weeks. The stacktrace points towards the r8169 driver (the machine has 
two RTL8111e chips) and the low load might lead to this not happening 
often. We are currently also not using the firmware-realtek package which 
might contribute to this oops:
[   10.671005] r8169 0000:02:00.0 eth1: unable to load firmware patch 
rtl_nic/rtl8168e-2.fw (-2)
[   10.741137] r8169 0000:01:00.0 eth0: unable to load firmware patch 
rtl_nic/rtl8168e-2.fw (-2)

Below the kern.log from the oops.
Note that kernel/rtmutex.c:890 is exactly the BUG_ON line that you are 
proposing to patch and EAX contains ffffffdd which matches -35 (EDEADLK = 
35).

We will soon have an array of these machines to hopefully reproduce the 
problem quicker so we would be open to testing proposed fixes. You seem 
hesitant if this is a valid fix, did you (or somebody else) tackle this 
issue in later versions? I checked in the current source code (3.14.25 RT 
22) and did not see any mitigation attempts, but I am quite new to PREEMPT-
RT so I might have missed it.

Nov 16 20:41:59 myhostname kernel: [487404.248390] NOHZ: 
local_softirq_pending 80
Nov 16 20:41:59 myhostname kernel: [487404.248664] NOHZ: 
local_softirq_pending 80
Nov 16 20:41:59 myhostname kernel: [487404.249295] NOHZ: 
local_softirq_pending 80
Nov 16 20:41:59 myhostname kernel: [776575.090709] NOHZ: 
local_softirq_pending 80
Nov 16 20:41:59 myhostname kernel: [776575.091489] NOHZ: 
local_softirq_pending 80
Nov 16 20:41:59 myhostname kernel: [899972.308008] ------------[ cut 
here ]------------
Nov 16 20:41:59 myhostname kernel: [899972.308015] kernel BUG at kernel/
rtmutex.c:890!
Nov 16 20:41:59 myhostname kernel: [899972.308027] invalid opcode: 0000 
[#1] PREEMPT SMP 
Nov 16 20:41:59 myhostname kernel: [899972.308061] Modules linked in: nfsd 
auth_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc tun loop iTCO_wdt 
iTCO_vendor_support acpi_cpufreq mperf coretemp psmouse serio_raw pcspkr 
i2c_i801 lpc_ich ehci_pci mfd_core evdev sd_mod crc_t10dif uhci_hcd 
gma500_gfx ehci_hcd r8169 video mii i2c_algo_bit drm_kms_helper thermal 
usbcore drm usb_common i2c_core
Nov 16 20:41:59 myhostname kernel: [899972.308067] CPU: 3 PID: 1947 Comm: 
irq/43-eth0 Not tainted 3.10.53-rt56fos4x+ #1
Nov 16 20:41:59 myhostname kernel: [899972.308069] Hardware name: ICP / iEi 
H688/E407, BIOS 4.6.5 11/16/2012
Nov 16 20:41:59 myhostname kernel: [899972.308073] task: f5357640 ti: 
f56f0000 task.ti: f56f0000
Nov 16 20:41:59 myhostname kernel: [899972.308076] EIP: 0060:[<c147aa8a>] 
EFLAGS: 00010286 CPU: 3
Nov 16 20:41:59 myhostname kernel: [899972.308085] EIP is at 
rt_spin_lock_slowlock+0x87/0x181
Nov 16 20:41:59 myhostname kernel: [899972.308088] EAX: ffffffdd EBX: 
c174e4c0 ECX: 00000000 EDX: 00009393
Nov 16 20:41:59 myhostname kernel: [899972.308091] ESI: f5357640 EDI: 
f5357a28 EBP: f56f1d4c ESP: f56f1d3c
Nov 16 20:41:59 myhostname kernel: [899972.308094]  DS: 007b ES: 007b FS: 
00d8 GS: 00e0 SS: 0068
Nov 16 20:41:59 myhostname kernel: [899972.308097] CR0: 8005003b CR2: 
b777e000 CR3: 01722000 CR4: 000007d0
Nov 16 20:41:59 myhostname kernel: [899972.308099] DR0: 00000000 DR1: 
00000000 DR2: 00000000 DR3: 00000000
Nov 16 20:41:59 myhostname kernel: [899972.308101] DR6: ffff0ff0 DR7: 
00000400
Nov 16 20:41:59 myhostname kernel: [899972.308102] Stack:
Nov 16 20:41:59 myhostname kernel: [899972.308113]  00000286 00000000 
c1719a00 f5357640 00000031 f56f1d50 f56f1d50 c174e4c4
Nov 16 20:41:59 myhostname kernel: [899972.308122]  c174e4c4 00000031 
f56f1d64 f56f1d64 f56f1d6c f56f1d6c f5357640 c174e4c0
Nov 16 20:41:59 myhostname kernel: [899972.308132]  00000001 c174e4c0 
c174e4c0 f2190944 f56f1dac c1030dfd f2190938 00000025
Nov 16 20:41:59 myhostname kernel: [899972.308133] Call Trace:
Nov 16 20:41:59 myhostname kernel: [899972.308145]  [<c1030dfd>] ? 
lock_timer_base.isra.31+0x24/0x3d
Nov 16 20:41:59 myhostname kernel: [899972.308150]  [<c1031455>] ? 
__mod_timer+0x33/0x11e
Nov 16 20:41:59 myhostname kernel: [899972.308156]  [<c10315f5>] ? mod_timer
+0x59/0x65
Nov 16 20:41:59 myhostname kernel: [899972.308163]  [<c1366fd1>] ? 
sk_reset_timer+0xc/0x1b
Nov 16 20:41:59 myhostname kernel: [899972.308169]  [<c13e5c0a>] ? 
tcp_prequeue+0x174/0x195
Nov 16 20:41:59 myhostname kernel: [899972.308175]  [<c13e84b1>] ? 
tcp_v4_rcv+0x211/0x494
Nov 16 20:41:59 myhostname kernel: [899972.308182]  [<c13ce1e8>] ? 
ip_local_deliver_finish+0xb7/0x187
Nov 16 20:41:59 myhostname kernel: [899972.308187]  [<c13ce100>] ? 
ip_rcv_finish+0x2b3/0x2e4
Nov 16 20:41:59 myhostname kernel: [899972.308193]  [<c1373fc7>] ? 
__netif_receive_skb_core+0x3bb/0x42c
Nov 16 20:41:59 myhostname kernel: [899972.308199]  [<c13741cc>] ? 
netif_receive_skb+0x58/0x8b
Nov 16 20:41:59 myhostname kernel: [899972.308204]  [<c13747f2>] ? 
napi_gro_receive+0x2e/0x69
Nov 16 20:41:59 myhostname kernel: [899972.308223]  [<f80770ba>] ? 
rtl8169_poll+0x2e7/0x471 [r8169]
Nov 16 20:41:59 myhostname kernel: [899972.308230]  [<c13745f0>] ? 
net_rx_action+0x75/0x16d
Nov 16 20:41:59 myhostname kernel: [899972.308237]  [<c102c350>] ? 
do_current_softirqs+0x128/0x25e
Nov 16 20:41:59 myhostname kernel: [899972.308244]  [<c107227a>] ? 
irq_thread_fn+0x21/0x21
Nov 16 20:41:59 myhostname kernel: [899972.308249]  [<c102c4e4>] ? 
local_bh_enable+0x31/0x4f
Nov 16 20:41:59 myhostname kernel: [899972.308254]  [<c10722ac>] ? 
irq_forced_thread_fn+0x32/0x38
Nov 16 20:41:59 myhostname kernel: [899972.308259]  [<c107281d>] ? 
irq_thread+0x6a/0x147
Nov 16 20:41:59 myhostname kernel: [899972.308265]  [<c10721d4>] ? 
irq_finalize_oneshot+0x76/0x76
Nov 16 20:41:59 myhostname kernel: [899972.308270]  [<c10727b3>] ? 
irq_affinity_notify+0x8/0x8
Nov 16 20:41:59 myhostname kernel: [899972.308275]  [<c103eb2e>] ? kthread
+0x68/0x6d
Nov 16 20:41:59 myhostname kernel: [899972.308282]  [<c147b8f7>] ? 
ret_from_kernel_thread+0x1b/0x28
Nov 16 20:41:59 myhostname kernel: [899972.308287]  [<c103eac6>] ? 
__kthread_parkme+0x50/0x50
Nov 16 20:41:59 myhostname kernel: [899972.308337] Code: 46 04 89 f8 c7 06 
02 00 00 00 e8 1c 05 00 00 89 f1 89 d8 6a 00 8d 54 24 14 e8 da 47 be ff 59 
85 c0 8d 6c 24 10 89 74 24 0c 74 02 <0f> 0b 89 f2 89 e9 6a 01 89 d8 e8 f6 
42 be ff 5a 85 c0 0f 85 88
Nov 16 20:41:59 myhostname kernel: [899972.308344] EIP: [<c147aa8a>] 
rt_spin_lock_slowlock+0x87/0x181 SS:ESP 0068:f56f1d3c
Nov 16 20:41:59 myhostname kernel: [899972.670009] ---[ end trace 
0000000000000002 ]---
Nov 16 20:41:59 myhostname kernel: [899972.670017] note: irq/43-eth0[1947] 
exited with preempt_count 1
Nov 16 20:41:59 myhostname kernel: [899972.670067] BUG: unable to handle 
kernel paging request at ffffffec
Nov 16 20:41:59 myhostname kernel: [899972.670081] IP: [<c103ee0c>] 
kthread_data+0x6/0xa
Nov 16 20:41:59 myhostname kernel: [899972.670087] *pde = 01723067 *pte = 
00000000 
Nov 16 20:41:59 myhostname kernel: [899972.670093] Oops: 0000 [#2] PREEMPT 
SMP 
Nov 16 20:41:59 myhostname kernel: [899972.670142] Modules linked in: nfsd 
auth_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc tun loop iTCO_wdt 
iTCO_vendor_support acpi_cpufreq mperf coretemp psmouse serio_raw pcspkr 
i2c_i801 lpc_ich ehci_pci mfd_core evdev sd_mod crc_t10dif uhci_hcd 
gma500_gfx ehci_hcd r8169 video mii i2c_algo_bit drm_kms_helper thermal 
usbcore drm usb_common i2c_core
Nov 16 20:41:59 myhostname kernel: [899972.670150] CPU: 3 PID: 1947 Comm: 
irq/43-eth0 Tainted: G      D      3.10.53-rt56fos4x+ #1
Nov 16 20:41:59 myhostname kernel: [899972.670153] Hardware name: ICP / iEi 
H688/E407, BIOS 4.6.5 11/16/2012
Nov 16 20:41:59 myhostname kernel: [899972.670157] task: f5357640 ti: 
f56f0000 task.ti: f56f0000
Nov 16 20:41:59 myhostname kernel: [899972.670162] EIP: 0060:[<c103ee0c>] 
EFLAGS: 00010202 CPU: 3
Nov 16 20:41:59 myhostname kernel: [899972.670167] EIP is at kthread_data
+0x6/0xa
Nov 16 20:41:59 myhostname kernel: [899972.670171] EAX: 00000000 EBX: 
f5357640 ECX: f56f1f58 EDX: f56f1f58
Nov 16 20:41:59 myhostname kernel: [899972.670175] ESI: f5357640 EDI: 
f5357640 EBP: f56f1d4c ESP: f56f1c00
Nov 16 20:41:59 myhostname kernel: [899972.670179]  DS: 007b ES: 007b FS: 
00d8 GS: 00e0 SS: 0068
Nov 16 20:41:59 myhostname kernel: [899972.670183] CR0: 8005003b CR2: 
ffffffec CR3: 01722000 CR4: 000007d0
Nov 16 20:41:59 myhostname kernel: [899972.670187] DR0: 00000000 DR1: 
00000000 DR2: 00000000 DR3: 00000000
Nov 16 20:41:59 myhostname kernel: [899972.670190] DR6: ffff0ff0 DR7: 
00000400
Nov 16 20:41:59 myhostname kernel: [899972.670191] Stack:
Nov 16 20:41:59 myhostname kernel: [899972.670205]  c107221d f5357640 
00000000 c103cb38 f5357640 00000000 c102a6dd 00000001
Nov 16 20:41:59 myhostname kernel: [899972.670219]  f56f1d4c c1474d05 
f5357a28 ffffffff 00000000 00000000 c1581b0a f56f1c48
Nov 16 20:41:59 myhostname kernel: [899972.670233]  c1025fe6 0000000b 
f56f1d00 00000246 f56f1d4c c1003780 f56f1d00 00000000
Nov 16 20:41:59 myhostname kernel: [899972.670234] Call Trace:
Nov 16 20:41:59 myhostname kernel: [899972.670246]  [<c107221d>] ? 
irq_thread_dtor+0x49/0x85
Nov 16 20:41:59 myhostname kernel: [899972.670254]  [<c103cb38>] ? 
task_work_run+0x60/0x70
Nov 16 20:41:59 myhostname kernel: [899972.670263]  [<c102a6dd>] ? do_exit
+0x352/0x7de
Nov 16 20:41:59 myhostname kernel: [899972.670271]  [<c1474d05>] ? printk
+0x16/0x1a
Nov 16 20:41:59 myhostname kernel: [899972.670281]  [<c1025fe6>] ? 
print_oops_end_marker+0x1b/0x1f
Nov 16 20:41:59 myhostname kernel: [899972.670290]  [<c1003780>] ? oops_end
+0x8e/0x92
Nov 16 20:41:59 myhostname kernel: [899972.670297]  [<c1001899>] ? do_bounds
+0x4c/0x4c
Nov 16 20:41:59 myhostname kernel: [899972.670304]  [<c1001902>] ? 
do_invalid_op+0x69/0x72
Nov 16 20:41:59 myhostname kernel: [899972.670314]  [<c147aa8a>] ? 
rt_spin_lock_slowlock+0x87/0x181
Nov 16 20:41:59 myhostname kernel: [899972.670323]  [<c104cb29>] ? 
__update_tg_runnable_avg+0x20/0x44
Nov 16 20:41:59 myhostname kernel: [899972.670331]  [<c1005b1c>] ? 
__cycles_2_ns+0x19/0x7e
Nov 16 20:41:59 myhostname kernel: [899972.670340]  [<c10481b7>] ? 
get_parent_ip+0x8/0x19
Nov 16 20:41:59 myhostname kernel: [899972.670347]  [<c1048268>] ? 
add_preempt_count+0xa0/0xc7
Nov 16 20:41:59 myhostname kernel: [899972.670355]  [<c147ae89>] ? 
_raw_spin_trylock+0x14/0x5b
Nov 16 20:41:59 myhostname kernel: [899972.670362]  [<c147ae07>] ? 
_raw_spin_unlock_irqrestore+0x3a/0x3f
Nov 16 20:41:59 myhostname kernel: [899972.670370]  [<c105f24d>] ? 
rt_mutex_adjust_prio_chain+0x295/0x29f
Nov 16 20:41:59 myhostname kernel: [899972.670378]  [<c10481b7>] ? 
get_parent_ip+0x8/0x19
Nov 16 20:41:59 myhostname kernel: [899972.670385]  [<c1048268>] ? 
add_preempt_count+0xa0/0xc7
Nov 16 20:41:59 myhostname kernel: [899972.670392]  [<c147b6d3>] ? 
error_code+0x67/0x6c
Nov 16 20:41:59 myhostname kernel: [899972.670403]  [<c147aa8a>] ? 
rt_spin_lock_slowlock+0x87/0x181
Nov 16 20:41:59 myhostname kernel: [899972.670414]  [<c1030dfd>] ? 
lock_timer_base.isra.31+0x24/0x3d
Nov 16 20:41:59 myhostname kernel: [899972.670422]  [<c1031455>] ? 
__mod_timer+0x33/0x11e
Nov 16 20:41:59 myhostname kernel: [899972.670430]  [<c10315f5>] ? mod_timer
+0x59/0x65
Nov 16 20:41:59 myhostname kernel: [899972.670440]  [<c1366fd1>] ? 
sk_reset_timer+0xc/0x1b
Nov 16 20:41:59 myhostname kernel: [899972.670449]  [<c13e5c0a>] ? 
tcp_prequeue+0x174/0x195
Nov 16 20:41:59 myhostname kernel: [899972.670457]  [<c13e84b1>] ? 
tcp_v4_rcv+0x211/0x494
Nov 16 20:41:59 myhostname kernel: [899972.670468]  [<c13ce1e8>] ? 
ip_local_deliver_finish+0xb7/0x187
Nov 16 20:41:59 myhostname kernel: [899972.670476]  [<c13ce100>] ? 
ip_rcv_finish+0x2b3/0x2e4
Nov 16 20:41:59 myhostname kernel: [899972.670485]  [<c1373fc7>] ? 
__netif_receive_skb_core+0x3bb/0x42c
Nov 16 20:41:59 myhostname kernel: [899972.670494]  [<c13741cc>] ? 
netif_receive_skb+0x58/0x8b
Nov 16 20:41:59 myhostname kernel: [899972.670502]  [<c13747f2>] ? 
napi_gro_receive+0x2e/0x69
Nov 16 20:41:59 myhostname kernel: [899972.670525]  [<f80770ba>] ? 
rtl8169_poll+0x2e7/0x471 [r8169]
Nov 16 20:41:59 myhostname kernel: [899972.670536]  [<c13745f0>] ? 
net_rx_action+0x75/0x16d
Nov 16 20:41:59 myhostname kernel: [899972.670545]  [<c102c350>] ? 
do_current_softirqs+0x128/0x25e
Nov 16 20:41:59 myhostname kernel: [899972.670555]  [<c107227a>] ? 
irq_thread_fn+0x21/0x21
Nov 16 20:41:59 myhostname kernel: [899972.670562]  [<c102c4e4>] ? 
local_bh_enable+0x31/0x4f
Nov 16 20:41:59 myhostname kernel: [899972.670570]  [<c10722ac>] ? 
irq_forced_thread_fn+0x32/0x38
Nov 16 20:41:59 myhostname kernel: [899972.670578]  [<c107281d>] ? 
irq_thread+0x6a/0x147
Nov 16 20:41:59 myhostname kernel: [899972.670586]  [<c10721d4>] ? 
irq_finalize_oneshot+0x76/0x76
Nov 16 20:41:59 myhostname kernel: [899972.670594]  [<c10727b3>] ? 
irq_affinity_notify+0x8/0x8
Nov 16 20:41:59 myhostname kernel: [899972.670601]  [<c103eb2e>] ? kthread
+0x68/0x6d
Nov 16 20:41:59 myhostname kernel: [899972.670611]  [<c147b8f7>] ? 
ret_from_kernel_thread+0x1b/0x28
Nov 16 20:41:59 myhostname kernel: [899972.670619]  [<c103eac6>] ? 
__kthread_parkme+0x50/0x50
Nov 16 20:41:59 myhostname kernel: [899972.670693] Code: 24 40 e8 bf b0 43 
00 83 c4 50 5b 5e 5f 5d c3 64 a1 80 f6 6f c1 8b 80 c4 01 00 00 8b 40 e4 c1 
e8 02 83 e0 01 c3 8b 80 c4 01 00 00 <8b> 40 ec c3 52 8b 90 c4 01 00 00 b9 
04 00 00 00 89 e0 c7 04 24
Nov 16 20:41:59 myhostname kernel: [899972.670702] EIP: [<c103ee0c>] 
kthread_data+0x6/0xa SS:ESP 0068:f56f1c00
Nov 16 20:41:59 myhostname kernel: [899972.670705] CR2: 00000000ffffffec
Nov 16 20:41:59 myhostname kernel: [899973.358942] ---[ end trace 
0000000000000003 ]---
Nov 16 20:41:59 myhostname kernel: [899973.358944] Fixing recursive fault 
but reboot is needed!
Nov 16 20:41:59 myhostname kernel: [899973.358949] BUG: scheduling while 
atomic: irq/43-eth0/1947/0x00000002
Nov 16 20:41:59 myhostname kernel: [899973.358990] Modules linked in: nfsd 
auth_rpcgss oid_registry nfs_acl nfs lockd fscache sunrpc tun loop iTCO_wdt 
iTCO_vendor_support acpi_cpufreq mperf coretemp psmouse serio_raw pcspkr 
i2c_i801 lpc_ich ehci_pci mfd_core evdev sd_mod crc_t10dif uhci_hcd 
gma500_gfx ehci_hcd r8169 video mii i2c_algo_bit drm_kms_helper thermal 
usbcore drm usb_common i2c_core
Nov 16 20:41:59 myhostname kernel: [899973.358994] Preemption disabled at:
[<  (null)>]   (null)
Nov 16 20:41:59 myhostname kernel: [899973.358995] 
Nov 16 20:41:59 myhostname kernel: [899973.359000] CPU: 3 PID: 1947 Comm: 
irq/43-eth0 Tainted: G      D      3.10.53-rt56fos4x+ #1
Nov 16 20:41:59 myhostname kernel: [899973.359002] Hardware name: ICP / iEi 
H688/E407, BIOS 4.6.5 11/16/2012
Nov 16 20:41:59 myhostname kernel: [899973.359014]  00000000 c1475089 
f5357640 c147a01c 0000004c 00000001 c1719a00 00000006
Nov 16 20:41:59 myhostname kernel: [899973.359023]  c174d72e c1719a00 
00000000 00000000 00000000 00000000 00000000 00000046
Nov 16 20:41:59 myhostname kernel: [899973.359032]  00000004 00000046 
00000006 00000000 00000003 00000046 f5357640 00000009
Nov 16 20:41:59 myhostname kernel: [899973.359033] Call Trace:
Nov 16 20:41:59 myhostname kernel: [899973.359045]  [<c1475089>] ? 
__schedule_bug+0x85/0x93
Nov 16 20:41:59 myhostname kernel: [899973.359051]  [<c147a01c>] ? 
__schedule+0x5d/0x3f6
Nov 16 20:41:59 myhostname kernel: [899973.359058]  [<c1474d05>] ? printk
+0x16/0x1a
Nov 16 20:41:59 myhostname kernel: [899973.359063]  [<c147a471>] ? schedule
+0x5e/0x6e
Nov 16 20:41:59 myhostname kernel: [899973.359069]  [<c102a45b>] ? do_exit
+0xd0/0x7de
Nov 16 20:41:59 myhostname kernel: [899973.359074]  [<c1474d05>] ? printk
+0x16/0x1a
Nov 16 20:41:59 myhostname kernel: [899973.359080]  [<c1025fe6>] ? 
print_oops_end_marker+0x1b/0x1f
Nov 16 20:41:59 myhostname kernel: [899973.359086]  [<c1003780>] ? oops_end
+0x8e/0x92
Nov 16 20:41:59 myhostname kernel: [899973.359091]  [<c147472f>] ? 
no_context+0x153/0x15d
Nov 16 20:41:59 myhostname kernel: [899973.359096]  [<c147481f>] ? 
__bad_area_nosemaphore+0xe6/0xee
Nov 16 20:41:59 myhostname kernel: [899973.359102]  [<c1474831>] ? 
bad_area_nosemaphore+0xa/0xc
Nov 16 20:41:59 myhostname kernel: [899973.359108]  [<c101f7ff>] ? 
__do_page_fault+0x2f0/0x371
Nov 16 20:41:59 myhostname kernel: [899973.359114]  [<c1027ea2>] ? 
vprintk_emit+0x31b/0x42c
Nov 16 20:41:59 myhostname kernel: [899973.359120]  [<c101f925>] ? 
vmalloc_sync_all+0xa5/0xa5
Nov 16 20:41:59 myhostname kernel: [899973.359125]  [<c147b6d3>] ? 
error_code+0x67/0x6c
Nov 16 20:41:59 myhostname kernel: [899973.359132]  [<c121007b>] ? 
get_cur_path+0x3a6/0x4c6
Nov 16 20:41:59 myhostname kernel: [899973.359138]  [<c103ee0c>] ? 
kthread_data+0x6/0xa
Nov 16 20:41:59 myhostname kernel: [899973.359145]  [<c107221d>] ? 
irq_thread_dtor+0x49/0x85
Nov 16 20:41:59 myhostname kernel: [899973.359149]  [<c103cb38>] ? 
task_work_run+0x60/0x70
Nov 16 20:41:59 myhostname kernel: [899973.359154]  [<c102a6dd>] ? do_exit
+0x352/0x7de
Nov 16 20:41:59 myhostname kernel: [899973.359158]  [<c1474d05>] ? printk
+0x16/0x1a
Nov 16 20:41:59 myhostname kernel: [899973.359164]  [<c1025fe6>] ? 
print_oops_end_marker+0x1b/0x1f
Nov 16 20:41:59 myhostname kernel: [899973.359169]  [<c1003780>] ? oops_end
+0x8e/0x92
Nov 16 20:41:59 myhostname kernel: [899973.359174]  [<c1001899>] ? do_bounds
+0x4c/0x4c
Nov 16 20:41:59 myhostname kernel: [899973.359178]  [<c1001902>] ? 
do_invalid_op+0x69/0x72
Nov 16 20:41:59 myhostname kernel: [899973.359184]  [<c147aa8a>] ? 
rt_spin_lock_slowlock+0x87/0x181
Nov 16 20:41:59 myhostname kernel: [899973.359190]  [<c104cb29>] ? 
__update_tg_runnable_avg+0x20/0x44
Nov 16 20:41:59 myhostname kernel: [899973.359195]  [<c1005b1c>] ? 
__cycles_2_ns+0x19/0x7e
Nov 16 20:41:59 myhostname kernel: [899973.359201]  [<c10481b7>] ? 
get_parent_ip+0x8/0x19
Nov 16 20:41:59 myhostname kernel: [899973.359205]  [<c1048268>] ? 
add_preempt_count+0xa0/0xc7
Nov 16 20:41:59 myhostname kernel: [899973.359210]  [<c147ae89>] ? 
_raw_spin_trylock+0x14/0x5b
Nov 16 20:41:59 myhostname kernel: [899973.359215]  [<c147ae07>] ? 
_raw_spin_unlock_irqrestore+0x3a/0x3f
Nov 16 20:41:59 myhostname kernel: [899973.359220]  [<c105f24d>] ? 
rt_mutex_adjust_prio_chain+0x295/0x29f
Nov 16 20:41:59 myhostname kernel: [899973.359225]  [<c10481b7>] ? 
get_parent_ip+0x8/0x19
Nov 16 20:41:59 myhostname kernel: [899973.359230]  [<c1048268>] ? 
add_preempt_count+0xa0/0xc7
Nov 16 20:41:59 myhostname kernel: [899973.359234]  [<c147b6d3>] ? 
error_code+0x67/0x6c
Nov 16 20:41:59 myhostname kernel: [899973.359241]  [<c147aa8a>] ? 
rt_spin_lock_slowlock+0x87/0x181
Nov 16 20:41:59 myhostname kernel: [899973.359248]  [<c1030dfd>] ? 
lock_timer_base.isra.31+0x24/0x3d
Nov 16 20:41:59 myhostname kernel: [899973.359253]  [<c1031455>] ? 
__mod_timer+0x33/0x11e
Nov 16 20:41:59 myhostname kernel: [899973.359258]  [<c10315f5>] ? mod_timer
+0x59/0x65
Nov 16 20:41:59 myhostname kernel: [899973.359266]  [<c1366fd1>] ? 
sk_reset_timer+0xc/0x1b
Nov 16 20:41:59 myhostname kernel: [899973.359272]  [<c13e5c0a>] ? 
tcp_prequeue+0x174/0x195
Nov 16 20:41:59 myhostname kernel: [899973.359277]  [<c13e84b1>] ? 
tcp_v4_rcv+0x211/0x494
Nov 16 20:41:59 myhostname kernel: [899973.359284]  [<c13ce1e8>] ? 
ip_local_deliver_finish+0xb7/0x187
Nov 16 20:41:59 myhostname kernel: [899973.359289]  [<c13ce100>] ? 
ip_rcv_finish+0x2b3/0x2e4
Nov 16 20:41:59 myhostname kernel: [899973.359295]  [<c1373fc7>] ? 
__netif_receive_skb_core+0x3bb/0x42c
Nov 16 20:41:59 myhostname kernel: [899973.359301]  [<c13741cc>] ? 
netif_receive_skb+0x58/0x8b
Nov 16 20:41:59 myhostname kernel: [899973.359306]  [<c13747f2>] ? 
napi_gro_receive+0x2e/0x69
Nov 16 20:41:59 myhostname kernel: [899973.359322]  [<f80770ba>] ? 
rtl8169_poll+0x2e7/0x471 [r8169]
Nov 16 20:41:59 myhostname kernel: [899973.359329]  [<c13745f0>] ? 
net_rx_action+0x75/0x16d
Nov 16 20:41:59 myhostname kernel: [899973.359335]  [<c102c350>] ? 
do_current_softirqs+0x128/0x25e
Nov 16 20:41:59 myhostname kernel: [899973.359341]  [<c107227a>] ? 
irq_thread_fn+0x21/0x21
Nov 16 20:41:59 myhostname kernel: [899973.359346]  [<c102c4e4>] ? 
local_bh_enable+0x31/0x4f
Nov 16 20:41:59 myhostname kernel: [899973.359351]  [<c10722ac>] ? 
irq_forced_thread_fn+0x32/0x38
Nov 16 20:41:59 myhostname kernel: [899973.359356]  [<c107281d>] ? 
irq_thread+0x6a/0x147
Nov 16 20:41:59 myhostname kernel: [899973.359361]  [<c10721d4>] ? 
irq_finalize_oneshot+0x76/0x76
Nov 16 20:41:59 myhostname kernel: [899973.359367]  [<c10727b3>] ? 
irq_affinity_notify+0x8/0x8
Nov 16 20:41:59 myhostname kernel: [899973.359371]  [<c103eb2e>] ? kthread
+0x68/0x6d
Nov 16 20:41:59 myhostname kernel: [899973.359378]  [<c147b8f7>] ? 
ret_from_kernel_thread+0x1b/0x28
Nov 16 20:41:59 myhostname kernel: [899973.359382]  [<c103eac6>] ? 
__kthread_parkme+0x50/0x50



