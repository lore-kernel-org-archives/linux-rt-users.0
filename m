From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 22/34] pi_stress: add missing argument in pi_error()
 call
Date: Mon, 22 May 2017 17:14:17 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221713560.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-23-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34460 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934647AbdEVPO1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 11:14:27 -0400
Received: by mail-wr0-f196.google.com with SMTP id 6so7273213wrb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 08:14:26 -0700 (PDT)
In-Reply-To: <20170522082540.15467-23-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> src/pi_tests/pi_stress.c: In function 'high_priority':
> src/pi_tests/pi_stress.c:993:9: warning: format '%x' expects a matching 'unsigned int' argument [-Wformat=]
>         ("high_priority[%d]: pthread_barrier_wait(finish): %x",
>          ^
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/pi_tests/pi_stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 8972122..e29956c 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -991,7 +991,7 @@ void *high_priority(void *arg)
>  		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
>  			pi_error
>  			    ("high_priority[%d]: pthread_barrier_wait(finish): %x",
> -			     status);
> +			     p->id, status);
>  			return NULL;
>  		}
>  		/* update the group stats */
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
