From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/6] Add syscall-number for sched_(gs)etattr() for tile
Date: Mon, 21 Sep 2015 21:42:31 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1509212142120.12009@riemann>
References: <1442849248-573-1-git-send-email-haustad@cisco.com> <1442849248-573-3-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
	Josh Cartwright <joshc@ni.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38213 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757221AbbIUTmf (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 21 Sep 2015 15:42:35 -0400
Received: by wiclk2 with SMTP id lk2so127300922wic.1
        for <linux-rt-users@vger.kernel.org>; Mon, 21 Sep 2015 12:42:33 -0700 (PDT)
In-Reply-To: <1442849248-573-3-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 21 Sep 2015, Henrik Austad wrote:

> Signed-off-by: Henrik Austad <haustad@cisco.com>
> ---
>  src/include/rt-sched.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/src/include/rt-sched.h b/src/include/rt-sched.h
> index 6c45f7a..b46b1b1 100644
> --- a/src/include/rt-sched.h
> +++ b/src/include/rt-sched.h
> @@ -47,6 +47,11 @@
>  #define __NR_sched_getattr		381
>  #endif
>  
> +#ifdef __tilegx__
> +#define __NR_sched_setattr		274
> +#define __NR_sched_getattr		275
> +#endif
> +
>  struct sched_attr {
>  	uint32_t size;
>  	uint32_t sched_policy;
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
