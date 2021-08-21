Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D861C432BE
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 05:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD85611CE
	for <linux-rt-users@archiver.kernel.org>; Sat, 21 Aug 2021 05:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhHUFF4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 21 Aug 2021 01:05:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230205AbhHUFF4 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 21 Aug 2021 01:05:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDB536113E;
        Sat, 21 Aug 2021 05:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629522317;
        bh=CP6bFxfCSRXzuFPiAmcRUPKjPV1ToRSYlZTlKn2rgUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bMx6nrJZCNeawQmaRTV3CnFImNHp4o7rlh7TnGdzIkpSc5xaRP3PoOhXamDmjjEGZ
         Oxgqvly98eVZUSj1ANg6QgQKlUwSWT4MD8u4ALUTEb9KSPUOvCNy674NCgnEhUDODY
         TSR8SjheEaDNGlQ5R+JFYtcK4jldDh92HP5ibT7eYRHK8Zxu5yyzfyyfmX8eSxk53w
         b0E+hKvB/ojl2gW17PYniYC/xg99snjQ28FXS12PJrjJRJ6+z7X/HcXxP/HzaaXM0N
         pC0XlWSt6Yy01qjthbcxF9nTRyT9tzNH2cvAEbN+8WHJ2w1CZ9hcyAfSi5NC5I9VwM
         NUhcYdql3XTGA==
Date:   Sat, 21 Aug 2021 13:05:11 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Linux team <team-linux@rtst.co.kr>,
        =?utf-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9t?=
         =?utf-8?B?YXRpb24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <mkbyeon@lselectric.co.kr>,
        =?utf-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRp?=
         =?utf-8?B?b24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <khchoib@lselectric.co.kr>
Subject: Re: [PATCH v2] usb: chipidea: local_irq_save/restore added for
 hw_ep_prime
Message-ID: <20210821050511.GA14810@Peter>
References: <20210817095313.GA671484@ubuntu>
 <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
 <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
 <20210819084759.stnmit32vs2be46m@linutronix.de>
 <CAJk_X9gyWch6Z1=hbe2vvqGu61mdavAU62+6dSka0tZoMzxu5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJk_X9gyWch6Z1=hbe2vvqGu61mdavAU62+6dSka0tZoMzxu5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 21-08-20 14:15:55, Jeaho Hwang wrote:
> 2021년 8월 19일 (목) 오후 5:48, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>님이 작성:
> >
> > On 2021-08-19 08:50:27 [+0900], Jeaho Hwang wrote:
> > > Without RT, udc_irq runs as a forced threaded irq handler, so it runs
> > > without any interruption or preemption. NO similar case is found on
> > > non-RT.
> >
> > I see only a devm_request_irq() so no force-threading here. Booting with
> > threadirqs would not lead to the problem since commit
> >    81e2073c175b8 ("genirq: Disable interrupts for force threaded handlers")
> >
> 
> I was wrong. udc threaded irq handler allows twd interrupt even on
> non-RT and with threaded irq.
> I believed Chen's comment "The function hw_ep_prime is only called at
> udc_irq which is registered as top-half irq handlers. Why the timer
> interrupt is occurred when hw_ep_prime is executing?".

Hi Jeaho,

How could you let udc irq as threaded irq? The chipidea interrupt
is registered using devm_request_irq.

> We have additional experiments and got the results like below. RNDIS
> host was Windows.
> 
> RT, 1ms delay between first ENDPTSETUPSTAT read and priming : error
> case occurred
> RT, 1ms delay + irq_save : no error case occurred.
> non-RT, threaded irq, 1ms delay : no error case occurred even twd
> fires inside the function execution.

Again, how do you observe it?

Peter

> 
> It doesn't seem to be a timing issue. But irq definitely affects
> priming on the RT kernel. Do you RT experts have any idea about the
> causes?
> If isr_tr_complete_handler fails ep priming it calls _ep_set_halt and
> goes an infinite loop in hw_ep_set_halt. It was an actual problem we
> experienced.
> So we protect irqs inside hw_ep_priming not to make error cases and
> also add a timeout inside the hw_ep_set_halt loop for a walkaround.
> The timeout patch is submitted to linux-usb.
> ( https://marc.info/?l=linux-usb&m=162918269024007&w=2 )
> 
> We withdrew this patch since we don't know if disabling irq is the
> best solution to solve the problem and udc would work fine with
> hw_ep_set_halt walkaround even though hw_ep_prime fails.
> But we are still trying to find out the cause of this symptom so We'd
> so appreciate it if RT or USB experts share some ideas or ways to
> report somewhere. Xilinx doesn't provide any support without their
> official kernel :(
> 
> Thanks for the discussion Sebastian.
> 
> Jeaho Hwang.
> 
> > …
> > > > If this function here is sensitive to timing (say the cpu_relax() loop
> > > > gets interrupt for 1ms) then it has to be documented as such.
> > >
> > > The controller sets ENDPTSETUPSTAT register if the host sent a setup packet.
> > > yes it is a timing problem. I will document that and resubmit again if
> > > you agree that local_irq_save could help from the timing problem.
> > >
> > > Thanks for the advice.
> >
> > If it is really a timing issue in the function as you describe below
> > then disabling interrupts would help and it is indeed an RT only issue.
> >
> > So you read OP_ENDPTSETUPSTAT, it is 0, all good.
> > You write OP_ENDPTPRIME, wait for it to be cleared.
> > Then you read OP_ENDPTSETUPSTAT again and if it is 0, all good.
> >
> > And the TWD interrupt could delay say the second read would read 1 and
> > it is invalidated. Which looks odd.
> > However, it is "okay" if the TWD interrupt happens after the second
> > read? Even if the host sends a setup packet, nothing breaks?
> > Do you have numbers on how long irq-off section is here? It seems to
> > depend on how long the HW needs to clear the OP_ENDPTPRIME bits.
> >
> > Sebastian
> 
> 
> 
> -- 
> 황재호, Jay Hwang, linux team manager of RTst
> 010-7242-1593

-- 

Thanks,
Peter Chen

