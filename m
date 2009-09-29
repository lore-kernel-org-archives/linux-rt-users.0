From: Remy Bohmer <linux@bohmer.net>
Subject: Re: RT Latency on Atmel Processors
Date: Tue, 29 Sep 2009 20:26:52 +0200
Message-ID: <3efb10970909291126w4d64fcf6s2b48277fe079a09c@mail.gmail.com>
References: <a9067d050909240502n3377f3c5gb70fcf16c58b3942@mail.gmail.com>
	 <3efb10970909241340v75375381m8f833e41ba96b733@mail.gmail.com>
	 <a9067d050909290727wc4659e8m55b55503d43979b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Azraiyl <azraiyl@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yx0-f199.google.com ([209.85.210.199]:51890 "EHLO
	mail-yx0-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbZI2S0s (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 29 Sep 2009 14:26:48 -0400
Received: by yxe37 with SMTP id 37so6271997yxe.33
        for <linux-rt-users@vger.kernel.org>; Tue, 29 Sep 2009 11:26:52 -0700 (PDT)
In-Reply-To: <a9067d050909290727wc4659e8m55b55503d43979b5@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

2009/9/29 Azraiyl <azraiyl@gmail.com>:
> Thanks for your details. My problem is that my problem can be simplified as
> follows: Toggle an IO with 4 KHz. I don't have an external 4 KHz clock,

Maybe a stupid question: Why not use a programmable clock output?

Or a timer/counter peripheral inside the SoC to generate the 4KHz interrupt.
Using the timer framework for a 4KHz interrupt source is way too heavy
for this processor related to the overhead the timer interrupt
introduces inside the system. Look at the CPU-load this is
generating... High latencies would not surprise me since it is likely
that the processor just cannot keep up...

Better use the TC-library to generate a dedicated interrupt if you
want some realtime responsiveness and somewhat reasonable CPU-load.
Personally I would not go beyond the 1kHz boundary with this
processor...

Remy
