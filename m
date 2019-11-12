Return-Path: <SRS0=ZIbK=ZE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5104C43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 11:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8346921783
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Nov 2019 11:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfKLLkC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Nov 2019 06:40:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34163 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbfKLLkC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Nov 2019 06:40:02 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iUUWb-0001Ti-AP; Tue, 12 Nov 2019 12:39:57 +0100
Date:   Tue, 12 Nov 2019 12:39:57 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Mike Snitzer <msnitzer@redhat.com>,
        Scott Wood <swood@redhat.com>, dm-devel@redhat.com,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Ilias Tsitsimpis <iliastsi@arrikto.com>,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de
Subject: Re: [dm-devel] [PATCH 2/2] realtime: avoid BUG when the list is not
 locked
Message-ID: <20191112113957.ojal5uccceky7s6f@linutronix.de>
References: <alpine.LRH.2.02.1911110853100.30532@file01.intranet.prod.int.rdu2.redhat.com>
 <20191112091044.lf7okijocx2wajhk@beryllium.lan>
 <alpine.LRH.2.02.1911120621030.17732@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1911120621030.17732@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-11-12 06:21:57 [-0500], Mikulas Patocka wrote:
> > CONFIG_PREEMPT_RT_BASE is only available in the out of tree -rt patch
> > set, therefore I assume it's not for mainline, right?
> 
> Yes - this is intended to be applied to the realtime patchset.

In that case please repost it and Cc tglx and myself and add the RT tag
after PATCH.
Please make sure it applies and fixes a problem in the latest available
RT kernel. Please state the problem on RT and how it is solved.

> Mikulas

Sebastian
