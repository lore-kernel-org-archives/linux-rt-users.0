From: "Jaggi, Manish" <Manish.Jaggi@caviumnetworks.com>
Subject: Issues with 4.4-rt2 with arm64
Date: Wed, 20 Jan 2016 14:05:14 +0000
Message-ID: <BY1PR0701MB15949D1B10F90EE124B51176E1C20@BY1PR0701MB1594.namprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bn1on0072.outbound.protection.outlook.com ([157.56.110.72]:27072
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751367AbcATOUg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 09:20:36 -0500
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi All,
I have found some issues running with the 4.4 kernel and 4.4rt2 patchset on Cavium ThunderX with 48 cores.

a) With 4 cores there is no issue, 

b) With 48 cores boot hangs, sata doesnt mount and network VFs have issues. Probably the threadded irq are not scheduled
[   37.354634] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 7 from VF3
[   40.558635] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 5 from VF3
[   43.762640] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 14 from VF3
[   46.966631] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 7 from VF3
[   50.170671] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 5 from VF3
[   53.374621] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 14 from VF3
[   56.578615] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 7 from VF3
[   59.782632] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 5 from VF3
[   62.986630] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 14 from VF3
[   66.190629] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 7 from VF3
[   69.394626] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 5 from VF3
[   72.598633] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 14 from VF3
[   75.802680] thunder-nicvf 0002:01:00.4 eth3: PF didn't ack to mbox msg 7 from VF3

c) By  disabling NO_HZ_ IDLE and enabling PERIODIC no issues are observed in kernel boot. There are random issues like mount of a partition throws errors (run fsck)

d) Enabling sleep while atomic debug config, got the call traces
[   19.506039] BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:930
[   19.506043] in_atomic(): 1, irqs_disabled(): 0, pid: 733, name: dhclient
[   19.506045] 2 locks held by dhclient/733:
[   19.506065]  #0:  (sk_lock-AF_INET){+.+...}, at: [<ffff800000882c14>] sock_setsockopt+0xbc/0x998
[   19.506079]  #1:  (jump_label_mutex){+.+...}, at: [<ffff8000001f53a0>] static_key_slow_inc+0xb0/0x110
[   19.506089] Preemption disabled at:[<ffff80000009aa04>] aarch64_insn_patch_text_nosync+0x1c/0x48
[   19.506090] 
[   19.506096] CPU: 0 PID: 733 Comm: dhclient Not tainted 4.4.0-rt2-00116-g02e26fb-dirty #20
[   19.506098] Hardware name: www.cavium.com ThunderX CRB1S/ThunderX CRB1S, BIOS 0.3 Dec  3 2015

[   19.506100] Call trace:
[   19.506104] [<ffff800000097b30>] dump_backtrace+0x0/0x160
[   19.506107] [<ffff800000097cb4>] show_stack+0x24/0x30
[   19.506112] [<ffff80000059c538>] dump_stack+0x88/0xa8
[   19.506120] [<ffff800000103088>] ___might_sleep+0x240/0x258
[   19.506130] [<ffff8000009c72a8>] rt_spin_lock+0x30/0x68
[   19.506133] [<ffff80000009a7e4>] __aarch64_insn_write+0x34/0x108
[   19.506137] [<ffff80000009aa04>] aarch64_insn_patch_text_nosync+0x1c/0x48
[   19.506140] [<ffff80000009ac2c>] aarch64_insn_patch_text+0xc4/0xd8
[   19.506146] [<ffff8000000a3400>] arch_jump_label_transform+0x70/0x80
[   19.506151] [<ffff8000001f4d8c>] __jump_label_update+0x84/0xa0
[   19.506154] [<ffff8000001f4e50>] jump_label_update+0xa8/0xe0
[   19.506157] [<ffff8000001f53dc>] static_key_slow_inc+0xec/0x110
[   19.506162] [<ffff800000896260>] net_enable_timestamp+0x80/0x90
[   19.506166] [<ffff800000882b4c>] sock_enable_timestamp+0x9c/0xa8
[   19.506169] [<ffff800000882ec8>] sock_setsockopt+0x370/0x998
[   19.506176] [<ffff80000087cae8>] SyS_setsockopt+0xd8/0xe8
[   19.506180] [<ffff800000093a30>] el0_svc_naked+0x24/0x28
[   20.634687] 
[   20.940909] ===============================

PS: earlier the 4.1 rt  patch worked without these issue on same hardware.

 Regards, 
Manish Jaggi    