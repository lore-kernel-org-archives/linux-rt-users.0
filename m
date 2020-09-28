Return-Path: <SRS0=JPb9=DF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D4FC2D0A8
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 07:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 921D42080C
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgI1HkC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Sep 2020 03:40:02 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:36838 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgI1HkC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Sep 2020 03:40:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id C7E671816C717;
        Mon, 28 Sep 2020 09:40:00 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Cyvan0j3s0rY; Mon, 28 Sep 2020 09:40:00 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id nbSSORnftm1T; Mon, 28 Sep 2020 09:40:00 +0200 (CEST)
Date:   Mon, 28 Sep 2020 09:39:59 +0200
From:   Aaron Marcher <aaron@sigma-star.at>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: Re: Debugging reboot freeze
Message-ID: <20200928073959.jf5wqgfzirhns6u3@linux-8csb>
References: <20200925100450.3t3xrwwb22fac7ti@linux-8csb>
 <DB6PR0402MB276028AE4CC27F2ACC5D96FC88340@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB276028AE4CC27F2ACC5D96FC88340@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peng,

> Where do you get the kernel source code and which version?
> NXP release or Linux kernel upstream?
>
> Also ATF/U-Boot version?

- Kernel: Mainline (5.4.66-rt37) + PREEMPT_RT + your power domain patches
- U-Boot: NXP (2020.07)
- ATF: NXP (v2.0)
   https://source.codeaurora.org/external/imx/imx-atf/

> Do you have a debugger to see where it hangs?

Unfortunately not.

> If you point me your version, and source, I could give a try in my side.

Thanks, let me know if you need anything else.

Regards,
Aaron
