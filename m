Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCF7C77B73
	for <linux-rt-users@archiver.kernel.org>; Sun, 21 May 2023 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjEUPG3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 May 2023 11:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjEUPGN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 May 2023 11:06:13 -0400
X-Greylist: delayed 454 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 21 May 2023 08:05:01 PDT
Received: from mx-8.mail.web4u.cz (smtp6-0803-0108.web4u.cz [IPv6:2001:1568:502:803::108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C95132
        for <linux-rt-users@vger.kernel.org>; Sun, 21 May 2023 08:05:01 -0700 (PDT)
Received: from mx-8.mail.web4u.cz (localhost [127.0.0.1])
        by mx-8.mail.web4u.cz (Postfix) with ESMTP id 179891FF15E;
        Sun, 21 May 2023 16:57:22 +0200 (CEST)
Received: from baree.pikron.com (unknown [89.103.131.245])
        (Authenticated sender: ppisa@pikron.com)
        by mx-8.mail.web4u.cz (Postfix) with ESMTPA id DCE761FF139;
        Sun, 21 May 2023 16:57:21 +0200 (CEST)
From:   Pavel Pisa <ppisa@pikron.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Date:   Sun, 21 May 2023 16:57:21 +0200
User-Agent: KMail/1.9.10
Cc:     linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>
References: <202305142217.46875.pisa@cmp.felk.cvut.cz> <20230519185241.03nTY1UE@linutronix.de>
In-Reply-To: <20230519185241.03nTY1UE@linutronix.de>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <202305211657.21525.ppisa@pikron.com>
Organization: PiKRON Ltd.
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
X-W4U-Auth: 51bf7151e5a43115fc4dee63b53987704eb0a642
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear Sebastian,

tanks much for the time investigated into the problem analysis
and designing solution. Pavel Hronek has checked actual daily runs
of for-kbuild-bot/current-stable of

https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel

and manually tested your 6.3 RT version and reports that is is stable
now.

But he has problem that his e-mail didnot pass mailing list filters
rules. I am trying to resnet from my other e-mail. I cannot send from
my university account as well so I ma trying my company one if
it passes

-------- Forwarded Message --------
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Date: Sun, 21 May 2023 16:42:13 +0200
From: Pavel Hronek <hronepa1@fel.cvut.cz>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org, 
Thomas Gleixner <tglx@linutronix.de>

Dear maintainers,

Thank you for looking into the issue.

On 19. 05. 23 20:52, Sebastian Andrzej Siewior wrote:
> I just released v6.3.3-rt15. Could you please give it a try and report
> back if all problems are gone or not? Based on the backtrace I can't
> tell if the other problems are follow-up or other things.

The last two rounds of automated tests on 6.4.0-rc2-rt1
(https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&flood=1&prio=1&kern=1&load=1)
have completed without the lockup and the messages no longer appear in 
the console.

I've also run the tests manually on 6.3.3-rt15 and the same workload 
that would freeze an earlier version of 6.3 within a minute has now 
lasted for over 30 minutes before I stopped it. No warnings here either. 
I think I can confirm the problems are gone.

Best regards,

Pavel Hronek


On Friday 19 of May 2023 20:52:41 Sebastian Andrzej Siewior wrote:
> On 2023-05-14 22:17:46 [+0200], Pavel Pisa wrote:
> > Dear PREEMPT RT Linux kernel maintainers,
> >
> > we have started to experience failures of PREEMPT RT kernels builds from
> > 6.3 RC versions. We use kernel on MZ_APO educational kits
> > based on MicroZed, Xilinx Zynq 7Z010 SoC. More about actual HW
>
> I just released v6.3.3-rt15. Could you please give it a try and report
> back if all problems are gone or not? Based on the backtrace I can't
> tell if the other problems are follow-up or other things.
>
> Sebastian


-- 
                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

