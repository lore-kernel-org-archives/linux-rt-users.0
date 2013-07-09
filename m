From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH rt] fix "list_bl.h: make list head locking RT safe" for
 !SMP && !DEBUG_SPINLOCK
Date: Tue, 09 Jul 2013 09:39:14 +0200
Message-ID: <51DBBE22.8060403@linutronix.de>
References: <1373322392-27604-1-git-send-email-u.kleine-koenig@pengutronix.de> <51DB40BA.60607@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<u.kleine-koenig@pengutronix.de>, rostedt@goodmis.org,
	tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
	linux-rt-users@vger.kernel.org, kernel@pengutronix.de
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:56046 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753062Ab3GIHjZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 9 Jul 2013 03:39:25 -0400
In-Reply-To: <51DB40BA.60607@windriver.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/09/2013 12:44 AM, Paul Gortmaker wrote:
> On 13-07-08 06:26 PM, Uwe Kleine-K=C3=B6nig wrote:
>> and so depending on LIST_BL_LOCKMASK being one. But LIST_BL_LOCKMASK=
 is
>> only one if at least on of CONFIG_SMP and CONFIG_DEBUG_SPINLOCK are
>> defined. Without these the value returned by hlist_bl_first has the
>> zeroth bit set which likely results in a crash.
>=20
> The incorrect assumption that I made was that the bit spin locks
> still set/cleared the bit in the !SMP case.  So if we set the bit
> and the mask is zero, we get the mismatch, giving something like:
>=20
> Acked-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> Tested-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Thanks everyone.

>=20
> Thanks,
> Paul.

Sebastian
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
