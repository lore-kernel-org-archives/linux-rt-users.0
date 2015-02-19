From: =?UTF-8?B?UGhpbGlwcCBUw7Zsa2U=?= <philipp.toelke@fos4x.de>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Thu, 19 Feb 2015 15:25:55 +0100
Message-ID: <54E5F273.9020508@fos4x.de>
References: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com> <20150217141333.GR26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:39429 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbbBSOZ6 (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 19 Feb 2015 09:25:58 -0500
Received: by wesx3 with SMTP id x3so57276wes.6
        for <linux-rt-users@vger.kernel.org>; Thu, 19 Feb 2015 06:25:57 -0800 (PST)
In-Reply-To: <20150217141333.GR26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 17.02.2015 15:13, Sebastian Andrzej Siewior wrote:
>> I have a simple test that runs two iperf clients in parallel with th=
e
>> ltp network tests and it triggers a deadlock within a few minutes.
>> This is 100% repeatable. I've tried this on different RT kernels and
>> determined that prior to the following commit (which went into 3.10
>> upstream), the machine doesn't deadlock and seems to run just fine:
>>
>> fb52f40e085ef4074f1335672cd62c1f832af13b rtmutex: Handle deadlock
>> detection smarter
>
> has this been resolved in the meantime? Do you see the same problem w=
ith
> v3.18-RT?

I was not able to reproduce the issue with 3.18.7-rt1 in 24hours. I wil=
l=20
repeat the test to be sure.

Cheers,
--=20
Philipp T=C3=B6lke, M.Sc. - Software-Developer - fos4X GmbH - www.fos4x=
=2Ede
Thalkirchner Str. 210, Geb. 6 - D-81371 M=C3=BCnchen; AG M=C3=BCnchen H=
RB 189 218
T +49 89 999 542 58 - F +49 89 999 542 01
Managing Directors: Dr. Lars Hoffmann, Dr. Mathias M=C3=BCller
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
