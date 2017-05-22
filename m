From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 23/34] svsematest: test .mindiff against UINT_MAX
Date: Mon, 22 May 2017 17:20:16 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221719561.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-24-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34559 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934647AbdEVPUU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 11:20:20 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so7292010wrb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 08:20:19 -0700 (PDT)
In-Reply-To: <20170522082540.15467-24-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> src/svsematest/svsematest.c:637:29: warning: comparison between signed and unsigned integer expressions [-Wsign-compare]
>      if (receiver[i].mindiff == -1)
>                              ^~
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/svsematest/svsematest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index eeb8285..9adbb52 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -634,7 +634,7 @@ int main(int argc, char *argv[])
>  				    sender[i].cpu, sender[i].samples);
>  			}
>  			for (i = 0; i < num_threads; i++) {
> -				if (receiver[i].mindiff == -1)
> +				if (receiver[i].mindiff == UINT_MAX)
>  					printf("#%d -> #%d (not yet ready)\n",
>  					    i*2+1, i*2);
>  				else
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>> 
