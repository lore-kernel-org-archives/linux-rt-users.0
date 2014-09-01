From: Harry van Haaren <harryhaaren@gmail.com>
Subject: Re: [RFC 0/4] Improving SPI driver latency (vs v3.8.13.14-rt31)
Date: Mon, 1 Sep 2014 23:30:40 +0100
Message-ID: <CAKudYbNm-grvsJhn03T5v0vWOMUisfKGN=4cNyLTJhodRhbixw@mail.gmail.com>
References: <1409581835-70814-1-git-send-email-jepler@unpythonic.net>
	<540493AA.2020207@dlr.de>
	<20140901181328.GB81857@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Philipp Lutz <philipp.lutz@dlr.de>, linux-rt-users@vger.kernel.org
To: Jeff Epler <jepler@unpythonic.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:59984 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbaIAWam (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 1 Sep 2014 18:30:42 -0400
Received: by mail-la0-f49.google.com with SMTP id b17so6713484lan.22
        for <linux-rt-users@vger.kernel.org>; Mon, 01 Sep 2014 15:30:40 -0700 (PDT)
In-Reply-To: <20140901181328.GB81857@unpythonic.net>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Mon, Sep 1, 2014 at 7:13 PM, Jeff Epler <jepler@unpythonic.net> wrote:
> On Mon, Sep 01, 2014 at 05:41:30PM +0200, Philipp Lutz wrote:
>> Have you looked into setting a RTPRIO for the SPI worker threads
>> <snip>
> Sort of.
>
> I was unaware of the "rt" property so I never tried setting it on the
> kernel side.  However, I did run into the idea of using "chrt" on the
> kernel tasks [spi1] and [irq/99-spi-s3c6].  This improved things
> somewhat, but this plus eliminating DMA acquistion still left me with
> some 800+us latencies that I didn't want.

chrt changes the rtprio, its the same thing.
Prioritizing IRQ's and using chrt is discussed (with a focus on audio
soundcards) [1]. Although the page is outdated, it is the best resource
I'm aware of for practical advice / walktrough of using rtprio and such.

[1] http://subversion.ffado.org/wiki/IrqPriorities

Cheers, -Harry

www.openavproductions.com
