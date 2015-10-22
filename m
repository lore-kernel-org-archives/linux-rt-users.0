From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 4/4] rt-sched.h: do not unconditionally define
 syscall-numbers
Date: Thu, 22 Oct 2015 11:43:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510221142460.5687@riemann>
References: <1445454011-18839-1-git-send-email-haustad@cisco.com> <1445454011-18839-5-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:33804 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586AbbJVJnJ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 22 Oct 2015 05:43:09 -0400
Received: by wikq8 with SMTP id q8so23030226wik.1
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Oct 2015 02:43:08 -0700 (PDT)
In-Reply-To: <1445454011-18839-5-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 21 Oct 2015, Henrik Austad wrote:

> These could be defined elsewhere, be careful when defining these
> 
> Cc: John Kacur <jkacur@redhat.com>
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  src/include/rt-sched.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
> index b46b1b16606f..679c4bd10ae2 100644
> --- a/src/include/rt-sched.h
> +++ b/src/include/rt-sched.h
> @@ -43,9 +43,13 @@
>  #endif
>  
>  #ifdef __arm__
> +#ifndef __NR_sched_setattr
>  #define __NR_sched_setattr		380
> +#endif
> +#ifndef __NR_sched_getattr
>  #define __NR_sched_getattr		381
>  #endif
> +#endif
>  
>  #ifdef __tilegx__
>  #define __NR_sched_setattr		274
> -- 
> 1.9.1
> 
> --

Signed-off-by: John Kacur <jkacur@redhat.com>
