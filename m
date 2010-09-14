From: Nivedita Singhvi <niv@us.ibm.com>
Subject: Re: preempt rt in commercial use
Date: Tue, 14 Sep 2010 15:20:30 -0700
Message-ID: <4C8FF52E.1030407@us.ibm.com>
References: <AANLkTinUYXDM_pGoJTd3veNNfYzWVu3Obv8v4RAL0urq@mail.gmail.com> <20100914094411.GB10841@pengutronix.de> <4C8F8500.5070002@theptrgroup.com> <201009141830.03206@zigzag.lvk.cs.msu.su> <4C8F8B79.1010300@theptrgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nikita V. Youshchenko" <yoush@cs.msu.su>,
	Robert Schwebel <r.schwebel@pengutronix.de>,
	Raz <raziebe@gmail.com>,
	linux-rt-users <linux-rt-users@vger.kernel.org>
To: Jeff Angielski <jeff@theptrgroup.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from e38.co.us.ibm.com ([32.97.110.159]:55453 "EHLO
	e38.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415Ab0INWTO (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 14 Sep 2010 18:19:14 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8EMBbDD005831
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 16:11:37 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id o8EMJEZJ111118
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 16:19:14 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id o8EMMrNx006856
	for <linux-rt-users@vger.kernel.org>; Tue, 14 Sep 2010 16:22:53 -0600
In-Reply-To: <4C8F8B79.1010300@theptrgroup.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 09/14/2010 07:49 AM, Jeff Angielski wrote:

>> Isn't any case where preempt-rt does not behave as hard reatlime a bug in
>> preempt-rt, that should be reported to this list and eventually fixed?
>
> That is a philosophical question for the preempt-rt maintainers.
>
> I *believe* that the design goal for the preempt rt code is to minimize
> kernel latency. It's not to make the kernel deterministic to support
> hard realtime.

Er, sort of, not quite.

The design goal of the real-time kernel is most certainly to make the
kernel more deterministic, to the extent we can in a general-purpose way.

Determinism = capping max latencies.

It's better to have all hundred iterations of an operation take
45us each than to have 95 iterations take 30us and 5 iterations
take 75us. You want to be able to say, "this operation will take
at _most_ 50us" and have that be as true as possible.

We sacrifice overall throughput (ave latency) for determinism
(low max latency).

Not sure if that's what you intended to say, but hope that helps.

thanks,
Nivedita


