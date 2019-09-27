Return-Path: <SRS0=wj13=XW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B27C4360C
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 12:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC38421906
	for <linux-rt-users@archiver.kernel.org>; Fri, 27 Sep 2019 12:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbfI0M3i convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 27 Sep 2019 08:29:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:45809 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbfI0M3i (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Sep 2019 08:29:38 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iDpNO-0000wR-Uv; Fri, 27 Sep 2019 14:29:35 +0200
Date:   Fri, 27 Sep 2019 14:29:34 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     Clark Williams <clark.williams@gmail.com>, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PREEMPT_RT PATCH 2/3] i915: convert all irq_locks spinlocks to
 raw spinlocks
Message-ID: <20190927122934.2bz6ysx27ecw2uxa@linutronix.de>
References: <20190820003319.24135-1-clark.williams@gmail.com>
 <20190820003319.24135-3-clark.williams@gmail.com>
 <20190903080335.pe45dmgmjvdvbyd4@linutronix.de>
 <9EF2695D-3FBD-40E0-BE8A-EB71AF4155A5@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <9EF2695D-3FBD-40E0-BE8A-EB71AF4155A5@linux.intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-16 14:21:22 [-0700], Sean V Kelley wrote:
> I’ve tested this also on the v5.2.14-rt7 and can confirm that it avoids the need for making the locks raw.
> 
> Tested-by: Sean V Kelley <sean.v.kelley@linux.intel.com>

Good. I went for an alternative approach in v5.2.17-rt9. Now I believe
that the three here are obsolete. If not, please give a sign.

> Thanks,
> 
> Sean

Sebastian
