From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH][RT] - Mismatching declaration and export
Date: Wed, 22 Apr 2009 11:01:09 +0200
Message-ID: <20090422090109.GC2479@pengutronix.de>
References: <1240338205.13601.17.camel@quadrophenia.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44642 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752369AbZDVJBM (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 22 Apr 2009 05:01:12 -0400
Content-Disposition: inline
In-Reply-To: <1240338205.13601.17.camel@quadrophenia.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

On Tue, Apr 21, 2009 at 11:23:25AM -0700, Sven-Thorsten Dietrich wrote:
> Subject: Make function declaration match EXPORT()
> -unsigned long __lockfunc _spin_lock_irqsave_nested(spinlock_t *lock,=
 int subclass)
> +unsigned long __lockfunc __spin_lock_irqsave_nested(spinlock_t *lock=
, int subclass)

	ukl@octopus:~/gsrc/linux-2.6$ git show v2.6.29.1-rt8:kernel/spinlock.c=
 | sed -n -e '357,376p'
	unsigned long __lockfunc __spin_lock_irqsave_nested(raw_spinlock_t *lo=
ck, int subclass)
	{
		unsigned long flags;

		local_irq_save(flags);
		preempt_disable();
		spin_acquire(&lock->dep_map, subclass, 0, _RET_IP_);
		/*
		 * On lockdep we dont want the hand-coded irq-enable of
		 * _raw_spin_lock_flags() code, because lockdep assumes
		 * that interrupts are not re-enabled during lock-acquire:
		 */
	#ifdef CONFIG_LOCKDEP
		LOCK_CONTENDED(lock, _raw_spin_trylock, _raw_spin_lock);
	#else
		_raw_spin_lock_flags(lock, &flags);
	#endif
		return flags;
	}
	EXPORT_SYMBOL(__spin_lock_irqsave_nested);

so this seems to be already included in 2.6.29.1-rt8.  Where is it
missing?

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
