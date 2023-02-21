Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9163C636D7
	for <linux-rt-users@archiver.kernel.org>; Tue, 21 Feb 2023 16:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233858AbjBUQQf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjBUQQe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 21 Feb 2023 11:16:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906DA2B2AD
        for <linux-rt-users@vger.kernel.org>; Tue, 21 Feb 2023 08:16:27 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1676996186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUoaKZPiBlB28m/DTeiI2bitW8/6n3bVShBxamKV3uY=;
        b=zHBzoV5l1lJ3ZjlXVZg/TxSE1Wt3HLwilgoIU+p2E9u98/r/zwFbtynlPiMldfCWG+rdr+
        j8jdGbgXcPm9KQjLs+tVmbVuSrPoVlMoy0qRfYmRwX/gCpO408H5qyzZyA8PwZfkEiTQYG
        xoNoa1Q3JZ+O23gybzbaf49XEfj7Ysl8u/dfnqDccAjMhQzKmpEJRCCqnf42gIOvL2pLJS
        N8K/U53XjXg9zJjP/RPNwleJaLsQuZJmask8AYfnqIJQ9LcQQbQkZvzeF+37vYxLGQMYoT
        vd3JWBKuocxp7WXEV5J/sLusaR1ezahc5GkGP8OEXa0hO94CZzVY0aAeJGucwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1676996186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VUoaKZPiBlB28m/DTeiI2bitW8/6n3bVShBxamKV3uY=;
        b=wO0ecSwmkRt/VRjhYBAQAYFJ1rb/wNAMk4xqQJZdoyAFQxoizRvCRS4ooiQoHUd1hbgtE4
        shXJ/b/3BuxjX9DQ==
To:     =?utf-8?Q?Andr=C3=A9?= Pribil <Andre.Pribil@hms-networks.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: [PATCH] printk/console: Enable console kthreads only when there is
 no boot console left
In-Reply-To: <87bklnro9j.fsf@jogness.linutronix.de>
References: <AM5PR10MB162013648CCFDDDC4EE42A3CBDA59@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
 <87bklnro9j.fsf@jogness.linutronix.de>
Date:   Tue, 21 Feb 2023 17:21:08 +0106
Message-ID: <878rgrro4z.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The console kthreads uncovered several races in console drivers.
All problems were in situation when a console was being properly
initialized and registered while an early console, using the same
port, was being used.

These problems are pretty hard to debug because they often result
into silent boot crashes. It would be nice to fix them but it
looks like a can of worms.

Prevent these problems by delaying the use of console kthreads
after all early consoles are gone. It might later be optimized.
But let's close this can of worms with a big hammer for now
so that they do not break first impression on the kthreads
that solve other real problems.

Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@samsun=
g.com
Reported-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
[ rebased for 5.10.165-rt81 by john.ogness ]
---
 kernel/printk/printk.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d2205872304d..db095bd0f17c 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2986,6 +2986,21 @@ void __init console_init(void)
 	}
 }
=20
+#ifdef CONFIG_PRINTK
+static int __init printk_activate_kthreads(void)
+{
+	struct console *con;
+
+	console_lock();
+	for_each_console(con)
+		printk_start_kthread(con);
+	kthreads_started =3D true;
+	console_unlock();
+
+	return 0;
+}
+#endif
+
 /*
  * Some boot consoles access data that is in the init section and which wi=
ll
  * be discarded after the initcalls have been run. To make sure that no co=
de
@@ -3002,6 +3017,7 @@ void __init console_init(void)
  */
 static int __init printk_late_init(void)
 {
+	bool no_bootcon =3D true;
 	struct console *con;
 	int ret;
=20
@@ -3023,15 +3039,20 @@ static int __init printk_late_init(void)
 			pr_warn("bootconsole [%s%d] uses init memory and must be disabled even =
before the real one is ready\n",
 				con->name, con->index);
 			unregister_console(con);
+			continue;
 		}
+
+		no_bootcon =3D false;
 	}
=20
 #ifdef CONFIG_PRINTK
-	console_lock();
-	for_each_console(con)
-		start_printk_kthread(con);
-	kthreads_started =3D true;
-	console_unlock();
+	/*
+	 * Some console drivers are not ready to use the same port with
+	 * boot (early) and normal console in parallel. Stay on the safe
+	 * side and enable kthreads only when there is no boot console.
+	 */
+	if (no_bootcon)
+		printk_activate_kthreads();
 #endif
=20
 	ret =3D cpuhp_setup_state_nocalls(CPUHP_PRINTK_DEAD, "printk:dead", NULL,
--=20
2.30.2
