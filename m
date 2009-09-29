From: Azraiyl <azraiyl@gmail.com>
Subject: Re: RT Latency on Atmel Processors
Date: Tue, 29 Sep 2009 22:46:53 +0200
Message-ID: <a9067d050909291346g43e777a1ya02cb12e7625de0d@mail.gmail.com>
References: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
	 <3efb10970909241340v75375381m8f833e41ba96b733@mail.gmail.com>
	 <a9067d050909290727wc4659e8m55b55503d43979b5@mail.gmail.com>
	 <3efb10970909291126w4d64fcf6s2b48277fe079a09c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Remy Bohmer <linux@bohmer.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:37208 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751445AbZI2Uqu (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Sep 2009 16:46:50 -0400
Received: by bwz6 with SMTP id 6so2339048bwz.37
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2009 13:46:53 -0700 (PDT)
In-Reply-To: <3efb10970909291126w4d64fcf6s2b48277fe079a09c@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> introduces inside the system. Look at the CPU-load this is
> generating... High latencies would not surprise me since it is likely
> that the processor just cannot keep up...

With some simple work inside the loop the max. cpu usage is 19%.
Normally it's ca. 15%.

> Better use the TC-library to generate a dedicated interrupt if you
> want some realtime responsiveness and somewhat reasonable CPU-load.
> Personally I would not go beyond the 1kHz boundary with this
> processor...

I'll try this. Thanks for the hint.

Anyway, I'm still worried about these worst case latencies and like to
know from where
they come from. Is the ftrace infrastructure supposed to work on ARM?

Azaraiyl
