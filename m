From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 19/34] pip_stress: getopt.h and long_options[] are
 unused
Date: Mon, 22 May 2017 18:39:21 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221839030.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-20-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:36666 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933994AbdEVQjY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 12:39:24 -0400
Received: by mail-wr0-f193.google.com with SMTP id v42so7508992wrc.3
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 09:39:24 -0700 (PDT)
In-Reply-To: <20170522082540.15467-20-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/pi_tests/pip_stress.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 1245705..15adf54 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -57,7 +57,6 @@
>  #include "pip_stress.h"
>  
>  #include <unistd.h>
> -#include <getopt.h>
>  
>  /* default time for low priority thread usleep */
>  useconds_t usleep_val = 500;
> @@ -79,11 +78,6 @@ struct State *statep;
>  const int policy = SCHED_FIFO;
>  const int prio_min;	/* Initialized for the minimum priority of policy */
>  
> -struct option long_options[] = {
> -    { "usleep", required_argument, 0, 0 },
> -    { 0,        0,                 0, 0 },
> -};
> -
>  int main(void)
>  {
>  	void *mptr;	/* memory pointer */
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
