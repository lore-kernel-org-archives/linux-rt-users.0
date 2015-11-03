From: Jonathan David <jonathan.david@ni.com>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Tue, 3 Nov 2015 16:10:23 -0600
Message-ID: <563930CF.9090800@ni.com>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
 <20151022055909.GA7263@icarus.home.austad.us> <5638F239.1030804@ni.com>
 <20151103194246.GA19824@sisyphus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <josh.cartwright@ni.com>
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-by2on0110.outbound.protection.outlook.com ([207.46.100.110]:51704
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755488AbbKCWK1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2015 17:10:27 -0500
In-Reply-To: <20151103194246.GA19824@sisyphus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 11/03/2015 01:42 PM, Henrik Austad wrote:
> On Tue, Nov 03, 2015 at 11:43:21AM -0600, Jonathan David wrote:
>> On 10/22/2015 12:59 AM, Henrik Austad wrote:

>>>> Adding a delay after long series of writes gives them time to
>>>> complete, and for higher priority tasks to run unimpeded.
>>>
>>> Aren't we running with threaded interrupts?
>>>
>>> What happens to the thread(s) pushing data to the network?
>>> What about xmit-buffer once it is full? Which thread will block on send or
>>> have its sk_buff dropped?
>>
>> All of this is totally irrelevant to the problem we are seeing.
>
> If this is irrelevant, why hack at the network-driver, hmm?

It is relevant to the network driver, as this is where the symptoms were 
discovered; however, it has no relation to the packet delivery path. 
This is related purely to link configuration.

>> The e1000x driver itself is not responsible for the delay here.
>
> ... then why hack the network-driver?

Lack of better known options.

>> The issue is with PCI where issuing a large number of MMIO writes
>> followed by a read (to force said writes to execute) will stall the CPU.
>> When the CPU is stalled, no interrupts are serviced, including the local
>> apic timer interrupt, which was responsible for waking up cyclictest.
>> This behavior was observed within traces gathered from cyclictest with
>> ftrace enabled.
>
> So you get bogged down with interrupts disabled;

No, interrupts are entirely enabled while the PCI MMIO writes/read are 
issued; but the local apic timer still arrives late, presumably because 
the CPU is waiting to complete whatever writes remain in the buffer.

I think this might be the root of our miscommunication. You are asking 
good questions about threaded interrupts, etc, but it isn't clear how 
they are related to the specific problem we are seeing.

Thanks,

- JD
