From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RT 2/5] a few open coded completions
Date: Wed, 11 Dec 2013 14:49:46 -0500
Message-ID: <20131211144946.27d82a78@gandalf.local.home>
References: <20131211003732.351606520@goodmis.org>
	<20131211003801.836995968@goodmis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	John Kacur <jkacur@redhat.com>,
	Corey Minyard <cminyard@mvista.com>
To: Steven Rostedt <rostedt@goodmis.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20131211003801.836995968@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Here's the new patch:


From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Mon, 28 Oct 2013 11:50:06 +0100
Subject: [PATCH] swait: Add a few more users

The wait-simple queue is lighter weight and more efficient than the full
wait queue, and may be used in atomic context on PREEMPT_RT.

Fix up some places that needed to call the swait_*() functions instead
of the wait_*() functions.

Cc: stable-rt@vger.kernel.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 drivers/net/wireless/orinoco/orinoco_usb.c | 2 +-
 drivers/usb/gadget/f_fs.c                  | 2 +-
 drivers/usb/gadget/inode.c                 | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/orinoco/orinoco_usb.c b/drivers/net/wireless/orinoco/orinoco_usb.c
index 1f9cb55..a28f298 100644
--- a/drivers/net/wireless/orinoco/orinoco_usb.c
+++ b/drivers/net/wireless/orinoco/orinoco_usb.c
@@ -714,7 +714,7 @@ static void ezusb_req_ctx_wait(struct ezusb_priv *upriv,
 			while (!ctx->done.done && msecs--)
 				udelay(1000);
 		} else {
-			wait_event_interruptible(ctx->done.wait,
+			swait_event_interruptible(ctx->done.wait,
 						 ctx->done.done);
 		}
 		break;
diff --git a/drivers/usb/gadget/f_fs.c b/drivers/usb/gadget/f_fs.c
index b6e9d91..35d9c53 100644
--- a/drivers/usb/gadget/f_fs.c
+++ b/drivers/usb/gadget/f_fs.c
@@ -1282,7 +1282,7 @@ static void ffs_data_put(struct ffs_data *ffs)
 		pr_info("%s(): freeing\n", __func__);
 		ffs_data_clear(ffs);
 		BUG_ON(waitqueue_active(&ffs->ev.waitq) ||
-		       waitqueue_active(&ffs->ep0req_completion.wait));
+		       swaitqueue_active(&ffs->ep0req_completion.wait));
 		kfree(ffs->dev_name);
 		kfree(ffs);
 	}
diff --git a/drivers/usb/gadget/inode.c b/drivers/usb/gadget/inode.c
index 570c005..c60233d 100644
--- a/drivers/usb/gadget/inode.c
+++ b/drivers/usb/gadget/inode.c
@@ -340,7 +340,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 	spin_unlock_irq (&epdata->dev->lock);
 
 	if (likely (value == 0)) {
-		value = wait_event_interruptible (done.wait, done.done);
+		value = swait_event_interruptible (done.wait, done.done);
 		if (value != 0) {
 			spin_lock_irq (&epdata->dev->lock);
 			if (likely (epdata->ep != NULL)) {
@@ -349,7 +349,7 @@ ep_io (struct ep_data *epdata, void *buf, unsigned len)
 				usb_ep_dequeue (epdata->ep, epdata->req);
 				spin_unlock_irq (&epdata->dev->lock);
 
-				wait_event (done.wait, done.done);
+				swait_event (done.wait, done.done);
 				if (epdata->status == -ECONNRESET)
 					epdata->status = -EINTR;
 			} else {
-- 
1.8.4.3
