From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 2/3] don't use exit(-1) for failures
Date: Tue, 22 Mar 2016 15:21:18 +0100 (CET)
Message-ID: <alpine.LFD.2.20.1603221519370.10687@riemann>
References: <1458239345-30892-1-git-send-email-lcapitulino@redhat.com> <1458239345-30892-3-git-send-email-lcapitulino@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-rt-users@vger.kernel.org, williams@redhat.com
To: Luiz Capitulino <lcapitulino@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33309 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701AbcCVOVc (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 22 Mar 2016 10:21:32 -0400
Received: by mail-wm0-f65.google.com with SMTP id u125so4057042wmg.0
        for <linux-rt-users@vger.kernel.org>; Tue, 22 Mar 2016 07:21:31 -0700 (PDT)
In-Reply-To: <1458239345-30892-3-git-send-email-lcapitulino@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On Thu, 17 Mar 2016, Luiz Capitulino wrote:

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
>  src/rt-migrate-test/rt-migrate-test.c | 5 ++---
>  src/signaltest/signaltest.c           | 2 +-
>  4 files changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c
> index a02f706..36b64ca 100644
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
> index a0477cc..e6cf0ce 100644
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
> index 1362404..a00e86f 100644
> --- a/src/rt-migrate-test/rt-migrate-test.c
> +++ b/src/rt-migrate-test/rt-migrate-test.c
> @@ -138,7 +138,7 @@ static void perr(char *fmt, ...)
>  
>  	perror(buffer);
>  	fflush(stderr);
> -	exit(-1);
> +	exit(1);
>  }
>  
>  static void print_progress_bar(int percent)
> @@ -226,7 +226,6 @@ static void parse_options (int argc, char *argv[])
>  			break;
>  		}
>  	}
> -
>  }
>  
>  static unsigned long long get_time(void)
> @@ -604,7 +603,7 @@ int main (int argc, char **argv)
>  			exit(2);
>  	}
>  	if (check < 0)
> -		exit(-1);
> +		exit(1);
>  	else
>  		exit(0);
>  
> diff --git a/src/signaltest/signaltest.c b/src/signaltest/signaltest.c
> index b80969b..59f979e 100644
> --- a/src/signaltest/signaltest.c
> +++ b/src/signaltest/signaltest.c
> @@ -323,7 +323,7 @@ int main(int argc, char **argv)
>  	process_options(argc, argv);
>  
>  	if (check_privs())
> -		exit(-1);
> +		exit(1);
>  
>  	/* lock all memory (prevent paging) */
>  	if (lockall)
> -- 
> 2.1.0
> 


Signed-off-by: John Kacur <jkacur@gmail.com>

However it didn't apply cleanly, once again, please work with
Repo: git://git.kernel.org/pub/scm/utils/rt-tests/rt-tests.git
Branch: devel/v0.97
