Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBC9DC433FE
	for <linux-rt-users@archiver.kernel.org>; Thu,  6 Oct 2022 07:16:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbiJFHQl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 6 Oct 2022 03:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJFHQj (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 6 Oct 2022 03:16:39 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F82F3343E
        for <linux-rt-users@vger.kernel.org>; Thu,  6 Oct 2022 00:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1665040585;
        bh=y4SbiQTvvUa344INXxOfp3bKkQY1gM/mymNg4ide77I=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=QRrI0mgSEudgGSKr0c14Q+tpJMi8aJ3Vdk1viIWQ1tnwcC1pK6SNt8jj/aVRp0Ycp
         AxpSWEYTZYB8atsvifeMQW5GxXmJn9I+/ARDn5+cPBFFjoMfkGnf/81DYWrgijTcA8
         TMx0/ziGKb54E9UMUtqKqJjtahV7RcHUtDSN6wT4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [129.70.76.171] ([129.70.76.171]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQvD5-1osG0E2lRX-00O1tb; Thu, 06
 Oct 2022 09:16:25 +0200
Message-ID: <447228e9-2509-20e7-c259-c226e2ee4742@gmx.net>
Date:   Thu, 6 Oct 2022 09:16:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: Regression (latency spike) between 5.16.2-rt19 and 5.17.1-rt17
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <565463ae-b86e-357d-962b-89d2a151ac73@gmx.net>
 <Yz2HQlzZ491HtOm+@linutronix.de>
 <5675da76-80ba-5708-e022-2385e3b56fad@redhat.com>
 <9a950f2b-94c2-7dad-51f2-545aa37850c2@gmx.net>
 <6b79b2f3-7ec9-88e9-48e4-71c6ec85b7db@redhat.com>
 <5d127d10-d606-52ad-b270-9bcbd66eec6c@gmx.net>
 <Yz51W0+ZVvYSa9kq@linutronix.de>
Content-Language: en-US
From:   Florian Paul Schmidt <mista.tapas@gmx.net>
In-Reply-To: <Yz51W0+ZVvYSa9kq@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:of6UrQQPuZBRR5SqaGa3tTrjuVmpAzDK9giBpz8jnA7nLotGfZr
 VuRA5bEVqLWRjRd7288AlEDGyDacuen8IS78Vk9fBuvZ/bJbMe945XPaQd5o3lhiZ3ZBWQV
 idT9dpYrURfTwpUG1WCXBpK7n5nMCHKWx2VEr8LgmNMxrwrlviEkrLc2okt7oplr4NJLZq2
 1OWwiruJSXk+NDSAzjbSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lKo8u2E7hgg=:LKpRSsi//6IxZhGiMkD/dN
 LEHjH+Mowlcj7yrAt9nz6FyAcO5ZGBUVqMDQ+fkRkb3QxpFgNvhupzQuSVvvkUGaE4e40VRl1
 M0JGzq+z+xOVQHo3x9BgTcz2zdPYqreNl7mB/Oln5K1Y0ITYUkhVn2tTfyGNlCdIfw+Iwc8na
 602SKNMtKhSw1TUwJcjnW7TgKDJ1sP0/XrgjCrJYo73pB/r+muAZfMdngnDu3UX1n3XWVsp9z
 gu4rd/itCoD0UXnZGmH+pQX96JluFKLFOFvE68S5UBAHw56Udrr6aPg3a6peofqAtyFn+YwPc
 xqOeHcjWP7XC8EpBnRjSwTDTrd6h/qTH0giv6mHKLqFLtVvkMCS7pAL0dZ1EMWSP2QVfXOJKP
 OaUxVdB6ncGzamS9ExDWZLNsphDnb6AHtcwN1scE+YYGsxLXOqQlUfax6DDjE/LeqcoVVZEk6
 YQqadmt8v8vT8IvN8BsVgPCaIPuY1AHgYc477lQcXNV0Ql0NuYZY2S5c3e/kkF/YQEs0kXLLl
 BDgxb8uUYkiCnAyGovihP3CSJIAa/VUeA3hp+9mKIiL1ZNTOMBrULIaPUwaDcMKWa0w3kRIbX
 iqd2IWHC9aJDnjSSaGuFi5Rvd7Ln6Nt78Feiuxe5ivCoNBvYGWxFcgrd6aIplTobJcN1ciyFz
 aZCDDSVz4sALp6r9c2dlQd9rPCgHHBqZRWkBTtuBoLgFAMzUg4QhWQihl1Mn7CXDjDmm23aY0
 uM0l/HDSyvTw+m5N6SkTzH904wbC4i8kwIOSeofEsGgZtxGHP5dgy+B7jdlong/QhrwUtZEvQ
 gsgDeXG8SpzGYLpi+CVPeH1GOyRswMZ8g6Rc7zLm5u95KeVR45nKne+NKgSEOOfFTR363+Z/O
 YXXFyN83mqdpPxQnxBsQ/AiOXtOd+h2UZAjCnvxlvViaqVMCoqVZeYLpWD4RxLGcKXUJDH3U4
 OMg05K1EXQY9b0V4ewdvNeQ1JO61TMrZtD9oW++uygXXjFYIVebOm4f6srtIK8UG22xDuWgg4
 VNQYUEyqlxXQTHEdQI2nelAaYibgU7Bi4d8V84AG7NxzTA4kXM8VSx3UtL78vrgHf18isKkv/
 2vdvRA69Pi16hhvT4VI0IVxXGNUHcJvQVUeaiP7hjmRholxqRqUPfN3bV+90+H1+CfcSTEQ/B
 6YoJyWvtGXVHN4M4X1U8MtrrCp
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On 10/6/2022 8:27 AM, Sebastian Andrzej Siewior wrote:
> that looks fine to me.
> The runtime_resume path points to intel_dmc_load_program(). The
> preempt-disable section there was introduced by commit
>     dff457d74e7ea ("drm/i915: Speed up DMC firmware loading")
>
> and the other thing seems to be intel_irq_reset() not sure where but it
> is the runtime_suspend path.
>
> So disabling runtime-suspend should help.

OK, so it was a user error :) Thanks for teaching me about rtla in the
process! This will turn out to be helpful in the future!

I passed acpi=3Doff as kernel parameter and that seems to have helped! The
closest to runtime-suspend I could find was:

/sys/devices/system/cpu/power/runtime_enabled

which is "disabled" now.

> Sebastian

Thanks again and kind regards,
FPS

=2D-
https://dfdx.eu
