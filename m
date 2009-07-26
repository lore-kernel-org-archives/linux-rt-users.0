From: "H. Peter Anvin" <h.peter.anvin@intel.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Sun, 26 Jul 2009 12:16:27 -0700
Message-ID: <4A6CAB8B.4080706@intel.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com> <4A6981B0.3000008@siemens.com> <4A6ABF28.1010602@redhat.com> <4A6AD69E.7030201@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Avi Kivity <avi@redhat.com>,
	Gregory Haskins <gregory.haskins@gmail.com>,
	kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Jan Kiszka <jan.kiszka@web.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:53859 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368AbZGZTQt (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Sun, 26 Jul 2009 15:16:49 -0400
In-Reply-To: <4A6AD69E.7030201@web.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Jan Kiszka wrote:
> Avi Kivity wrote:
>> On 07/24/2009 12:41 PM, Jan Kiszka wrote:
>>> I vaguely recall that someone promised to add a feature reporting
>>> facility for all those nice things, modern VM-extensions may or may not
>>> support (something like or even an extension of /proc/cpuinfo). What is
>>> the state of this plan? Would be specifically interesting for Intel CPUs
>>> as there seem to be many of them out there with restrictions for special
>>> use cases - like real-time.
>>>    
>> Newer kernels do report some vmx features (like flexpriority) in
>> /proc/cpuinfo but not all.
>>
> 
> Ah, nice. Then we just need this?
> 

Fine with me.

Acked-by: H. Peter Anvin <hpa@zytor.com>

However, I guess the real question if we shouldn't export ALL VMX
features in a consistent way instead?

	-hpa
