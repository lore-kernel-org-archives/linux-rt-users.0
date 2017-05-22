From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 18/34] pip_stress: fix missing argument in err_msg() call
 in process_shared_mutex_available()
Date: Mon, 22 May 2017 18:36:18 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221835590.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-19-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34393 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934291AbdEVQg0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:36:26 -0400
Received: by mail-wr0-f194.google.com with SMTP id 6so7511847wrb.1
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:36:25 -0700 (PDT)
In-Reply-To: <20170522082540.15467-19-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/pi_tests/pip_stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index e6cf0ce..1245705 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -244,7 +244,7 @@ long process_shared_mutex_available(void)
>  	res = sysconf(_SC_THREAD_PROCESS_SHARED);
>  	if (res == -1) {
>  		int err = errno;	/* save the error number */
> -		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ");
> +		err_msg("%s: sysconf(_SC_THREAD_PROCESS_SHARED): ", __func__);
>  		err_exit(err, NULL);
>  	}
>  #else
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
