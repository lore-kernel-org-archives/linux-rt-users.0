From: Jonathan David <jonathan.david@ni.com>
Subject: Re: [RFC] e1000e: Add delays after writing to registers
Date: Tue, 3 Nov 2015 11:43:21 -0600
Message-ID: <5638F239.1030804@ni.com>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
 <20151022055909.GA7263@icarus.home.austad.us>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-rt-users@vger.kernel.org>, <josh.cartwright@ni.com>
To: Henrik Austad <henrik@austad.us>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bl2on0140.outbound.protection.outlook.com ([65.55.169.140]:29472
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755213AbbKCR56 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 3 Nov 2015 12:57:58 -0500
In-Reply-To: <20151022055909.GA7263@icarus.home.austad.us>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 10/22/2015 12:59 AM, Henrik Austad wrote:
> On Wed, Oct 21, 2015 at 05:07:48PM -0500, Jonathan David wrote:
>> There is a noticeable impact on determinism when a large number of
>> writes are flushed. Writes to the hardware registers are sent across
>> the PCI bus and take a significant amount of time to complete after
>> a flush, which causes high priority tasks (including interrupts) to
>> be delayed.
>
> Do you see this in the entire system, or on the core where the write was
> triggered?

Only on the core where the writes are issued.

>> Adding a delay after long series of writes gives them time to
>> complete, and for higher priority tasks to run unimpeded.
>
> Aren't we running with threaded interrupts?
>
> What happens to the thread(s) pushing data to the network?
> What about xmit-buffer once it is full? Which thread will block on send or
> have its sk_buff dropped?

All of this is totally irrelevant to the problem we are seeing.

The e1000x driver itself is not responsible for the delay here. The 
issue is with PCI where issuing a large number of MMIO writes followed 
by a read (to force said writes to execute) will stall the CPU. When the 
CPU is stalled, no interrupts are serviced, including the local apic 
timer interrupt, which was responsible for waking up cyclictest. This 
behavior was observed within traces gathered from cyclictest with ftrace 
enabled.

> I'm not sure if adding random delay and giving an unpredictable impact on
> completely random threads is the best way to solve this..

Agreed, we know that this is a hack. Do you have any better solutions?

- JD
