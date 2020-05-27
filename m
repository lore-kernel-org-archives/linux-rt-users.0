Return-Path: <SRS0=+jQa=7J=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386AC433E1
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 May 2020 09:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5F20888
	for <linux-rt-users@archiver.kernel.org>; Wed, 27 May 2020 09:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgE0JtA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 27 May 2020 05:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727895AbgE0JtA (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 27 May 2020 05:49:00 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1D8C061A0F
        for <linux-rt-users@vger.kernel.org>; Wed, 27 May 2020 02:48:59 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdsgE-0005ms-5V; Wed, 27 May 2020 11:48:58 +0200
Date:   Wed, 27 May 2020 11:48:58 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v5.6.4-rt3] rfcomm/bluetooth: avoid disabling interrupts
 on RT
Message-ID: <20200527094858.qqbctvdgr6bvjfqn@linutronix.de>
References: <20200423193155.GD75343@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200423193155.GD75343@uudg.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-23 16:31:55 [-0300], Luis Claudio R. Goncalves wrote:
…
> Replacing local_irq_save()/bh_lock_sock() by spin_lock_bh() keeps the semantics
> and does the right thing under PREEMPT_RT.

Nope. The irq-off was introduced in commit
   fad003b6c8e3d ("Bluetooth: Fix inconsistent lock state with RFCOMM")

It doesn't look right. Could you please revert that commit and check if
lockdep still complains?

Sebastian
