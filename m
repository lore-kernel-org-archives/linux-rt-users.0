Return-Path: <SRS0=0hJj=WQ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F001DC3A589
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 08:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBAD23A45
	for <linux-rt-users@archiver.kernel.org>; Tue, 20 Aug 2019 08:28:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729269AbfHTI2O (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 20 Aug 2019 04:28:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51067 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfHTI2O (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 20 Aug 2019 04:28:14 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hzzUw-0006no-Bm; Tue, 20 Aug 2019 10:28:10 +0200
Date:   Tue, 20 Aug 2019 10:28:10 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        williams@redhat.com
Subject: Re: [RT PATCH v2] net/xfrm/xfrm_ipcomp: Protect scratch buffer with
 local_lock
Message-ID: <20190820082810.ixkmi56fp7u7eyn2@linutronix.de>
References: <20190819122731.6600-1-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190819122731.6600-1-juri.lelli@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-08-19 14:27:31 [+0200], Juri Lelli wrote:
> This v2 applies to v4.19.59-rt24.

Looks good, I suggest to apply this to v4.19 and earlier.

For v5.2 and later (including upstream) please send a patch to simply
replace get_cpu() with smp_processor_id(). The reason is that get_cpu()
will not disable BH and according to the call path this function is
invoked in NAPI callback and the other sides does local_bh_disable().
Therefore the caller of this must ensure that BH is disabled and
disabling preemption is not enough.

Sebastian
