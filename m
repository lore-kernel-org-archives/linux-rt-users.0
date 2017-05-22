From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 33/34] mark unused sighand() parameters with unused
 attribute
Date: Mon, 22 May 2017 17:47:04 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1705221746370.7915@riemann>
References: <20170522082540.15467-1-tommi.t.rantala@nokia.com> <20170522090424.16086-1-tommi.t.rantala@nokia.com> <20170522090424.16086-4-tommi.t.rantala@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
To: Tommi Rantala <tommi.t.rantala@nokia.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35093 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758410AbdEVPrI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2017 11:47:08 -0400
Received: by mail-wr0-f193.google.com with SMTP id j27so894312wre.2
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2017 08:47:07 -0700 (PDT)
In-Reply-To: <20170522090424.16086-4-tommi.t.rantala@nokia.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 22 May 2017, Tommi Rantala wrote:

> src/sched_deadline/cyclicdeadline.c: In function 'sighand':
> src/sched_deadline/cyclicdeadline.c:1010:25: warning: unused parameter 'sig' [-Wunused-parameter]
>  static void sighand(int sig)
>                          ^~~
> 
> Signed-off-by: Tommi Rantala <tommi.t.rantala@nokia.com>
> ---
>  src/pmqtest/pmqtest.c               | 2 +-
>  src/ptsematest/ptsematest.c         | 2 +-
>  src/sched_deadline/cyclicdeadline.c | 2 +-
>  src/signaltest/signaltest.c         | 2 +-
>  src/sigwaittest/sigwaittest.c       | 2 +-
>  src/svsematest/svsematest.c         | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/src/pmqtest/pmqtest.c b/src/pmqtest/pmqtest.c
> index 75d5ee8..e2d5f36 100644
> --- a/src/pmqtest/pmqtest.c
> +++ b/src/pmqtest/pmqtest.c
> @@ -380,7 +380,7 @@ static void process_options (int argc, char *argv[])
>  
>  static int volatile shutdown;
>  
> -static void sighand(int sig)
> +static void sighand(int sig __attribute__((unused)))
>  {
>  	shutdown = 1;
>  }
> diff --git a/src/ptsematest/ptsematest.c b/src/ptsematest/ptsematest.c
> index a31c745..26e800b 100644
> --- a/src/ptsematest/ptsematest.c
> +++ b/src/ptsematest/ptsematest.c
> @@ -290,7 +290,7 @@ static void process_options (int argc, char *argv[])
>  
>  static int volatile shutdown;
>  
> -static void sighand(int sig)
> +static void sighand(int sig __attribute__((unused)))
>  {
>  	shutdown = 1;
>  }
> diff --git a/src/sched_deadline/cyclicdeadline.c b/src/sched_deadline/cyclicdeadline.c
> index 5fbfa13..9bcfe26 100644
> --- a/src/sched_deadline/cyclicdeadline.c
> +++ b/src/sched_deadline/cyclicdeadline.c
> @@ -1007,7 +1007,7 @@ static int calc_nr_cpus(const char *setcpu, char **buf)
>  	return -1;
>  }
>  
> -static void sighand(int sig)
> +static void sighand(int sig __attribute__((unused)))
>  {
>  	shutdown = 1;
>  }
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 72a549d..dff0c56 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -282,7 +282,7 @@ static void check_kernel(void)
>  		oldtrace = 1;
>  }
>  
> -static void sighand(int sig)
> +static void sighand(int sig __attribute__((unused)))
>  {
>  	shutdown = 1;
>  }
> diff --git a/src/sigwaittest/sigwaittest.c b/src/sigwaittest/sigwaittest.c
> index 91fcdaa..6e6591f 100644
> --- a/src/sigwaittest/sigwaittest.c
> +++ b/src/sigwaittest/sigwaittest.c
> @@ -331,7 +331,7 @@ static void process_options (int argc, char *argv[])
>  
>  static int volatile mustshutdown;
>  
> -static void sighand(int sig)
> +static void sighand(int sig __attribute__((unused)))
>  {
>  	mustshutdown = 1;
>  }
> diff --git a/src/svsematest/svsematest.c b/src/svsematest/svsematest.c
> index 9adbb52..b688831 100644
> --- a/src/svsematest/svsematest.c
> +++ b/src/svsematest/svsematest.c
> @@ -378,7 +378,7 @@ static void process_options (int argc, char *argv[])
>  
>  static int volatile mustshutdown;
>  
> -static void sighand(int sig)
> +static void sighand(int sig __attribute__((unused)))
>  {
>  	mustshutdown = 1;
>  }
> -- 

Signed-off-by: John Kacur <jkacur@redhat.com>
