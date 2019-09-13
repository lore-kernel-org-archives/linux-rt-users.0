Return-Path: <SRS0=sGjS=XI=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A03EC49ED7
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 15:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C8B320830
	for <linux-rt-users@archiver.kernel.org>; Fri, 13 Sep 2019 15:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390902AbfIMPGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 13 Sep 2019 11:06:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34754 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390025AbfIMPGr (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Sep 2019 11:06:47 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1i8n9p-0004FB-CF; Fri, 13 Sep 2019 17:06:45 +0200
Date:   Fri, 13 Sep 2019 17:06:45 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Martin.Wirth@dlr.de
Cc:     linux-rt-users@vger.kernel.org, austin.linux@gmail.com
Subject: Re: Long latencies during disk-io
Message-ID: <20190913150645.nqt4ekv466yby2a4@linutronix.de>
References: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-13 14:09:22 [+0000], Martin.Wirth@dlr.de wrote:
> Hi Sebastian
Hi Martin,

> I will try the request_threaded_irq(, NULL, vInterruptService, …) solution on 
> Monday and report back. Since the driver also allows to poll several cards 
> (which I don't use at the moment) I think it is not possible to switch to swait/swake...

If you support the ->poll callback then it is not that simple to use
swait. For tasks that block in ->read()/->write() you could use it, for
->poll() you need the threaded handler to handle poll().

> And the interrupt line may be shared and if I remember correctly in this case it is also 
> not possible to use primary handlers, or am I wrong?  

puh. So you need to specify IRQF_ONESHOT so that the IRQ-core disables
the interrupt line until the threaded handler finishes its work (a
detail I forgot to mention in the previous mail). You are not allowed to
mix the IRQF_ONESHOT flag with multiple handlers (either all should have
them or none). So I think in the force-threaded case you should be fine
but in the non-threaded case you would have trouble.

> Cheers,
> Martin

Sebastian
