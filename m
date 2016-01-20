From: Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 5/9] drivers/clocksource: timer-atmel-st: fix unused var 'ret'
Date: Wed, 20 Jan 2016 22:33:15 +0100
Message-ID: <CAK--WWNuQ_9miCT9f9wAmD_6MOivV5-sO9RURgD+hhwMripTXg@mail.gmail.com>
References: <1452885673-30891-1-git-send-email-anders.roxell@linaro.org>
	<1452885673-30891-6-git-send-email-anders.roxell@linaro.org>
	<CAGt3f4kZAL65+yeNh1qrAbap4SJNwQrSa=5QF0LN9Mh8ew5HSQ@mail.gmail.com>
	<CAP01z6+7XU3PCVX+a0z+WiiB58EgK__Cpswzu73KoOAg9ZebCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-rt-users@vger.kernel.org, Kevin Hilman <khilman@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Brian Silverman <bsilver16384@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:35050 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751773AbcATVdQ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 20 Jan 2016 16:33:16 -0500
Received: by mail-io0-f174.google.com with SMTP id 77so34018875ioc.2
        for <linux-rt-users@vger.kernel.org>; Wed, 20 Jan 2016 13:33:16 -0800 (PST)
In-Reply-To: <CAP01z6+7XU3PCVX+a0z+WiiB58EgK__Cpswzu73KoOAg9ZebCA@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 18 January 2016 at 19:34, Brian Silverman <bsilver16384@gmail.com> wrote:
> The subject line for this one has the wrong variable name in it.
