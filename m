Return-Path: <SRS0=0Kbd=XM=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15D5C4CEC9
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 11:20:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7829F214AF
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Sep 2019 11:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfIQLUm (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Sep 2019 07:20:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41369 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfIQLUm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Sep 2019 07:20:42 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iABXE-0002xr-6c; Tue, 17 Sep 2019 13:20:40 +0200
Date:   Tue, 17 Sep 2019 13:20:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Martin.Wirth@dlr.de
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Long latencies during disk-io
Message-ID: <20190917112039.nwzg3qfxrdwsa6t7@linutronix.de>
References: <20190905154115.mnid6rue65x6vvt6@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51159F@DLDEFFMIMP02EXC.intra.dlr.de>
 <CABsbf=EsGK0-teWZ7vGuKS=edz+uCoxcd6KdoU5Cf_2gdeEhtg@mail.gmail.com>
 <1A2AF5F768264E479963C4D8C015EB696C515541@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913133655.2pbhnxm5ndcje3bk@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C51C1F1@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190913150645.nqt4ekv466yby2a4@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C520504@DLDEFFMIMP02EXC.intra.dlr.de>
 <20190917105236.yf5btniiq4bjhimo@linutronix.de>
 <1A2AF5F768264E479963C4D8C015EB696C521875@DLDEFFMIMP02EXC.intra.dlr.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1A2AF5F768264E479963C4D8C015EB696C521875@DLDEFFMIMP02EXC.intra.dlr.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-17 11:09:31 [+0000], Martin.Wirth@dlr.de wrote:
> Hi Sebastian,
Hi Martin,

> Maybe not. But this means that a lot of drivers which have no requirement 
> to be protected against softirq will have to be converted to make them fit for RT. 
> But maybe I'm wrong and most RT applications are triggered by the timer 
> and not by some io-card...

Your argument is valid. If we don't disable softirqs while
force-threading then we need duct-tape in other places. So it is not
ideal. Now we know that this seems to be problem.

> Thanks again for all the work!
> 
> Martin

Sebastian
