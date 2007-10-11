From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] RT: fix spin_trylock_irq
Date: Thu, 11 Oct 2007 10:49:14 -0400 (EDT)
Message-ID: <Pine.LNX.4.58.0710111046170.20114@gandalf.stny.rr.com>
References: <20071011142417.1d965820@bull.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>,
	Linux RT Users <linux-rt-users@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Daniel Walker <dwalker@mvista.com>
To: =?UTF-8?B?U8OpYmFzdGllbiBEdWd1w6k=?= <sebastien.dugue@bull.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:52997 "EHLO
	ms-smtp-04.nyroc.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751748AbXJKOub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2007 10:50:31 -0400
In-Reply-To: <20071011142417.1d965820@bull.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



--
When I'm asked what language is my mother tongue,
I simply answer "C".

On Thu, 11 Oct 2007, [UTF-8] S=C3=A9bastien Dugu=C3=A9 wrote:

> ---
>  include/linux/spinlock.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Index: linux-2.6.23-rc9-rt2/include/linux/spinlock.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.23-rc9-rt2.orig/include/linux/spinlock.h
> +++ linux-2.6.23-rc9-rt2/include/linux/spinlock.h
> @@ -501,7 +501,7 @@ do {									\
>
>  #define spin_trylock_irq(lock)	\
>  	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irq,		\
> -		__spin_trylock_irq, lock))
> +		_spin_trylock_irq, lock))
>
>  #define spin_trylock_irqsave(lock, flags) \
>  	__cond_lock(lock, PICK_SPIN_OP_RET(__spin_trylock_irqsave, 	\

Thanks! Applied.

Daniel, this BUG was introduced by your conversion to PICK_FUNCTION pat=
ch.
Please be more careful, and do an audit of your patch. (I don't have ti=
me
ATM). This could also be the source of other bugs I've been chasing.

I might be pulling the PICK_FUNCTION patches if there's more bugs like
this.

-- Steve
