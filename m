From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH v3] iio: adc: xilinx-xadc: Push interrupts into threaded
 context
Date: Tue, 04 Aug 2015 10:01:36 +0200
Message-ID: <55C07160.5040907@metafoo.de>
References: <CAKfKVtGTO81wLWk50M303t2WjcBEMEt_LUnsJ3_WmvR_3izUjg@mail.gmail.com> <1437434050-32907-1-git-send-email-xander.huff@ni.com> <55B231DE.4080308@metafoo.de> <55BFCC9C.5040305@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org,
	soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	joe.hershberger-acOepvfBmUk@public.gmane.org, joshc-acOepvfBmUk@public.gmane.org, nathan.sullivan-acOepvfBmUk@public.gmane.org,
	jaeden.amero-acOepvfBmUk@public.gmane.org
To: Xander Huff <xander.huff-acOepvfBmUk@public.gmane.org>, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55BFCC9C.5040305-acOepvfBmUk@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

On 08/03/2015 10:18 PM, Xander Huff wrote:
> On 7/24/2015 7:38 AM, Lars-Peter Clausen wrote:
>> Hi,
>>
>> Sorry, but I don't think this patch has been sufficiently tested against a
>> mainline kernel. The driver wont even probe the way it is right now.
>>
> Thanks for your responses. I'm not sure why it doesn't probe for you since I
> was able to do a fair amount of tests with it on our device.

genirq: Threaded irq requested with handler=NULL and !ONESHOT for irq 157
xadc: probe of f8007100.xadc failed with error -22

You can' request a threaded IRQ without having IRQF_ONESHOT set, since this
will effectively result in a IRQ storm.

> 
> I'll get to work on your suggestions and hopefully having a v4 out sometime
> next week.
> 
