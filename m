Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B93FC43334
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jun 2022 10:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiF0KMC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jun 2022 06:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiF0KMB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jun 2022 06:12:01 -0400
X-Greylist: delayed 1251 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 03:12:00 PDT
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A926401
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jun 2022 03:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=TuoJwMn/ECh31VCOO/1whkPsWYq2a9yG3HbC8sw1Ak0=; b=b52Va
        O7gKRciMeeYTfvRMinLgqGXPzh/xw1huciICObgrdYLSLXJMRZ3UhRhVCy2SA6L8uQ/MSe2sZp5Ll
        qw6eqztx6HsCgxHWpuNRh11EH5tmKE9fy2XO9oNFsaJ0mYxBUQv2NO1YdU5z0OdL9XL0/nag1RKcd
        JJqy8WmJ9I+IrQdh3E8EyMfw8ESzi6bk5mQBPzoFr9yI4qhTtD7vsKQ328SooiHf3EPgmueXPezyP
        y14Iter7Zi6uevaVm3gdWw/llZoL7949idbC9HS52eZ3utr1t0TdWzDbFsvop7ArXN6wLSTOcIm3A
        442zfEPirRjEMuVV3WFUOxsrxLYYA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1o5lOZ-0002MJ-B5; Mon, 27 Jun 2022 10:51:03 +0100
Date:   Mon, 27 Jun 2022 10:51:02 +0100
From:   John Keeping <john@metanate.com>
To:     andreadaoud6@gmail.com
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [RT] BUG in sched/cpupri.c
Message-ID: <Yrl9hqqwskqVubt+@donbot>
References: <87h7a66uow.mognet@arm.com>
 <20220627020204.29132-1-andreadaoud6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627020204.29132-1-andreadaoud6@gmail.com>
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Jun 27, 2022 at 10:02:04AM +0800, andreadaoud6@gmail.com wrote:
> I'm encountering this problem today with linux 5.15.5 rt22 kernel.
> This bug leads to an unstable system. Having read all your discussions, I know
> there is a workaround, but it doesn't seem that everybody agrees this.
> I'd like to know if this problem is solved in later rt patch series.
> If yes, could someone be more specific which patch solves it?
> If not, is applying the above mentioned workaround patch the best solution?

Valentin was fixed this in 49bef33e4b87 ("sched/rt: Plug
rt_mutex_setprio() vs push_rt_task() race") which was backported to
v5.15.33, so updating to the latest v5.15 stable release will pull in
the fix.
