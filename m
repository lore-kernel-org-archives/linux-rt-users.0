From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [4.4.4-rt11] Possiblie recursive locking detected in kswapd /
 mb_cache_shrink_scan()
Date: Tue, 29 Mar 2016 17:04:44 +0200
Message-ID: <20160329150444.GD13334@linutronix.de>
References: <20160314210058.GE29798@uudg.org>
 <alpine.DEB.2.11.1603190933150.3978@nanos>
 <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Gleixner <tglx@linutronix.de>,
	"Luis Claudio R. Goncalves" <lclaudio@uudg.org>,
	linux-rt-users@vger.kernel.org
To: Josh Cartwright <joshc@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:58441 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757166AbcC2PEt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Mar 2016 11:04:49 -0400
Content-Disposition: inline
In-Reply-To: <20160321144016.GA31276@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Josh Cartwright | 2016-03-21 09:40:16 [-0500]:

>diff --git a/include/linux/list_bl.h b/include/linux/list_bl.h
>index 44f0b55..d13428a 100644
>--- a/include/linux/list_bl.h
>+++ b/include/linux/list_bl.h
>@@ -42,13 +42,18 @@ struct hlist_bl_node {
> 	struct hlist_bl_node *next, **pprev;
> };
>=20
>-static inline void INIT_HLIST_BL_HEAD(struct hlist_bl_head *h)
>-{
>-	h->first =3D NULL;
> #ifdef CONFIG_PREEMPT_RT_BASE
>-	raw_spin_lock_init(&h->lock);
>+#define INIT_HLIST_BL_HEAD(h)		\
>+do {					\
>+	(h)->first =3D NULL;		\
>+	raw_spin_lock_init(&(h)->lock);	\
>+} while (0)
>+#else
>+#define INIT_HLIST_BL_HEAD(h)		\
>+do {					\
>+	(h)->first =3D NULL;		\
>+} while (0)
> #endif
>-}

So we use a macro instead a "static inline" to ensure we end up with
another lockdep class? This surprises me because it would mean that the
function wasn't inlined / key classed was re-used.
Looking at the assembly I see:

|ffffffff8121fb41:       48 c7 c2 e0 bb d6 82    mov    $0xffffffff82d6=
bbe0,%rdx
|ffffffff8121fb48:       48 89 df                mov    %rbx,%rdi
|ffffffff8121fb4b:       48 c7 c6 30 2b a2 81    mov    $0xffffffff81a2=
2b30,%rsi
|ffffffff8121fb52:       e8 a9 0e e9 ff          callq  ffffffff810b0a0=
0 <__raw_spin_lock_init>
=E2=80=A6
|ffffffff8121fc12:       48 c7 c2 d0 bb d6 82    mov    $0xffffffff82d6=
bbd0,%rdx
|ffffffff8121fc19:       48 c7 c6 7b 2e a3 81    mov    $0xffffffff81a3=
2e7b,%rsi
|ffffffff8121fc20:       48 c7 07 00 00 00 00    movq   $0x0,(%rdi)
|ffffffff8121fc27:       48 83 c7 08             add    $0x8,%rdi
|ffffffff8121fc2b:       e8 d0 0d e9 ff          callq  ffffffff810b0a0=
0 <__raw_spin_lock_init>

rdx holds the third parameter and it is different. What do I miss?
Was the rdx argument in Luis' case the same before this path was
applied?

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
