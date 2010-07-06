From: Pradyumna Sampath <pradysam@gmail.com>
Subject: Re: fast interprocess communication ?
Date: Tue, 6 Jul 2010 12:29:38 +0200
Message-ID: <AANLkTil7jag53q4on2xuxYOqISub3RRrNiSNkGCatKW1@mail.gmail.com>
References: <DFFBF4EB468A894AB1474ED220F05AF60134C0C2@srv-dc.ona-electroerosion.com>
	<1273680443.27703.33.camel@gandalf.stny.rr.com>
	<4BEBB1C8.90606@steinhoff.de>
	<20100513175842.GN6055@pengutronix.de>
	<4BED1937.6080907@steinhoff.de>
	<20100514114625.GA6055@pengutronix.de>
	<4C2B2BA0.8080108@steinhoff.de>
	<AANLkTikM-AhROT6GJULLhzNZUVfdFEGt6VoZHC-86wEf@mail.gmail.com>
	<4C320CF1.7080803@steinhoff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-rt-users@vger.kernel.org
To: Armin Steinhoff <armin@steinhoff.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41155 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab0GFK3k (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 6 Jul 2010 06:29:40 -0400
Received: by fxm14 with SMTP id 14so4602900fxm.19
        for <linux-rt-users@vger.kernel.org>; Tue, 06 Jul 2010 03:29:39 -0700 (PDT)
In-Reply-To: <4C320CF1.7080803@steinhoff.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Armin,

On Mon, Jul 5, 2010 at 6:48 PM, Armin Steinhoff <armin@steinhoff.de> wrote:

> Local message exchange between lokal processes in less than 10us.

As per my measurements, mqueue meets this criteria. It was compared
with a test suite which ran against _a_popular_commercial_rtos_ and
RT_PREEMPT linux and the performance was equally good on both. Like I
said, the problem was the accuracy of the timeouts (mq_timedrecieve
and mq_timedsend) which is now fixed and mainlined.

regards
/prady

--
http://www.prady.in
