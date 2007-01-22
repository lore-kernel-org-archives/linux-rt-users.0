From: Ingo Molnar <mingo@elte.hu>
Subject: Re: compilation error
Date: Mon, 22 Jan 2007 11:54:07 +0100
Message-ID: <20070122105407.GA32067@elte.hu>
References: <5114.194.65.103.1.1168943363.squirrel@www.rncbc.org> <1169461764.26596.10.camel@godzilla.tecnorama.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.mail.elte.hu ([157.181.151.9]:40441 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751447AbXAVKzH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 22 Jan 2007 05:55:07 -0500
To: Alessio Igor Bogani <abogani@texware.it>
Content-Disposition: inline
In-Reply-To: <1169461764.26596.10.camel@godzilla.tecnorama.it>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org


* Alessio Igor Bogani <abogani@texware.it> wrote:

> With this trivial patch i can compile kernel successfully:
> 
> --- intel.c.orig	2007-01-22 11:03:06.000000000 +0100
> +++ intel.c	2007-01-22 11:03:36.000000000 +0100
> @@ -6,6 +6,7 @@
>  #include <linux/smp.h>
>  #include <linux/thread_info.h>
>  #include <linux/module.h>
> +#include <linux/paravirt.h>
>  
>  #include <asm/processor.h>
>  #include <asm/msr.h>
> 
> But i don't know if it is the best way to resolve this problem.

that's the best way i think - i've applied your patch.

	Ingo
