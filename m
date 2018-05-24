Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from lgeamrelo12.lge.com ([156.147.23.52]:40244 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751335AbeEXE1D (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 24 May 2018 00:27:03 -0400
Subject: Re: i7 vs Atom
References: <CAJ2oMhL=AT0K4rqMpaYGEfM+oxSPgw7n-KaWzhg5VNvkujDVJw@mail.gmail.com>
 <47b20a1d-6b06-3791-1cf2-931c30116dcf@lge.com>
 <cec18eea-0bcc-421f-43a0-ec07039cdf9b@monom.org>
From: Seokhee Han <seokhee.han@lge.com>
Message-ID: <d05b614f-9500-0018-a699-167da93948a5@lge.com>
Date: Thu, 24 May 2018 13:27:00 +0900
MIME-Version: 1.0
In-Reply-To: <cec18eea-0bcc-421f-43a0-ec07039cdf9b@monom.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Daniel Wagner <wagi@monom.org>, Ran Shalit <ranshalit@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

Hi,


On 23/05/18 23:30, Daniel Wagner wrote:
> Hi,
>
> On 23.05.2018 06:19, Seokhee Han wrote:
>>> The results of portwell seems more than just bad - they same
>>> unbelievable, the error is VERY high (2msec).
>>>
>>> I've tried to find a benchmark which can support my results, but found
>>> no benchmark with ATOM.
>> I am now developing RT Linux system on minnowboard Turbot Quad Core board,
>> which adopts ATOM E3845 series SoC, and it shows above about 2ms worst-case
>> latency during cyclictest. So I try to detect SMI-related, kernel unaware,
>> hw latency using Linux kernel's hwlat tracer and it tells me that there are
>> couples of latency spikes (above 1000us) on the board.
> FWIW, I played a while with a MinnowBoard too. As it turns out the
> firmware provided from Intel is just no good for -rt. I ended up
> building a firmware with coreboot. With coreboot all the 2-3ms spikes
> were gone. Unfortunately, building your own firmware for the MinnowBoard
> is far from easy though possible:
>
> https://3mdeb.com/firmware/building-coreboot-on-minnowboard/
>
> Thanks,
> Daniel
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rt-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

I agree with your comment. It is not so easy to build firmware and find any
information about it, because it's my first time to handle intel SoC board.

Unfortunately, I cannot access your link. I can see just "500 Internal error"
in any pages on https://3mdeb.com/, including your link.

Anyway, Thanks a lot and welcome further information.

Seokhee
