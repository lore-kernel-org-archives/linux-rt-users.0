Return-Path: <SRS0=gYFm=DC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24FC4363D
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 10:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CED20BED
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 10:04:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgIYKEw (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Sep 2020 06:04:52 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:42360 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbgIYKEw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Sep 2020 06:04:52 -0400
X-Greylist: delayed 454 seconds by postgrey-1.27 at vger.kernel.org; Fri, 25 Sep 2020 06:04:51 EDT
Received: from localhost (localhost [127.0.0.1])
        by lilium.sigma-star.at (Postfix) with ESMTP id 2BFBA1812609B
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Sep 2020 12:04:51 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5ND5t5sOj8Xp for <linux-rt-users@vger.kernel.org>;
        Fri, 25 Sep 2020 12:04:50 +0200 (CEST)
Received: from lilium.sigma-star.at ([127.0.0.1])
        by localhost (lilium.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fa-C8EFlch0P for <linux-rt-users@vger.kernel.org>;
        Fri, 25 Sep 2020 12:04:50 +0200 (CEST)
Date:   Fri, 25 Sep 2020 12:04:50 +0200
From:   Aaron Marcher <aaron@sigma-star.at>
To:     linux-rt-users@vger.kernel.org
Subject: Debugging reboot freeze
Message-ID: <20200925100450.3t3xrwwb22fac7ti@linux-8csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

we are encountering reboot freezes on the current 5.4.66-rt38 kernel
with PREEMPT_RT enabled on i.mx8mm hardware.
Unfortunately, debugging is difficult in this situation as the only
related output we get during reboot (via serial console) is:

    Rebooting...
    Segmentation fault

However, the second line is not shown on every reboot; the freeze
happens everytime.

We already tried various kernel command line options
(print-fatal-signals=1 oops=panic), earlyprintk/earlycon and a lot of
debug printk's in the kernel source.
However it seems that there is no output after
`kernel_restart_prepare(cmd);` in kernel/reboot.c.

When using the same kernel version without PREEMPT_RT, the issue does
not occur.

Do you have any hints for further debugging?
Thank you very much in advance.

Regards,
Aaron Marcher
