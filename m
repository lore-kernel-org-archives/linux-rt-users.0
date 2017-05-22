From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 15/34] cyclictest: param is unused in fifothread()
Date: Mon, 22 May 2017 18:29:05 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221828470.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-16-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36494 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932514AbdEVQ3I (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:29:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id v42so7479243wrc.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:29:07 -0700 (PDT)
In-Reply-To: <20170522082540.15467-16-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> src/cyclictest/cyclictest.c: In function 'fifothread':
> src/cyclictest/cyclictest.c:2119:31: warning: unused parameter 'param' [-Wunused-parameter]
>  static void *fifothread(void *param)
>                                ^~~~~
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/cyclictest/cyclictest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 517f061..b4dec98 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -2115,7 +2115,7 @@ static void print_stat(FILE *fp, struct thread_param *par, int index, int verbos
>   * thread that creates a named fifo and hands out run stats when someone
>   * reads from the fifo.
>   */
> -static void *fifothread(void *param)
> +static void *fifothread(void *param __attribute__((unused)))
>  {
>  	int ret;
>  	int fd;
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
