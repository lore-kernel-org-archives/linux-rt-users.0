From: Alessio Igor Bogani <abogani@texware.it>
Subject: [PATCH rt/2.6.33] Fix for this build error:
Date: Mon, 22 Feb 2010 22:33:42 +0100
Message-ID: <1266874422-3200-1-git-send-email-abogani@texware.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-rt-users@vger.kernel.org>,
	Alessio Igor Bogani <abogani@texware.it>
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:39369 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754474Ab0BVVeI (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Feb 2010 16:34:08 -0500
Received: by fg-out-1718.google.com with SMTP id e21so619069fga.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 Feb 2010 13:34:06 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

fs/xfs/linux-2.6/xfs_super.c: In function =E2=80=98xfs_fs_clear_inode=E2=
=80=99:
fs/xfs/linux-2.6/xfs_super.c:1113: error: =E2=80=98struct rw_anon_semap=
hore=E2=80=99 has no member named =E2=80=98lock=E2=80=99
make[2]: *** [fs/xfs/linux-2.6/xfs_super.o] Error 1

Signed-off-by: Alessio Igor Bogani <abogani@texware.it>
---
 fs/xfs/linux-2.6/xfs_super.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/xfs/linux-2.6/xfs_super.c b/fs/xfs/linux-2.6/xfs_super.=
c
index 77414db..5eddd6f 100644
--- a/fs/xfs/linux-2.6/xfs_super.c
+++ b/fs/xfs/linux-2.6/xfs_super.c
@@ -1110,7 +1110,7 @@ xfs_fs_clear_inode(
 	 * (and basically indicate what we are doing), we explicitly
 	 * re-init the iolock here.
 	 */
-	ASSERT(!rwsem_is_locked(&ip->i_iolock.mr_lock));
+	ASSERT(!anon_rwsem_is_locked(&ip->i_iolock.mr_lock));
 	mrlock_init(&ip->i_iolock, MRLOCK_BARRIER, "xfsio", ip->i_ino);
=20
 	xfs_inactive(ip);
--=20
1.6.3.3

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
