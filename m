From: Luiz Capitulino <lcapitulino@redhat.com>
Subject: Re: [PATCH] cyclictest: stop any tracing after hitting a breaktrace
 threshold
Date: Tue, 3 May 2016 15:56:44 -0400
Message-ID: <20160503155644.0aa34c34@redhat.com>
References: <20160503125953.1987bedd@sluggy.hsv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	RT <linux-rt-users@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160503125953.1987bedd@sluggy.hsv.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On Tue, 3 May 2016 12:59:53 -0500
Clark Williams <williams@redhat.com> wrote:

> John,
> 
> This patch is against the devel/v0.98 branch. It turns off tracing in the tracemark() so that we don't lose information about what was going on when we hit the latency:
> 
> 
> The current logic of using --tracemark and --notrace works for running
> cyclictest with trace-cmd, but even if we are not doing any trace
> manipulation in cyclictest, we still need to stop tracing when we hit a
> breaktrace threshold (i.e. -b <n>).

Does it solve the problem for you if you revert ba4dd1bf54 and start
cyclictest with:

# cyclictest [...] -bX

Or with:

# cyclictest [...] -bX --tracemark

Also, how do I reproduce your issue? Are you doing tracing by hand?

More comments below.

> 
> Modify startup logic to hold open file descriptors for the tracemark file
> *and* the tracing_on file. When we hit a threshold and call the tracemark()
> function, write the marker to the trace buffers and then write a "0\n" to
> the tracing_on file to turn off tracing, otherwise we lose the information
> immediately prior to the point where we hit the latency.
> 
> Signed-off-by: Clark Williams <williams@redhat.com>
> ---
>  src/cyclictest/cyclictest.c | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 902167010416..00e5f3d59a5b 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -489,7 +489,12 @@ static void tracemark(char *fmt, ...)
>  	va_start(ap, fmt);
>  	len = vsnprintf(tracebuf, TRACEBUFSIZ, fmt, ap);
>  	va_end(ap);
> +
> +	/* write the tracemark message */
>  	write(tracemark_fd, tracebuf, len);
> +
> +	/* now stop any trace */
> +	write(trace_fd, "0\n", 2);
>  }

We do tracing(0) when we hit the latency threshold, so I don't
think this is necessary.

However, have you checked that writing to tracing_on won't break
trace-cmd when it exec()ed cyclictest?

>  
>  
> @@ -535,13 +540,28 @@ static void open_tracemark_fd(void)
>  {
>  	char path[MAX_PATH];
>  
> -	if (tracemark_fd >= 0)
> -		return;
> +	/*
> +	 * open the tracemark file if it's not already open
> +	 */
> +	if (tracemark_fd < 0) {
> +		sprintf(path, "%s/%s", fileprefix, "trace_marker");
> +		tracemark_fd = open(path, O_WRONLY);
> +		if (tracemark_fd < 0) {
> +			warn("unable to open trace_marker file: %s\n", path);
> +			return;
> +		}
> +	}
>  
> -	sprintf(path, "%s/%s", fileprefix, "trace_marker");
> -	tracemark_fd = open(path, O_WRONLY);
> -	if (tracemark_fd < 0)
> -		warn("unable to open trace_marker file: %s\n", path);
> +	/*
> +	 * if we're not tracing and the tracing_on fd is not open,
> +	 * open the tracing_on file so that we can stop the trace
> +	 * if we hit a breaktrace threshold
> +	 */
> +	if (notrace && trace_fd < 0) {
> +		sprintf(path, "%s/%s", fileprefix, "tracing_on");
> +		if ((trace_fd = open(path, O_WRONLY)) < 0)
> +			warn("unable to open tracing_on file: %s\n", path);
> +	}
>  }
>  
>  static void debugfs_prepare(void)
