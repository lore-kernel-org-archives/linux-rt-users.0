Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF56C43334
	for <linux-rt-users@archiver.kernel.org>; Sat, 25 Jun 2022 03:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiFYD03 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiFYD02 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 23:26:28 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698F838186
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 20:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656127583;
        bh=1oJVvnqJGY9uxJIxuezYqIS2+wBEKFJEumjNG+LLyzw=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=H6op+M56MfyqjT65cc7HOBQLOTa1pXhxGbpA7EX82CZeSiTGugA2JyJZcZFu1jRao
         7BEjHLezWs6IjyAT7DE3FwXAlb2gvW7odzKwByGAXFEVzygZhTLn6MzGby2jyDobcu
         XnrLCiyhcUv59lJkGHvUswiZt9L+oC8GW2ENobkw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.220]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1oIE5n2Zea-00M3XL; Sat, 25
 Jun 2022 05:26:23 +0200
Message-ID: <3a1359eb3d96454079e91011e99ff347b466f15b.camel@gmx.de>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
From:   Mike Galbraith <efault@gmx.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Ogness <john.ogness@linutronix.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Date:   Sat, 25 Jun 2022 05:26:23 +0200
In-Reply-To: <YrXMnCDoO2QPD9np@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
         <YrV4795StT13AUC+@linutronix.de>
         <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
         <YrWPiwtk0kAWxXI9@linutronix.de> <87wnd616ds.fsf@jogness.linutronix.de>
         <87tu8a16bm.fsf@jogness.linutronix.de> <YrXMnCDoO2QPD9np@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:c9RDqe9S6SW+8vseHxQtjuphg7sI3UXTmbt4Y4rPBe9EzJBw5cq
 Ckjid7cV308y8qwRUBtNoKmSsMOvIJmgVbzTkdp5/1ezi51aZDwlmR/ZriNEpmmkVACxT8X
 pHBvAtuCaQudjHkNLXMWc8tEo3ldwGDKdnA0ZWLYBQvALk1B/Xf0fnqX2sGXZWeDqa6Beec
 YW4LQkJ8SCoq3Gj9XZlZA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1+r/obFzcWc=:pIhD6E3zerHp3UAc8letIO
 DSE8ns4XCn6yq6k6jmmQZ/lesgUOndLiw5mxe+7WO4yy6sua93EFdG0CUxfg583GEsbhm5vkA
 k/oFUa314ddbtRus3KUnelyZB0XLD6UR/lf5jg2BsQzcI8j9Z+aHB164jf+dDK/0P36Tykn6M
 a72Cr+yz0KwPp9ED1it16bHUX7n+GwQzMx0q6i2v8I3xZJqLZXGhlRFCvn8+H5gPqmkIG0tzl
 cA61g7KT5HNSoaJteau37u+UQyWo2FVL3RjNQvw0ufjAoHPbdIc4Dz0TeSHpo4C8kQjkE7+7N
 3URm+ulTxtweYuc+cCjGVbCdNVAi40wFCDSL0bp4q7VnWEdgymw621jRqHOetB4lma2wyxey2
 EfyKr1griT9QwqcK2a2oBCl9gErxAtIwaq0FnHCdv0JJy0ZK6xv3ZdPl5levCw+waWgB+rN6y
 KQ1u6YmobnetMod1b9igJS+taIfdezj7U1B0+rIoFBnvMvpcoiESkcV+ZSMBNIMByoTJ23e0M
 VDiIOPmgmxtjlNnvM2csuWiQ/qbdUCBb8XoFuvLtUww8kMzKZPORNcyS+0t9zmqB5frGxnhdY
 U7Mj1EeG3ZWFZXzlPtcl2CA+6VXL5eR4Yt9WT3pciKCVkCUlbv76oRmBn2RP00Sp67tHUg13M
 IKGdFLi4WQwZO/QcTExJIUBzrC9pN8CAhsQ31NThvbeSY32CyN2lwIBBkLn3wjNs6+NkngUz5
 ssLWC0ivDMseocMiRz1/54L50WlRzzfymConcsouyoBcDs7YZWG0niZBBkOAlYLwZ5Cx2BEiI
 Jlu48q/MI7i0Yl80CV69+K4i037WjLgKqJ6vfQxCBRy6iedPhWpoiK6f6aqUVijAuNwArRBiG
 PD7xPgvTVMqQiv6UMEEQzzdbl6RZTvKquRn7mM7taqjjN2Xw3ahMosvQzAueZy7apzGGrVluP
 uRRb2E/V/LfBw8hisr21fCZ/XK+xu3kHrSB8RTlaXaxoqlt5OJf4V+JiqcUgqw9wrihhzCek5
 COgxU6yqjIvx6cpFa2exn4sJu/VYYiK/Yk6V8MM6u1j0FaRAjZ8wGqJFNJWKScuoj3hHGUpMP
 +0tfctVyD45pp+Fdht1arOA0tCp0ps85u1eLlQk1bN/I3XCopO9mOCYrA==
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, 2022-06-24 at 16:39 +0200, Sebastian Andrzej Siewior wrote:
> On 2022-06-24 16:37:25 [+0206], John Ogness wrote:
> > On 2022-06-24, John Ogness <john.ogness@linutronix.de> wrote:
> > > As to this the actual problem reported in this thread, I believe
> > > this
> > > patch solves it:
> > >
> > > https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com
> >
> > There was a cleaner v2 later in the thread:
> >
> > https://lore.kernel.org/lkml/20220609123319.17576-1-Jason@zx2c4.com
>
> In that case v5.19-rc3-rt5 should no longer show it but I am still
> confused why we need to disable interrupts within vsnprintf().

It says they're disabled to simplify recursion tracking.  I was
thinking maybe replace that with a local lock, but then the below
happened, rendering that little wart kinda moot for the moment.

07a22b61946f Revert "printk: add functions to prefer direct printing"
5831788afb17 Revert "printk: add kthread console printers"
2d9ef940f89e Revert "printk: extend console_lock for per-console locking"
007eeab7e9f0 Revert "printk: remove @console_locked"
05c96b3713aa Revert "printk: Block console kthreads when direct printing w=
ill be required"
20fb0c8272bb Revert "printk: Wait for the global console lock when the sys=
tem is going down"


	-Mike
