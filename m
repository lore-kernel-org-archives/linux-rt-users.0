From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
Date: Tue, 04 Aug 2015 10:05:00 +0200
Message-ID: <55C0722C.7080904@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com>	<1437434050-32907-1-git-send-email-xander.huff@ni.com>	<55B231DE.4080308@metafoo.de> <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org,
	Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	=?windows-1252?Q?S=F6ren_Brink?= =?windows-1252?Q?mann?=
	<soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, nathan.sullivan-acOepvfBmUk@public.gmane.org,
	jaeden.amero-acOepvfBmUk@public.gmane.org
To: Shubhrajyoti Datta <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAKfKVtGegy2P_YWQAtKEzByN-+q+bq=uus4zNvO4sghXRjpGPQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 08/04/2015 07:34 AM, Shubhrajyoti Datta wrote:
> On Fri, Jul 24, 2015 at 6:08 PM, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>> Hi,
>>
>> Sorry, but I don't think this patch has been sufficiently tested against a
>> mainline kernel. The driver wont even probe the way it is right now.
>>
>> On 07/21/2015 01:14 AM, Xander Huff wrote:
>>>
>>> The driver currently registers a pair of irq handlers using
>>> request_threaded_irq(), however the synchronization mechanism between the
>>> hardirq and the threadedirq handler is a regular spinlock.
>>
>>
>> If everything runs in threaded context we don't really need the spinlock
>> anymore and can use the mutex throughout.
> 
> that should be better from the performance point of view.
> 
>>
>>>
>>> Unfortunately, this breaks PREEMPT_RT builds, where a spinlock can sleep,
>>> and is thus not able to be acquired from a hardirq handler. This patch
>>> gets
>>> rid of the hardirq handler and pushes all interrupt handling into the
>>> threaded context.
>>
>>
>> We actually might as well run everything in the hardirq handler (which will
>> be threaded in PREEMPT_RT). The reason why we have the threaded handler is
>> because xadc_handle_event() used to sleep, but it doesn't do this anymore.
> 
> The point is why have the hard irq. If we use hardirq then not mutex
> can be used and spinlock will
> be busy.

Well there is no need to use a threaded IRQ. The interrupt handler is quite
small and doesn't take too much time and doesn't have any delays or sleeps
in it either.
