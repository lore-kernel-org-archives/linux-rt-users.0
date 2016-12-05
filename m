From: "Shi, Yang" <yang.shi@linaro.org>
Subject: Re: [PATCH] arm: kprobe: replace patch_lock to raw lock
Date: Mon, 5 Dec 2016 10:16:37 -0800
Message-ID: <06234a80-1908-996e-d134-3ac7d6ad5284@linaro.org>
References: <1478823475-15087-1-git-send-email-yang.shi@linaro.org>
 <20161201141345.4xlceuchfkxyel75@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: rostedt@goodmis.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rt-users@vger.kernel.org, linaro-kernel@lists.linaro.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux@armlinux.org.uk
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35524 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751675AbcLESQk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 5 Dec 2016 13:16:40 -0500
Received: by mail-pf0-f176.google.com with SMTP id i88so64615126pfk.2
        for <linux-rt-users@vger.kernel.org>; Mon, 05 Dec 2016 10:16:40 -0800 (PST)
In-Reply-To: <20161201141345.4xlceuchfkxyel75@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 12/1/2016 6:13 AM, Sebastian Andrzej Siewior wrote:
> On 2016-11-10 16:17:55 [-0800], Yang Shi wrote:
>>
>> Since patch_text_stop_machine() is called in stop_machine() which disables IRQ,
>> sleepable lock should be not used in this atomic context, so replace patch_lock
>> to raw lock.
>>
>> Signed-off-by: Yang Shi <yang.shi@linaro.org>
>
> This can also go upstream.
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Yes, thanks for acking.

Russell,

Could you please consider this patch?

Thanks,
Yang

>
> Sebastian
>

