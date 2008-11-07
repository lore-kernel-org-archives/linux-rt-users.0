From: Stephen Hemminger <shemminger@vyatta.com>
Subject: unionfs on RT
Date: Fri, 7 Nov 2008 13:47:35 -0800
Message-ID: <20081107134735.639c8c5d@extreme>
References: <20081105115205.14c5282f@s6510>
	<20081106185029.0d4c5cd8@redhat.com>
	<1226092963.5685.14.camel@dd>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail.vyatta.com ([76.74.103.46]:60061 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751019AbYKGVrh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 7 Nov 2008 16:47:37 -0500
In-Reply-To: <1226092963.5685.14.camel@dd>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

commit 192308315fdc06659a43d5011d9be76eb2520579
Author: Stephen Hemminger <stephen.hemminger@vyatta.com>
Date:   Fri Oct 31 14:17:17 2008 -0700

    Fix unionfs on RT
    
    RT changes inode stucture slightly.

diff --git a/fs/unionfs/super.c b/fs/unionfs/super.c
index 5fa4253..6f384e7 100644
--- a/fs/unionfs/super.c
+++ b/fs/unionfs/super.c
@@ -92,7 +92,7 @@ static void unionfs_delete_inode(struct inode *inode)
 	spin_unlock(&inode->i_lock);
 #endif
 
-	if (inode->i_data.nrpages)
+	if (mapping_nrpages(&inode->i_data))
 		truncate_inode_pages(&inode->i_data, 0);
 
 	clear_inode(inode);
