From: rolf.freitag@email.de
Subject: RE: Variance, Standard Deviation, Skewness and Kurtosis for
 cyclictest results?
Date: Mon, 26 Jun 2017 19:12:54 +0200
Message-ID: <trinity-ab9d29ac-aa53-4fca-9547-aea8c3fbf13a-1498497174171@3capp-webde-bap53>
References: <trinity-bc729c2f-fd82-4804-bc70-99fab82bf762-1498257529316@3capp-webde-bs65>
 <20170626143035.kir3ym6so6yifrza@linutronix.de>
 <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:57453 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751697AbdFZRM4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jun 2017 13:12:56 -0400
In-Reply-To: <AM3PR02MB1305D909595CD5A0AE25D29C1DF0@AM3PR02MB130.eurprd02.prod.outlook.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

yes, at voltages the mean is the DC part, the standard deviation is the AC part and usually no one asks for the peak values.
And these values (mean, stddev.) can also be used to characterize soft real-time behavior.

Regards,

Rolf

 

>Gesendet: Montag, 26. Juni 2017 um 17:59 Uhr
>Von: "Piotr Gregor" <pgregor@quadrant-systems.co.uk>
>An: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>, "rolf.freitag@email.de" <rolf.freitag@email.de>
>Cc: "r t" <linux-rt-users@vger.kernel.org>
>Betreff: RE: Variance, Standard Deviation, Skewness and Kurtosis for cyclictest results?
>Hi Sebastian,
>
>I think Rolf understands that but he is simply interested in deviation anyway.
>I can agree deviation gives some more insight into nature of latency observed even if it is clear
>then max peak is what determines real-timeness of the setup. One may be interested in distribution
>of latency - you may have two setups with same average and max peak while there is much less
>meaningful peaks on one than on the other.
>
>cheers,
>Piotr
>
>-----Original Message-----
>From: linux-rt-users-owner@vger.kernel.org [mailto:linux-rt-users-owner@vger.kernel.org] On Behalf Of Sebastian Andrzej Siewior
>Sent: 26 June 2017 15:31
>To: rolf.freitag@email.de
>Cc: r t <linux-rt-users@vger.kernel.org>
>Subject: Re: Variance, Standard Deviation, Skewness and Kurtosis for cyclictest results?
>
>On 2017-06-24 00:38:49 [+0200], rolf.freitag@email.de wrote:
>> Hi,
>Hi,
>
>> many programs, e. g. ping also print the standard deviation of the measured times, so i would like get the standard deviation(s) also from cyclictest.
>> It's easy to also calculate Variance, Skewness and Kurtosis in the
>> same pass: https://www.johndcook.com/blog/skewness_kurtosis/
>> Has someone planned to implement this in cyclictest?
>
>cyclictest prints min/avg/max. min and avg are nice to look at. The important part is the max value. If you have avg at 30us and max at 500us then you know, that you can't meet your deadline for a cycle of 400us.
>
>> Regards,
>>
>> Rolf
>
>Sebastian
>--
>To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in the body of a message to majordomo@vger.kernel.org More majordomo info at http://vger.kernel.org/majordomo-info.html[http://vger.kernel.org/majordomo->info.html]
