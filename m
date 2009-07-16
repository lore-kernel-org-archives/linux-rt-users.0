From: GeunSik Lim <leemgs1@gmail.com>
Subject: Re: Test Scenario for Realtime latency benchmark in the worstcase
	environment.
Date: Thu, 16 Jul 2009 16:32:24 +0900
Message-ID: <49b7c2350907160032g76ebe748mfabf622b10313c8d@mail.gmail.com>
References: <1245368556.2153.10.camel@centos51>
	 <1247196343.5398.22.camel@sven.thebigcorporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>,
	tglx <tglx@linutronix.de>
To: Sven-Thorsten Dietrich <sven@thebigcorporation.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-gx0-f213.google.com ([209.85.217.213]:51804 "EHLO
	mail-gx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751175AbZGPHcZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 16 Jul 2009 03:32:25 -0400
Received: by gxk9 with SMTP id 9so3235111gxk.13
        for <linux-rt-users@vger.kernel.org>; Thu, 16 Jul 2009 00:32:24 -0700 (PDT)
In-Reply-To: <1247196343.5398.22.camel@sven.thebigcorporation.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you  for your opinions.

On Fri, Jul 10, 2009 at 12:25 PM, Sven-Thorsten
Dietrich<sven@thebigcorporation.com> wrote:

> There are no guarantees.
> Only extensive testing can validate the application.
> IMO 24 hours is not nearly enough.
It's right.
> I know of stress tests that have been run for multiple weeks.
Actually, I am trying  experiments with increase of test time to
measure latencies
step by step.

For example,
30 minutes --> 1hour --> 1day(24hours) --> 3days --> 6days (until now)

-- 
Regards,
GeunSik Lim ( Samsung Electronics )
Blog : http://blog.naver.com/invain/
e-Mail: geunsik.lim@samsung.com
           leemgs@gmail.com , leemgs1@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
