From: Frank Rowand <frank.rowand@am.sony.com>
Subject: Re: [PATCH RT-TESTS] cyclictest: new command line switch for histogram
 overflow instance tracking
Date: Tue, 11 Dec 2012 17:45:45 -0800
Message-ID: <50C7E1C9.60102@am.sony.com>
References: <1463873663.4023529.1353965874630.JavaMail.root@vmware.com>
Reply-To: <frank.rowand@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: John Kacur <jkacur@redhat.com>,
	"linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: Bhavesh Davda <bhavesh@vmware.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from am1ehsobe005.messaging.microsoft.com ([213.199.154.208]:40321
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753593Ab2LLBpv (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 11 Dec 2012 20:45:51 -0500
In-Reply-To: <1463873663.4023529.1353965874630.JavaMail.root@vmware.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/26/12 13:37, Bhavesh Davda wrote:
>> On 11/16/12 18:41, Frank Rowand wrote:
>>> On 11/16/12 18:31, Frank Rowand wrote:
>>> 
>>> < snip >
>>> 
>>>> I graphed the results with the msec data and with the
>>>> nanosecond timestamps for an artificial test (two test runs for
>>>> each case):
>>>> 
>>>> nanosecond:  junk7.gif    junk10.gif msec:        junk8_d.gif
>>>> junk9_d.gif
>>>> 
>>>> The cyclictest latency disruptions seem more visible to me in
>>>> the nanosecond data graphs.  But that is just a first
>>>> impression without playing around with a lot of different data
>>>> sets.
>>> 
>>> John, Bhavesh,
>>> 
>>> OK, so after all of that, I'm going on vacation for a week. I
>>> hope the rest of you are taking some time off too.
>> 
>> I'm back...  Bhavesh, have you had a chance to think about my last 
>> several emails (my comments on your latest patch, my proposed
>> patch, and the email I'm responding to)?  Any comments?
> 
> Hello Frank. Welcome back. I was out for the long weekend and am just
> getting back in the swing of things too, so sorry about the delay.
> 
> I do have real use cases for this "outlier" mode, that I've used
> effectively to identify sources of high latencies of cyclictest
> running in a Linux-rt kernel based VM on our VMware ESXi hypervisor.
> The patterns in the outliers, for various thresholds (e.g. 50 us)
> have helped me identify timers and callbacks in the hypervisor kernel
> (vmkernel) which have caused time to be "stolen" away from scheduling
> the virtual CPUs of the VM to do various housekeeping tasks, and to
> either move those timers out to other physical CPUs or to limit the
> time spend in those timers and callbacks to have a smaller impact on
> the cyclictest latencies.
> 
> I'm hoping that others in the community find similar uses of this
> "outlier" feature of cyclictest.
> 
> That said, I realize that not every use cases might fit my exact
> mould and might require either different formatting, or different
> granularities of the "outliers" output. So I'm open to suggestions in
> that regard.
> 
> I'm going to respond to your proposed patch next.
> 
> Thanks
> 
> - Bhavesh

ping....

Thanks,

Frank

