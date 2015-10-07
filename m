From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/4] signaltest: properly test return value from
 system()
Date: Wed, 7 Oct 2015 12:44:07 +0200 (CEST)
Message-ID: <alpine.LFD.2.20.1510071240120.14006@riemann>
References: <1444122503-8112-1-git-send-email-haustad@cisco.com> <1444122503-8112-2-git-send-email-haustad@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org,
	Clark Williams <williams@redhat.com>
To: Henrik Austad <haustad@cisco.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36592 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbJGKoK (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 7 Oct 2015 06:44:10 -0400
Received: by wicgb1 with SMTP id gb1so204919114wic.1
        for <linux-rt-users@vger.kernel.org>; Wed, 07 Oct 2015 03:44:09 -0700 (PDT)
In-Reply-To: <1444122503-8112-2-git-send-email-haustad@cisco.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Tue, 6 Oct 2015, Henrik Austad wrote:

> signaltest writes to several /proc/sys/kernel attributes without testing
> if the system() call succeeds or not. We expect the writes from echo to
> suceed (i.e. yield '0' in return), so we test explicitly for that.
> 
> Signed-off-by: Henrik Austad <haustad@cisco.com>
> Cc: Clark Williams <williams@redhat.com>
> Cc: John Kacur <jkacur@redhat.com>
> ---
>  src/signaltest/signaltest.c | 25 +++++++++++++++----------
>  1 file changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b80969b..8074b68 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -65,6 +65,11 @@ struct thread_stat {
>  	int threadstarted;
>  	int tid;
>  };
> +#define SYSTEM_W(x)				\
> +	if (system((x)) != 0) {			\
> +		fprintf(stderr, "Trouble running %s\n", (x));	\
> +		return NULL;					\
> +	}							\
>  
>  static int shutdown;
>  static int tracelimit = 0;
> @@ -102,16 +107,16 @@ void *signalthread(void *param)
>  	int first = 1;
>  
>  	if (tracelimit) {
> -		system("echo 1 > /proc/sys/kernel/trace_all_cpus");
> -		system("echo 1 > /proc/sys/kernel/trace_enabled");
> -		system("echo 1 > /proc/sys/kernel/trace_freerunning");
> -		system("echo 0 > /proc/sys/kernel/trace_print_at_crash");
> -		system("echo 1 > /proc/sys/kernel/trace_user_triggered");
> -		system("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
> -		system("echo 0 > /proc/sys/kernel/trace_verbose");
> -		system("echo 0 > /proc/sys/kernel/preempt_thresh");
> -		system("echo 0 > /proc/sys/kernel/wakeup_timing");
> -		system("echo 0 > /proc/sys/kernel/preempt_max_latency");
> +		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_all_cpus");
> +		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_enabled");
> +		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_freerunning");
> +		SYSTEM_W("echo 0 > /proc/sys/kernel/trace_print_at_crash");
> +		SYSTEM_W("echo 1 > /proc/sys/kernel/trace_user_triggered");
> +		SYSTEM_W("echo -1 > /proc/sys/kernel/trace_user_trigger_irq");
> +		SYSTEM_W("echo 0 > /proc/sys/kernel/trace_verbose");
> +		SYSTEM_W("echo 0 > /proc/sys/kernel/preempt_thresh");
> +		SYSTEM_W("echo 0 > /proc/sys/kernel/wakeup_timing");
> +		SYSTEM_W("echo 0 > /proc/sys/kernel/preempt_max_latency");
>  	}
>  
>  	stat->tid = gettid();
> -- 
> 1.9.1
> 

I really don't like patches like this that just exist to shut-up the 
compiler's overzealous warnings. Are you actually having a problem with 
this program that you need to debug? If you are, is the message "Trouble 
running echo num to some /proc" file really useful? Have you carefully 
read the system man page to see what kind of errors can be returned and 
why? I'm going to pass on this one for now.
Sorry
John
