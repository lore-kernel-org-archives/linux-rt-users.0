From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 06/34] cyclictest: fix typo in warn() message
Date: Mon, 22 May 2017 17:35:54 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221735350.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-7-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35404 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934804AbdEVPf5 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 11:35:57 -0400
Received: by mail-wm0-f66.google.com with SMTP id g15so14333098wmc.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 08:35:57 -0700 (PDT)
In-Reply-To: <20170522082540.15467-7-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4f94b06..8f7b28c 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -1149,7 +1149,7 @@ static void *timerthread(void *param)
>  		ret = clock_gettime(par->clock, &now);
>  		if (ret != 0) {
>  			if (ret != EINTR)
> -				warn("clock_getttime() failed. errno: %d\n",
> +				warn("clock_gettime() failed. errno: %d\n",
>  				     errno);
>  			goto out;
>  		}
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
