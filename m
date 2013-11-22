From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] drop recursive migrate_disable in
 rt_write_trylock_irqsave
Date: Fri, 22 Nov 2013 18:15:55 +0100
Message-ID: <20131122171555.GH8698@linutronix.de>
References: <20131120102107.GA12022@opentech.at>
 <20131122044439.GC31849@opentech.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andreas Platschek <platschek@ict.tuwien.ac.at>
To: Nicholas Mc Guire <der.herr@hofr.at>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:46308 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113Ab3KVRP6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 22 Nov 2013 12:15:58 -0500
Content-Disposition: inline
In-Reply-To: <20131122044439.GC31849@opentech.at>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

* Nicholas Mc Guire | 2013-11-22 05:44:39 [+0100]:

> rt_write_trylock_irqsave unconditionally calls rt_write_trylock which=
 will
> disable migration if the lock was sucessfully acquired.
> This patch drops the recursive migrate_disable/enable in
> rt_write_trylock_irqsave and rt_write_unlock_irq respecttively
>
> No change of functionality

I think you change functionality because you remove code. If you would
cut a big function into two small functions then I would agree that the
functionality has not been changed. But=E2=80=A6

>index 9a5fe26..f6c7612 100644
>--- a/include/linux/rwlock_rt.h
>+++ b/include/linux/rwlock_rt.h
>@@ -105,7 +105,6 @@ extern void __rt_rwlock_init(rwlock_t *rwlock, cha=
r *name, struct lock_class_key
> 		typecheck(unsigned long, flags);	\
> 		(void) flags;				\
> 		rt_read_unlock(lock);			\
>-		migrate_enable();			\
> 	} while (0)

You are removing that from read_unlock_irqrestore() instead of
write_unlock_irqrestore() which comes next:

>=20
> #define write_unlock_irqrestore(lock, flags) \
>diff --git a/kernel/rt.c b/kernel/rt.c
>index 4b2c4a9..71d26a4 100644
>--- a/kernel/rt.c
>+++ b/kernel/rt.c
>@@ -196,10 +196,8 @@ int __lockfunc rt_write_trylock_irqsave(rwlock_t =
*rwlock, unsigned long *flags)
> 	int ret;
>=20
> 	*flags =3D 0;
>-	migrate_disable();
> 	ret =3D rt_write_trylock(rwlock);
>-	if (!ret)
>-		migrate_enable();
>+

The amount of users of rt_write_trylock_irqsave() is so small that
nobody noticed this bug:

 write_trylock_irqsave()
  ->rt_write_trylock_irqsave()
  -> m_d()
    -> rt_write_trylock()
    -> m_d()

That means we called migrate_disable() twice. Now comes the unlock path=
:
 write_unlock_irqrestore()
  -> rt_write_unlock()
  -> m_e()

That means migrations still needs to be enabled.

I would however prefer your optimisation where you remove the pointless
m_e() in rt_write_trylock_irqsave();

> 	return ret;
> }
> EXPORT_SYMBOL(rt_write_trylock_irqsave);

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
