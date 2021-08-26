Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A23C432BE
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C59360EBC
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Aug 2021 15:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242926AbhHZPnU (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Aug 2021 11:43:20 -0400
Received: from mout.gmx.net ([212.227.15.19]:52563 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232592AbhHZPnU (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Aug 2021 11:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629992541;
        bh=69hBQ9BR1UIaSfDdeIIEfoexQUCp4u3EO3TylTaT3UI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=bLQbAKnw0d5JLGiq6Og3LQiyOJRU/J1NBrVD/e6CDkU2mQV1Ym8fYL01+UHYPni3E
         HS9lM8dHXc4TP4mHlE8CklWbQqm4Fgk2KOqsEPsa/HA031floNyoygdXXjJfxmK3AA
         EglDVlCvdzvbUcOcbKDwfqt29N+GAY2ZGnTYCJa4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MkHMZ-1mlRXY2q7t-00kfVK; Thu, 26
 Aug 2021 17:42:21 +0200
Message-ID: <f6c40d238a1990a4649ec848a67aae88846505ab.camel@gmx.de>
Subject: Re: [patch] kcsan: Make it RT aware
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Thu, 26 Aug 2021 17:42:21 +0200
In-Reply-To: <20210826151827.wvsm7civflz62olx@linutronix.de>
References: <dc0cb448d46f465bb0064b1c301cb0b3ab4f8492.camel@gmx.de>
         <34f1e1dadb2c3d19389427303da6ea53e321e726.camel@gmx.de>
         <86f35f7c-c545-d870-b36e-5d091799f54c@suse.cz>
         <20210826151827.wvsm7civflz62olx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bJZiYppB3xzp1LeJy7oYMoApBAvqZNFpcOXJu5Rd/adcUTwa4aA
 hsBF7StMkjjHIDkNU8+g4rGSUIPwcmvZdRP0Z/PV+kj8YYo1uZFt95KLTTjzQsmgEgYDoEH
 2hNrJ3kIrhiuFCwmSvVWfCxAuEroxIKYmmyfJZGWkUXEUa5Lpo10Zy4Ql92aC+n8ZzWo9Dc
 aDCJWwwrn3YL9nBUQazlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XQRgU/zYCBk=:zRUomsLGtBi9JynNp3wovl
 2v0qo0e/zVmt27u+04Dy6V5WpIzOqNqaPL9a4G7T2geoOGWZWLKm8YqjdmO1qHj0iY6I++pId
 gL0M/et2QAy7PNiN90RbAiSH+G93w34Zy6WD79v1ojbcZWagV7E9xA+j+FTrhuJh5iS6wUeuW
 JHJH59kA6/XcnJ7g6DRHKdZiQZkY0cVrsk6Hzi9PCH1HSBhh8Vna6cVjeLmN5z165hoKmlsPw
 bH9PqIRBAUugFM2FVnIZtvhqde+uyQCrusQrpiwMxJqrumBzxhdzzbdJtrCahLNhXAbNDxQUX
 CZwZv9qI4Oe/fs1LRG3Fip5MO5jJolcSXW6e6ejBSQsODKANrxFP2oRz/XvDhpaf3lYMCbqpS
 Zl8v8AIwQMGW/ZxXi+DwoFnyecqHtxEaY+Ey3ljJ2IBvhITYTA466ip6JG806NpI3oaWA/t7H
 EMQ+iYKuKTznth/6o7Gwr3UGXdJVeXl6DTNqFD1sBMQi4cR3qTz3iUk/4u4zc9/S/iqx7sOzT
 co63tvkWGNVazSi5v+dHo9fzVXDp6drIE0pTxFkHE6rO0FK8cqeYcQFIvUbglgEpk4nD3ZXEd
 twkGP8QmvAaWCrHERQansmYkvvhGo0tIekH6bPWiBsNhPBhX07k556qD6+DdGWmfZw84RdT57
 RAHcjymS9qpUa74I5viuIhBsHf3gLBqhsejjyATBawwrghZKcnh/wFYG/jHFNFXh5k5EM2yCu
 AG6eCstQMKa3zp9BSeEEkSiyGL5yU9z3t7OSMp6UnOhPteqTydARHJIBDvPZJe1rOAD866u5a
 gmzK9EdSWr4cTlKjtbVhpElRLCHGfDFB+W+iEXlWm4KajAEwu7NQntZi1lvUqpZQFG+FSNH0f
 NtxdpYTa1/bQljuxNLoxk3vIM0D3eUlVeNGKCzbnI/qqWJQ6rCjTpoKndDyMrBPQ6uzOH/4vh
 mtEk/NWIwJP6a16WfjVr2WUVA78ov3zP85sEGMFGGydHX40G7dymw4Z2ydEUktLDmXD59HxWG
 +GIP4Gt0E+QxS46n1LBdmpgm5AzoQaMtBKEAa6vS+wAQm7PzWEadF9lvYW4el10jJd2Q5ocEB
 GofrSYLjy+DicbG7OzIKOy4FbvP8aAqIRUp
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 2021-08-26 at 17:18 +0200, Sebastian Andrzej Siewior wrote:
> On 2021-08-22 19:29:00 [+0200], Vlastimil Babka wrote:
> > On 8/22/21 6:35 PM, Mike Galbraith wrote:
> > > On second thought, burn both patches.=C2=A0 Making K[AC]SAN work wit=
h RT
> > > ain't worth the warts.
> >
> > The stackdepot part of kasan patch will be useful at some point.
> > slub_debug should eventually switch to stackdepot - it almost did in
> > mainline already. I'll try to remember and dig that part up when
> > needed.
> > Thanks.
>
> If you want them dropped, sure.

If you think they're worth having, feel free.  The kcsan patch I found
especially icky, and changed it like so, avoiding icky config dependent
branches while giving myself an ever so tiny excuse for looping ;-)

kcsan: Make it RT aware

Converting report_filterlist_lock to raw_spinlock_t lets RT report
problem free, but makes allocations in insert_report_filterlist()
problematic.  Solve that by taking the lock after allocation.  That
means all configs must check that the situation didn't change while
acquiring if we're to avoid ugly config specific branches, but it
also removes the need for GFP_ATOMIC allocations.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 kernel/kcsan/debugfs.c |   74 +++++++++++++++++++++++++++++--------------=
------
 1 file changed, 45 insertions(+), 29 deletions(-)

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
@@ -145,39 +145,56 @@ static ssize_t insert_report_filterlist(
 {
 	unsigned long flags;
 	unsigned long addr =3D kallsyms_lookup_name(func);
-	ssize_t ret =3D 0;

 	if (!addr) {
 		pr_err("could not find function: '%s'\n", func);
 		return -ENOENT;
 	}

-	spin_lock_irqsave(&report_filterlist_lock, flags);
-
+repeat:
 	if (report_filterlist.addrs =3D=3D NULL) {
 		/* initial allocation */
-		report_filterlist.addrs =3D
-			kmalloc_array(report_filterlist.size,
-				      sizeof(unsigned long), GFP_ATOMIC);
-		if (report_filterlist.addrs =3D=3D NULL) {
-			ret =3D -ENOMEM;
-			goto out;
+		unsigned long *array =3D kmalloc_array(report_filterlist.size,
+				    		     sizeof(unsigned long),
+						     GFP_KERNEL);
+		if (array =3D=3D NULL)
+			return -ENOMEM;
+		raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+		if (report_filterlist.addrs !=3D NULL)  {
+			/* Someone beat us to it, move along to resize check. */
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(array);
+			goto repeat;
 		}
+		report_filterlist.addrs =3D array;
 	} else if (report_filterlist.used =3D=3D report_filterlist.size) {
 		/* resize filterlist */
-		size_t new_size =3D report_filterlist.size * 2;
-		unsigned long *new_addrs =3D
-			krealloc(report_filterlist.addrs,
-				 new_size * sizeof(unsigned long), GFP_ATOMIC);
-
-		if (new_addrs =3D=3D NULL) {
-			/* leave filterlist itself untouched */
-			ret =3D -ENOMEM;
-			goto out;
+		size_t old_size =3D report_filterlist.size;
+		size_t new_size =3D old_size * 2;
+		unsigned long *new_addrs =3D krealloc(report_filterlist.addrs,
+						    new_size * sizeof(unsigned long),
+						    GFP_KERNEL);
+		if (new_addrs =3D=3D NULL)
+			return -ENOMEM;
+		raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+		if (report_filterlist.size !=3D old_size) {
+			/* Someone else resized, recheck space availability. */
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			kfree(new_addrs);
+			goto repeat;
 		}
-
 		report_filterlist.size =3D new_size;
 		report_filterlist.addrs =3D new_addrs;
+	} else {
+		/*
+		 * spekulatively, all looked fine, but we now must both take the
+		 * lock and verify space availability before proceeding.
+		 */
+		raw_spin_lock_irqsave(&report_filterlist_lock, flags);
+		if (report_filterlist.used =3D=3D report_filterlist.size) {
+			raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);
+			goto repeat;
+		}
 	}

 	/* Note: deduplicating should be done in userspace. */
@@ -185,10 +202,9 @@ static ssize_t insert_report_filterlist(
 		kallsyms_lookup_name(func);
 	report_filterlist.sorted =3D false;

-out:
-	spin_unlock_irqrestore(&report_filterlist_lock, flags);
+	raw_spin_unlock_irqrestore(&report_filterlist_lock, flags);

-	return ret;
+	return 0;
 }

 static int show_info(struct seq_file *file, void *v)
@@ -204,13 +220,13 @@ static int show_info(struct seq_file *fi
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




