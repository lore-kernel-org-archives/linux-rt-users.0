From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH] [RFC] tpm_tis: tpm_tcg_flush() after iowrite*()s
Date: Mon, 14 Aug 2017 17:52:38 -0500
Message-ID: <16bd7bd9-6489-1a0d-d39c-fd78ce03bc6e@ni.com>
References: <20170804215651.29247-1-haris.okanovic@ni.com>
 <20170807145935.GW8384@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        harisokn@gmail.com, gratian.crisan@ni.com, scott.hartman@ni.com,
        chris.graf@ni.com, brad.mouring@ni.com, jonathan.david@ni.com
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:46089 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752770AbdHNWwq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 14 Aug 2017 18:52:46 -0400
In-Reply-To: <20170807145935.GW8384@jcartwri.amer.corp.natinst.com>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 08/07/2017 09:59 AM, Julia Cartwright wrote:
> On Fri, Aug 04, 2017 at 04:56:51PM -0500, Haris Okanovic wrote:
>> I have a latency issue using a SPI-based TPM chip with tpm_tis driver
>> from non-rt usermode application, which induces ~400 us latency spikes
>> in cyclictest (Intel Atom E3940 system, PREEMPT_RT_FULL kernel).
>>
>> The spikes are caused by a stalling ioread8() operation, following a
>> sequence of 30+ iowrite8()s to the same address. I believe this happens
>> because the writes are cached (in cpu or somewhere along the bus), which
>> gets flushed on the first LOAD instruction (ioread*()) that follows.
> 
> To use the ARM parlance, these accesses aren't "cached" (which would
> imply that a result could be returned to the load from any intermediate
> node in the interconnect), but instead are "bufferable".
> 

Fixed wording

> It is really unfortunate that we continue to run into this class of
> problem across various CPU vendors and various underlying bus
> technologies; it's the continuing curse of running an PREEMPT_RT on
> commodity hardware.  RT is not easy :)
> 
>> The enclosed change appears to fix this issue: read the TPM chip's
>> access register (status code) after every iowrite*() operation.
> 
> Are we engaged in a game of wack-a-mole with all of the drivers which
> use this same access pattern (of which I imagine there are quite a
> few!)?
> 
> I'm wondering if we should explore the idea of adding a load in the
> iowriteN()/writeX() macros (marking those accesses in which reads cause
> side effects explicitly, redirecting to a _raw() variant or something).
> 
> Obviously that would be expensive for non-RT use cases, but for helping
> constrain latency, it may be worth it for RT.
> 
>     Julia
> 
