From: Jan Blunck <jblunck@gmail.com>
Subject: Re: hwlat latency readings [WAS: IRC Alert]
Date: Tue, 7 Jul 2009 16:03:49 +0200
Message-ID: <4de7f8a60907070703g621d9b79w91467c99945353d5@mail.gmail.com>
References: <E1MMhLr-0007zJ-D9@dallas.jonmasters.org>
	 <1246643444.5270.380.camel@perihelion.bos.jonmasters.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	irc-freenode <irc-freenode@jonmasters.org>
To: Jon Masters <jonathan@jonmasters.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:55586 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756043AbZGGODu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 7 Jul 2009 10:03:50 -0400
Received: by fxm18 with SMTP id 18so4927759fxm.37
        for <linux-rt-users@vger.kernel.org>; Tue, 07 Jul 2009 07:03:49 -0700 (PDT)
In-Reply-To: <1246643444.5270.380.camel@perihelion.bos.jonmasters.org>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jul 3, 2009 at 7:50 PM, Jon Masters<jonathan@jonmasters.org> wrote:
> On Fri, 2009-07-03 at 11:54 +0000, jbl wrote:
>
>> [11:52:41] <jbl:#linux-rt> +jonmasters: ping
>> [11:53:27] <jbl> +how long should be max latencies seen with hwlat detector?
>
> It's a US holiday, so I'll reply by email as I'm not really around for
> IRC, but I don't want to forget to add something to this - especially as
> people seem to be trying to also track down new latencies in RT itself.
> I don't think these are SMI related - though now you can check.

First I wondered if I should reply via twitter or blog ... just to be
more 2.0 ;)

> The default for the latency detector is to regard any unexplained time
> interval over (greater than, not greater than or equal to) 10us as a
> latency worthy of some regard. But you can also configure it down to 1us
> since anything over 0us represents some kind of interruption - it's all
> down to what threshold you actually care about (few people notice 1us).
>
> Anyway. How high should it go? Theoretically, that is an open ended
> question. But we have seen in practice latencies up to many milliseconds
> or even higher - I don't expect you'll go over 100ms and in reality, I
> don't expect it to be anything like that, maybe hundreds of us on a
> modern enough system. But the range is really down to whatever crap the
> BIOS is doing when it's taking your CPU cycles away, and that could
> literally be anything (reformulating the coke recipe isn't unlikely).
>
> If you're seeing something irregular, for widely long periods of time it
> is less likely to be the kind of SMIs we see, which do tend to be
> semi-predictable as they rely upon counters for most of the
> non-asynchronous (e.g. hardware emulation) activities. But if you see
> something short many times per second, or something longer on a
> predictable schedule then it is quite likely to be an SMI hitting you.

I was wondering about the "samples recorded" value. First I thought
there is something wrong since that value was always zero on my test
machine. I expected that this this value would reflect somehow
duration / window length. I guess the documentation could be extended
to explain a bit how to work with various settings of sample window
and width to find out the exact interval of the disturbance.

Thanks,
Jan
