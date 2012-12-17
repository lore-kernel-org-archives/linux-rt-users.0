From: Bhavesh Davda <bhavesh@vmware.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for
 histogram overflow instance tracking
Date: Mon, 17 Dec 2012 14:17:35 -0800 (PST)
Message-ID: <817126228.24970734.1355782655348.JavaMail.root@vmware.com>
References: <50CF8FDC.3090307@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
To: frank rowand <frank.rowand@am.sony.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp-outbound-2.vmware.com ([208.91.2.13]:45396 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754071Ab2LQW2D (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Dec 2012 17:28:03 -0500
In-Reply-To: <50CF8FDC.3090307@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>


> It would be great if you could add my changes on top of your original
> patch
> since John hasn't committed your original patch yet.  That way
> everything
> will be coordinated from one person.  And yes, without the "#if 0's".
> 
> It would probably be good to submit it to John as a series of two
> patches,
> your original patch, followed by my additions.
> 
> For my patch, you can add: Signed-off-by: Frank Rowand
> <frank.rowand@am.sony.com>
> 
> My patch did not address one other comment I made, which is:
> 
>   default of -g to zero means histogram overflows will be printed
>   even
>   if "-g" not specified (same as "-g 0").  The output of histogram
>   overflows should only occur if of_max > 0.


I'll see if I can address that in a potentially 3rd part of a 3 patch series.

One thing I noticed when actually creating the 2nd patch, in your change:

@@ -890,7 +904,7 @@ void *timerthread(void *param)
                        if (diff >= histogram) {
                                stat->hist_overflow++;
                                if (stat->num_outliers < of_max)
-                                       stat->outliers[stat->num_outliers++] = stat->cycles;
+                                       stat->outliers[stat->num_outliers++] = next;
                        }
                        else
                                stat->hist_array[diff]++;

Should that be:
+                                       stat->outliers[stat->num_outliers++] = now;

instead?

Also, not your fault, but I fixed another white space issue here:

@@ -151,7 +153,7 @@ struct thread_stat {
        double avg;
        long *values;
        long *hist_array;
-        long *outliers;
+        struct timespec *outliers;
        pthread_t thread;
        int threadstarted;
        int tid;

And finally, as far as output format for the outliers is concerned, I'm slightly worried it takes too much screen real estate by printing one line per outlier per thread. But that's quite subjective and I wouldn't be opposed to living with it for a while and seeing if it starts to get annoying :)

Thanks

- Bhavesh
