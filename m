From: John Kacur <jkacur@redhat.com>
Subject: Re: RFC: cyclictest notrace option
Date: Thu, 14 Mar 2013 14:07:45 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1303141405540.8036@tycho>
References: <20130313194650.45649c1f@riff.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>, RT <linux-rt-users@vger.kernel.org>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f41.google.com ([209.85.214.41]:37873 "EHLO
	mail-bk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757692Ab3CNNHu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 14 Mar 2013 09:07:50 -0400
Received: by mail-bk0-f41.google.com with SMTP id q16so994316bkw.14
        for <linux-rt-users@vger.kernel.org>; Thu, 14 Mar 2013 06:07:48 -0700 (PDT)
In-Reply-To: <20130313194650.45649c1f@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 13 Mar 2013, Clark Williams wrote:

> This patch adds the --notrace/-A option to cyclictest. The intent is to
> allow use of the -b/--breaktrace option but to have cyclictest do no
> actual ftrace operations (i.e. stop when threshold is hit and do
> nothing wrt ftrace).  The idea is that you can do more sophisticated
> tracing with the trace-cmd script, so do that rather than trying to put
> all combinations of tracing into cyclictest. 
> 
> I've push this and the previous patch up to my kernel.org repository in
> the work branch:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/clrkwllms/rt-tests.git
> 
> commit 83adb67c7928a73f6434e98cba736717d656ceb4
> Author: Clark Williams <clark.williams@gmail.com>
> Date:   Wed Mar 13 19:36:29 2013 -0500
> 
>     cyclictest: allow break threshold without doing any tracing
>     
>     Add the --notrace/-A option, intended to be used in conjunction
>     with the -b option. This will cause cyclictest to exit when a
>     threshold is hit, but will not perform any tracing operations,
>     allowing more sophisticated tracing to be done externally.
>     
>     Signed-off-by: Clark Williams <clark.williams@gmail.com>
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index a8f9534..7eb4799 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -165,6 +165,7 @@ struct thread_stat {
>  
>  static int shutdown;
>  static int tracelimit = 0;
> +static int notrace = 0;
>  static int ftrace = 0;
>  static int kernelversion;
>  static int verbose = 0;
> @@ -446,7 +447,7 @@ static int settracer(char *tracer)
>  
>  static void setup_tracer(void)
>  {
> -	if (!tracelimit)
> +	if (!tracelimit || notrace)
>  		return;
>  
>  	if (mount_debugfs(NULL))
> @@ -1101,6 +1102,7 @@ static void process_options (int argc, char
> *argv[]) */
>  		static struct option long_options[] = {
>  			{"affinity",         optional_argument, NULL,
> 'a'},
> +			{"notrace",          no_argument,       NULL,
> 'A'}, {"breaktrace",       required_argument, NULL, 'b'},
>  			{"preemptirqs",      no_argument,       NULL,
> 'B'}, {"clock",            required_argument, NULL, 'c'},
> @@ -1161,6 +1163,7 @@ static void process_options (int argc, char
> *argv[]) setaffinity = AFFINITY_USEALL;
>  			}
>  			break;
> +		case 'A': notrace = 1; break;
>  		case 'b': tracelimit = atoi(optarg); break;
>  		case 'B': tracetype = PREEMPTIRQSOFF; break;
>  		case 'c': clocksel = atoi(optarg); break;
> @@ -1400,7 +1403,7 @@ static void sighand(int sig)
>  	shutdown = 1;
>  	if (refresh_on_max)
>  		pthread_cond_signal(&refresh_on_max_cond);
> -	if (tracelimit)
> +	if (tracelimit && !notrace)
>  		tracing(0);
>  }
>  
> @@ -1921,7 +1924,7 @@ int main(int argc, char **argv)
>  	}
>   out:
>  	/* ensure that the tracer is stopped */
> -	if (tracelimit)
> +	if (tracelimit && !notrace)
>  		tracing(0);
>  
>  
> @@ -1937,7 +1940,7 @@ int main(int argc, char **argv)
>  
>  	/* turn off the function tracer */
>  	fileprefix = procfileprefix;
> -	if (tracetype)
> +	if (tracetype && !notrace)
>  		setkernvar("ftrace_enabled", "0");
>  	fileprefix = get_debugfileprefix();
>  
> 

I think your mailer is word-wrapping this patch. I would have fixed it up 
if it were only in one or two places, but it's not, could you either 
resend or point me to a git commit?

Thanks

John
