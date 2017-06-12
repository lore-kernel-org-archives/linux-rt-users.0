From: Chris Friesen <chris.friesen@windriver.com>
Subject: Re: Why is real time pinging not possible with RT kernels?
Date: Sun, 11 Jun 2017 23:10:41 -0600
Message-ID: <593E2251.3070308@windriver.com>
References: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
To: <rolf.freitag@email.de>, <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail5.windriver.com ([192.103.53.11]:55926 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752002AbdFLFKv (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 12 Jun 2017 01:10:51 -0400
In-Reply-To: <trinity-c4969a6b-8eeb-4799-93a4-349c300c9363-1497118391298@3capp-webde-bap09>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 06/10/2017 12:13 PM, rolf.freitag@email.de wrote:
> Hi,
>
> I tried ping as a minimal latency test, e. g.
>
> ionice -c3 -p $$
> renice +19 -p $$
> ping -q -s 28 -l 1 -p 0f1e2d3c4b5a6978 -i 0.001 localhost
>
> but when cyclictest shows a worst-case latency of 40 mikroseconds,
> ping shows more than 10,000 (after 1 day run).
> I tried different kernels, e. g.
> SMP PREEMPT RT Debian 4.6.4-1~bpo8+1 (2016-08-11) x86_64
> but with the same result, low cyclictest values, high ping values.
> What is the reason?

That's a great question, I'm curious what responses you get.

It might be useful to use a custom ping client (or remove the -q option and 
parse the output) so you could track the latencies and generate a histogram to 
see if that 10ms latency was a single outlier or whether it happened fairly 
frequently.

Chris



