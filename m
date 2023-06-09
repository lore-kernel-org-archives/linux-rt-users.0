Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEA9C7EE29
	for <linux-rt-users@archiver.kernel.org>; Fri,  9 Jun 2023 00:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237348AbjFIAU6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 8 Jun 2023 20:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237148AbjFIAU5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 8 Jun 2023 20:20:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042232D71
        for <linux-rt-users@vger.kernel.org>; Thu,  8 Jun 2023 17:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686270009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=YIiUCFB5sD6fZazuOVK85pJk3UFdHIpRMduxAKmbZmc=;
        b=VsvXLRZV4iKnFEqPThyi4t+ypYkoM0BoTK9YBJxfxzywmlKCWNCeQCI3IMBBOjQKcxxnw2
        SiYTFWGXi3kKTQQSPpt4l99Clru2k4BaPNYHd4SMoZnyMCv1CNvKL+eZDzBRKen1jmakmA
        +v78EIEqlZcQtpifzbSHnv5Rjjb8YI4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-5MaerUTMPq-tpWzHiV92Eg-1; Thu, 08 Jun 2023 20:20:06 -0400
X-MC-Unique: 5MaerUTMPq-tpWzHiV92Eg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2AE7E80A099;
        Fri,  9 Jun 2023 00:20:06 +0000 (UTC)
Received: from localhost (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C46DD140EBB8;
        Fri,  9 Jun 2023 00:20:05 +0000 (UTC)
Date:   Thu, 8 Jun 2023 21:20:04 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     Linux RT Users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v6.4-rc5-rt4] rt: vmd: make cfg_lock a raw spinlock
Message-ID: <ZIJwNBZa0UUTAx5i@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Sebastian, Steven,

I don't know if this is the best solution for the problem, but surely the
simplest one. If this patch makes sense, it could probably go upstream as
the changes only affect RT.

-------

rt: vmd: make cfg_lock a raw spinlock

This call sequence triggers the backtrace listed below:

    pci_user_read_config_dword()  --->  vmd_pci_read()

The first function, pci_user_read_config_dword(), takes a raw_spin_lock
(a classic spin lock) and disables preemption and interrupts. Then
vmd_pci_read() takes a RT spinlock (a rtmutex), which can sleep, hence
the complaint about a sleeping function being called from atomic context.


[  168.466387] LTP: starting read_all_proc (read_all -d /proc -q -r 3)
[  168.614389] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[  168.614393] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 10268, name: read_all
[  168.614395] preempt_count: 1, expected: 0
[  168.614396] RCU nest depth: 0, expected: 0
[  168.614397] INFO: lockdep is turned off.
[  168.614398] irq event stamp: 0
[  168.614398] hardirqs last  enabled at (0): [<0000000000000000>] 0x0
[  168.614402] hardirqs last disabled at (0): [<ffffffffa4b0f3bf>] copy_process+0x80f/0x1990
[  168.614411] softirqs last  enabled at (0): [<ffffffffa4b0f3bf>] copy_process+0x80f/0x1990
[  168.614414] softirqs last disabled at (0): [<0000000000000000>] 0x0
[  168.614415] Preemption disabled at:
[  168.614416] [<0000000000000000>] 0x0
[  168.614418] CPU: 19 PID: 10268 Comm: read_all Tainted: G        W          6.4.0-rc5-rt4 #2
[  168.614421] Hardware name: Dell Inc. Precision 7820 Tower/0804P1, BIOS 2.6.3 05/04/2020
[  168.614422] Call Trace:
[  168.614424]  <TASK>
[  168.614425]  dump_stack_lvl+0x47/0x80
[  168.614433]  __might_resched+0x19b/0x250
[  168.614441]  rt_spin_lock+0x4c/0x100
[  168.614446]  ? vmd_pci_read+0x85/0xf0
[  168.614453]  vmd_pci_read+0x85/0xf0
[  168.614456]  pci_user_read_config_dword+0x78/0x100
[  168.614464]  proc_bus_pci_read+0x110/0x2e0
[  168.614471]  ? selinux_file_permission+0x117/0x150
[  168.614478]  proc_reg_read+0x59/0xa0
[  168.614483]  vfs_read+0xa7/0x2e0
[  168.614488]  ? lock_acquire+0x1b9/0x300
[  168.614492]  ? do_sys_openat2+0x85/0x160
[  168.614496]  ? kmem_cache_free+0x269/0x3c0
[  168.614502]  ksys_read+0x68/0xf0
[  168.614505]  do_syscall_64+0x59/0x90
[  168.614508]  ? do_syscall_64+0x69/0x90
[  168.614510]  ? do_syscall_64+0x69/0x90
[  168.614511]  ? trace_hardirqs_on_prepare+0x19/0x30
[  168.614515]  ? do_syscall_64+0x69/0x90
[  168.614516]  ? do_syscall_64+0x69/0x90
[  168.614517]  ? trace_irq_enable.constprop.0+0x1f/0xb0
[  168.614520]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  168.614525] RIP: 0033:0x7ff67e88eaf2
[  168.614527] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ca 0c 08 00 e8 35 eb 01 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[  168.614529] RSP: 002b:00007ffe5f3f2698 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[  168.614531] RAX: ffffffffffffffda RBX: 0000000001990b98 RCX: 00007ff67e88eaf2
[  168.614533] RDX: 00000000000003ff RSI: 00007ffe5f3f2750 RDI: 0000000000000003
[  168.614534] RBP: 00007ff67e73d028 R08: 0000000000037fde R09: 0000000000000004
[  168.614535] R10: 00007ffe5f3f9170 R11: 0000000000000246 R12: 0000000000000078
[  168.614537] R13: 0000000000000003 R14: 00007ff67e739000 R15: 000000000000281c
[  168.614541]  </TASK>


Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>
---
diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 990630ec57c6a..3253e71fa0ad9 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -125,7 +125,7 @@ struct vmd_irq_list {
 struct vmd_dev {
 	struct pci_dev		*dev;
 
-	spinlock_t		cfg_lock;
+	raw_spinlock_t		cfg_lock;
 	void __iomem		*cfgbar;
 
 	int msix_count;
@@ -402,7 +402,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		*value = readb(addr);
@@ -417,7 +417,7 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -437,7 +437,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	if (!addr)
 		return -EFAULT;
 
-	spin_lock_irqsave(&vmd->cfg_lock, flags);
+	raw_spin_lock_irqsave(&vmd->cfg_lock, flags);
 	switch (len) {
 	case 1:
 		writeb(value, addr);
@@ -455,7 +455,7 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 		ret = -EINVAL;
 		break;
 	}
-	spin_unlock_irqrestore(&vmd->cfg_lock, flags);
+	raw_spin_unlock_irqrestore(&vmd->cfg_lock, flags);
 	return ret;
 }
 
@@ -1000,7 +1000,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (features & VMD_FEAT_OFFSET_FIRST_VECTOR)
 		vmd->first_vec = 1;
 
-	spin_lock_init(&vmd->cfg_lock);
+	raw_spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
 	err = vmd_enable_domain(vmd, features);
 	if (err)

