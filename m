From: Avi Kivity <avi@redhat.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sat, 25 Jul 2009 16:27:19 +0300
Message-ID: <4A6B0837.6010608@redhat.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6ABF28.1010602@redhat.com> <4A6AD69E.7030201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:56095 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751707AbZGYN1h (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sat, 25 Jul 2009 09:27:37 -0400
In-Reply-To: <4A6AD69E.7030201@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/25/2009 12:55 PM, Jan Kiszka wrote:
> Avi Kivity wrote:
>    
>> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>>      
>>> I vaguely recall that someone promised to add a feature reporting
>>> facility for all those nice things, modern VM-extensions may or may not
>>> support (something like or even an extension of /proc/cpuinfo). What is
>>> the state of this plan? Would be specifically interesting for Intel CPUs
>>> as there seem to be many of them out there with restrictions for special
>>> use cases - like real-time.
>>>
>>>        
>> Newer kernels do report some vmx features (like flexpriority) in
>> /proc/cpuinfo but not all.
>>
>>      
>
> Ah, nice. Then we just need this?
>
> ------------>
>
> From: Jan Kiszka<jan.kiszka@siemens.com>
> Subject: [PATCH] x86: Report VMX feature vwbinvd
>
> Not all VMX-capable CPUs support guest exists on wbinvd execution. If
> this is not supported, the instruction will run natively on behalf of
> the guest. This can cause multi-millisecond latencies to the host which
> is very problematic in real-time scenarios.
>
> Report the wbinvd trapping feature along with other VMX feature flags,
> calling it 'vwbinvd' ('virtual wbinvd').
>
>    

What about AMD cpus that can always trap wbinvd?  do we set the bit or 
do we trust the user to know that it isn't needed on AMD (I suppose the 
latter)?

This should go in via tip.git, it isn't really kvm related (except that 
kvm should start reading these caps one day instead of querying the 
hardware directly).

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

