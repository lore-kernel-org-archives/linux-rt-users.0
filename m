From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH] cyclictest histogram overflow instance tracking
Date: Mon, 15 Oct 2012 09:38:26 -0700
Message-ID: <6B64752A-B20A-4C14-A402-5859EF84D02B@vmware.com>
References: <21A665E0-66F4-4C7E-BDB2-820DDC5398C8@vmware.com>
 <507724B2.5050103@am.sony.com>
 <9C1EE6A5-2B57-45AC-B4D7-5AF7F56A7BCA@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	Garrett Smith <garrett@vmware.com>,
	Lenin Singaravelu <lsingara@vmware.com>
To: "frank.rowand@am.sony.com" <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-1.vmware.com ([208.91.2.12]:54485 "EHLO
	smtp-outbound-1.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751002Ab2JOQi3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 15 Oct 2012 12:38:29 -0400
In-Reply-To: <9C1EE6A5-2B57-45AC-B4D7-5AF7F56A7BCA@vmware.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Frank,

=46riendly ping, to make sure this doesn't fall through the cracks.

Thanks

- Bhavesh

On Oct 11, 2012, at 1:59 PM, Bhavesh Davda wrote:

> Thanks for the review, Frank.
>=20
> On Oct 11, 2012, at 12:57 PM, Frank Rowand wrote:
>> Nice idea=85
> Thanks
>=20
>> Suggest:
>>       printf("# Histogram Overflows at cycle number:");
>>=20
> Done
>=20
>>> - 		printf(" %05lu", par[j]->stats->hist_overflow);
>>> +		printf(" %05lu", par[j]->stats->hist_overflow);
>>=20
>> Am I blind, or is that a whitespace change?  (The latest version I h=
ave does not seem
>> to have any white space issues in that line.)
>>=20
> Turns out I had removed extraneous whitespace. My vim settings allow =
me to see extraneous whitespaces in red, so I get annoyed by them and c=
an fix them up. So I've removed a few more in the revised diffs (sorry!=
)
>=20
>> Suggest:
>>=20
>> +             printf("# thread %d:", j);
>>=20
> Done
>=20
>> Nit: You don't need stats->outliers_overflow.  You can calculate it =
from
>> stats->hist_overflow - stats->num_outliers:
>>=20
> Nice catch! I've removed outliers_overflow now.
>=20
>=20
> From: Bhavesh Davda <bhavesh@vmware.com>
>=20
> Add feature to cyclictest histogram mode to track cycle counts every =
time a
> sample overflows the histogram limit. This should help identify if th=
ere is a
> timing pattern to jitters in cyclictest runs.
>=20
> Example output (with -h 10):
>  ...
>  Histogram Overflows: 00000 00253 00000 00005 00000 00024 00003 00005
>  Histogram Overflow at cycle number:
>  Thread 0:
>  Thread 1: 00023 00028 00337 00338 00339 00340 00341 00342 00343 0034=
4 # 00243 others
>  Thread 2:
>  Thread 3: 10486 10487 10488 10489 10490
>  Thread 4:
>  Thread 5: 00002 00004 00008 00012 00178 10458 10459 10460 10461 1046=
2 # 00014 others
>  Thread 6: 05954 08954 29955
>  Thread 7: 20536 20537 20538 20539 20540
>  ...
>=20
> Signed-off-by: Bhavesh Davda <bhavesh@vmware.com>
> ---
> src/cyclictest/cyclictest.c |   38 +++++++++++++++++++++++++++++-----=
----
> 1 files changed, 29 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.=
c
> index 731b4bd..dc985de 100644
> --- a/src/cyclictest/cyclictest.c
> +++ b/src/cyclictest/cyclictest.c
> @@ -147,6 +147,7 @@ struct thread_stat {
> 	double avg;
> 	long *values;
> 	long *hist_array;
> +        unsigned long *outliers;
> 	pthread_t thread;
> 	int threadstarted;
> 	int tid;
> @@ -154,6 +155,7 @@ struct thread_stat {
> 	long redmax;
> 	long cycleofmax;
> 	long hist_overflow;
> +        long num_outliers;
> };
>=20
> static int shutdown;
> @@ -756,8 +758,11 @@ void *timerthread(void *param)
>=20
> 		/* Update the histogram */
> 		if (histogram) {
> -			if (diff >=3D histogram)
> +			if (diff >=3D histogram) {
> 				stat->hist_overflow++;
> +				if (stat->num_outliers < histogram)
> +					stat->outliers[stat->num_outliers++] =3D stat->cycles - 1;
> +			}
> 			else
> 				stat->hist_array[diff]++;
> 		}
> @@ -811,7 +816,7 @@ static void display_help(int error)
> 		if (kernvar(O_RDONLY, "available_tracers", tracers, sizeof(tracers)=
))
> 			strcpy(tracers, "none");
> 	}
> -	=09
> +
> 	printf("cyclictest V %1.2f\n", VERSION_STRING);
> 	printf("Usage:\n"
> 	       "cyclictest <options>\n\n"
> @@ -1188,7 +1193,7 @@ static int check_kernel(void)
> 		kv =3D KV_30;
> 		strcpy(functiontracer, "function");
> 		strcpy(traceroptions, "trace_options");
> -	=09
> +
> 	} else
> 		kv =3D KV_NOT_SUPPORTED;
>=20
> @@ -1226,7 +1231,7 @@ static void print_tids(struct thread_param *par=
[], int nthreads)
>=20
> static void print_hist(struct thread_param *par[], int nthreads)
> {
> -	int i, j;
> +	int i, j, k;
> 	unsigned long long int log_entries[nthreads+1];
> 	unsigned long maxmax, alloverflows;
>=20
> @@ -1270,7 +1275,7 @@ static void print_hist(struct thread_param *par=
[], int nthreads)
> 	printf("# Max Latencies:");
> 	maxmax =3D 0;
> 	for (j =3D 0; j < nthreads; j++) {
> - 		printf(" %05lu", par[j]->stats->max);
> +		printf(" %05lu", par[j]->stats->max);
> 		if (par[j]->stats->max > maxmax)
> 			maxmax =3D par[j]->stats->max;
> 	}
> @@ -1280,9 +1285,20 @@ static void print_hist(struct thread_param *pa=
r[], int nthreads)
> 	printf("# Histogram Overflows:");
> 	alloverflows =3D 0;
> 	for (j =3D 0; j < nthreads; j++) {
> - 		printf(" %05lu", par[j]->stats->hist_overflow);
> +		printf(" %05lu", par[j]->stats->hist_overflow);
> 		alloverflows +=3D par[j]->stats->hist_overflow;
> 	}
> +	printf("\n");
> +	printf("# Histogram Overflow at cycle number:\n");
> +	for (j =3D 0; j < nthreads; j++) {
> +		printf("# Thread %d:", j);
> +		for (k =3D 0; k < par[j]->stats->num_outliers; k++)
> +			printf(" %05lu", par[j]->stats->outliers[k]);
> +		if (par[j]->stats->num_outliers < par[j]->stats->hist_overflow)
> +			printf(" # %05lu others", par[j]->stats->hist_overflow - par[j]->=
stats->num_outliers);
> +                printf("\n");
> +        }
> +
> 	if (histofall && nthreads > 1)
> 		printf(" %05lu", alloverflows);
> 	printf("\n");
> @@ -1434,10 +1450,12 @@ int main(int argc, char **argv)
> 			int bufsize =3D histogram * sizeof(long);
>=20
> 			stat->hist_array =3D threadalloc(bufsize, node);
> -			if (stat->hist_array =3D=3D NULL)
> +			stat->outliers =3D threadalloc(bufsize, node);
> +			if (stat->hist_array =3D=3D NULL || stat->outliers =3D=3D NULL)
> 				fatal("failed to allocate histogram of size %d on node %d\n",
> 				      histogram, i);
> 			memset(stat->hist_array, 0, bufsize);
> +			memset(stat->outliers, 0, bufsize);
> 		}
>=20
> 		if (verbose) {
> @@ -1553,8 +1571,10 @@ int main(int argc, char **argv)
>=20
> 	if (histogram) {
> 		print_hist(parameters, num_threads);
> -		for (i =3D 0; i < num_threads; i++)
> +		for (i =3D 0; i < num_threads; i++) {
> 			threadfree(statistics[i]->hist_array, histogram*sizeof(long), para=
meters[i]->node);
> +			threadfree(statistics[i]->outliers, histogram*sizeof(long), param=
eters[i]->node);
> +                }
> 	}
>=20
> 	if (tracelimit) {
> @@ -1564,7 +1584,7 @@ int main(int argc, char **argv)
> 			printf("# Break value: %lu\n", break_thread_value);
> 		}
> 	}
> -=09
> +
>=20
> 	for (i=3D0; i < num_threads; i++) {
> 		if (!statistics[i])
> --=20
> 1.7.1
>=20

--
Bhavesh Davda
bhavesh@vmware.com






--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
