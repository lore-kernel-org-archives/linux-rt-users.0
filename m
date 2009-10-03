From: Sven-Thorsten Dietrich <sdietrich@novell.com>
Subject: Re: [PATCH][UHCI-DEBUG] Don't kmalloc with BKL held
Date: Sat, 03 Oct 2009 05:35:59 -0700
Message-ID: <1254573359.11691.0.camel@sven.thebigcorporation.com>
References: <1254474744.28661.2.camel@sven.thebigcorporation.com>
	 <20091002092021.GA25083@gambetta>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Frederik Deweerdt <frederik.deweerdt@xprog.eu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:45708 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755884AbZJCMgJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 3 Oct 2009 08:36:09 -0400
In-Reply-To: <20091002092021.GA25083@gambetta>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, 2009-10-02 at 09:20 +0000, Frederik Deweerdt wrote:
> Hi Sven-Thorsten,
> 
> On Fri, Oct 02, 2009 at 11:12:24AM +0200, Sven-Thorsten Dietrich wrote:
> > Subject: Don't kmalloc with BKL held.
> > From: Sven-Thorsten Dietrich <sdietrich@suse.de>
> > 
> > I'm eyeballing this file for complete removal of lock_kernel but 
> > at first glance, we definitely don't need BKL to kmalloc(). 
> You need to move the unlock_kernel() above the out: label too.
> 

How about this ?

Subject: Don't kmalloc with BKL held.
From: Sven-Thorsten Dietrich sdietrich@suse.de Sat Oct 3 01:27:27 2009 -0700
Date: Sat Oct 3 01:27:27 2009 -0700:
Git: 4f62eb81e827eb857129101e49757d84ac9ee7eb

We don't need BKL to kmalloc

diff --git a/drivers/usb/host/uhci-debug.c b/drivers/usb/host/uhci-debug.c
index e52b954..3fd5602 100644
--- a/drivers/usb/host/uhci-debug.c
+++ b/drivers/usb/host/uhci-debug.c
@@ -494,32 +494,30 @@ static int uhci_debug_open(struct inode *inode, struct file *file)
 {
 	struct uhci_hcd *uhci = inode->i_private;
 	struct uhci_debug *up;
-	int ret = -ENOMEM;
 	unsigned long flags;
 
-	lock_kernel();
 	up = kmalloc(sizeof(*up), GFP_KERNEL);
 	if (!up)
-		goto out;
+		return -ENOMEM;
 
 	up->data = kmalloc(MAX_OUTPUT, GFP_KERNEL);
 	if (!up->data) {
 		kfree(up);
-		goto out;
+		return -ENOMEM;
 	}
 
 	up->size = 0;
+
+	lock_kernel();
 	spin_lock_irqsave(&uhci->lock, flags);
 	if (uhci->is_initialized)
 		up->size = uhci_sprint_schedule(uhci, up->data, MAX_OUTPUT);
 	spin_unlock_irqrestore(&uhci->lock, flags);
 
 	file->private_data = up;
