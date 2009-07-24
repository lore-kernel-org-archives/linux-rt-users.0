From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: Host latency peaks due to kvm-intel
Date: Fri, 24 Jul 2009 11:41:04 +0200
Message-ID: <4A6981B0.3000008@siemens.com>
References: <4A68A6E5.6010808@siemens.com> <4A68BD5D.1070302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: kvm-devel <kvm@vger.kernel.org>,
	RT <linux-rt-users@vger.kernel.org>, Avi Kivity <avi@redhat.com>,
	"Yang, Sheng" <sheng.yang@intel.com>
To: Gregory Haskins <gregory.haskins@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from lizzard.sbs.de ([194.138.37.39]:24453 "EHLO lizzard.sbs.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168AbZGXJl1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Fri, 24 Jul 2009 05:41:27 -0400
In-Reply-To: <4A68BD5D.1070302@gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Gregory Haskins wrote:
> Jan Kiszka wrote:
>> Hi,
>>
>> did anyone recently tried current KVM for Intel over some real-time
>> Linux? I'm seeing more than 500 us latency peaks on the host,
>> specifically during VM startup. This applies to both 2.6.29.6-rt23 and
>> Xenomai/I-pipe. For -rt, I both tried the included (patched) KVM modules
>> as well as kvm.git head with some additionally required -rt fixes.
>> Xenomai ran over a 2.6.30 kernel with my own KVM-enabler patch.
>>
>> Early instrumentation actually points to the guest exit itself: I added
>> markers right before and after the assembly part of vmx_vcpu_run, and
>> further instrumentation reports that the next host APIC tick should go
>> off right inside guest mode. But KVM leaves the switching part 500 us
>> too late in that case - as if guest exit on external IRQs was disabled.
>>
>> Will debug this further, but I'm also curious to hear other user
>> experiences.
>>
>> Jan
>>
>>   
> Hi Jan,
>   Did you try to run with latency-tracer enabled?  If not, this may
> pinpoint the source for you.

I did, see above.

It finally turned out that I got burned once again by wbinvd: My test
CPUs (and likely also some of my customer) are too "old" to support
SECONDARY_VM_EXEC_CONTROL, which includes trapping guest's wbinvd
invocations. Too bad.

I vaguely recall that someone promised to add a feature reporting
facility for all those nice things, modern VM-extensions may or may not
support (something like or even an extension of /proc/cpuinfo). What is
the state of this plan? Would be specifically interesting for Intel CPUs
as there seem to be many of them out there with restrictions for special
use cases - like real-time.

Jan (who is now patching his guest to avoid wbinvd where possible)

-- 
Siemens AG, Corporate Technology, CT SE 2
Corporate Competence Center Embedded Linux
