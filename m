From: Haris Okanovic <haris.okanovic@ni.com>
Subject: Re: [PATCH] [RFC] tpm_tis: tpm_tcg_flush() after iowrite*()s
Date: Mon, 14 Aug 2017 17:53:15 -0500
Message-ID: <ccc022a8-de6c-3d68-27db-ee4117f190db@ni.com>
References: <20170804215651.29247-1-haris.okanovic@ni.com>
 <20170807145935.GW8384@jcartwri.amer.corp.natinst.com>
 <20170808215848.nngnph6wkqvx6zh3@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        harisokn@gmail.com, gratian.crisan@ni.com, scott.hartman@ni.com,
        chris.graf@ni.com, brad.mouring@ni.com, jonathan.david@ni.com
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170808215848.nngnph6wkqvx6zh3@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org



On 08/08/2017 04:58 PM, Jarkko Sakkinen wrote:
> On Mon, Aug 07, 2017 at 09:59:35AM -0500, Julia Cartwright wrote:
>> On Fri, Aug 04, 2017 at 04:56:51PM -0500, Haris Okanovic wrote:
>>> I have a latency issue using a SPI-based TPM chip with tpm_tis driver
>>> from non-rt usermode application, which induces ~400 us latency spikes
>>> in cyclictest (Intel Atom E3940 system, PREEMPT_RT_FULL kernel).
>>>
>>> The spikes are caused by a stalling ioread8() operation, following a
>>> sequence of 30+ iowrite8()s to the same address. I believe this happens
>>> because the writes are cached (in cpu or somewhere along the bus), which
>>> gets flushed on the first LOAD instruction (ioread*()) that follows.
>>
>> To use the ARM parlance, these accesses aren't "cached" (which would
>> imply that a result could be returned to the load from any intermediate
>> node in the interconnect), but instead are "bufferable".
>>
>> It is really unfortunate that we continue to run into this class of
>> problem across various CPU vendors and various underlying bus
>> technologies; it's the continuing curse of running an PREEMPT_RT on
>> commodity hardware.  RT is not easy :)
>>
>>> The enclosed change appears to fix this issue: read the TPM chip's
>>> access register (status code) after every iowrite*() operation.
>>
>> Are we engaged in a game of wack-a-mole with all of the drivers which
>> use this same access pattern (of which I imagine there are quite a
>> few!)?
>>
>> I'm wondering if we should explore the idea of adding a load in the
>> iowriteN()/writeX() macros (marking those accesses in which reads cause
>> side effects explicitly, redirecting to a _raw() variant or something).
>>
>> Obviously that would be expensive for non-RT use cases, but for helping
>> constrain latency, it may be worth it for RT.
>>
>>     Julia
> 
> What if we as quick resort we add tpm_tis_iowrite8() to the TPM driver.
> Would be easy to move to iowrite8() if the problem is sorted out there
> later on.
> 

Sounds OK to me. I will submit a PATCH shortly.

> /Jarkko
> 
