From: John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH] cyclictest histogram overflow instance tracking
Date: Tue, 16 Oct 2012 02:33:09 +0200 (CEST)
Message-ID: <alpine.LFD.2.02.1210160226270.11097@tycho>
References: <21A665E0-66F4-4C7E-BDB2-820DDC5398C8@vmware.com> <507724B2.5050103@am.sony.com> <9C1EE6A5-2B57-45AC-B4D7-5AF7F56A7BCA@vmware.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463806542-498766144-1350347595=:11097"
Cc: "frank.rowand@am.sony.com" <frank.rowand@am.sony.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Garrett Smith <garrett@vmware.com>,
	Lenin Singaravelu <lsingara@vmware.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46568 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752664Ab2JPAb2 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2012 20:31:28 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so2726935bkc.19
        for <linux-rt-users@vger.kernel.org>; Mon, 15 Oct 2012 17:31:26 -0700 (PDT)
In-Reply-To: <9C1EE6A5-2B57-45AC-B4D7-5AF7F56A7BCA@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463806542-498766144-1350347595=:11097
Content-Type: TEXT/PLAIN; charset=Windows-1252
Content-Transfer-Encoding: 8BIT



On Thu, 11 Oct 2012, Bhavesh Davda wrote:

> Thanks for the review, Frank.
> 
> On Oct 11, 2012, at 12:57 PM, Frank Rowand wrote:
> > Nice idea…
> Thanks
> 
> > Suggest:
> >        printf("# Histogram Overflows at cycle number:");
> > 
> Done
> 
> >> - 		printf(" %05lu", par[j]->stats->hist_overflow);
> >> +		printf(" %05lu", par[j]->stats->hist_overflow);
> > 
> > Am I blind, or is that a whitespace change?  (The latest version I have does not seem
> > to have any white space issues in that line.)
> > 
> Turns out I had removed extraneous whitespace. My vim settings allow me to see extraneous whitespaces in red, so I get annoyed by them and can fix them up. So I've removed a few more in the revised diffs (sorry!)

If there are too many of such fix-ups then it can reduce the readability 
of your patch. If this is the case, then it is okay to submit a separate 
patch to fix this up.

 > 
> > Suggest:
> > 
> >  +             printf("# thread %d:", j);
> > 
> Done
> 
> > Nit: You don't need stats->outliers_overflow.  You can calculate it from
> > stats->hist_overflow - stats->num_outliers:
> > 
> Nice catch! I've removed outliers_overflow now.
> 
> 
> From: Bhavesh Davda <bhavesh@vmware.com>
> 
> Add feature to cyclictest histogram mode to track cycle counts every time a
> sample overflows the histogram limit. This should help identify if there is a
> timing pattern to jitters in cyclictest runs.
> 
> Example output (with -h 10):
>   ...
>   Histogram Overflows: 00000 00253 00000 00005 00000 00024 00003 00005
>   Histogram Overflow at cycle number:
>   Thread 0:
>   Thread 1: 00023 00028 00337 00338 00339 00340 00341 00342 00343 00344 # 00243 others
>   Thread 2:
>   Thread 3: 10486 10487 10488 10489 10490
>   Thread 4:
>   Thread 5: 00002 00004 00008 00012 00178 10458 10459 10460 10461 10462 # 00014 others
>   Thread 6: 05954 08954 29955
>   Thread 7: 20536 20537 20538 20539 20540

Okay, I haven't looked closely at your code, but it doesn't seem to be 
working for me. After applying your patch and running with it, I got the 
following.

./cyclictest -h10 -t 10
->o snip

# Histogram Overflows: 00760 00752 00758 00758 00757 00756 00758 00757 
00757 00757
# Histogram Overflow at cycle number:
# Thread 0: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00750 others
# Thread 1: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00742 others
# Thread 2: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00748 others
# Thread 3: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00748 others
# Thread 4: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00747 others
# Thread 5: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00746 others
# Thread 6: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00748 others
# Thread 7: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00747 others
# Thread 8: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00747 others
# Thread 9: 18446744073709551615 00000 00001 00002 00003 00004 00005 00006 
00007 00008 # 00747 others

Thanks
>   ...
> 
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> ---
>  src/cyclictest/cyclictest.c |   38 +++++++++++++++++++++++++++++---------
>  1 files changed, 29 insertions(+), 9 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 731b4bd..dc985de 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -147,6 +147,7 @@ struct thread_stat {
>  	double avg;
>  	long *values;
>  	long *hist_array;
> +        unsigned long *outliers;
>  	pthread_t thread;
>  	int threadstarted;
>  	int tid;
> @@ -154,6 +155,7 @@ struct thread_stat {
>  	long redmax;
>  	long cycleofmax;
>  	long hist_overflow;
> +        long num_outliers;
>  };
>  
>  static int shutdown;
> @@ -756,8 +758,11 @@ void *timerthread(void *param)
>  
>  		/* Update the histogram */
>  		if (histogram) {
> -			if (diff >= histogram)
> +			if (diff >= histogram) {
>  				stat->hist_overflow++;
> +				if (stat->num_outliers < histogram)
> +					stat->outliers[stat->num_outliers++] = stat->cycles - 1;
> +			}
>  			else
>  				stat->hist_array[diff]++;
>  		}
> @@ -811,7 +816,7 @@ static void display_help(int error)
>  		if (kernvar(O_RDONLY, "available_tracers", tracers, sizeof(tracers)))
>  			strcpy(tracers, "none");
>  	}
> -		
> +
>  	printf("cyclictest V %1.2f\n", VERSION_STRING);
>  	printf("Usage:\n"
>  	       "cyclictest <options>\n\n"
> @@ -1188,7 +1193,7 @@ static int check_kernel(void)
>  		kv = KV_30;
>  		strcpy(functiontracer, "function");
>  		strcpy(traceroptions, "trace_options");
> -		
> +
>  	} else
>  		kv = KV_NOT_SUPPORTED;
>  
> @@ -1226,7 +1231,7 @@ static void print_tids(struct thread_param *par[], int nthreads)
>  
>  static void print_hist(struct thread_param *par[], int nthreads)
>  {
> -	int i, j;
> +	int i, j, k;
>  	unsigned long long int log_entries[nthreads+1];
>  	unsigned long maxmax, alloverflows;
>  
> @@ -1270,7 +1275,7 @@ static void print_hist(struct thread_param *par[], int nthreads)
>  	printf("# Max Latencies:");
>  	maxmax = 0;
>  	for (j = 0; j < nthreads; j++) {
> - 		printf(" %05lu", par[j]->stats->max);
> +		printf(" %05lu", par[j]->stats->max);
>  		if (par[j]->stats->max > maxmax)
>  			maxmax = par[j]->stats->max;
>  	}
> @@ -1280,9 +1285,20 @@ static void print_hist(struct thread_param *par[], int nthreads)
>  	printf("# Histogram Overflows:");
>  	alloverflows = 0;
>  	for (j = 0; j < nthreads; j++) {
> - 		printf(" %05lu", par[j]->stats->hist_overflow);
> +		printf(" %05lu", par[j]->stats->hist_overflow);
>  		alloverflows += par[j]->stats->hist_overflow;
>  	}
> +	printf("\n");
> +	printf("# Histogram Overflow at cycle number:\n");
> +	for (j = 0; j < nthreads; j++) {
> +		printf("# Thread %d:", j);
> +		for (k = 0; k < par[j]->stats->num_outliers; k++)
> +			printf(" %05lu", par[j]->stats->outliers[k]);
> +		if (par[j]->stats->num_outliers < par[j]->stats->hist_overflow)
> +			printf(" # %05lu others", par[j]->stats->hist_overflow - par[j]->stats->num_outliers);
> +                printf("\n");
> +        }
> +
>  	if (histofall && nthreads > 1)
>  		printf(" %05lu", alloverflows);
>  	printf("\n");
> @@ -1434,10 +1450,12 @@ int main(int argc, char **argv)
>  			int bufsize = histogram * sizeof(long);
>  
>  			stat->hist_array = threadalloc(bufsize, node);
> -			if (stat->hist_array == NULL)
> +			stat->outliers = threadalloc(bufsize, node);
> +			if (stat->hist_array == NULL || stat->outliers == NULL)
>  				fatal("failed to allocate histogram of size %d on node %d\n",
>  				      histogram, i);
>  			memset(stat->hist_array, 0, bufsize);
> +			memset(stat->outliers, 0, bufsize);
>  		}
>  
>  		if (verbose) {
> @@ -1553,8 +1571,10 @@ int main(int argc, char **argv)
>  
>  	if (histogram) {
>  		print_hist(parameters, num_threads);
> -		for (i = 0; i < num_threads; i++)
> +		for (i = 0; i < num_threads; i++) {
>  			threadfree(statistics[i]->hist_array, histogram*sizeof(long), parameters[i]->node);
> +			threadfree(statistics[i]->outliers, histogram*sizeof(long), parameters[i]->node);
> +                }
>  	}
>  
>  	if (tracelimit) {
> @@ -1564,7 +1584,7 @@ int main(int argc, char **argv)
>  			printf("# Break value: %lu\n", break_thread_value);
>  		}
>  	}
> -	
> +
>  
>  	for (i=0; i < num_threads; i++) {
>  		if (!statistics[i])
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
---1463806542-498766144-1350347595=:11097--
