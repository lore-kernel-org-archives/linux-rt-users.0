From: John Kacur <jkacur@redhat.com>
Subject: Re: RFC: patch to trigger thread stats output from cyclictest with
 SIGHUP
Date: Tue, 12 Mar 2013 13:10:43 +0100 (CET)
Message-ID: <alpine.LFD.2.03.1303121309370.8036@tycho>
References: <20130311111607.587cda32@riff.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Kacur <jkacur@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	RT <linux-rt-users@vger.kernel.org>,
	David Sommerseth <davids@redhat.com>
To: Clark Williams <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:50692 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755143Ab3CLMQd (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Mar 2013 08:16:33 -0400
Received: by mail-we0-f173.google.com with SMTP id x51so4596501wey.18
        for <linux-rt-users@vger.kernel.org>; Tue, 12 Mar 2013 05:16:32 -0700 (PDT)
In-Reply-To: <20130311111607.587cda32@riff.lan>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Mon, 11 Mar 2013, Clark Williams wrote:

> John,
> 
> Steven suggested a feature for cyclictest that I'd actually been
> whining about (internally anyway). During long rteval runs there's
> really no feedback available if you want to know how the run is
> progressing. Steven suggested sending SIGHUP and dumping the current
> state. Below is a patch that seems to work for cyclictest; just
> wanted to get some feedback on whether this would be acceptable
> behaviour. 
> 
> Of course if we get this going then we need to figure out how to wire
> it into rteval as well :).
> 
> Clark
> 
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 0a15dcb..51b97cf 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -199,6 +199,11 @@ static char **traceptr;
>  static int traceopt_count;
>  static int traceopt_size;
>  
> +static struct thread_param **parameters;
> +static struct thread_stat **statistics;
> +
> +static void print_stat(struct thread_param *par, int index, int verbose);
> +
>  static int latency_target_fd = -1;
>  static int32_t latency_target_value = 0;
>  
> @@ -1368,6 +1373,19 @@ static int check_timer(void)
>  
>  static void sighand(int sig)
>  {
> +	if (sig == SIGHUP) {
> +		int i;
> +		int oldquiet = quiet;
> +
> +		quiet = 0;
> +		printf("#---------------------------\n");
> +		printf("# cyclictest current status:\n");
> +		for (i = 0; i < num_threads; i++)
> +			print_stat(parameters[i], i, 0);
> +		printf("#---------------------------\n");
> +		quiet = oldquiet;
> +		return;
> +	}
>  	shutdown = 1;
>  	if (refresh_on_max)
>  		pthread_cond_signal(&refresh_on_max_cond);
> @@ -1503,8 +1521,6 @@ int main(int argc, char **argv)
>  	sigset_t sigset;
>  	int signum = SIGALRM;
>  	int mode;
> -	struct thread_param **parameters;
> -	struct thread_stat **statistics;
>  	int max_cpus = sysconf(_SC_NPROCESSORS_CONF);
>  	int i, ret = -1;
>  	int status;
> @@ -1642,6 +1658,7 @@ int main(int argc, char **argv)
>  
>  	signal(SIGINT, sighand);
>  	signal(SIGTERM, sighand);
> +	signal(SIGHUP, sighand);
>  
>  	parameters = calloc(num_threads, sizeof(struct thread_param *));
>  	if (!parameters)
> 

Where's your SOB Clark? I'm assuming that you and not Steve are the 
author. I can add this to my development dir for people to try.

Thanks

John
