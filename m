From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Mon, 17 Dec 2012 13:34:20 -0800
Message-ID: <50CF8FDC.3090307@am.sony.com>
References: <1021286613.24677841.1355768653269.JavaMail.root@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe006.messaging.microsoft.com ([213.199.154.209]:12812
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751180Ab2LQVeb (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 17 Dec 2012 16:34:31 -0500
In-Reply-To: <1021286613.24677841.1355768653269.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/17/12 10:24, Bhavesh Davda wrote:
>>> I'm going to respond to your proposed patch next.
>>> 
>>> Thanks
>>> 
>>> - Bhavesh
>> 
>> ping....
>> 
>> Thanks,
>> 
>> Frank
> 
> Hello Frank,
> 
> Extremely sorry about the tardiness in reviewing your proposed
> change!

No problem.  Life is busy, we progress as we can.

> Your change looks good to me. Again, did you want me to fold your
> proposed change into my original patch, or were you proposing
> applying your patch (of course without the #if 0's) on top of mine?

It would be great if you could add my changes on top of your original patch
since John hasn't committed your original patch yet.  That way everything
will be coordinated from one person.  And yes, without the "#if 0's".

It would probably be good to submit it to John as a series of two patches,
your original patch, followed by my additions.

For my patch, you can add: Signed-off-by: Frank Rowand <frank.rowand@am.sony.com>

My patch did not address one other comment I made, which is:

  default of -g to zero means histogram overflows will be printed even
  if "-g" not specified (same as "-g 0").  The output of histogram
  overflows should only occur if of_max > 0.


> Thanks for spending so much time reviewing my patches, trying them
> out, and suggesting ways to make it better!

Your welcome!

-Frank


