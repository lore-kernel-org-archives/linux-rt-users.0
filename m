From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: Network performance forwarding tests on RT
Date: Wed, 12 Nov 2008 22:20:24 +0100
Message-ID: <c384c5ea0811121320m513fd707q7316d1fd692cc5f5@mail.gmail.com>
References: <20081105115205.14c5282f@s6510>
	 <20081106185029.0d4c5cd8@redhat.com>
	 <ccb913ac0811062303r7f94f8a8lfe48336d6dafb9f6@mail.gmail.com>
	 <20081107085210.67d4c962@extreme>
	 <ccb913ac0811110537u20a05682x9f60bc69b42d943a@mail.gmail.com>
	 <20081111081319.6fce5337@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Tobias Knutsson" <tobias.knutsson@gmail.com>,
	"Stephen Hemminger" <shemminger@vyatta.com>,
	linux-rt-users@vger.kernel.org
To: "Clark Williams" <williams@redhat.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.26]:19889 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939AbYKLVUZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 12 Nov 2008 16:20:25 -0500
Received: by qw-out-2122.google.com with SMTP id 3so361240qwe.37
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Nov 2008 13:20:24 -0800 (PST)
In-Reply-To: <20081111081319.6fce5337@redhat.com>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello,

On Tue, Nov 11, 2008 at 3:13 PM, Clark Williams <williams@redhat.com> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
>
> On Tue, 11 Nov 2008 14:37:46 +0100
> "Tobias Knutsson" <tobias.knutsson@gmail.com> wrote:
>
>> Ok well that assumption is probably not right. I am quite sure that both the
>> soft and hard irqs are assigned priority 50. But you probably should raise
>> the priority of the irqs related to your implementation.
>>
>> I am writing my master's thesis on real-time Linux and I found that the
>> worst-case latency dropped from about 2000us to 250us just by changing some
>> priorities of the relevant tasks. This was on an XScale based system running
>> at 520Mhz.
>>
>
> Yeah, they default to 50 and then most RT distros adjust them from there. We generally push the hard IRQ threads up to 85 and keep the soft irq threads down around 75, on the assumption that actual IRQs need to be serviced immediately, with the hope that the service routine runs quicky and then defers further work to a lower priority entity (tasklet, softirq, workqueue, etc.).
>

Hope is not what you should count on :-)

When you start deferred work from an interrupt handler, it runs at
equal priority to the interrupt handler thread.
This is actually a regression in most cases (as this might cause
interrupts to be delayed by deferred work).

Under 2.6.24 I had to come up with a patch that allowed to set work
priority. I posted it to linux-rt-users@vger.kernel.org, just search
for my name.

Regards,
-- 
Leon
