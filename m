From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 21/34] pi_stress: use %lu for unsigned long
Date: Mon, 22 May 2017 17:34:41 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221734190.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522082540.15467-22-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32770 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934960AbdEVPet (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 11:34:49 -0400
Received: by mail-wm0-f68.google.com with SMTP id b84so18107256wmh.0
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 08:34:48 -0700 (PDT)
In-Reply-To: <20170522082540.15467-22-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 

On Mon, 22 May 2017, Tommi Rantala wrote:

> src/pi_tests/pi_stress.c: In function 'low_priority':
> src/pi_tests/pi_stress.c:712:12: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
>    pi_debug("low_priority[%d]: entering start wait (%d)\n", p->id,
>             ^
> src/pi_tests/pi_stress.c: In function 'med_priority':
> src/pi_tests/pi_stress.c:840:12: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
>    pi_debug("med_priority[%d]: entering start state (%d)\n", p->id,
>             ^
> src/pi_tests/pi_stress.c: In function 'high_priority':
> src/pi_tests/pi_stress.c:964:12: warning: format '%d' expects argument of type 'int', but argument 3 has type 'long unsigned int' [-Wformat=]
>    pi_debug("high_priority[%d]: entering start state (%d)\n", p->id,
>             ^
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/pi_tests/pi_stress.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index 116869a..8972122 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -709,7 +709,7 @@ void *low_priority(void *arg)
>  		}
>  
>  		/* initial state */
> -		pi_debug("low_priority[%d]: entering start wait (%d)\n", p->id,
> +		pi_debug("low_priority[%d]: entering start wait (%lu)\n", p->id,
>  		      count++);
>  		status = pthread_barrier_wait(&p->start_barrier);
>  		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> @@ -837,7 +837,7 @@ void *med_priority(void *arg)
>  		}
>  
>  		/* start state */
> -		pi_debug("med_priority[%d]: entering start state (%d)\n", p->id,
> +		pi_debug("med_priority[%d]: entering start state (%lu)\n", p->id,
>  		      count++);
>  		status = pthread_barrier_wait(&p->start_barrier);
>  		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> @@ -961,7 +961,7 @@ void *high_priority(void *arg)
>  			}
>  			pthread_mutex_unlock(&shutdown_mtx);
>  		}
> -		pi_debug("high_priority[%d]: entering start state (%d)\n", p->id,
> +		pi_debug("high_priority[%d]: entering start state (%lu)\n", p->id,
>  		      count++);
>  		status = pthread_barrier_wait(&p->start_barrier);
>  		if (status && status != PTHREAD_BARRIER_SERIAL_THREAD) {
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
