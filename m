Return-Path: <SRS0=29q8=ZT=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0743DC432C3
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8DBB20678
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 Nov 2019 14:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfK0OAY (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 Nov 2019 09:00:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44735 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbfK0OAY (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 Nov 2019 09:00:24 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iZxri-0007ly-8x; Wed, 27 Nov 2019 15:00:22 +0100
Date:   Wed, 27 Nov 2019 15:00:22 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 2/2] rt-tests: Add SPDX tag to hackbench.c
Message-ID: <20191127140022.ggrikkp4xtqo3ysm@linutronix.de>
References: <20191125223810.16643-1-jkacur@redhat.com>
 <20191125223810.16643-2-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191125223810.16643-2-jkacur@redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-11-25 23:38:10 [+0100], John Kacur wrote:
> Add SPDX tag GPL-2.0-or-later
> The original author is Rusty Russell
> 
> In his mail with the following message-id, he says:
> Message-ID: <200911022357.36541.rusty@rustcorp.com.au>
> 
> > ( I've Cc:-ed Rusty, the original author of hackbench.c. Rusty, the file
> >   has no explicit GPLv2 compatible license - is it fine to be put
> >   into GPLv2 code? )
> 
> Yep, like all my code it's standard v2 "or later".
> 
> Sounds like a good plan, thanks!
> Rusty.
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Thank you.

Sebastian
