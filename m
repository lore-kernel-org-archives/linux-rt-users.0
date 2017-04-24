From: Daniel Bristot de Oliveira <daniel@bristot.me>
Subject: Re: [PATCH] usb: Use _nort in usb_hcd_pci_remove
Date: Mon, 24 Apr 2017 22:03:16 +0200
Message-ID: <23e658b3-f3c5-799c-4442-0817573d2b55@bristot.me>
References: <20170420180027.19316-1-nate.dailey@stratus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Nate Dailey <nate.dailey@stratus.com>,
        linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtpi-sp-236.kinghost.net ([177.185.201.236]:47711 "EHLO
        smtpi-sp-236.kinghost.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1174188AbdDXUL4 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 24 Apr 2017 16:11:56 -0400
In-Reply-To: <20170420180027.19316-1-nate.dailey@stratus.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 04/20/2017 08:00 PM, Nate Dailey wrote:
> A trip through usb_hcd_pci_remove produces:
> 
>  BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:993
>  in_atomic(): 0, irqs_disabled(): 1, pid: 4752, name: bash
>  INFO: lockdep is turned off.
>  irq event stamp: 0
>  hardirqs last  enabled at (0): [<          (null)>]           (null)
>  hardirqs last disabled at (0): [<ffffffff8108da9d>] copy_process.part.36+0x64d/0x2380
>  softirqs last  enabled at (0): [<ffffffff8108da9d>] copy_process.part.36+0x64d/0x2380
>  softirqs last disabled at (0): [<          (null)>]           (null)
>  CPU: 1 PID: 4752 Comm: bash Tainted: G        W I     4.9.0debug-rt16+ #2
>  Hardware name: Stratus ftServer 2700/G7LAY, BIOS BIOS Version 6.3:58 09/18/2014
>  ffffc90006e5fbd0 ffffffff813d243a ffff88016ac0b240 0000000000001290
>  ffffc90006e5fbf8 ffffffff810c6907 ffff8801682f45d0 ffff8801682f1000
>  ffff8801682f45d0 ffffc90006e5fc18 ffffffff817dee44 ffff88016b2aee18
>  Call Trace:
>  [<ffffffff813d243a>] dump_stack+0x99/0xcf
>  [<ffffffff810c6907>] ___might_sleep+0x137/0x210
>  [<ffffffff817dee44>] rt_spin_lock+0x24/0x60
>  [<ffffffff815b526f>] ehci_irq+0x2f/0x400
>  [<ffffffff814226b9>] ? pci_bus_read_config_word+0x99/0xb0
>  [<ffffffff81592d66>] usb_hcd_irq+0x26/0x40
>  [<ffffffff815a7a90>] usb_hcd_pci_remove+0x50/0x170
>  [<ffffffff815b933a>] ehci_pci_remove+0x1a/0x20
>  [<ffffffff8142fc39>] pci_device_remove+0x39/0xc0
>  [<ffffffff8152c4da>] __device_release_driver+0x9a/0x150
>  [<ffffffff8152c5b3>] device_release_driver+0x23/0x30
>  [<ffffffff81427f6c>] pci_stop_bus_device+0x8c/0xa0
>  [<ffffffff8142808a>] pci_stop_and_remove_bus_device_locked+0x1a/0x30
>  [<ffffffff8143182c>] remove_store+0x7c/0x90
>  [<ffffffff81526508>] dev_attr_store+0x18/0x30
>  [<ffffffff81313444>] sysfs_kf_write+0x44/0x60
>  [<ffffffff81312d7c>] kernfs_fop_write+0x13c/0x1d0
>  [<ffffffff81279bb7>] __vfs_write+0x37/0x160
>  [<ffffffff81118c82>] ? rcu_sync_lockdep_assert+0x12/0x60
>  [<ffffffff8127e3c6>] ? __sb_start_write+0x176/0x260
>  [<ffffffff8127a3f4>] ? vfs_write+0x184/0x1b0
>  [<ffffffff8127a325>] vfs_write+0xb5/0x1b0
>  [<ffffffff810025e0>] ? syscall_trace_enter+0x1d0/0x380
>  [<ffffffff8127b7e8>] SyS_write+0x58/0xc0
>  [<ffffffff81002d0a>] do_syscall_64+0x7a/0x230
>  [<ffffffff817df6c9>] entry_SYSCALL64_slow_path+0x25/0x25
> 
> Repro via something like:
> 
>> echo 1 > /sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/0000:02:01.0/0000:3d:00.0/0000:3e:01.0/0000:66:00.0/remove
> Switching usb_hcd_pci_remove to use _nort variants prevents the BUG.
> 
> Signed-off-by: Nate Dailey <nate.dailey@stratus.com>

Acked-by: Daniel Bristot de Oliveira <bristot@redhat.com>
