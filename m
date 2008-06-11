From: "Leon Woestenberg" <leon.woestenberg@gmail.com>
Subject: Re: cyclictest - trouble explaning results
Date: Wed, 11 Jun 2008 21:08:16 +0200
Message-ID: <c384c5ea0806111208s375232c7y6209238ebf1d167f@mail.gmail.com>
References: <20080611151437.234900@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users@vger.kernel.org
To: "Oleg Galimov" <Galimov@gmx.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.237]:9676 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753665AbYFKTIT (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 11 Jun 2008 15:08:19 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1611968rvb.1
        for <linux-rt-users@vger.kernel.org>; Wed, 11 Jun 2008 12:08:16 -0700 (PDT)
In-Reply-To: <20080611151437.234900@gmx.net>
Content-Disposition: inline
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hello Oleg,

On Wed, Jun 11, 2008 at 5:14 PM, Oleg Galimov <Galimov@gmx.de> wrote:
> I use cyclictest as a benchmark for my diploma thesis. I have a strange behavior however, which I can't explain:
>
> I have a dual-core cpu. When I run cyclictest on both cores and then start a time hog (like cp /dev/zero /dev/null), then the average latency on the core where it runs goes down significantly (on my machine it is like 30us before and 10us after, when using rt-patch). It returns to the original values, when I kill the cp process.
>

Possibly, without the single-threaded 'time hog', your cyclictest
threads maybe are scheduled across the two cores, resulting in
increased (peak and average) latencies.

See if you can use the CPU affinity feature to fix each thread to a
dedicated core, and see if this matters.

I'm quite sure cyclictest has an option for this, but please check.

Regards,
-- 
Leon
