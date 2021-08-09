Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69240C4338F
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Aug 2021 01:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C28160FF2
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Aug 2021 01:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhHIB2M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:28:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232359AbhHIB2M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 8 Aug 2021 21:28:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 096BB604D7;
        Mon,  9 Aug 2021 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628472472;
        bh=XPp8rG08ZWrplVlCPRKs47QXV8DYIX2lILk+jz/sn4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELnHoYf79h2LIuAOQL0IjUZZBTqWq3+GgWY4XtCO6Af6t3of3nGHKAfyfhqyHWtdp
         tVNUzHaS7xQzAZ1gpcqBLvPtaTS/Od6/ozkhPsS7FIJ2dfpr33lPT3RRXDIewqeKsa
         0LghcAIZLPY8bLIEg+e+ahdJCRs9lKzztIv7EEFTGXSvxybaQ8iSCv54aC0E5VWY/m
         MJHpNJGXhevFhVSmQ+VSbmBbdR9XDUmF/uwIpIhbZoc+BUX/yVRS/ArW5keyWodzIG
         vJJ8GQ06M0dCt7qpx8y8It0Iz5UIYwrg090FR8VWTqnKB5j/sgLb9yxLDib1fcdzRz
         ONIyGkpWk6nmg==
Date:   Mon, 9 Aug 2021 09:27:47 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     linux-usb@vger.kernel.org,
        =?utf-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9t?=
         =?utf-8?B?YXRpb24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <mkbyeon@lselectric.co.kr>, Linux team <team-linux@rtst.co.kr>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Chipidea USB device goes infinite loop due to interrupt while
 hw_ep_prime
Message-ID: <20210809012747.GA6814@nchen>
References: <CAJk_X9hBB_edByfEvueSyWgKjpYGZbS2rPLPCSpRrPr+icFz_Q@mail.gmail.com>
 <20210804013252.GA16420@nchen>
 <CAJk_X9gwa+4CZRemKqW7XZzxd438EQHA-Ngp4MdmPVgHM0Q5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJk_X9gwa+4CZRemKqW7XZzxd438EQHA-Ngp4MdmPVgHM0Q5fg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 21-08-04 11:03:44, Jeaho Hwang wrote:
> Hi. linux-usb and linux-rt experts.
> >
> > On 21-08-02 17:35:01, Jeaho Hwang wrote:
> > > Hi.
> > >
> > > We found an infinite loop inside the function hw_ep_set_halt
> > > (drivers/usb/chipidea/udc.c) if a cablle is repeatedly
> > > connnected/disconnected while ping through RNDIS with chipidea USB device.
> > >
> > > Using ftrace tracing, we found that hw_ep_set_halt is called due to error
> > > return of hw_ep_prime(drivers/usb/chipidea/udc.c:202) which is called from
> > > isr_tr_complete_handler -> isr_setup_status_phase -> _ep_queue.
> > >
> > > The comment of function hw_ep_prime says (execute without interruption) but
> > > timer interrupt is occurred while hw_ep_prime is executing. We believe that
> > > the interrupt causes an error return of hw_ep_prime. We tried to protect
> > > hw_ep_prime from irqs and then no case of the infinite loop is occurred.
> > >
> > > I want ask if it is appropriate way that turning off irq inside (threaded)
> > > irq handlers. And should we explicitly turn off irqs before calling
> > > hw_ep_prime?
> > >
> >
> > Jeaho, do you use RT-Linux or standard Linux? The function hw_ep_prime is
> > only called at udc_irq which is registered as top-half irq handlers.
> > Why the timer interrupt is occurred when hw_ep_prime is executing?
> 
> We use preempt_RT so timer interrupt could be occurred. Now I found
> out that forced threaded irq handler disables local irq on standard
> linux so It is a linux-rt issue. Then should I make patch which
> disables local irqs during hw_ep_prime for RT kernel and suggest it to
> linux-rt maintainers?
> 
> Thanks for a kind answer Peter.
> 

No, that will lead to deadlock since the normal request queue API function
ep_queue disables irq which also calls into hw_ep_prime.

For RT kernel, you may try to disable local irq at isr_setup_status_phase.

-- 

Thanks,
Peter Chen

