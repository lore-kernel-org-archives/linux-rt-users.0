From: Ingo Molnar <mingo@elte.hu>
Subject: Re: PI mutex support on ARM
Date: Sun, 8 Jul 2007 11:58:41 +0200
Message-ID: <20070708095841.GA4601@elte.hu>
References: <3efb10970707080124i7a9323c5o9257b4adcb2ac493@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-rt-users@vger.kernel.org
To: linux@bohmer.net
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:39998 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753155AbXGHJ6s (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 8 Jul 2007 05:58:48 -0400
Content-Disposition: inline
In-Reply-To: <3efb10970707080124i7a9323c5o9257b4adcb2ac493@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Remy Bohmer <l.pinguin@gmail.com> wrote:

> --- linux-2.6.21.orig/include/asm/futex.h	2007-04-26 05:08:32.000000000 +0200

patch format problem: never diff the asm/ files, diff the asm-arm/ 
files.

> +	local_irq_save(flags);
> +
> +	err = get_user(uval, uaddr);

is it safe to do a get_user() with irqs off?

> +	if (err)
> +	{
> +		local_irq_restore(flags);
> +		 return -EFAULT;
> +	}

(style problems. Use scripts/checkpatch.pl to verify your patches.)

> +	local_irq_restore(flags);

is this method of atomic ops SMP-safe?

	Ingo
