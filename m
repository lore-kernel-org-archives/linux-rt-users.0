Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AC93F9F56;
	Tue, 25 Aug 2026 10:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654723; cv=none; b=DLTnjA9YIvmAkB1o+q7sCgrx1RlphxYo8miqWL1a9eeKU7EzR4GcTTvBNiCfalzFOd7h2vfA7xiv/E3z2uF6/NFD64xSJDM+CeHf+4GXNeYUrYi82LkSyh+/tSJA46T07ttz97JdJRN5DgXZhFd7qWl8itjmjje9xMEHZ9cA5CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654723; c=relaxed/simple;
	bh=qKCQvCME2VqkF5supqan4719ajfypRuDAyUw+pvUtsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UlywwFJ12Pyv/CIR3F534UNtcj7rNQm4YeiHFbyZrAJtj7Kx8ajPZGaLF4zVRQcWxUNUdFEIXtzV6xllMpa1z7KwU2ct42uS+exWa4ONddqfKQ/YYIeHYS/rIIm7e3jXw7PoE37DMsgmFik8aNjL8T5xOzHTCi2GJ9C4AcsIql4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PIWDfvND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20n4dRpK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PIWDfvND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20n4dRpK"
Date: Tue, 25 Aug 2026 12:45:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787654719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbTkMM3jsjR+dul+fQnFF90wf4wnxrMhG53g5wbiQis=;
	b=PIWDfvND1+cgGHxGsFT9KqIF3hYP9PW3tnBus8sKDu/rov+C6gIbvUmdwJ/FeGQBbiysMN
	kA7AUFP2SiglH7cyfjFFkc51c95Fx9pMn+YpvCpQ6lTUO8BF/+GYxrI3VTxsUiD2QqUmeV
	2lVw4F1OgpF23HRZ41qBYlfKd3UvEro4y/pt0aAZ6ZZA+IMjjn1lwAdekGV1H1L0ZwirIR
	DUHgRBnKky5jvv9migZRmTlOsNy//VixCgibE/EjxzjYrBfAlEmGPj9juGWZEqe9nllS6D
	7bJ06pIUrl9p1X54LQ69KK37y1jVss3e/GcP/zUhRUM+gxtxS85lRyDIloAcOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787654719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nbTkMM3jsjR+dul+fQnFF90wf4wnxrMhG53g5wbiQis=;
	b=20n4dRpK9D7ayo5bPJDqW/IlmpSQSNNy8pxF8g6R4WkPHGp9V4KV5FiSwucMM3aZZZA8lL
	AKHbNuTGfGh3i5Dw==
From: "Ahmed S. Darwish" <darwi@linutronix.de>
To: Mike Schanne <mschanne@kns.com>
Cc: "'gregkh@linuxfoundation.org'" <gregkh@linuxfoundation.org>,
	'LKML' <linux-kernel@vger.kernel.org>,
	"'linux-rt-devel@lists.linux.dev'" <linux-rt-devel@lists.linux.dev>,
	'linux-rt-users' <linux-rt-users@vger.kernel.org>,
	'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>,
	'Thomas Gleixner' <tglx@linutronix.de>,
	'Steven Rostedt' <rostedt@goodmis.org>,
	"'chris.packham@alliedtelesis.co.nz'" <chris.packham@alliedtelesis.co.nz>,
	Todd Leitzel <tleitzel@kns.com>
Subject: Re: [PATCH] uio: eliminate extraneous irq thread under
 CONFIG_PREEMPT_RT
Message-ID: <ao1yPl-FiYjMV20u@lx-t490>
References: <TY0PR0101MB48676D503A7F6C5CAC112B3BD2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TY0PR0101MB48676D503A7F6C5CAC112B3BD2A52@TY0PR0101MB4867.apcprd01.prod.exchangelabs.com>

On Wed, 19 Aug 2026, Mike Schanne wrote:
> @@ -1038,8 +1042,13 @@ int __uio_register_device(struct module *owner,
>                  * FDs at the time of unregister and therefore may not be
>                  * freed until they are released.
>                  */
> -               ret = request_threaded_irq(info->irq, uio_interrupt_handler, uio_interrupt_thread,
> -                                          info->irq_flags, info->name, idev);
> +               if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> +                       ret = request_irq(info->irq, uio_interrupt_handler,
> +                               info->irq_flags, info->name, idev);
> +               } else {
> +                       ret = request_threaded_irq(info->irq, uio_interrupt_handler, uio_interrupt_thread,
> +                               info->irq_flags, info->name, idev);
> +               }
>

There should be a better way to do this.

The whole point of PREEMPT_RT is not to add random conditionals like that
inside drivers code.

Thanks,
Ahmed
