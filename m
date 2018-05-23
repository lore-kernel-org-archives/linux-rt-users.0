Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44432 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750744AbeEWETl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 May 2018 00:19:41 -0400
Subject: Re: i7 vs Atom
References: <CAJ2oMhL=AT0K4rqMpaYGEfM+oxSPgw7n-KaWzhg5VNvkujDVJw@mail.gmail.com>
From: Seokhee Han <seokhee.han@lge.com>
Message-ID: <47b20a1d-6b06-3791-1cf2-931c30116dcf@lge.com>
Date: Wed, 23 May 2018 13:19:39 +0900
MIME-Version: 1.0
In-Reply-To: <CAJ2oMhL=AT0K4rqMpaYGEfM+oxSPgw7n-KaWzhg5VNvkujDVJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Ran Shalit <ranshalit@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

Hi,


On 23/05/18 06:17, Ran Shalit wrote:
> Hello,
>
> We are using same BSP , kernel 3.18.11 rt7, with 2 different hardwares:
> 1. kontron board - i7 cpu
> 2. portwell board. - atom cpu (E3845 )
> The results are totally different with the same testing.
>
> In kontron the error is 11usec, while in portwell it is 2000usec .
>
> The results of portwell seems more than just bad - they same
> unbelievable, the error is VERY high (2msec).
>
> I've tried to find a benchmark which can support my results, but found
> no benchmark with ATOM.
I am now developing RT Linux system on minnowboard Turbot Quad Core board,
which adopts ATOM E3845 series SoC, and it shows above about 2ms worst-case
latency during cyclictest. So I try to detect SMI-related, kernel unaware,
hw latency using Linux kernel's hwlat tracer and it tells me that there are
couples of latency spikes (above 1000us) on the board.

I think that most of them are SMI-related. However, because I am not familiar
with intel system, I could not find the right way yet to disable SMI. Morever,
as googling, disabling SMI on the intel system can make the system harmful,
because some actions with SMI are related with critical conditions of the system,
like critical thermal conditions.

As you can see in the below link, you can also detect hw latency with hwlat tracer.
https://www.osadl.org/Create-a-frequency-plot-from-data-of-har.bash-script-for-hwlat-plots.0.html

Seokhee
> Thank you for any suggestion.
>
> Ranran
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

