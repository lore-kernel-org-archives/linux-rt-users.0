Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail.monom.org ([188.138.9.77]:55284 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933104AbeEWOa0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 23 May 2018 10:30:26 -0400
Subject: Re: i7 vs Atom
References: <CAJ2oMhL=AT0K4rqMpaYGEfM+oxSPgw7n-KaWzhg5VNvkujDVJw@mail.gmail.com>
 <47b20a1d-6b06-3791-1cf2-931c30116dcf@lge.com>
From: Daniel Wagner <wagi@monom.org>
Message-ID: <cec18eea-0bcc-421f-43a0-ec07039cdf9b@monom.org>
Date: Wed, 23 May 2018 16:30:24 +0200
MIME-Version: 1.0
In-Reply-To: <47b20a1d-6b06-3791-1cf2-931c30116dcf@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Seokhee Han <seokhee.han@lge.com>, Ran Shalit <ranshalit@gmail.com>, linux-rt-users <linux-rt-users@vger.kernel.org>

Hi,

On 23.05.2018 06:19, Seokhee Han wrote:
>> The results of portwell seems more than just bad - they same
>> unbelievable, the error is VERY high (2msec).
>>
>> I've tried to find a benchmark which can support my results, but found
>> no benchmark with ATOM.
> I am now developing RT Linux system on minnowboard Turbot Quad Core board,
> which adopts ATOM E3845 series SoC, and it shows above about 2ms worst-case
> latency during cyclictest. So I try to detect SMI-related, kernel unaware,
> hw latency using Linux kernel's hwlat tracer and it tells me that there are
> couples of latency spikes (above 1000us) on the board.

FWIW, I played a while with a MinnowBoard too. As it turns out the
firmware provided from Intel is just no good for -rt. I ended up
building a firmware with coreboot. With coreboot all the 2-3ms spikes
were gone. Unfortunately, building your own firmware for the MinnowBoard
is far from easy though possible:

https://3mdeb.com/firmware/building-coreboot-on-minnowboard/

Thanks,
Daniel
