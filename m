From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Thu, 15 Nov 2012 18:24:23 -0800
Message-ID: <50A5A3D7.7090904@am.sony.com>
References: <1376702282.1876429.1353030991353.JavaMail.root@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	John Kacur <jkacur@redhat.com>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from [216.32.181.183] ([216.32.181.183]:6094 "EHLO
	ch1outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1750804Ab2KPCZp (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 15 Nov 2012 21:25:45 -0500
In-Reply-To: <1376702282.1876429.1353030991353.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/15/12 17:56, Bhavesh Davda wrote:
> From: Bhavesh Davda <bhavesh@vmware.com>
> 
> Add a new command line option '-g' (long option '--of_max') to cap
> how many outliers are tracked per thread.

< snip >

> ---
> 
>> | Add a line to the histogram overflow cycle report that merges
>> all | threads into a single time line.  This is controlled by the
>> -H | option which already serves a similar purpose for histograms.
>> 
>> The merged data line is an enhancement.  If there is no strong 
>> request from anyone for the feature then no need to include.  But
>> it seems useful to me.
> 
> I agree this is a useful feature request, but harder to implement,
> since I'll have to merge sort from the per-thread outliers to produce
> a single line merged outlier output. I hope it's okay if I punt on
> this one.

It is ok to punt.  But the code to do it was in my patch if you want it.
It is the block of code inside of "if (histofall && nthreads > 1) { ... }".
The code is a little bit ugly, but not totally terrible.

< snip >

I'll look over and test the rest of the patch in a moment (well
actually the next version, which you already sent), as soon
as I finish debugging an email problem.

-Frank

