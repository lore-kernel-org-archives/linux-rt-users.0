Return-Path: <SRS0=2Bnr=75=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099F9C433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 20:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78082085B
	for <linux-rt-users@archiver.kernel.org>; Tue, 16 Jun 2020 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592340416;
	bh=2dvEAqyxOW3qcudKHZlBAh3MG+XCmSm3T63qebwF9vk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2QNY46ikS4Ee5E9yw2b1mtA1+QA3XRL4agxwi/eQoATVcC+DTBW7pQJL771wmJsHz
	 uVKkyYorYpN8WNdrTS9Ws0EJ2QwFGnQi4BSxBctTe57/eJmkVLcO94GfInw5jAyLGs
	 Bs5Eux3Yz3uLWaVVncDtUpu1vCp/Pf0ngntt7ic0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFPUqy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 16 Jun 2020 16:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgFPUqx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 16 Jun 2020 16:46:53 -0400
Received: from localhost (lfbn-ncy-1-150-120.w83-194.abo.wanadoo.fr [83.194.232.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEC752080D;
        Tue, 16 Jun 2020 20:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592340413;
        bh=2dvEAqyxOW3qcudKHZlBAh3MG+XCmSm3T63qebwF9vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PNtmy1s94C9sPECtyji/NqSJXzBEA2tVsgqMAx0irX0PpQ3zUuO4wwLBSq1qep7Qf
         GuHSjQyA54IOnPNDpF4Pe0JiaCUiS6Oc7UXkAl1lznHIygYsYocEoY30j5k765MS0K
         N/SD81SnKiuxXRTFqGuPZ4R2tVF343/nyRqg/sG8=
Date:   Tue, 16 Jun 2020 22:46:51 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200616204649.GA4914@lenoir>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
 <20200520184710.GO10078@localhost.localdomain>
 <20200521004443.GB15455@lenoir>
 <20200521170020.GQ10078@localhost.localdomain>
 <20200615210743.GA21371@lenoir>
 <20200616065757.GA446382@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616065757.GA446382@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jun 16, 2020 at 08:57:57AM +0200, Juri Lelli wrote:
> Sure. Let me know if you find anything.

I managed to reproduce. With "threadirqs" and without
"tsc=reliable". I see tons of spurious TIMER softirqs.
Investigation begins! I'll let you know.

Thanks!
