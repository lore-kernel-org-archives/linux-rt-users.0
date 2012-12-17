From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Mon, 17 Dec 2012 15:30:45 -0800
Message-ID: <50CFAB25.90209@am.sony.com>
References: <817126228.24970734.1355782655348.JavaMail.root@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [216.32.180.185] ([216.32.180.185]:53713 "EHLO
	co1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753209Ab2LQXc3 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Dec 2012 18:32:29 -0500
In-Reply-To: <817126228.24970734.1355782655348.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/17/12 14:17, Bhavesh Davda wrote:
> 
>> It would be great if you could add my changes on top of your original
>> patch
>> since John hasn't committed your original patch yet.  That way
>> everything
>> will be coordinated from one person.  And yes, without the "#if 0's".
>>
>> It would probably be good to submit it to John as a series of two
>> patches,
>> your original patch, followed by my additions.
>>
>> For my patch, you can add: Signed-off-by: Frank Rowand
>> <frank.rowand@am.sony.com>
>>
>> My patch did not address one other comment I made, which is:
>>
>>   default of -g to zero means histogram overflows will be printed
>>   even
>>   if "-g" not specified (same as "-g 0").  The output of histogram
>>   overflows should only occur if of_max > 0.
> 
> 
> I'll see if I can address that in a potentially 3rd part of a 3 patch series.
> 
> One thing I noticed when actually creating the 2nd patch, in your change:
> 
> @@ -890,7 +904,7 @@ void *timerthread(void *param)
>                         if (diff >= histogram) {
>                                 stat->hist_overflow++;
>                                 if (stat->num_outliers < of_max)
> -                                       stat->outliers[stat->num_outliers++] = stat->cycles;
> +                                       stat->outliers[stat->num_outliers++] = next;
>                         }
>                         else
>                                 stat->hist_array[diff]++;
> 
> Should that be:
> +                                       stat->outliers[stat->num_outliers++] = now;
> 
> instead?

Both next and now are valid choices.  If one was to get totally carried away both
values could be reported.  I don't think it is critical which one is used, as
long as it is clearly documented.  For those reading along at home:

  next is the beginning time stamp of the delay (when execution should have occurred)

  now is the ending time stamp of the delay (when execution did occur)

Different causes of periodic latency causes might be more apparent with one time or
the other.  I suspect that whichever one is used that I will on occasion modify
cyclictest to report the other one.


> Also, not your fault, but I fixed another white space issue here:
> 
> @@ -151,7 +153,7 @@ struct thread_stat {
>         double avg;
>         long *values;
>         long *hist_array;
> -        long *outliers;
> +        struct timespec *outliers;
>         pthread_t thread;
>         int threadstarted;
>         int tid;

There are still a handful of white space issues if you want to kill
them all with one patch (just look for a space in the first or last
column).  I was just going to wait to everything else settled out to
submit a patch for that.


> And finally, as far as output format for the outliers is concerned, I'm slightly worried it takes too much screen real estate by printing one line per outlier per thread. But that's quite subjective and I wouldn't be opposed to living with it for a while and seeing if it starts to get annoying :)

Agreed.  Two different use cases argue for different output format.  I'm used to
processing large batches of data and frequently graph the data to make it more
manageable.  But if you are looking at the raw data on a screen then many values
per line is more effective use of real estate.  It isn't too hard to convert back
and forth.  So given my use case, my one vote (for whatever that is worth) is for
the screen real estate wasting format.

-Frank

