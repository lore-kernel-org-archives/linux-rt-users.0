From: =?UTF-8?B?UGhpbGlwcCBUw7Zsa2U=?= <philipp.toelke@fos4x.de>
Subject: Re: kernel BUG at /build/linux-rt/kernel/locking/rtmutex.c:997!
Date: Wed, 18 Feb 2015 08:54:36 +0100
Message-ID: <54E4453C.8060508@fos4x.de>
References: <CADLDEKuPf3UNf-CB_xpmjcmQxQA_drFkXzBMQYUF_7K0dM7V3w@mail.gmail.com> <20150217141333.GR26177@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36498 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751789AbbBRHyj (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Wed, 18 Feb 2015 02:54:39 -0500
Received: by mail-wi0-f177.google.com with SMTP id bs8so181659wib.4
        for <linux-rt-users@vger.kernel.org>; Tue, 17 Feb 2015 23:54:38 -0800 (PST)
In-Reply-To: <20150217141333.GR26177@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,

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
> has this been resolved in the meantime?

As said in=20
<http://thread.gmane.org/gmane.linux.rt.user/12563/focus=3D12809> I can=
=20
reproduce the issue pretty easy. Using the patch from that thread it=20
seems to be fixed.

 > Do you see the same problem with v3.18-RT?

I do feel kind of stupid to ask this: Where would I find 3.18-RT? The=20
git only goes to 3.14...

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
