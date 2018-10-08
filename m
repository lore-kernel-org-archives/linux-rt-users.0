Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbeJIFBh (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 9 Oct 2018 01:01:37 -0400
Date: Mon, 8 Oct 2018 16:47:47 -0500
From: Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] cyclictest: only print non-zero values in histogram
 output
Message-ID: <20181008164747.3afab224@tagon>
In-Reply-To: <e8080a04-597a-2bb3-f745-6a6c75b7dd5c@oth-regensburg.de>
References: <20180913125239.32679-1-ralf.ramsauer@oth-regensburg.de>
        <alpine.LFD.2.21.1809261251270.6531@planxty>
        <43c66b87-f3e6-6bb1-b83e-5632a6676077@oth-regensburg.de>
        <4b26cf5f-ff58-ea60-4e05-effe4b67b76d@gmail.com>
        <e8080a04-597a-2bb3-f745-6a6c75b7dd5c@oth-regensburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Cc: Frank Rowand <frowand.list@gmail.com>, John Kacur <jkacur@redhat.com>, John Kacur <jkacur@gmail.com>, Linux RT Users <linux-rt-users@vger.kernel.org>

On Wed, 26 Sep 2018 21:18:30 +0200
Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de> wrote:

> On 9/26/18 8:46 PM, Frank Rowand wrote:
> > On 09/26/18 04:15, Ralf Ramsauer wrote:  
> >>
> >>
> >> On 9/26/18 12:53 PM, John Kacur wrote:  
> >>>
> >>>
> >>> On Thu, 13 Sep 2018, Ralf Ramsauer wrote:
> >>>  
> >>>> If the histogram output is enabled, cyclictest dumps lines of all latencies,
> >>>> even if the specific latency was never hit. For analysing a histogram, it is
> >>>> sufficient to only dump latencies that actually occured. This patch skips
> >>>> latencies that were never hit with respect to all threads.
> >>>>
> >>>> If cyclictest is used in combination with --nsecs, this removes a lot of
> >>>> output noise.
> >>>>
> >>>> It shrinks output to:
> >>>>   $ cyclictest --threads 2 --affinity 2-3 --priority 99 --histofall 100 --loops 100000
> >>>>   # /dev/cpu_dma_latency set to 0us
> >>>>   policy: fifo: loadavg: 0.03 0.13 0.07 1/560 1248
> >>>>
> >>>>   T: 0 ( 1228) P:99 I:1000 C: 100000 Min:      2 Act:    2 Avg:    2 Max:  4
> >>>>   T: 1 ( 1229) P:99 I:1000 C: 100000 Min:      2 Act:    2 Avg:    2 Max:  4
> >>>>   # Histogram
> >>>>   000002 069425   067138  136563
> >>>>   000003 030536   032850  063386
> >>>>   000004 000039   000012  000051
> >>>>   # Total: 000100000 000100000 000200000
> >>>>   # Min Latencies: 00002 00002
> >>>>   # Avg Latencies: 00002 00002
> >>>>   # Max Latencies: 00004 00004 00004
> >>>>   # Histogram Overflows: 00000 00000 00000
> >>>>   # Histogram Overflow at cycle number:
> >>>>   # Thread 0:
> >>>>   # Thread 1:
> >>>>
> >>>> Signed-off-by: Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
> >>>> ---
> >>>>  src/cyclictest/cyclictest.c | 13 ++++++++++---
> >>>>  1 file changed, 10 insertions(+), 3 deletions(-)
> >>>>
> >>>> diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> >>>> index 8d9ec80..0e8459c 100644
> >>>> --- a/src/cyclictest/cyclictest.c
> >>>> +++ b/src/cyclictest/cyclictest.c
> >>>> @@ -1988,16 +1988,23 @@ static void print_hist(struct thread_param *par[], int nthreads)
> >>>>  	fprintf(fd, "# Histogram\n");
> >>>>  	for (i = 0; i < histogram; i++) {
> >>>>  		unsigned long long int allthreads = 0;
> >>>> +		unsigned long curr_latency = 0;
> >>>> +
> >>>> +		for (j = 0; j < nthreads ; j++) {
> >>>> +			curr_latency = par[j]->stats->hist_array[i];
> >>>> +			allthreads += curr_latency;
> >>>> +			log_entries[j] += curr_latency;
> >>>> +		}
> >>>> +		if (!allthreads)
> >>>> +			continue;
> >>>>  
> >>>>  		fprintf(fd, "%06d ", i);
> >>>>  
> >>>>  		for (j = 0; j < nthreads; j++) {
> >>>> -			unsigned long curr_latency=par[j]->stats->hist_array[i];
> >>>> +			curr_latency = par[j]->stats->hist_array[i];
> >>>>  			fprintf(fd, "%06lu", curr_latency);
> >>>>  			if (j < nthreads - 1)
> >>>>  				fprintf(fd, "\t");
> >>>> -			log_entries[j] += curr_latency;
> >>>> -			allthreads += curr_latency;
> >>>>  		}
> >>>>  		if (histofall && nthreads > 1) {
> >>>>  			fprintf(fd, "\t%06llu", allthreads);
> >>>> -- 
> >>>> 2.19.0
> >>>>
> >>>>  
> >>>
> >>> Note, although I initially accepted this patch I may have to revert it.
> >>> The output of the histogram is not consumed just by humans but by 
> >>> software, namely rteval  
> >>
> >> Narf, didn't know.  
> > 
> > I considered commenting on this patch when it was first submitted, then
> > decided not to since I am no longer actively using cyclictest.  But it
> > sounds like I can add some insight on usage of histogram data.
> > 
> > One of the ways that histogram data can be used is to create a line graph.
> > In this case, it is important to have a zero value at the beginning and
> > end of a range of zero values.  This is maybe easiest to illustrate with
> > a simple data set of x (latency) and y (occurances):
> > 
> >   1   5
> >   2   7
> >   3   0
> >   4   0
> >   5   0
> >   6   9
> >   7  11
> >   8  25
> >   9   0
> > 
> > If the zero values are left out, then the graph will show a straight line
> > from 2,7 to 6,9, which is very misleading.  
> 
> I see the point, but for further visualisation of data, I prefer to use
> density plots created by some software (R/gnuplot/younameit) than trying
> to interprate command line output, which might be several sites long.
> 
>   I'm currently writing a R script that is able to parse, plot and
> compare (multiple) cyclictest output files. I can publish it, if someone
> is interested.

I'm interested and would love to see it. I've been fighting with gnuplot for
ten years or so and would like to have an alternative. :)

> 
> > 
> > When I was creating a lot of cyclictest data, I had a simple filter program
> > that stripped out the extraneous zero values, leaving only the first and
> > last zero value in a contiguous range of zero values.  I did this both to
> > make the data files smaller (use less space and transfer faster across a
> > slow data link) and to make them easier to examine in a text editor.  
> 
> Ack, this is exactly the motivation behind this patch. I'm running
> cyclictest with ns resolution and a high maximum of max. histogram
> latency. Most of the values are never hit, but I'd like to see all
> extreme outliers. Cyclictest produced files with several hundret MiB,
> while this tiny fix can extremely shrink it -- data is useless, so
> instead of producing and filtering it, simply don't print it.
> 
> > 
> > The reason I did not speak up is that with cyclictest not outputting zero
> > values my filter program would simply have to be changed to sort-of the
> > inverse of what it does now: insert the first and last zero values.
> > 
> > Whether the data includes or excludes the zero data, it is a simple
> > filter program to transform it.  Though having options to exclude
> > excessive zero values instead of all zero values would be a nice
> > feature for cyclictest.  (Not volunteering to write the code. :-))  
> 
> Yet another command line switch... :) I can add an additional switch, if
> desired. I leave the decision up to the maintainer, though I still think
> that zero lines are useless in any case.
> 
> BTW: Patches for rteval are ready! I'll send them soon, they will
> support both, the old and new output format.

I look forward to another perspective on rteval.

Clark


-- 
The United States Coast Guard
Ruining Natural Selection since 1790
