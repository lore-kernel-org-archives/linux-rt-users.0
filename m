From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: Pthread Condition Variables and Priority Inversion
Date: Fri, 14 Sep 2012 12:28:30 -0700
Message-ID: <5053855E.1090802@linux.intel.com>
References: <5047DD91.3030402@linux.intel.com> <5047E749.3040507@am.sony.com> <5047E9FF.2070803@linux.intel.com> <740C4A5BFE01244180687FD9526EB33C0148257965@MBX19.EXCHPROD.USA.NET> <5053650A.5020408@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Carol Wong <carolw@netacquire.com>,
	"frank.rowand@am.sony.com" <frank.rowand@am.sony.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jan Kiszka <jan.kiszka@siemens.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:64771 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759973Ab2INT3B (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 14 Sep 2012 15:29:01 -0400
In-Reply-To: <5053650A.5020408@siemens.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 09/14/2012 10:10 AM, Jan Kiszka wrote:
> On 2012-09-14 04:16, Carol Wong wrote:
>> <snip>
>>
>>>>
>>>> That reminds me...  someone at Plumbers (I'm pretty sure it was
>>> Thomas)
>>>> told me that the glibc maintainers have become much more responsive,
>>>> so maybe I should encourage you to try once again, when you find some
>>>> spare time :-), submitting to glibc.
>>>
>>> I think Jan and I both intend to do this, but until such time as we can,
>>> I'd like the docs to reflect reality.
>>>
>>> --
>>> Darren Hart
>>> Intel Open Source Technology Center
>>> Yocto Project - Technical Lead - Linux Kernel
>>
>> We've run up against this condvar limitation on the system (glibc 2.15 on Linux with RT patch) we've been developing.
>>
>> How can we help nudge the glibc maintainers? Is there some issue/fix voting system?
> 
> Well, at least this one is not working properly yet:
> 
> http://sourceware.org/bugzilla/show_bug.cgi?id=11588
> 
> Does someone have personal contact to a key persons from the community
> and can raise the awareness level there?

This bug has all the context, so this is definitely the place to focus.
As for nudging people along in the right direction, I've tried appealing
to Mark Brown and the POSIX committee without success. I suppose we
could go back and review whatever changes were to the glibc development
processes and email the relevant individuals.


-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Technical Lead - Linux Kernel
