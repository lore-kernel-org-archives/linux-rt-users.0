From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded context
Date: Tue, 4 Aug 2015 11:04:52 +0530
Message-ID: <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>
	<1437434050-32907-1-git-send-email-xander.huff@ni.com>
	<55B231DE.4080308@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Xander Huff <xander.huff@ni.com>, jic23@kernel.org,
	bigeasy@linutronix.de, knaack.h@gmx.de,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	joe.hershberger@ni.com, joshc@ni.com, nathan.sullivan@ni.com,
	jaeden.amero@ni.com
To: Lars-Peter Clausen <lars@metafoo.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35128 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbbHDFex (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 4 Aug 2015 01:34:53 -0400
In-Reply-To: <55B231DE.4080308@metafoo.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jul 24, 2015 at 6:08 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi,
>
> Sorry, but I don't think this patch has been sufficiently tested against a
> mainline kernel. The driver wont even probe the way it is right now.
>
> On 07/21/2015 01:14 AM, Xander Huff wrote:
>>
>> The driver currently registers a pair of irq handlers using
>> request_threaded_irq(), however the synchronization mechanism between the
>> hardirq and the threadedirq handler is a regular spinlock.
>
>
> If everything runs in threaded context we don't really need the spinlock
> anymore and can use the mutex throughout.

that should be better from the performance point of view.

>
>>
>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>> and is thus not able to be acquired from a hardirq handler. This patch
>> gets
>> rid of the hardirq handler and pushes all interrupt handling into the
>> threaded context.
>
>
> We actually might as well run everything in the hardirq handler (which will
> be threaded in PREEMPT_RT). The reason why we have the threaded handler is
> because xadc_handle_event() used to sleep, but it doesn't do this anymore.

The point is why have the hard irq. If we use hardirq then not mutex
can be used and spinlock will
be busy.

is there something i may be missing?
>
>
