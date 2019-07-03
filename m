Return-Path: <SRS0=+P7g=VA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA58C0650E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A98092189E
	for <linux-rt-users@archiver.kernel.org>; Wed,  3 Jul 2019 11:21:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGCLVT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Jul 2019 07:21:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51786 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbfGCLVT (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Jul 2019 07:21:19 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hidK8-0003JV-N1; Wed, 03 Jul 2019 13:21:16 +0200
Date:   Wed, 3 Jul 2019 13:21:16 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Chris Friesen <chris.friesen@windriver.com>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: weird issue with CentOS RT kernel, hangs hard under particular
 load.
Message-ID: <20190703112116.bnahv3wno7o475zt@linutronix.de>
References: <c9786841-df3c-b022-3f94-5973f97086aa@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c9786841-df3c-b022-3f94-5973f97086aa@windriver.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-28 13:35:51 [-0600], Chris Friesen wrote:
> Hi all,
Hi,

> Not sure who I should be talking to about this, but we're hitting a weird
> issue with kernel-rt-3.10.0-957.12.2.rt56.929.el7.src.rpm from CentOS.

3.10-rt56 is terribly old and unsupported [0].

> Anyone got any suggestions on where to start debugging it?  Kernel options
> to enable, extra debug logging, events to monitor?

You could try to enable MM debugging, lock debugging and so on.

[0] https://wiki.linuxfoundation.org/realtime/preempt_rt_versions

> Thanks,
> Chris

Sebastian
