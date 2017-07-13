From: Alex Shi <alex.shi@linaro.org>
Subject: Re: [PATCH] cpu_pm: replace raw_notifier to atomic_notifier
Date: Thu, 13 Jul 2017 10:46:30 +0800
Message-ID: <5868a352-5974-e22b-7e94-96c2f9beff5a@linaro.org>
References: <1499820498-7983-1-git-send-email-alex.shi@linaro.org>
 <5232233.WFeFAu20WR@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: open list <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Anders Roxell <anders.roxell@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35130 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbdGMCqf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jul 2017 22:46:35 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so22009094pfk.2
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jul 2017 19:46:34 -0700 (PDT)
In-Reply-To: <5232233.WFeFAu20WR@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>



On 07/13/2017 05:30 AM, Rafael J. Wysocki wrote:
>>
>> This patch passed Fengguang's 0day testing.
>>
>> Signed-off-by: Alex Shi <alex.shi@linaro.org>
>> To: linux-kernel@vger.kernel.org
>> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Anders Roxell <anders.roxell@linaro.org>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-rt-users <linux-rt-users@vger.kernel.org>
>> Cc: linux-pm@vger.kernel.org
>> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Applied (although you have forgotten to CC me actually).


Ops, My bad. I shouldn't resend email just few minutes before bed time. :(

I will take this lesson.

Regards
Alex
