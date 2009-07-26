From: Avi Kivity <avi@redhat.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sun, 26 Jul 2009 17:45:40 +0300
Message-ID: <4A6C6C14.4030805@redhat.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6B1C15.6090608@redhat.com> <4A6C6970.6060200@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:34521 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753546AbZGZOlS (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 10:41:18 -0400
In-Reply-To: <4A6C6970.6060200@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 07/26/2009 05:34 PM, Jan Kiszka wrote:
> Avi Kivity wrote:
>    
>> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>>      
>>> Jan (who is now patching his guest to avoid wbinvd where possible)
>>>
>>>
>>>        
>> Is there ever a case where it is required?  What about under a
>> hypervisor (i.e. check the hypervisor enabled bit).
>>
>>      
>
> Reminds me of the discussion in '07 when I first stumbled over this :) :
> Yes, the bochs bios could safely skip the wbinvd in qemu mode. But that
> won't safe us from Linux and - far more problematic - Windows or any
> binary-only guest which think they have to issue it.
>
> One may the close eyes, fire up the guest and then start the
> time-critical host application in the hope that the guest remains calm
> as long as it's up and running. But, well...
>    

Given that it's now '09, how critical is the problem?  Don't most cpus 
have vwbinvd now?

If so, the real-time management application can simply refuse to run on 
such an old processor.

-- 
error compiling committee.c: too many arguments to function

