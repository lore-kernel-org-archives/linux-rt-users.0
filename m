From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: ARM 920T build problems for patch-2.6.19-rt1
Date: Fri, 01 Dec 2006 17:33:17 +0100
Message-ID: <4570594D.2090900@gmail.com>
References: <200612011412.57777.ppisa4lists@pikron.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Pavel Pisa <ppisa4lists@pikron.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:48483 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S936490AbWLAQdV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 1 Dec 2006 11:33:21 -0500
Received: by nf-out-0910.google.com with SMTP id o25so3597680nfa
        for <linux-rt-users@vger.kernel.org>; Fri, 01 Dec 2006 08:33:20 -0800 (PST)
To: linux-rt-users@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <200612011412.57777.ppisa4lists@pikron.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Pavel Pisa wrote:
> I have tried to build patch-2.6.19-rt1 patched 2.6.19 kernel
> for MX1 (PiMX1). There seems to be some problems.
> One is corrected by attached patch,
> -----------------------------------------------------------------------------------
>  include/asm-arm/atomic.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6.19-rt/include/asm-arm/atomic.h
> ===================================================================
> --- linux-2.6.19-rt.orig/include/asm-arm/atomic.h
> +++ linux-2.6.19-rt/include/asm-arm/atomic.h
> @@ -188,10 +188,10 @@ static inline unsigned long __cmpxchg(vo
>  	volatile unsigned long *p = ptr;
>  
>  	if (size == 4) {
> -		local_irq_save(flags);
> +		raw_local_irq_save(flags);
>  		if ((prev = *p) == old)
>  			*p = new;
> -		local_irq_restore(flags);
> +		raw_local_irq_restore(flags);
>  		return(prev);
>  	} else
>  		return wrong_size_cmpxchg(ptr);

Yeah, same is necessary to get OMAP1 ARM926 compiled.

Best regards

Dirk
