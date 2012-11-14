From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: histogram overflow instance tracking
Date: Tue, 13 Nov 2012 16:02:54 -0800
Message-ID: <50A2DFAE.7010306@am.sony.com>
References: <880517104.255767.1352850809690.JavaMail.root@redhat.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: John Kacur <jkacur@redhat.com>, Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from co1ehsobe001.messaging.microsoft.com ([216.32.180.184]:11608
	"EHLO co1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756035Ab2KNACt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 13 Nov 2012 19:02:49 -0500
In-Reply-To: <880517104.255767.1352850809690.JavaMail.root@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/13/12 15:53, John Kacur wrote:
> 
> 
> ----- Original Message -----
>> Hello Frank,
>>
>> I apologize I didn't have a chance to review your proposed
>> modifications to my patch.
>>
>> I had looked at your proposal to introduce a '-g' option (for lack of
>> a better letter) instead of piggy-backing on the '-h' option, and I
>> completely agree with that approach.
>>
>> It would be very handy to specify, for example, '-h 50 -g 1000' to
>> capture and print the 1000 outliers beyond 50 us to get a good sense
>> of any patterns hidden in the outliers.
>>
>> If John has already accepted my proposed patches, do you want to
>> propose your changes on top of that as a separate patch now?

Bhavesh,

I would agree with John's suggestions (the following paragraph).  I did not
want to hijack your feature, but instead just help make it better, so I was
phrasing my stuff as suggestions, not as "you must do this" type of
additions.  So I would prefer you still own the feature.  If you propose
a further patch based on my suggestions, I will review and test it.

> 
> Please pull the git tree, have a look at what I put in, and then think about
> Frank's suggestions. Make sure you are "proactive" - (oh God, thinking about 
> a Simpson's episode now), and see what you can do with it, instead of just
> waiting for Frank to tell you his opinions.
> 
> Thanks!
> 
>>
>> Thanks for your review, and your excellent suggestion to make this
>> feature even more useful.
>>
>> --
>> Bhavesh Davda

< snip >

