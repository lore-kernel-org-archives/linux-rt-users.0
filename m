From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: [PATCH][UHCI-DEBUG] Don't kmalloc with BKL held
Date: Fri, 02 Oct 2009 11:12:24 +0200
Message-ID: <1254474744.28661.2.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51145 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754646AbZJBJM1 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 2 Oct 2009 05:12:27 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Subject: Don't kmalloc with BKL held.
From: Sven-Thorsten Dietrich <sdietrich@suse.de>

I'm eyeballing this file for complete removal of lock_kernel but 
at first glance, we definitely don't need BKL to kmalloc(). 

Signed-off-by: Sven-Thorsten Dietrich <sdietrich@suse.de>


diff --git a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
index e52b954..325d508 100644
--- a/drivers/usb/host/uhci-debug.c
+++ b/drivers/usb/host/uhci-debug.c
@@ -497,7 +497,6 @@ static int uhci_debug_open(struct inode *inode, struct file *file)
 	int ret = -ENOMEM;
 	unsigned long flags;
 
-	lock_kernel();
 	up = kmalloc(sizeof(*up), GFP_KERNEL);
 	if (!up)
 		goto out;
@@ -509,6 +508,8 @@ static int uhci_debug_open(struct inode *inode, struct file *file)
 	}
 
 	up->size = 0;
+
+	lock_kernel();
 	spin_lock_irqsave(&uhci->lock, flags);
 	if (uhci->is_initialized)
 		up->size = uhci_sprint_schedule(uhci, up->data, MAX_OUTPUT);


