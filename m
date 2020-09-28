Return-Path: <SRS0=JPb9=DF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B21C2D0A8
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 11:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722712080C
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 11:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1LVr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Sep 2020 07:21:47 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:49026 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgI1LVq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Sep 2020 07:21:46 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id A11D61816C70D;
        Mon, 28 Sep 2020 13:21:44 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id k3YT-ZzIR-qf; Mon, 28 Sep 2020 13:21:44 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nAp5OvVV_2L5; Mon, 28 Sep 2020 13:21:44 +0200 (CEST)
Date:   Mon, 28 Sep 2020 13:21:43 +0200
From:   Aaron Marcher <aaron@sigma-star.at>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Debugging reboot freeze
Message-ID: <20200928112143.66tsdiw2wunwra3a@linux-8csb>
References: <20200925100450.3t3xrwwb22fac7ti@linux-8csb>
 <DB6PR0402MB276028AE4CC27F2ACC5D96FC88340@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200928073959.jf5wqgfzirhns6u3@linux-8csb>
 <DB6PR0402MB276079E8BC4B302DEE99B58488350@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB276079E8BC4B302DEE99B58488350@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peng,

> you mean upstream stable branch 5.4.66 + RT37 patchset?

Yes.

> Where is the power domain patches? I not did this part.

I confused names, sorry. You can find them here:
https://patchwork.kernel.org/cover/10904511/

> Do you have a github branch for this? And what kernel config are you using?

Unfortunately not as we got the sources from the vendor directly.
We are using an arm64 defconfig with everything imx8-related enabled.

> NXP official release is 2020.04, not 2020.07, could you share the link?

Same here, unfortunately we cannot share a link to the sources.

> Which specific release branch?

rel_imx_5.4.3_2.0.0-0-gf1a195b5c-dirty


Does the issue happen for you with these versions?

Thanks
Aaron
