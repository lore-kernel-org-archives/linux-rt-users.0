Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5062725D1F5
	for <linux-rt-users@vger.kernel.org>; Fri, 28 Feb 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740739486; cv=none; b=HCvPhiMVQ8r8IZzGKA+//dmpdRwnbLX0xeI09SnssFM56j/FpMXlaMvBk3dwTFhcRQhCQ4PE3j+Y/sCrCJ3V9z5gqgXSgUO7JZIoDZUrddL5emsyfl3FJssyTxQ6k+P35QIaV1Ebvqu8oUpaIgT7i8cDkR/pmucGRB0xlYqezD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740739486; c=relaxed/simple;
	bh=vLiJi41bBUWl0zSsZaPDlrvc0Q1Ov2ymYp2SskGvZ+0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ce4suurPrxay7XS6u8CS39jqATKEldIjycffRt9xAjNUoYuTlzXppI5Dw4r4KS5MHVY/7sFmTwxresB6CVqv0msESGgvHc3IvxIadYDRQ7z+Lg2eLq6VJ29t6DeQCnxkRdRP7hjRL1XpOQrieO0AchYr6Ot85tK15fgDvRZ59+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b=IsrT/egb; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smile.fr header.i=@smile.fr header.b="IsrT/egb"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-390e3b3d3bcso2218524f8f.3
        for <linux-rt-users@vger.kernel.org>; Fri, 28 Feb 2025 02:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1740739480; x=1741344280; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AUMiIVZHmxd84lOYA1ezGJcwPRk8IL6XHlpnZi3s7do=;
        b=IsrT/egbPR1dsF3Sy0ZQxwM4uKu4eV+90GYooY174tBCeb/luT4CDAQvoqs71s/EsO
         nZANHjf+fjkMNqePb1jt9cHakjJpkpJsbbYFmkM6LmM9GxpC3AuNLgIT1JUD8mf/Gz2B
         lL39f+a118n3nC/YaGmiC/3qOV7y5Nsep4kHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740739480; x=1741344280;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AUMiIVZHmxd84lOYA1ezGJcwPRk8IL6XHlpnZi3s7do=;
        b=VUyNrUqI6q5vCtbqYuCSpw+n+niywNSN81teSi3eFDBs2+LXv5DFfAuP+iLRjZIt10
         WkUUdLTcaXlEDMpyGHcshWRNJKVnBxM320DyzABf2kCImtcZBa9RetMC+sVLWsQoh2dA
         ny5ZvO1DA/O78sAFXTYJ9ENs2HUMsNNamdDhXHi5ftPWC0sWXH7VryuEaOqzLx/oRDi1
         tDh/He+W9Ca0QiBrf0QoB4EIyg4wAAeaWjtcKTY89RdRTN9RBW4mAz3rn8bbewtqyKLl
         Wqrop3OE+PDf6DsMECQXgYcx4ICpjGtr0rYK2wgrzrC1hkf8jk8BS0OeULIwzg+BILt3
         HJQQ==
X-Gm-Message-State: AOJu0YzPrLlNO+wzY6asW/KIlHFl7EZ3hdDYDYuTATqK4XXdECLSeCrQ
	T1i//Dasn/P9aFktZK32+xvIJHLKzZON9YREM8N/tuqU99jyd95fu/vXRAS6xiUstBA1oZWScYu
	x
X-Gm-Gg: ASbGncvx+NlXX/E0tOtaxpHso2pllLkbgF+dIMys8OiVV8495+eeDqp+ylbvHGuCpcU
	QeXWjwe7HvvuYpLWUgF9fRntXlTU+Y5gcpGK71VQZSRpLhN1FzMGJxmr3E0O8Yz8ZYrKM7q0JW2
	DIMexXhvZIah8xEE5wAElisx1zfr2bPbOWhQjD+iCAPs0KaSL65FS5teHAjdMzrUvbyW7Md7WpT
	lnCUDONq/N29fiovbujRq+3hozZArttVYxyrX9mGiETxKAsd9TJT0/NvmPMjbEE0pcR3p/0kYtP
	slWGJgZTLfNtlaRiS6i3lKBF2xXXbhbTr1gl1BDZa0MiWlQPXxylWdJFFoss7HyGjOZGwYK2yJz
	5jXiJx+afXJa/hEbw6prl0PvGcnmt0P5IHw==
X-Google-Smtp-Source: AGHT+IHbaX2JBJGKlHmj9THhNiAJ9439irwAVmSgM+n07JDb2kIyxQuawBHYTCFRh3ZVblP2HbKpcA==
X-Received: by 2002:a5d:47c3:0:b0:38d:d371:e01d with SMTP id ffacd0b85a97d-390eca25f7fmr2258560f8f.49.1740739479737;
        Fri, 28 Feb 2025 02:44:39 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (2a01cb000deef0002cff7470e58ff5dc.ipv6.abo.wanadoo.fr. [2a01:cb00:dee:f000:2cff:7470:e58f:f5dc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47a6a87sm4890409f8f.32.2025.02.28.02.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 02:44:39 -0800 (PST)
Date: Fri, 28 Feb 2025 11:44:30 +0100
From: Yoann Congal <yoann.congal@smile.fr>
To: Linux RT Users ML <linux-rt-users@vger.kernel.org>
Cc: Florent Carli <florent.carli@rte-france.com>
Subject: "BUG: scheduling while atomic" with nested KVM and LVM snapshots
Message-ID: <Z8GTjqgDe_5EkE3t@P-ASN-ECS-830T8C3.local>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Linux RT users,

I got a setup running nested KVM virtual machines on PREEMPT RT kernels
(all 6.12.12 RT kernels from Debian):
The "physical hypervisor" runs "virtual host" VMs which runs guests VMs.

When using LVM snapshots on the "virtual host" (ie the middle one), I
randomly get a "BUG: scheduling while atomic" trace in the
ext4->dm_snapshot callstack (full trace bellow). It seems to happen more
often when the whole system is loaded. There are multiple BUG traces
each time with slightly different stacks, the deepest common function is
do_origin in [dm_snapshot] [0].

Does that ring a bell?
Do you have an advice on how to debug or even fix this?

Thanks!

[0]: https://web.git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/md/dm-snap.c?h=v6.12.12&id=d914acc16b5910bf9b46e2e8b441569bfe180d1b#n2556

Full kernel log:

Feb 27 16:38:46 BUG: scheduling while atomic: kworker/u27:0/75/0x00000003
Feb 27 16:38:46 Modules linked in: mptcp_diag tcp_diag udp_diag raw_diag inet_diag xt_conntrack nft_chain_nat xt_MASQUERADE nf_conntrack_netlink xfrm>
Feb 27 16:38:46  virtio_blk scsi_mod virtio_net net_failover scsi_common failover i2c_i801 psmouse crc32_pclmul i2c_smbus lpc_ich crc32c_intel
Feb 27 16:38:46 CPU: 2 UID: 0 PID: 75 Comm: kworker/u27:0 Not tainted 6.12.12-rt-amd64 #1  Debian 6.12.12-1
Feb 27 16:38:46 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Feb 27 16:38:46 Workqueue: writeback wb_workfn (flush-253:1)
Feb 27 16:38:46 Call Trace:
Feb 27 16:38:46  <TASK>
Feb 27 16:38:46  dump_stack_lvl+0x5d/0x80
Feb 27 16:38:46  __schedule_bug.cold+0x42/0x4e
Feb 27 16:38:46  __schedule+0x998/0xc00
Feb 27 16:38:46  schedule_rtlock+0x1e/0x40
Feb 27 16:38:46  rtlock_slowlock_locked+0x21b/0xd30
Feb 27 16:38:46  rt_spin_lock+0x42/0x60
Feb 27 16:38:46  __insert_pending_exception+0x4e/0xe0 [dm_snapshot]
Feb 27 16:38:46  __origin_write+0x369/0x3e0 [dm_snapshot]
Feb 27 16:38:46  do_origin+0xae/0xe0 [dm_snapshot]
Feb 27 16:38:46  __map_bio+0x194/0x1c0 [dm_mod]
Feb 27 16:38:46  dm_submit_bio+0x222/0xa90 [dm_mod]
Feb 27 16:38:46  ? mpage_release_unused_pages+0x1f6/0x200 [ext4]
Feb 27 16:38:46  __submit_bio+0x138/0x200
Feb 27 16:38:46  submit_bio_noacct_nocheck+0x1a8/0x3f0
Feb 27 16:38:46  ext4_io_submit+0x24/0x40 [ext4]
Feb 27 16:38:46  ext4_do_writepages+0x38b/0xc50 [ext4]
Feb 27 16:38:46  ext4_writepages+0xad/0x170 [ext4]
Feb 27 16:38:46  do_writepages+0x7e/0x280
Feb 27 16:38:46  ? update_sd_lb_stats.constprop.0+0x695/0x950
Feb 27 16:38:46  __writeback_single_inode+0x41/0x340
Feb 27 16:38:46  writeback_sb_inodes+0x21d/0x4e0
Feb 27 16:38:46  __writeback_inodes_wb+0x4c/0xf0
Feb 27 16:38:46  wb_writeback+0x196/0x310
Feb 27 16:38:46  wb_workfn+0x2af/0x450
Feb 27 16:38:46  process_one_work+0x174/0x330
Feb 27 16:38:46  worker_thread+0x252/0x390
Feb 27 16:38:46  ? __pfx_worker_thread+0x10/0x10
Feb 27 16:38:46  kthread+0xcf/0x100
Feb 27 16:38:46  ? __pfx_kthread+0x10/0x10
Feb 27 16:38:46  ret_from_fork+0x31/0x50
Feb 27 16:38:46  ? __pfx_kthread+0x10/0x10
Feb 27 16:38:46  ret_from_fork_asm+0x1a/0x30
Feb 27 16:38:46  </TASK>

Feb 27 16:38:46 BUG: scheduling while atomic: kworker/u27:0/75/0x7fffffff
Feb 27 16:38:46 Modules linked in:
Feb 27 16:38:46  mptcp_diag tcp_diag udp_diag raw_diag inet_diag xt_conntrack nft_chain_nat xt_MASQUERADE nf_conntrack_netlink xfrm_user xfrm_algo xt>
Feb 27 16:38:46  virtio_net net_failover scsi_common failover i2c_i801 psmouse crc32_pclmul i2c_smbus lpc_ich crc32c_intel
Feb 27 16:38:46 
Feb 27 16:38:46 CPU: 2 UID: 0 PID: 75 Comm: kworker/u27:0 Tainted: G        W          6.12.12-rt-amd64 #1  Debian 6.12.12-1
Feb 27 16:38:46 Tainted: [W]=WARN
Feb 27 16:38:46 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Feb 27 16:38:46 Workqueue: writeback wb_workfn (flush-253:1)
Feb 27 16:38:46 Call Trace:
Feb 27 16:38:46  <TASK>
Feb 27 16:38:46  dump_stack_lvl+0x5d/0x80
Feb 27 16:38:46  __schedule_bug.cold+0x42/0x4e
Feb 27 16:38:46  __schedule+0x998/0xc00
Feb 27 16:38:46  ? __blk_flush_plug+0xf3/0x150
Feb 27 16:38:46  schedule+0x27/0xf0
Feb 27 16:38:46  io_schedule+0x46/0x70
Feb 27 16:38:46  wait_for_in_progress+0x13d/0x170 [dm_snapshot]
Feb 27 16:38:46  ? __pfx_default_wake_function+0x10/0x10
Feb 27 16:38:46  do_origin+0x8a/0xe0 [dm_snapshot]
Feb 27 16:38:46  __map_bio+0x194/0x1c0 [dm_mod]
Feb 27 16:38:46  dm_submit_bio+0x222/0xa90 [dm_mod]
Feb 27 16:38:46  ? mpage_release_unused_pages+0x1f6/0x200 [ext4]
Feb 27 16:38:46  __submit_bio+0x138/0x200
Feb 27 16:38:46  submit_bio_noacct_nocheck+0x1a8/0x3f0
Feb 27 16:38:46  ext4_io_submit+0x24/0x40 [ext4]
Feb 27 16:38:46  ext4_do_writepages+0x38b/0xc50 [ext4]
Feb 27 16:38:46  ext4_writepages+0xad/0x170 [ext4]
Feb 27 16:38:46  do_writepages+0x7e/0x280
Feb 27 16:38:46  ? update_sd_lb_stats.constprop.0+0x695/0x950
Feb 27 16:38:46  __writeback_single_inode+0x41/0x340
Feb 27 16:38:46  writeback_sb_inodes+0x21d/0x4e0
Feb 27 16:38:46  __writeback_inodes_wb+0x4c/0xf0
Feb 27 16:38:46  wb_writeback+0x196/0x310
Feb 27 16:38:46  wb_workfn+0x2af/0x450
Feb 27 16:38:46  process_one_work+0x174/0x330
Feb 27 16:38:46  worker_thread+0x252/0x390
Feb 27 16:38:46  ? __pfx_worker_thread+0x10/0x10
Feb 27 16:38:46  kthread+0xcf/0x100
Feb 27 16:38:46  ? __pfx_kthread+0x10/0x10
Feb 27 16:38:46  ret_from_fork+0x31/0x50
Feb 27 16:38:46  ? __pfx_kthread+0x10/0x10
Feb 27 16:38:46  ret_from_fork_asm+0x1a/0x30
Feb 27 16:38:46  </TASK>

Feb 27 16:38:48 BUG: scheduling while atomic: python3/6358/0x00000003
Feb 27 16:38:48 Modules linked in: mptcp_diag tcp_diag udp_diag raw_diag inet_diag xt_conntrack nft_chain_nat xt_MASQUERADE nf_conntrack_netlink xfrm>
Feb 27 16:38:48  virtio_blk scsi_mod virtio_net net_failover scsi_common failover i2c_i801 psmouse crc32_pclmul i2c_smbus lpc_ich crc32c_intel
Feb 27 16:38:48 CPU: 5 UID: 0 PID: 6358 Comm: python3 Tainted: G        W          6.12.12-rt-amd64 #1  Debian 6.12.12-1
Feb 27 16:38:48 Tainted: [W]=WARN
Feb 27 16:38:48 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2024.11-5 01/28/2025
Feb 27 16:38:48 Call Trace:
Feb 27 16:38:48  <TASK>
Feb 27 16:38:48  dump_stack_lvl+0x5d/0x80
Feb 27 16:38:48  __schedule_bug.cold+0x42/0x4e
Feb 27 16:38:48  __schedule+0x998/0xc00
Feb 27 16:38:48  ? kvm_sched_clock_read+0x11/0x20
Feb 27 16:38:48  ? sched_clock+0x10/0x30
Feb 27 16:38:48  ? var_wake_function+0x21/0x70
Feb 27 16:38:48  schedule_rtlock+0x1e/0x40
Feb 27 16:38:48  rtlock_slowlock_locked+0x21b/0xd30
Feb 27 16:38:48  ? psi_task_switch+0xb7/0x200
Feb 27 16:38:48  rt_spin_lock+0x42/0x60
Feb 27 16:38:48  __insert_pending_exception+0x4e/0xe0 [dm_snapshot]
Feb 27 16:38:48  __origin_write+0x369/0x3e0 [dm_snapshot]
Feb 27 16:38:48  do_origin+0xae/0xe0 [dm_snapshot]
Feb 27 16:38:48  __map_bio+0x194/0x1c0 [dm_mod]
Feb 27 16:38:48  dm_submit_bio+0x222/0xa90 [dm_mod]
Feb 27 16:38:48  ? mpage_release_unused_pages+0x1f6/0x200 [ext4]
Feb 27 16:38:48  __submit_bio+0x138/0x200
Feb 27 16:38:48  submit_bio_noacct_nocheck+0x1a8/0x3f0
Feb 27 16:38:48  ext4_io_submit+0x24/0x40 [ext4]
Feb 27 16:38:48  ext4_do_writepages+0x38b/0xc50 [ext4]
Feb 27 16:38:48  ext4_writepages+0xad/0x170 [ext4]
Feb 27 16:38:48  do_writepages+0x7e/0x280
Feb 27 16:38:48  filemap_fdatawrite_wbc+0x63/0x90
Feb 27 16:38:48  __filemap_fdatawrite_range+0x60/0x90
Feb 27 16:38:48  ext4_release_file+0x71/0xb0 [ext4]
Feb 27 16:38:48  __fput+0xde/0x2a0
Feb 27 16:38:48  __x64_sys_close+0x3c/0x80
Feb 27 16:38:48  do_syscall_64+0x82/0x190
Feb 27 16:38:48  ? atime_needs_update+0x9c/0x110
Feb 27 16:38:48  ? touch_atime+0x1e/0x120
Feb 27 16:38:48  ? current_time+0x3e/0xf0
Feb 27 16:38:48  ? atime_needs_update+0x9c/0x110
Feb 27 16:38:48  ? touch_atime+0x1e/0x120
Feb 27 16:38:48  ? splice_direct_to_actor+0x1f2/0x280
Feb 27 16:38:48  ? __pfx_direct_splice_actor+0x10/0x10
Feb 27 16:38:48  ? __audit_filter_op+0xa2/0x110
Feb 27 16:38:48  ? audit_reset_context+0x232/0x300
Feb 27 16:38:48  ? syscall_exit_to_user_mode_prepare+0x149/0x170
Feb 27 16:38:48  ? syscall_exit_to_user_mode+0x4d/0x210
Feb 27 16:38:48  ? do_syscall_64+0x8e/0x190
Feb 27 16:38:48  ? audit_reset_context+0x232/0x300
Feb 27 16:38:48  ? syscall_exit_to_user_mode_prepare+0x149/0x170
Feb 27 16:38:48  ? syscall_exit_to_user_mode+0x4d/0x210
Feb 27 16:38:48  ? do_syscall_64+0x8e/0x190
Feb 27 16:38:48  ? do_syscall_64+0x8e/0x190
Feb 27 16:38:48  ? do_syscall_64+0x8e/0x190
Feb 27 16:38:48  ? syscall_exit_to_user_mode_prepare+0x149/0x170
Feb 27 16:38:48  ? syscall_exit_to_user_mode+0x4d/0x210
Feb 27 16:38:48  ? clear_bhb_loop+0x25/0x80
Feb 27 16:38:48  ? clear_bhb_loop+0x25/0x80
Feb 27 16:38:48  ? clear_bhb_loop+0x25/0x80
Feb 27 16:38:48  entry_SYSCALL_64_after_hwframe+0x76/0x7e
Feb 27 16:38:48 RIP: 0033:0x7effc10d2a30
Feb 27 16:38:48 Code: 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 80 3d 39 06 0f 00 00 74 17 b8 03 00 00 00 0f 05 <>
Feb 27 16:38:48 RSP: 002b:00007ffc4d680968 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
Feb 27 16:38:48 RAX: ffffffffffffffda RBX: 0000000000a794f0 RCX: 00007effc10d2a30
Feb 27 16:38:48 RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000005
Feb 27 16:38:48 RBP: 0000000000000005 R08: 0000000000000000 R09: 0000000000000002
Feb 27 16:38:48 R10: 0000000000000007 R11: 0000000000000202 R12: 000000003e29ac00
Feb 27 16:38:48 R13: 0000000000a794f0 R14: 0000000000000000 R15: 00007effbfda5080
Feb 27 16:38:48  </TASK>

Best Regards,
-- 
Yoann Congal - Smile ECS
