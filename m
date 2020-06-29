Return-Path: <SRS0=hsO6=AK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73002C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Jun 2020 21:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4052F20759
	for <linux-rt-users@archiver.kernel.org>; Mon, 29 Jun 2020 21:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466514;
	bh=vDqH4OQik9QBHRoYPIsS115Se7LvewJkoA+wC/XILJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RYhIF4BXPFOy+Kzc472uDgRI9NuBIHlQ3fyu7jTz02J4x88xBOHmAVXpsaoiTuY2W
	 BGfHPyy5CgscmckVmGhcLkwTGikqaINB/KyOAvs4Da1OD1KFJLoTyZ7YkvhSGZ5cOW
	 H9XKdVT6Vvr5wSKGfHO8RP1T29hhvi8mdx8ePs8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgF2VfN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728529AbgF2Sky (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 29 Jun 2020 14:40:54 -0400
Received: from localhost (lfbn-ncy-1-996-218.w90-101.abo.wanadoo.fr [90.101.73.218])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54B8E23D24;
        Mon, 29 Jun 2020 12:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593434530;
        bh=vDqH4OQik9QBHRoYPIsS115Se7LvewJkoA+wC/XILJ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=04ef066Nl1RVmJ0rEQuLCUxIe74aNZT94SXMcWmBJpt8ieJLaRiuiPf01/phg/pRn
         cwsQ8o70pdRXGfjV7aiVEDSYjYr+B/VlEQvBhNdQABAmIitvNHFdXFvu5FutYwDCMl
         yFxuImOmuk9k1S/icL0Ln6ggd0ghKrEIiR1lHDhc=
Date:   Mon, 29 Jun 2020 14:42:08 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200629124207.GA6088@lenoir>
References: <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
 <20200616065757.GA446382@localhost.localdomain>
 <20200616204649.GA4914@lenoir>
 <20200629123651.GA9670@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629123651.GA9670@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jun 29, 2020 at 02:36:51PM +0200, Juri Lelli wrote:
> Hi,
> 
> On 16/06/20 22:46, Frederic Weisbecker wrote:
> > On Tue, Jun 16, 2020 at 08:57:57AM +0200, Juri Lelli wrote:
> > > Sure. Let me know if you find anything.
> > 
> > I managed to reproduce. With "threadirqs" and without
> > "tsc=reliable". I see tons of spurious TIMER softirqs.
> > Investigation begins! I'll let you know.
> 
> Gentle ping. Any new findings about this issue?

Yep, I'm working on a series to reduce timer softirqs. I'm almost
done, should post it soon.

I believe you guessed right:

* Timer tick raises timer softirq
* Ksoftirqd wakes up, restarts the tick
* Timer tick raises timer softirq
* ...

Thanks.
