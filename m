From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH] cyclictest histogram overflow instance tracking
Date: Thu, 11 Oct 2012 12:57:38 -0700
Message-ID: <507724B2.5050103@am.sony.com>
References: <21A665E0-66F4-4C7E-BDB2-820DDC5398C8@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Garrett Smith <garrett@vmware.com>,
	Lenin Singaravelu <lsingara@vmware.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from va3ehsobe004.messaging.microsoft.com ([216.32.180.14]:11560
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752077Ab2JKT5w (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 11 Oct 2012 15:57:52 -0400
In-Reply-To: <21A665E0-66F4-4C7E-BDB2-820DDC5398C8@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/11/12 11:42, Bhavesh Davda wrote:
> From: Bhavesh Davda <bhavesh@vmware.com>
> 
> Add feature to cyclictest histogram mode to track cycle counts every time a
> sample overflows the histogram limit. This should help identify if there is a
> timing pattern to jitters in cyclictest runs.

Nice idea...

> 
> Example output (with -h 10):
>   ...
>   Histogram Overflows: 00278
>   Histogram Overflow instances:
>     09373 09374 09375 09376 09377 09378 09379 09380 09381 09382 # 00268 others
> 
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> ---
>  src/cyclictest/cyclictest.c |   32 +++++++++++++++++++++++++++-----
>  1 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> index 731b4bd..31131ad 100644
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
> @@ -154,6 +155,8 @@ struct thread_stat {
>  	long redmax;
>  	long cycleofmax;
>  	long hist_overflow;
> +        long num_outliers;
> +        long outliers_overflow;
>  };
>  
>  static int shutdown;
> @@ -756,8 +759,13 @@ void *timerthread(void *param)
>  
>  		/* Update the histogram */
>  		if (histogram) {
> -			if (diff >= histogram)
> +			if (diff >= histogram) {
>  				stat->hist_overflow++;
> +				if (stat->num_outliers < histogram)
> +					stat->outliers[stat->num_outliers++] = stat->cycles - 1;
> +				else
> +					stat->outliers_overflow++;
> +			}
>  			else
>  				stat->hist_array[diff]++;
>  		}
> @@ -1226,7 +1234,7 @@ static void print_tids(struct thread_param *par[], int nthreads)
>  
>  static void print_hist(struct thread_param *par[], int nthreads)
>  {
> -	int i, j;
> +	int i, j, k;
>  	unsigned long long int log_entries[nthreads+1];
>  	unsigned long maxmax, alloverflows;
>  
> @@ -1280,9 +1288,19 @@ static void print_hist(struct thread_param *par[], int nthreads)
>  	printf("# Histogram Overflows:");

Suggest:
        printf("# Histogram Overflows at cycle number:");

>  	alloverflows = 0;
>  	for (j = 0; j < nthreads; j++) {

> - 		printf(" %05lu", par[j]->stats->hist_overflow);
> +		printf(" %05lu", par[j]->stats->hist_overflow);

Am I blind, or is that a whitespace change?  (The latest version I have does not seem
to have any white space issues in that line.)

>  		alloverflows += par[j]->stats->hist_overflow;
>  	}
> +	printf("\n");
> +	printf("# Histogram Overflow instances:\n");
> +	for (j = 0; j < nthreads; j++) {

Suggest:

  +             printf("# thread %d:", j);

Before this patch, a graphing program that treats lines beginning with "#" as a
comment could graph the histogram output.

> +		for (k = 0; k < par[j]->stats->num_outliers; k++)
> +			printf(" %05lu", par[j]->stats->outliers[k]);

Nit: You don't need stats->outliers_overflow.  You can calculate it from
stats->hist_overflow - stats->num_outliers:

> +		if (par[j]->stats->outliers_overflow > 0)
> +			printf(" # %05lu others", par[j]->stats->outliers_overflow);
> +                printf("\n");
> +        }
> +
>  	if (histofall && nthreads > 1)
>  		printf(" %05lu", alloverflows);
>  	printf("\n");
> @@ -1434,10 +1452,12 @@ int main(int argc, char **argv)
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
> @@ -1553,8 +1573,10 @@ int main(int argc, char **argv)
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


