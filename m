From: "John Kacur" <jkacur@gmail.com>
Subject: Can't boot 2.6.26-rt1
Date: Sat, 2 Aug 2008 23:16:25 +0200
Message-ID: <520f0cf10808021416n286855f9s126d416230aee249@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steven Rostedt" <rostedt@goodmis.org>,
	"Ingo Molnar" <mingo@elte.hu>,
	"Thomas Gleixner" <tglx@linutronix.de>
To: linux-rt-users@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.178]:18091 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbYHBVQ1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 2 Aug 2008 17:16:27 -0400
Received: by ik-out-1112.google.com with SMTP id c28so1783271ika.5
        for <linux-rt-users@vger.kernel.org>; Sat, 02 Aug 2008 14:16:25 -0700 (PDT)
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

VFS: Cannot open root device
"disk/by-id/scsi-SATA_WDC_WD1600BEVS-WD-WXEZ07100576-part 7" or
unknown block(0,0)
Please append a correct "root = " boot option; here are the available
partitions.
Pid:1,comm:swapper Not tainted
2.6.26-rt1-default#1linux-rt-users@vger.kernel.org
[< ffff ffff 8046 c149 >] rt_mutex_lock+0x22/0x50
[< ffff ffff 8046 cae6 >] _mutex_unlock+0xe/0x10
[< ffff ffff 8020 cb00 >] exit_intr+0x10/0x1e
[< ffff ffff 8028 633d >] trace_hardirqs_on_caller+0x1e/0x133
[< ffff ffff 8020 d608 >] child_rip+0xa/0x12
[< ffff ffff 8020 cb69 >] restore_args+0x0/0x30
[< ffff ffff 8020 d5fe >] child_rip+0x0/0x12

preempt count 00000001
1-level deep critical section nesting
[< ffff ffff 8047 43e2 >] .... panic +0x43/0x167
[< ffff ffff 8073 6338 >] (<= mount_block_root+0x258/0x26f
