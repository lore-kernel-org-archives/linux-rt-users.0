From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/4] cyclictest: move tracemark_fd handling to its own
 function
Date: Tue, 22 Mar 2016 15:35:55 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221534380.10687@riemann>
References: <1458239417-31089-1-git-send-email-lcapitulino@redhat.com> <1458239417-31089-4-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33268 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758835AbcCVOf6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:35:58 -0400
Received: by mail-wm0-f65.google.com with SMTP id u125so4155316wmg.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 07:35:57 -0700 (PDT)
In-Reply-To: <1458239417-31089-4-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 17 Mar 2016, Luiz Capitulino wrote:

> A function added by the next commit will want to call
> this code too.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 4e80831..65f2aec 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -532,6 +532,19 @@ static void debugfs_prepare(void)
>  		fileprefix = procfileprefix;
>  }
>  
> +static void open_tracemark_fd(void)
> +{
> +	char path[MAX_PATH];
> +
> +	if (tracemark_fd >= 0)
> +		return;
> +
> +	sprintf(path, "%s/%s", fileprefix, "trace_marker");
> +	tracemark_fd = open(path, O_WRONLY);
> +	if (tracemark_fd < 0)
> +		warn("unable to open trace_marker file: %s\n", path);
> +}
> +
>  static void setup_tracer(void)
>  {
>  	if (!tracelimit || notrace)
> @@ -647,14 +660,7 @@ static void setup_tracer(void)
>  				fatal("unable to open %s for tracing", path);
>  		}
>  
> -		/* open the tracemark file descriptor */
> -		if (tracemark_fd == -1) {
> -			char path[MAX_PATH];
> -			strcat(strcpy(path, fileprefix), "trace_marker");
> -			if ((tracemark_fd = open(path, O_WRONLY)) == -1)
> -				warn("unable to open trace_marker file: %s\n", path);
> -		}
> -
> +		open_tracemark_fd();
>  	} else {
>  		setkernvar("trace_all_cpus", "1");
>  		setkernvar("trace_freerunning", "1");
> -- 
> 2.1.0

Signed-off-by: John Kacur <jkacur@redhat.com>

But, once again, it didn't apply cleanly, and you should have included it
with the next set off patches where it is required, because I was 
scratching my head as to why I should include this until I looked there.

