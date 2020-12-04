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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C0C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Dec 2020 05:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F0922573
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Dec 2020 05:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgLDFYl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Dec 2020 00:24:41 -0500
Received: from mout.gmx.net ([212.227.15.15]:50199 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLDFYk (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Dec 2020 00:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1607059380;
        bh=MpwJa4BE2eEDWXkh3JwBOXl6KQano76AnRquRYJadGY=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=gsQ9UB7Hjs35ZGUQ4Ef+OxNQBvAVrOsrUs2houFIi5ihDwsI/Wl2POH0Muf6JTPUR
         vrjILcccztLK2X61sj2FHLZPN/d35Hmhz34noaN8pF4KuBl92lKC3QIC6gJUzKcX3a
         zFcKzjBr3kAsM9pT3KZ7Uxy0mDHEhfK7Tu31AZmE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.149.242]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N5G9n-1k3hri3VUz-011EtB; Fri, 04
 Dec 2020 06:22:59 +0100
Message-ID: <faa33cc485728cdbe587f61934c3740e4b9e0d5a.camel@gmx.de>
Subject: [patch] mm,zswap: fix zswap::zswap_comp.lock vs
 zsmalloc::zs_map_area.lock deadlock
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Fri, 04 Dec 2020 06:22:59 +0100
In-Reply-To: <03bd2c15e611d7b8bb74cf9ecb20d15fab31e067.camel@gmx.de>
References: <20201130132014.mlvxeyiub3fpwyw7@linutronix.de>
         <856b5cc2a3d4eb673743b52956bf1e60dcdf87a1.camel@gmx.de>
         <20201130145229.mhbkrfuvyctniaxi@linutronix.de>
         <05121515e73891ceb9e5caf64b6111fc8ff43fab.camel@gmx.de>
         <20201130160327.ov32m4rapk4h432a@linutronix.de>
         <fca7ecadf1bddafb7e88cbeb4a57d1464c87b044.camel@gmx.de>
         <20201202220826.5chy56mbgvrwmg3d@linutronix.de>
         <abe48cb9ab522659a05d7e41ce07317da2a85163.camel@gmx.de>
         <64ab382309c41ca5c7a601fc3efbb6d2a6e68602.camel@gmx.de>
         <345fdb33f5bc0046b80c6319e61e9ee33b83cac6.camel@gmx.de>
         <20201203094805.dhk3f7mlth3vm6ck@linutronix.de>
         <2b297170dbf98b36526f876650a2707e59d4ae92.camel@gmx.de>
         <7d4e36c78320ec01b56a12bc14ac3ddce3e26827.camel@gmx.de>
         <13b102c659c2880fcd98541a2844f0f9a028826e.camel@gmx.de>
         <f19f4df85d2469e5d186268f60be2657b7b8e99f.camel@gmx.de>
         <03bd2c15e611d7b8bb74cf9ecb20d15fab31e067.camel@gmx.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:41H7vJYhY9tNX+w64YwX2DxOF20Fc4s4xhSx0adzeIb6GfvVYYD
 4OfRvZMahmA15GIap+cRuPvQ8gOjYfk131OhVsdG/9tZVuZQptUTowxn/jdkKim5QnXbkKH
 ecO5/D6isrmL2pNsMRHZf2NzpNb3hjtozW/IiqoPGPubKpA4KNonBzRvvYDXB85+boxxro1
 H32QTAkhScHdGd4qrbErQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8I5NqiYEuj4=:dL2YFqPRY+J1JtK7cJ3qP7
 M+ptk1HpFyispRdYcBU2B3V4PyGPLADPpC+PJVF81pMUfRckGus2i597fWFn+zb8vQhd/qwJY
 S+2iVmtvPCraHCzNhRwlxfmKW9hKTS496kVyoWJg5/+aS+aBtOVJ30NtSVNUz4iAV2zCeHM0t
 y/CMXNOmBr4aK/Rh+JaQAPGxzwqpPNBXPURLvRMrmZ2i4T+JRZI4JU2Izf7J13BN5SWzezrd3
 kZIYnirVZGTY1pjWndRBnp3V9LFkvgsa5XLH2sWl0VtPDi6Cqk3ncFfAjKiQUFmfXur0OAi9q
 Nbxiwypz2hLgaLRWsP45NTY5mpKcmqIvsLtAf+VU7+zGFl5hkVhxpTvuH0qJAXHNvv7Wse9g6
 6gCUIhJ9Fronxh4dVzOqYxPQ6MgmLNQrEj13l9pSEjxDhVov6uC+xMo4WSqPzWt0xYqsRM4Ai
 xjMlp6MsgNhvynTDALs1TigIlkcCOmeZ50KWeCELhbeDuIKzeCG7v9DW3JwHQIKl8GOmXmrur
 z/5+by0+V4w3vcM8Og6rcYmr1dLqMsfnvWdVxuuC0OD0i1Xgrrt3eq5FgGSe6MnuWmMAl87X1
 E5v4pDLXTcNt6jriBLXLZLwOLvGZP+/8eLomQJHh8b89a38EHuhtJWeTz7uYskwzXeFWAwwUU
 9+FqenQEbgu0pXIDWybvXRDDbC+DKnYB3ssFeicYi9DpsYyIkuR4wl/oDrysjJvaDQUtBdpVt
 ldbGxWCraqDCIizg74KCBjC6qSmaeIgHQOkhOOEgiA1hTd/Kiqudp6RmOo4UE3JGanWHBFvf1
 lkKo/fPM2DfUv/KdL6wqNIxMNoqHZFy/MYpyB5ks54U55+xB2BOWOPG07qa3GoN86LVNEp+Se
 UB1/awhDUIx72TxUIzzA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


When zswap_comp.lock was added, zpool_map/unmap_handle() were called both =
inside and
outside of preempt disabled sections, thus zswap_comp.lock locked sections=
 when those
preempt disabled sections were removed.  With the later addition of zs_map=
_area.lock
in the zsmalloc map/unmap methods, these two locks collide in a zswap_fron=
tswap_load()
vs zswap_frontswap_store() inversion/deadlock.

Call zpool map/unmap methods in zswap_frontswap_load() under zswap_comp.lo=
ck as
they are in zswap_frontswap_store() to prevent deadlock.

Signed-off-by: Mike Galbraith <efault@gmx.de>
=2D--
 mm/zswap.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

=2D-- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1183,17 +1183,17 @@ static int zswap_frontswap_load(unsigned
 	}

 	/* decompress */
+	local_lock(&zswap_comp.lock);
 	dlen =3D PAGE_SIZE;
 	src =3D zpool_map_handle(entry->pool->zpool, entry->handle, ZPOOL_MM_RO)=
;
 	if (zpool_evictable(entry->pool->zpool))
 		src +=3D sizeof(struct zswap_header);
 	dst =3D kmap_atomic(page);
-	local_lock(&zswap_comp.lock);
 	tfm =3D *this_cpu_ptr(entry->pool->tfm);
 	ret =3D crypto_comp_decompress(tfm, src, entry->length, dst, &dlen);
-	local_unlock(&zswap_comp.lock);
 	kunmap_atomic(dst);
 	zpool_unmap_handle(entry->pool->zpool, entry->handle);
+	local_unlock(&zswap_comp.lock);
 	BUG_ON(ret);

 freeentry:

