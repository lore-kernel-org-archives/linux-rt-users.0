Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52842C4338F
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 06:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AC856103B
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 06:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbhHUGvi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 02:51:38 -0400
Received: from mout.gmx.net ([212.227.17.20]:42115 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232097AbhHUGvi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Aug 2021 02:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629528649;
        bh=05G6QJk9SfdvpRWo9evcUXKBh/DmFJ7gGSE8lbMmVAs=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=YgPOQPTsEh++EIjydktKVMSua2TmVM2HkqAmOfenSTs46jiTsc8Z/X5DaZyppP0Jx
         LTRwKaw5gGR/aRVEBukj3Tn+IoMnPSqd1MGI2w7msJjo86RTW/QlRkdC1vpl1kf+VT
         fek49IwP8hMLZ5L+N1p5JuyP+L+MnqWoAPqpDfuU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.146.51.70]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5QF-1mEqY20ptP-00FA1R; Sat, 21
 Aug 2021 08:50:49 +0200
Message-ID: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
Subject: [patch] kcsan: Make it RT aware
From:   Mike Galbraith <efault@gmx.de>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Sat, 21 Aug 2021 08:50:48 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:J+09KFKL4OTurbIauNRnqfZ12KA4r8Pc++J5QmWak0WIszRUQND
 LD+CyyiHy9X3M7keJA1FsJTlThoHlt1jd45SkUoMtVgQ5ZHmD8tKiiByZA6KApSNObS1QoE
 PvWVCJMlSW/DMi4LcaOk1RSkzMWnOcAJJeD1OaTGtz284VUOro/krWOcLc34vaKFDrmBN6d
 SZAgI5y6+71cJEfa+HGnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HBgAGCo3Kls=:1QGQaJvu20+vYZrb+vaO3W
 JOpOETN5ot30fmbGJqm73NsoR1kwvd7m27t6hRSWuhk1JiIpzrG8ZESvlwh1V6oDVW/znz7Pr
 68ZIEz83w5Wq06zNOj7uM7KrBYgWH2qJ0S1uLwf/DdQ8jN6Iia2PjiBvpRavVO6MJ5sWE/Ak0
 EunvuzjiyCGl33WM5jlIgmiiBirFkANCeOmRznp2o2z6go9JHfWzw1dmDvEFJVgx/rocZVvE/
 aakblh/8LiNyZX0xROFhogNi15s7r0akr/y6QDWGUe8fKAsf0ze8qMRmP3Uf1RHaav2U8PGxQ
 nE1ybS31tVSAw1T7WQLpMHttgW4jozizE2sf2ljjuxJ1N/oKW6dUMSmtm7xtb2qEDoB0dKMPx
 pSYzZFDf/ocznO6Vvw6coB42Y7EIfzxoJer6NHWbCMzIkLJBd1Hgd0Iv8+T0oLXt/dDCrxl6W
 9R0SK4PXNAtYjNVlxjKs4UTn0N1Orren8hs39ON3yJOzygWZ8clBkjW9Hybc1MGcGFDRV0ji/
 r3+SgS4MDYpRMuTDXTGbSLrVLRMpQmpthUOG288vQRbNZ+iqOO6MIyJ0wfXxCMsdbWxzbQlk/
 e2h9aHLoOEcA/ZuUbXuoaVIlUjFrN2b+uhAwbFNZkoj3dKeXsGio0geXYzTfvhXBCltBEX5e5
 EufAS+9E6c/Eee2B52GCN3NB30stGkFlozUVrW4YLk8OQa8umua5LmzTRDPOm5shRLExRTUc8
 HAip8ORNPDHYiA3GZtCSevlQFvgCYmilSZ41wdjlitiCMpympt1CVFvP5wz8GwifgxGRi5/ET
 ut/onhy8TyN2rcgKAzX/Vq52MUUyjVcYbJM0JpSHe+JwQbXzjYv9eMI1E0wDtRxYYnSPjFCyY
 /50tsqzf56qll973aCXN2WuuLKa0yw6KCh1LokQsJUHdTr6eGJUKHgl8Vc9tFm8XCkaPc6bZE
 890i9DsP7cOzzgfwVXeZFrZHX27IZcXHUWV/PihdnjMCPVFm2gEJ62VGSXgrSyQfFMc8lR+Ir
 S4B+tvFOZ9lAFp6RbKjC+lezNna3SORSe5mH/7HRzQNlBNcLUdyYWVLUuzLJStK/HUZBsRbNt
 NjFZqnWb9sqYXhAk4nl8sbf3abAXZZgAiph
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Converting report_filterlist_lock to raw_spinlock_t lets RT report
problem free, but makes allocations in insert_report_filterlist()
problematic.  Solve that via unlock, allocate, relock and restart.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/kcsan/debugfs.c |   62 +++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 43 insertions(+), 19 deletions(-)

=2D-- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -53,7 +53,7 @@ static struct {
 	.sorted		=3D false,
 	.whitelist	=3D false,	/* default is blacklist */
 };
-static DEFINE_SPINLOCK(report_filterlist_lock);
+static DEFINE_RAW_SPINLOCK(report_filterlist_lock);

 /*
  * The microbenchmark allows benchmarking KCSAN core runtime only. To run
@@ -110,7 +110,7 @@ bool kcsan_skip_report_debugfs(unsigned
 		return false;
 	func_addr -=3D offset; /* Get function start */

-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	if (report_filterlist.used =3D=3D 0)
 		goto out;

@@ -127,7 +127,7 @@ bool kcsan_skip_report_debugfs(unsigned
 		ret =3D !ret;

 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 	return ret;
 }

@@ -135,9 +135,9 @@ static void set_report_filterlist_whitel
 {
 	unsigned long flags;

-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	report_filterlist.whitelist =3D whitelist;
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
 }

 /* Returns 0 on success, error-code otherwise. */
@@ -146,36 +146,60 @@ static ssize_t insert_report_filterlist(
 	unsigned long flags;
 	unsigned long addr =3D kallsyms_lookup_name(func);
 	ssize_t ret =3D 0;
+	int is_rt =3D IS_ENABLED(CONFIG_PREEMPT_RT);

 	if (!addr) {
 		pr_err("could not find function: '%s'\n", func);
 		return -ENOENT;
 	}

-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	if (is_rt && !preemptible())
+		return -ENOMEM;
+
+repeat:
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);

 	if (report_filterlist.addrs =3D=3D NULL) {
-		/* initial allocation */
-		report_filterlist.addrs =3D
-			kmalloc_array(report_filterlist.size,
+		unsigned long *array;
+		if (is_rt)
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+		array =3D kmalloc_array(report_filterlist.size,
 				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs =3D=3D NULL) {
+		if (is_rt)
+			raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+		if (!array) {
 			ret =3D -ENOMEM;
 			goto out;
 		}
+		if (is_rt && report_filterlist.addrs !=3D NULL)  {
+			/* Someone beat us to it, move along to size check. */
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(array);
+			goto repeat;
+		}
+		report_filterlist.addrs =3D array;
 	} else if (report_filterlist.used =3D=3D report_filterlist.size) {
 		/* resize filterlist */
-		size_t new_size =3D report_filterlist.size * 2;
-		unsigned long *new_addrs =3D
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
-
+		size_t old_size =3D report_filterlist.size;
+		size_t new_size =3D old_size * 2;
+		unsigned long *new_addrs;
+		if (is_rt)
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+		new_addrs =3D krealloc(report_filterlist.addrs,
+				     new_size * sizeof(unsigned long), GFP_ATOMIC);
+		if (is_rt)
+			raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 		if (new_addrs =3D=3D NULL) {
 			/* leave filterlist itself untouched */
 			ret =3D -ENOMEM;
 			goto out;
 		}
-
+		if (is_rt && report_filterlist.size !=3D old_size) {
+			/* Someone else resized while we were unlocked, recheck. */
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(new_addrs);
+			goto repeat;
+		}
 		report_filterlist.size =3D new_size;
 		report_filterlist.addrs =3D new_addrs;
 	}
@@ -186,7 +210,7 @@ static ssize_t insert_report_filterlist(
 	report_filterlist.sorted =3D false;

 out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);

 	return ret;
 }
@@ -204,13 +228,13 @@ static int show_info(struct seq_file *fi
 	}

 	/* show filter functions, and filter type */
-	spin_lock_irqsave(&report_filterlist_lock, flags);
+	raw_spin_lock_irqsave(&report_filterlist_lock, flags);
 	seq_printf(file, "\n%s functions: %s\n",
 		   report_filterlist.whitelist ? "whitelisted" : "blacklisted",
 		   report_filterlist.used =3D=3D 0 ? "none" : "");
 	for (i =3D 0; i < report_filterlist.used; ++i)
 		seq_printf(file, " %ps\n", (void *)report_filterlist.addrs[i]);
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);

 	return 0;
 }


