From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 3/4] don't use exit(-1) for failures
Date: Wed, 16 Mar 2016 23:19:14 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603162315210.16977@riemann>
References: <1456346981-24032-1-git-send-email-lcapitulino@redhat.com> <1456346981-24032-4-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33832 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965739AbcCPWTR (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 16 Mar 2016 18:19:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id p65so11403973wmp.1
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Mar 2016 15:19:16 -0700 (PDT)
In-Reply-To: <1456346981-24032-4-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Wed, 24 Feb 2016, Luiz Capitulino wrote:

> The kernel uses only 8 bits of the status as a return
> code, so this actually becomes 255 in the shell.
> 
> In any case, the most widely convension is exit(1)
> for failures, so let's be consistent.
> 
> Signed-off-by: Luiz Capitulino <lcapitulino@redhat.com>
> ---
>  src/pi_tests/pi_stress.c              | 2 +-
>  src/pi_tests/pip_stress.c             | 6 +++---
>  src/rt-migrate-test/rt-migrate-test.c | 8 ++++----
>  src/signaltest/signaltest.c           | 2 +-
>  4 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index aaa36c3..574fb65 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -634,7 +634,7 @@ int verify_cpu(int cpu)
>  	if (status == -1) {
>  		err = errno;
>  		fprintf(stderr, "sched_getaffinity %s\n", strerror(err));
> -		exit(-1);
> +		exit(1);
>  	}
>  
>  	if (CPU_ISSET(cpu, &mask))
> diff --git a/src/pi_tests/pip_stress.c b/src/pi_tests/pip_stress.c
> index 812a703..bef1f92 100644
> --- a/src/pi_tests/pip_stress.c
> +++ b/src/pi_tests/pip_stress.c
> @@ -95,7 +95,7 @@ int main(void)
>  	*minimum_priority = sched_get_priority_min(policy);
>  
>  	if (check_privs())
> -		exit(-1);
> +		exit(1);
>  
>  	mptr = mmap_page();	/* Get a page of shared memory */
>  	resource = (pthread_mutex_t*)mptr;	/* point our lock to it */
> @@ -138,7 +138,7 @@ int main(void)
>  		pid2 = fork();		/* parent code */
>  		if (pid2 == -1) {
>  			perror("fork: ");
> -			exit(-1);
> +			exit(1);
>  		} else if (pid2 != 0) {		/* parent code */
>  			high(pid2);
>  		} else {			/* child code */
> @@ -231,7 +231,7 @@ void *mmap_page(void)
>  	mptr = mmap(NULL, pgsize, PROTRW, MMAP_FLAGS, 0, 0);
>  	if (mptr == MAP_FAILED) {
>  		perror("In function mmap_page - mmap");
> -		exit(-1);
> +		exit(1);
>  	}
>  
>  	return mptr;
> diff --git a/src/rt-migrate-test/rt-migrate-test.c b/src/rt-migrate-test/rt-migrate-test.c
> index 6e8acc2..4a7ecbb 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -141,7 +141,7 @@ static void perr(char *fmt, ...)
>  
>  	perror(buffer);
>  	fflush(stderr);
> -	exit(-1);
> +	exit(1);
>  }
>  
>  static void print_progress_bar(int percent)
> @@ -228,11 +228,11 @@ static void parse_options (int argc, char *argv[])
>  	}
>  	if (nr_runs <= 0) {
>  		fprintf(stderr, "Error: --loops argument is non-positive.  Exiting.\n");
> -		exit(-1);
> +		exit(1);
>  	}
>  	if (prio_start < 1 || prio_start > 99) {
>  		fprintf(stderr, "Error: invalid value for --prio: %d (valid: 1-99)\n", prio_start);
> -		exit(-1);
> +		exit(1);
>  	}
>  }
>  
> @@ -599,7 +599,7 @@ int main (int argc, char **argv)
>  			exit(2);
>  	}
>  	if (check < 0)
> -		exit(-1);
> +		exit(1);
>  	else
>  		exit(0);
>  
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index 9454a26..7eaceec 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -318,7 +318,7 @@ int main(int argc, char **argv)
>  	int i, ret = -1;
>  
>  	if (check_privs())
> -		exit(-1);
> +		exit(1);
>  
>  	process_options(argc, argv);
>  
> -- 
> 2.1.0
> 
> --

This should be okay, but the patch doesn't apply, probably because
you're not using the most recent source. If you respin this patch and it 
applies cleanly I'll probably take it. (unless someone tells me that 
something like rteval or Carsten's tests require an exit of -1

Thanks

John
