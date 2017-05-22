From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 24/34] signaltest: remove unused ARRAY_SIZE macro
Date: Mon, 22 May 2017 18:44:06 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221843320.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-25-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33927 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934539AbdEVQoP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:44:15 -0400
Received: by mail-wm0-f68.google.com with SMTP id d127so34271731wmf.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:44:09 -0700 (PDT)
In-Reply-To: <20170522082540.15467-25-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/signaltest/signaltest.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 59f979e..72a549d 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -30,8 +30,6 @@
>  #include "error.h"
>  #include "rt-utils.h"
>  
> -#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> -
>  /* Ugly, but .... */
>  #define gettid() syscall(__NR_gettid)
>  
> -- 

NAK

You're right, it could be removed, but it's not really causing in harm 
either. I'm going to leave it in for now.

Thanks

John
