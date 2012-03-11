From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH RT] staging/pohmelfs: convert struct fs->lock usage to seq_spin_{,un}lock
Date: Sun, 11 Mar 2012 17:23:19 +0100
Message-ID: <1331482999-32252-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33221 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab2CKQXW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 11 Mar 2012 12:23:22 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This fixes:

	drivers/staging/pohmelfs/path_entry.c:47:2: warning: passing argument =
1 of =E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [ena=
bled by default]
	include/linux/spinlock_rt.h:19:56: note: expected =E2=80=98struct spin=
lock_t *=E2=80=99 but argument is of type =E2=80=98struct seqlock_t *=E2=
=80=99
	drivers/staging/pohmelfs/path_entry.c:49:2: warning: passing argument =
1 of =E2=80=98rt_spin_unlock=E2=80=99 from incompatible pointer type [e=
nabled by default]
	include/linux/spinlock_rt.h:22:56: note: expected =E2=80=98struct spin=
lock_t *=E2=80=99 but argument is of type =E2=80=98struct seqlock_t *=E2=
=80=99
	drivers/staging/pohmelfs/path_entry.c:95:2: warning: passing argument =
1 of =E2=80=98rt_spin_lock=E2=80=99 from incompatible pointer type [ena=
bled by default]
	include/linux/spinlock_rt.h:19:56: note: expected =E2=80=98struct spin=
lock_t *=E2=80=99 but argument is of type =E2=80=98struct seqlock_t *=E2=
=80=99
	drivers/staging/pohmelfs/path_entry.c:97:2: warning: passing argument =
1 of =E2=80=98rt_spin_unlock=E2=80=99 from incompatible pointer type [e=
nabled by default]
	include/linux/spinlock_rt.h:22:56: note: expected =E2=80=98struct spin=
lock_t *=E2=80=99 but argument is of type =E2=80=98struct seqlock_t *=E2=
=80=99

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
Hello Thomas,

you probably want to squash that into fs-struct-use-seqlock.patch
It's only compile tested.

Best regards
Uwe

 drivers/staging/pohmelfs/path_entry.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/pohmelfs/path_entry.c b/drivers/staging/po=
hmelfs/path_entry.c
index 400a9fc..fc0c3fe 100644
--- a/drivers/staging/pohmelfs/path_entry.c
+++ b/drivers/staging/pohmelfs/path_entry.c
@@ -44,9 +44,9 @@ int pohmelfs_construct_path_string(struct pohmelfs_in=
ode *pi, void *data, int le
 		return -ENOENT;
 	}
=20
-	spin_lock(&current->fs->lock);
+	seq_spin_lock(&current->fs->lock);
 	path.mnt =3D mntget(current->fs->root.mnt);
-	spin_unlock(&current->fs->lock);
+	seq_spin_unlock(&current->fs->lock);
=20
 	path.dentry =3D d;
=20
@@ -92,9 +92,9 @@ int pohmelfs_path_length(struct pohmelfs_inode *pi)
 		return -ENOENT;
 	}
=20
-	spin_lock(&current->fs->lock);
+	seq_spin_lock(&current->fs->lock);
 	root =3D dget(current->fs->root.dentry);
-	spin_unlock(&current->fs->lock);
+	seq_spin_unlock(&current->fs->lock);
=20
 rename_retry:
 	len =3D 1; /* Root slash */
--=20
1.7.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
