From: Stephen Hemminger <shemminger@vyatta.com>
Subject: aufs: built it on RT
Date: Fri, 7 Nov 2008 13:48:53 -0800
Message-ID: <20081107134853.652f6b5e@extreme>
References: <20081105115205.14c5282f@s6510>
	<20081106185029.0d4c5cd8@redhat.com>
	<1226092963.5685.14.camel@dd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Clark Williams <williams@redhat.com>,
	linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:60176 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbYKGVsy (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Nov 2008 16:48:54 -0500
In-Reply-To: <1226092963.5685.14.camel@dd>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

commit 485dd27c0ed3cfc553ef380a370c9614559aae08
Author: Stephen Hemminger <stephen.hemminger@vyatta.com>
Date:   Fri Oct 31 14:16:50 2008 -0700

    Fix aufs for -rt
    
    Rt changes some inode infrastructure to percpu.

diff --git a/fs/aufs/branch.c b/fs/aufs/branch.c
index e40ebcd..b52b085 100644
--- a/fs/aufs/branch.c
+++ b/fs/aufs/branch.c
@@ -898,7 +898,7 @@ static int au_br_mod_files_ro(struct super_block *sb, aufs_bindex_t bindex)
 
 	/* no need file_list_lock() since sbinfo is locked */
 	err = 0;
-	list_for_each_entry(file, &sb->s_files, f_u.fu_list) {
+	list_for_each_entry(file, percpu_list_head(&sb->s_files), f_u.fu_llist) {
 		LKTRTrace("%.*s\n", AuDLNPair(file->f_dentry));
 		if (!au_test_aufs_file(file))
 			continue;
