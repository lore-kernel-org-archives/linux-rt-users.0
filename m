From: Wargreen <wargreen@lebib.org>
Subject: Radeon driver hang with 4.9.0-rt
Date: Thu, 23 Feb 2017 19:15:17 +0100
Message-ID: <51bb7d64-b41f-3fe9-f1d7-eef34b93ff0f@lebib.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lebib.org ([89.234.152.46]:52480 "EHLO lebib.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751228AbdBWSjq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 23 Feb 2017 13:39:46 -0500
Received: from [10.13.10.42] (81-64-127-34.rev.numericable.fr [81.64.127.34])
        by lebib.org (Postfix) with ESMTPSA id 71AFB2B3C883
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Feb 2017 19:14:02 +0100 (CET)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello linux-rt list,

After swith to a radeon HD5850, i have a full graphic hang when an
application require lot of GPU. Kill this application (via ssh) resume
the normal operation.
I run Debian SID, it's happen with both linux-image-4.9.0.1-rt-amd64 and
linux-image-4.9.0.2-rt-amd64.

Extract of my syslog (full version at
http://kalaj.darktech.org/~wargreen/logs/radeon/syslog)  :

Feb 19 23:17:19 LaChoze kernel: [  605.169580] INFO: task Xorg:2014 blocked for more than 120 seconds.
Feb 19 23:17:19 LaChoze kernel: [  605.169588]       Not tainted 4.9.0-1-rt-amd64 #1
Feb 19 23:17:19 LaChoze kernel: [  605.169590] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 19 23:17:19 LaChoze kernel: [  605.169593] Xorg            D    0  2014   2012 0x00000004
Feb 19 23:17:19 LaChoze kernel: [  605.169598]  ffff9235afe24800 0000000000000000 ffff9235b6c69200 ffff9235b12e9f80
Feb 19 23:17:19 LaChoze kernel: [  605.169602]  ffff9235b4e4ee40 ffffa16b023a7be8 ffffffff85a16cbf 00ff9235b12e9f80
Feb 19 23:17:19 LaChoze kernel: [  605.169606]  ffff9235b6c69200 ffff9235b12e9f80 ffff9235b12e9f80 0000000000000000
Feb 19 23:17:19 LaChoze kernel: [  605.169611] Call Trace:
Feb 19 23:17:19 LaChoze kernel: [  605.169620]  [<ffffffff85a16cbf>] ? __schedule+0x26f/0x5b0
Feb 19 23:17:19 LaChoze kernel: [  605.169623]  [<ffffffff85a17043>] ? schedule+0x43/0xc0
Feb 19 23:17:19 LaChoze kernel: [  605.169625]  [<ffffffff85a18aa3>] ? __rt_mutex_slowlock+0x83/0x150
Feb 19 23:17:19 LaChoze kernel: [  605.169628]  [<ffffffff85a18fcc>] ? rt_mutex_slowlock+0x11c/0x2a0
Feb 19 23:17:19 LaChoze kernel: [  605.169633]  [<ffffffff854cd9d4>] ? rt_down_read+0x24/0x30
Feb 19 23:17:19 LaChoze kernel: [  605.169663]  [<ffffffffc0b2eaf7>] ? radeon_gem_create_ioctl+0x37/0x100 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169680]  [<ffffffffc09f9b9a>] ? drm_ioctl+0x1ea/0x470 [drm]
Feb 19 23:17:19 LaChoze kernel: [  605.169703]  [<ffffffffc0b2eac0>] ? radeon_gem_pwrite_ioctl+0x30/0x30 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169706]  [<ffffffff8547dc82>] ? unpin_current_cpu+0x12/0x70
Feb 19 23:17:19 LaChoze kernel: [  605.169723]  [<ffffffffc0afd049>] ? radeon_drm_ioctl+0x49/0x80 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169726]  [<ffffffff856257bf>] ? do_vfs_ioctl+0x9f/0x610
Feb 19 23:17:19 LaChoze kernel: [  605.169730]  [<ffffffff858f2e4d>] ? __sys_recvmsg+0x7d/0x90
Feb 19 23:17:19 LaChoze kernel: [  605.169733]  [<ffffffff85625da4>] ? SyS_ioctl+0x74/0x80
Feb 19 23:17:19 LaChoze kernel: [  605.169736]  [<ffffffff85a1b27b>] ? system_call_fast_compare_end+0xc/0x9b
Feb 19 23:17:19 LaChoze kernel: [  605.169770] INFO: task E.d3d9.OpenGL:4263 blocked for more than 120 seconds.
Feb 19 23:17:19 LaChoze kernel: [  605.169773]       Not tainted 4.9.0-1-rt-amd64 #1
Feb 19 23:17:19 LaChoze kernel: [  605.169774] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 19 23:17:19 LaChoze kernel: [  605.169776] E.d3d9.OpenGL   D    0  4263   4243 0x20020000
Feb 19 23:17:19 LaChoze kernel: [  605.169779]  ffff9235b0839b00 0000000000000000 ffff9235b6ce9200 ffff92341d6a4ec0
Feb 19 23:17:19 LaChoze kernel: [  605.169783]  ffff9235b4e4af40 ffffa16b020a3b40 ffffffff85a16cbf 0000000000000000
Feb 19 23:17:19 LaChoze kernel: [  605.169787]  ffff9235b6ce9200 ffff92341d6a4ec0 ffff92341d6a4ec0 0000000000000000
Feb 19 23:17:19 LaChoze kernel: [  605.169791] Call Trace:
Feb 19 23:17:19 LaChoze kernel: [  605.169795]  [<ffffffff85a16cbf>] ? __schedule+0x26f/0x5b0
Feb 19 23:17:19 LaChoze kernel: [  605.169798]  [<ffffffff85a17043>] ? schedule+0x43/0xc0
Feb 19 23:17:19 LaChoze kernel: [  605.169800]  [<ffffffff85a18aa3>] ? __rt_mutex_slowlock+0x83/0x150
Feb 19 23:17:19 LaChoze kernel: [  605.169802]  [<ffffffff85a18fcc>] ? rt_mutex_slowlock+0x11c/0x2a0
Feb 19 23:17:19 LaChoze kernel: [  605.169805]  [<ffffffff854cd9d4>] ? rt_down_read+0x24/0x30
Feb 19 23:17:19 LaChoze kernel: [  605.169827]  [<ffffffffc0b1becd>] ? radeon_bo_create+0x15d/0x280 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169849]  [<ffffffffc0b2e6ce>] ? radeon_gem_object_create+0xbe/0x1a0 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169870]  [<ffffffffc0b2eb29>] ? radeon_gem_create_ioctl+0x69/0x100 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169884]  [<ffffffffc09f9b9a>] ? drm_ioctl+0x1ea/0x470 [drm]
Feb 19 23:17:19 LaChoze kernel: [  605.169905]  [<ffffffffc0b2eac0>] ? radeon_gem_pwrite_ioctl+0x30/0x30 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169908]  [<ffffffff8547dc82>] ? unpin_current_cpu+0x12/0x70
Feb 19 23:17:19 LaChoze kernel: [  605.169924]  [<ffffffffc0afd049>] ? radeon_drm_ioctl+0x49/0x80 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169950]  [<ffffffffc0be89c0>] ? radeon_kms_compat_ioctl+0x10/0x20 [radeon]
Feb 19 23:17:19 LaChoze kernel: [  605.169953]  [<ffffffff8566e4ec>] ? compat_SyS_ioctl+0xbc/0x1140
Feb 19 23:17:19 LaChoze kernel: [  605.169956]  [<ffffffff85a1704d>] ? schedule+0x4d/0xc0
Feb 19 23:17:19 LaChoze kernel: [  605.169959]  [<ffffffff85403e1d>] ? do_fast_syscall_32+0x8d/0x170
Feb 19 23:17:19 LaChoze kernel: [  605.169962]  [<ffffffff85a1caac>] ? entry_SYSENTER_compat+0x4c/0x5b
[...]
Feb 19 23:19:20 LaChoze kernel: [  726.004439] INFO: task gnome-shell:1825 blocked for more than 120 seconds.
Feb 19 23:19:20 LaChoze kernel: [  726.004447]       Not tainted 4.9.0-1-rt-amd64 #1
Feb 19 23:19:20 LaChoze kernel: [  726.004449] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Feb 19 23:19:20 LaChoze kernel: [  726.004452] gnome-shell     D    0  1825   1817 0x00000000
Feb 19 23:19:20 LaChoze kernel: [  726.004457]  ffff9235b3591200 0000000000000000 ffff9235b6d69200 ffff923596402f40
Feb 19 23:19:20 LaChoze kernel: [  726.004461]  ffff9235b4e49f80 ffffa16b01f67be8 ffffffff85a16cbf 0000000000000000
Feb 19 23:19:20 LaChoze kernel: [  726.004465]  ffff9235b6d69200 0000000000000001 ffff923596402f40 0000000000000000
Feb 19 23:19:20 LaChoze kernel: [  726.004469] Call Trace:
[.....]

Is there a workaround ?
I'm here for more informations or tests.

Thanks for the RT !

