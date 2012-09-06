From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: Pthread Condition Variables and Priority Inversion
Date: Wed, 05 Sep 2012 17:10:39 -0700
Message-ID: <5047E9FF.2070803@linux.intel.com>
References: <5047DD91.3030402@linux.intel.com> <5047E749.3040507@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: frank.rowand@am.sony.com
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28927 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759859Ab2IFALP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 5 Sep 2012 20:11:15 -0400
In-Reply-To: <5047E749.3040507@am.sony.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 09/05/2012 04:59 PM, Frank Rowand wrote:
> On 09/05/12 16:17, Darren Hart wrote:
>> Hi Michael,
>>
>> I've tried many times over the last several years to get proper priority
>> inheritance support for pthread condition variables added to glibc.
>> Unfortunately, I haven't convinced the powers that be to incorporate the
>> proposed fixes. Since the failure scenario involves an opaque type and
>> is rather non-intuitive, it was suggested (thanks Frank) that I attempt
>> to at least document the behavior.
> 
> < snip >
> 
> That reminds me...  someone at Plumbers (I'm pretty sure it was Thomas)
> told me that the glibc maintainers have become much more responsive,
> so maybe I should encourage you to try once again, when you find some
> spare time :-), submitting to glibc.

I think Jan and I both intend to do this, but until such time as we can,
I'd like the docs to reflect reality.

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
