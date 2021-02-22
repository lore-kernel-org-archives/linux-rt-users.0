Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA8C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 01:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BA764ED6
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Feb 2021 01:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhBVBnm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Feb 2021 20:43:42 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:1673 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhBVBnk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Feb 2021 20:43:40 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60330c240000>; Sun, 21 Feb 2021 17:43:00 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Feb
 2021 01:42:59 +0000
Received: from [172.17.173.69] (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Mon, 22 Feb 2021 01:42:59 +0000
X-Nvconfidentiality: public
To:     <linux-rt-users@vger.kernel.org>
From:   Dipen Patel <dipenp@nvidia.com>
Subject: sync system call failure
Message-ID: <6ed96c7e-aa40-e8d9-6330-85dc84514a81@nvidia.com>
Date:   Sun, 21 Feb 2021 17:46:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613958180; bh=lq0S5fIx3GRtMigmt9aADNEvwi/ea6f9k4lisAZ7L2E=;
        h=X-Nvconfidentiality:To:From:Subject:Message-ID:Date:User-Agent:
         MIME-Version:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=lV6lhbtaJFm8oJ4nF5yPr/U5/ncK4zdeVz4aDyBzmNgUDAAF4CVKuJyev4Nxqg5lQ
         QD4CA6KCVe8gVoDY/Xj75FfM1++5njvfgZoQMNZTI7K9Md1IopHwqyxfGgpwn39qbP
         MBBiQ3dlCKJLrs88Gug1nAF3jfnR1uqOayu7X2g5s7hmRK0JFlyPtA6O+nyXTuwMiN
         lxVi8Uhr4UupfDslI6gO4HjLJazFV6dBTH9aBoCH3CuEnsvd+Ni4gUHrZLYb6N82kl
         MTId/HW3odoPNzohER0eLwtVsDAtjg7QYLdpzN0J3MJOMmqtW8xJZHztwL041rWe8v
         KZl3D48Rx594w==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I encountered below crash during the sync system call possibly coming from the stress threads spawned because of the --io options which does sync system calls. I believe the crash is because of this upstream patch https://patchwork.kernel.org/project/linux-fsdevel/patch/20171212163830.GC3919388@devbig577.frc2.facebook.com/ which introduces read write semaphore. I am not sure how to mitigate this issue, any advice will be appreciated.

How to reproduce:
1. apt-get install stress
2. stress -c 8 --io 8 --vm 8 --hdd 4

Platform:
Nvidia Jetson AGX XAVIER, with 32GB eMMC 5.1 and 256 bit 32GB LPDDR4 RAM.

Kernel:
4.9.201-rt134

CPU:
8-Core ARM v8.2 64-Bit CPU, 8 MB L2 + 4 MB L3

Call stack:

[ 1813.814464] INFO: task stress blocked for more than 120 seconds.
[ 1813.814610]       Not tainted 4.9.201-rt134 #2
[ 1813.814613] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 1813.814615] stress          D    0 11510  11504 0x00000008
[ 1813.814616] Call trace:
[ 1813.814617] [<ffffff8008085eac>] __switch_to+0x98/0xb8
[ 1813.814618] [<ffffff8008f23b2c>] __schedule+0x270/0x570
[ 1813.814619] [<ffffff8008f23e74>] schedule+0x48/0xe0
[ 1813.814620] [<ffffff8008f25384>] __rt_mutex_slowlock+0xc4/0x144
[ 1813.814622] [<ffffff8008f2578c>] rt_mutex_slowlock_locked+0xcc/0x1e4
[ 1813.814624] [<ffffff8008f25910>] rt_mutex_slowlock.constprop.22+0x6c/0xb0
[ 1813.814625] [<ffffff8008f25c70>] rt_mutex_lock_state+0x94/0xc0
[ 1813.814626] [<ffffff8008f25f48>] __down_write_common+0x38/0x140
[ 1813.814627] [<ffffff8008f26148>] __down_write+0x24/0x30
[ 1813.814628] [<ffffff8008f25198>] down_write+0x20/0x2c
[ 1813.814629] [<ffffff8008279a08>] sync_inodes_sb+0x98/0x220
[ 1813.814630] [<ffffff8008280350>] sync_inodes_one_sb+0x28/0x34
[ 1813.814631] [<ffffff80082497d4>] iterate_supers+0x114/0x118
[ 1813.814632] [<ffffff8008280738>] sys_sync+0x44/0xac
[ 1813.814633] [<ffffff8008083100>] el0_svc_naked+0x34/0x38

[  363.940264] Showing all locks held in the system:
[  363.946481] 6 locks held by kworker/u16:0/7:
[  363.950503]  #0:  ("writeback"){......}, at: [<ffffff80080d3ed0>] process_one_work+0x1c0/0x670
[  363.959692]  #1:  ((&(&wb->dwork)->work)){......}, at: [<ffffff80080d3ed0>] process_one_work+0x1c0/0x670
[  363.969137]  #2:  (&type->s_umount_key#31){......}, at: [<ffffff800826b124>] trylock_super+0x24/0x70
[  363.978848]  #3:  (&sbi->s_journal_flag_rwsem){......}, at: [<ffffff80081e7688>] do_writepages+0x48/0xa0
[  363.988651]  #4:  (jbd2_handle){......}, at: [<ffffff8008369a80>] start_this_handle+0xf0/0x3b8
[  363.997576]  #5:  (&ei->i_data_sem){......}, at: [<ffffff8008315228>] ext4_map_blocks+0xd8/0x5a8
[  364.006530] 2 locks held by khungtaskd/740:
[  364.010699]  #0:  (rcu_read_lock){......}, at: [<ffffff800818f8e0>] watchdog+0xf0/0x510
[  364.018749]  #1:  (tasklist_lock){......}, at: [<ffffff8008117f64>] debug_show_all_locks+0x3c/0x1b8
[  364.027960] 1 lock held by in:imklog/5258:
[  364.032051]  #0:  (&f->f_pos_lock){......}, at: [<ffffff800828c120>] __fdget_pos+0x50/0x60
[  364.040366] 4 locks held by rs:main Q:Reg/5259:
[  364.044912]  #0:  (&f->f_pos_lock){......}, at: [<ffffff800828c120>] __fdget_pos+0x50/0x60
[  364.053311]  #1:  (rcu_read_lock){......}, at: [<ffffff800811578c>] cpuacct_charge+0x44/0xe8
[  364.061547]  #2:  (rcu_read_lock){......}, at: [<ffffff8008283b78>] dput.part.5+0x50/0x328
[  364.070289]  #3:  (&(&(&dentry->d_lockref.lock)->lock)->wait_lock){......}, at: [<ffffff8008fef254>] __schedule+0x84/0x6f0
[  364.081077] 2 locks held by agetty/6375:
[  364.085384]  #0:  (&tty->ldisc_sem){......}, at: [<ffffff8008ff2b94>] ldsem_down_read+0x2c/0x38
[  364.093567]  #1:  (&tty->atomic_write_lock){......}, at: [<ffffff80087399b8>] tty_write_lock+0x28/0x60
[  364.103206] 2 locks held by stress/12304:
[  364.107298]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.116317]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.125589] 2 locks held by stress/12308:
[  364.129266]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.138627]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.147821] 2 locks held by stress/12312:
[  364.152098]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.161392]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.170913] 2 locks held by stress/12314:
[  364.174761]  #0:  (sb_writers#5){......}, at: [<ffffff800826631c>] vfs_write+0x19c/0x1b0
[  364.183180]  #1:  (&sb->s_type->i_mutex_key#13){......}, at: [<ffffff800830e564>] ext4_file_write_iter+0x44/0x388
[  364.193580] 2 locks held by stress/12316:
[  364.197423]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.206786]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.215981] 2 locks held by stress/12320:
[  364.219829]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.229448]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.238717] 2 locks held by stress/12323:
[  364.242495]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.251680]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.261129] 2 locks held by stress/12326:
[  364.265237]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.274688]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.283796] 2 locks held by stress/12330:
[  364.287641]  #0:  (&type->s_umount_key#31){......}, at: [<ffffff800826b368>] iterate_supers+0x78/0x140
[  364.297261]  #1:  (&bdi->wb_switch_rwsem){......}, at: [<ffffff800829e630>] sync_inodes_sb+0x98/0x2a0
[  364.306720] 2 locks held by Xorg/14558:
[  364.310301]  #0:  (&tty->legacy_mutex){......}, at: [<ffffff8008747d84>] tty_lock_interruptible+0x4c/0xb0
[  364.319683]  #1:  (tasklist_lock){......}, at: [<ffffff800873f088>] tty_open+0x438/0x5b0

Best Regards,
Dipen Patel
