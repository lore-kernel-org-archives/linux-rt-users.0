From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH] Staging: pohmelfs: Fix a build error
Date: Wed, 19 May 2010 16:57:35 +0200
Message-ID: <1274281055-28812-1-git-send-email-abogani@texware.it>
Cc: Linux RT users <linux-rt-users@vger.kernel.org>,
	Alessio Igor Bogani <abogani@texware.it>
To: Thomas Gleixner <tglx@linutronix.de>,
	john stultz <johnstul@us.ibm.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ew0-f216.google.com ([209.85.219.216]:42169 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab0ESPDA (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 19 May 2010 11:03:00 -0400
Received: by ewy8 with SMTP id 8so2689359ewy.28
        for <linux-rt-users@vger.kernel.org>; Wed, 19 May 2010 08:02:59 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Build tested only, sorry.

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 drivers/staging/pohmelfs/inode.c |   72 +++++++++++++++++++++----------------
 1 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/staging/pohmelfs/inode.c b/drivers/staging/pohmelfs/inode.c
index cd25811..82d238a 100644
--- a/drivers/staging/pohmelfs/inode.c
+++ b/drivers/staging/pohmelfs/inode.c
@@ -1275,7 +1275,8 @@ static void pohmelfs_put_super(struct super_block *sb)
 	struct pohmelfs_inode *pi;
 	unsigned int count;
 	unsigned int in_drop_list = 0;
-	struct inode *inode, *tmp;
+	struct inode *inode, *next_i;
+	int i;
 
 	dprintk("%s.\n", __func__);
 
@@ -1290,11 +1291,11 @@ static void pohmelfs_put_super(struct super_block *sb)
 		dprintk("%s: ino: %llu, pi: %p, inode: %p, count: %u.\n",
 				__func__, pi->ino, pi, inode, count);
 
-		if (atomic_read(&inode->i_count) != count) {
+		if (inode->i_count != count) {
 			printk("%s: ino: %llu, pi: %p, inode: %p, count: %u, i_count: %d.\n",
 					__func__, pi->ino, pi, inode, count,
-					atomic_read(&inode->i_count));
-			count = atomic_read(&inode->i_count);
+					inode->i_count);
+			count = inode->i_count;
 			in_drop_list++;
 		}
 
@@ -1302,40 +1303,49 @@ static void pohmelfs_put_super(struct super_block *sb)
 			iput(&pi->vfs_inode);
 	}
 
-	list_for_each_entry_safe(inode, tmp, &sb->s_inodes, i_sb_list) {
-		pi = POHMELFS_I(inode);
-
-		dprintk("%s: ino: %llu, pi: %p, inode: %p, i_count: %u.\n",
-				__func__, pi->ino, pi, inode, atomic_read(&inode->i_count));
+	for_each_possible_cpu(i) {
+		struct list_head *list;
+#ifdef CONFIG_SMP
+		list = per_cpu_ptr(sb->s_inodes, i);
+#else
+		list = &sb->s_inodes;
+#endif
 
-		/*
-		 * These are special inodes, they were created during
-		 * directory reading or lookup, and were not bound to dentry,
-		 * so they live here with reference counter being 1 and prevent
-		 * umount from succeed since it believes that they are busy.
-		 */
-		count = atomic_read(&inode->i_count);
-		if (count) {
-			list_del_init(&inode->i_sb_list);
-			while (count--)
-				iput(&pi->vfs_inode);
+		list_for_each_entry_safe(inode, next_i, list, i_sb_list) {
+			pi = POHMELFS_I(inode);
+
+			dprintk("%s: ino: %llu, pi: %p, inode: %p, i_count: %u.\n",
+					__func__, pi->ino, pi, inode, atomic_read(&inode->i_count));
+
+			/*
+			 * These are special inodes, they were created during
+			 * directory reading or lookup, and were not bound to dentry,
+			 * so they live here with reference counter being 1 and prevent
+			 * umount from succeed since it believes that they are busy.
+			 */
+			count = inode->i_count;
+			if (count) {
+				list_del_init(&inode->i_sb_list);
+				while (count--)
+					iput(&pi->vfs_inode);
+			}
 		}
-	}
 
-	psb->trans_scan_timeout = psb->drop_scan_timeout = 0;
-	cancel_rearming_delayed_work(&psb->dwork);
-	cancel_rearming_delayed_work(&psb->drop_dwork);
-	flush_scheduled_work();
+		psb->trans_scan_timeout = psb->drop_scan_timeout = 0;
+		cancel_rearming_delayed_work(&psb->dwork);
+		cancel_rearming_delayed_work(&psb->drop_dwork);
+		flush_scheduled_work();
 
-	dprintk("%s: stopped workqueues.\n", __func__);
+		dprintk("%s: stopped workqueues.\n", __func__);
 
-	pohmelfs_crypto_exit(psb);
-	pohmelfs_state_exit(psb);
+		pohmelfs_crypto_exit(psb);
+		pohmelfs_state_exit(psb);
 
-	bdi_destroy(&psb->bdi);
+		bdi_destroy(&psb->bdi);
 
-	kfree(psb);
-	sb->s_fs_info = NULL;
+		kfree(psb);
+		sb->s_fs_info = NULL;
+	}
 }
 
 static int pohmelfs_statfs(struct dentry *dentry, struct kstatfs *buf)
-- 
1.7.0.4

