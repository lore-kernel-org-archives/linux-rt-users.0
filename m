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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA45C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9485361373
	for <linux-rt-users@archiver.kernel.org>; Tue, 24 Aug 2021 11:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhHXLJV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 24 Aug 2021 07:09:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:41787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236698AbhHXLJJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 24 Aug 2021 07:09:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1629803295;
        bh=/vYG/7FmyblrZg8I14/fEHa5jbxMHo8Sir5J9h4tO9E=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=TaaVm2UnSbaq3gmHa4Wz53HUkN26r8G9XfS10cj54tpQVgqPkvEYi4FK1usEcTTms
         hEP1guHs4XlP2rNNoShDRsFa75ip/LUY2rEW3GYA0w6CtW6bSo8LmNfsdi5Wus0pFe
         cubN8xURHQDaFGEztYh6xbEiAZh0TCP12qFjiKDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([212.114.172.232]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUGe1-1mS4h33tND-00RIBb; Tue, 24
 Aug 2021 13:08:14 +0200
Message-ID: <70cc66840bbd9446061fc40088575565d8d98e37.camel@gmx.de>
Subject: [patch] mm, zsmalloc: Convert zsmalloc_handle.lock to spinlock_t
From:   Mike Galbraith <efault@gmx.de>
To:     linux-rt-users@vger.kernel.org
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>
Date:   Tue, 24 Aug 2021 13:08:14 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H/rxWSAU+XJXDsZAIPfZzjJsN/xsi4HdOpb52URgHsSDhAWIfBb
 riP9gmmjTrpBDNsia3Rg9meKS3305SCqAlwyywCtZQNC8vmBI+0KCAW1uGy7vUUfPjyhPoU
 kYG409rD83TYy92lejEQs3RN5kQ9HtOOmaj/hiEqXOnZOjF6Hu5UAry3TwHx5KYy9jSQBcj
 pBqMJ1+pkVjEZxUSXuo6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fDx2MKSjy3o=:9o8qhiNL1B4VGE2RQI7HHV
 qSa058V81osOLXONZKDlFJpD8Bi2RvOgWpFhyc77cYLb+hU7QVx4+PP+W+ZJm6d9n7mr3ByTY
 9dJ8wJvGKmlNL1inyTczu88URlmzvbaZM5FY+/DpwRx3lFz/ouPyUee3starIAJQYFqtyMnKx
 2NrghRTMi9743lJza1Srr5IAi5SUSwHfwHN4vXr0HKDclO86J1JvHr57vpHHubGc7Fh4+yWUg
 dUemPLABcRF3+wsEb4rjx4nH6OmjiGD1NnON3NH8uOzR6WsRzwgLf5wOBxXLQy9Hay8wyYLkO
 vROLW23K5mW/g40KsF/O14mGD45okVqaFG6tnNrRm3NEIot6R4qmggt+NWwjCU1yJyl7Eixve
 MdDVBfyAChH1Ro+YOPUzC8oomGZwbhidoPLl7zQv23fEOcXzUAmWVZhmtJF72BgxX4ggsNIwv
 nuS4QEVJw5Vb5MsnvkGjMvqyShDrtSqoqhMrniIb04niZRWrNqG45HXDA1pkrY7de0wX5itoK
 +ZlMTm7ccXbxgxyxJ0SWF4C88pUQO9pqsDev8tYPbnaz51N7vV1otzDb9JXnP3e7svEFxYs8T
 SxB8lMx0qhbh2O7HZL2V6T9TpBIzq5zBO0hrhPzEDduNmyYZGXRW9koGn0F7pXhZ4rnx3Dnxv
 MyzZfnR4tEQ38D6xiwfWd1J69X9ydpsdu/YyDtKF8/QNRV0FJ++l8CRsm+mUetzgj6C8G+36f
 fmfGwZTvmyedMZyzFmygD0ffQYg32nFnZFu2mdfi+VHYdC6AJ3mNs/6GRPmM3JcRCK/5XME2r
 KW0PoPto9u7CviAAYEUMbHc8ZDXtKMn3dm8doY6xBS0R+sLbPYJI0D8zJfOhD6Kt65O7MCHD9
 rATmBEwAHb7VVV2SivW398zshS14YBqczLCufgpoOjoXmUjBx9cMB4s2/fWsZdyEHm8q/naxO
 rFyKpG6WkpQAjm+IJwhaTdVc/FA96Hw0394xWNHlP4vVNIpZIWogEOM0K0muvzyIZM3JdgTr5
 dB2f+n3o1UNTkJe7uBecglGPm+rJpXYAbWoHgQbzAvxu2qR7X+diociQwNJga4Bjj6t5PyAPG
 lS3nu0mIWplQZjHBlx57lmRMe9Z5qzmMZYL
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


local_lock_t becoming a synonym of spinlock_t had consequences for the RT
mods to zsmalloc, which were taking a mutex while holding a local_lock,
inspiring a lockdep "BUG: Invalid wait context" gripe.

Converting zsmalloc_handle.lock to a spinlock_t restored lockdep silence.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 mm/zsmalloc.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

=2D-- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -82,7 +82,7 @@

 struct zsmalloc_handle {
 	unsigned long addr;
-	struct mutex lock;
+	spinlock_t lock;
 };

 #define ZS_HANDLE_ALLOC_SIZE (sizeof(struct zsmalloc_handle))
@@ -370,7 +370,7 @@ static unsigned long cache_alloc_handle(
 	if (p) {
 		struct zsmalloc_handle *zh =3D p;

-		mutex_init(&zh->lock);
+		spin_lock_init(&zh->lock);
 	}
 #endif
 	return (unsigned long)p;
@@ -927,7 +927,7 @@ static inline int testpin_tag(unsigned l
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh =3D zs_get_pure_handle(handle);

-	return mutex_is_locked(&zh->lock);
+	return spin_is_locked(&zh->lock);
 #else
 	return bit_spin_is_locked(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -938,7 +938,7 @@ static inline int trypin_tag(unsigned lo
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh =3D zs_get_pure_handle(handle);

-	return mutex_trylock(&zh->lock);
+	return spin_trylock(&zh->lock);
 #else
 	return bit_spin_trylock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -949,7 +949,7 @@ static void pin_tag(unsigned long handle
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh =3D zs_get_pure_handle(handle);

-	return mutex_lock(&zh->lock);
+	return spin_lock(&zh->lock);
 #else
 	bit_spin_lock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif
@@ -960,7 +960,7 @@ static void unpin_tag(unsigned long hand
 #ifdef CONFIG_PREEMPT_RT
 	struct zsmalloc_handle *zh =3D zs_get_pure_handle(handle);

-	return mutex_unlock(&zh->lock);
+	return spin_unlock(&zh->lock);
 #else
 	bit_spin_unlock(HANDLE_PIN_BIT, (unsigned long *)handle);
 #endif


