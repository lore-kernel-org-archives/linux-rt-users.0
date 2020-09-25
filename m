Return-Path: <SRS0=gYFm=DC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2F0C4363D
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 15:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29C2620878
	for <linux-rt-users@archiver.kernel.org>; Fri, 25 Sep 2020 15:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnALWWze";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lLkjtey+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgIYPQi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 25 Sep 2020 11:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbgIYPQi (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 25 Sep 2020 11:16:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3FC0613CE
        for <linux-rt-users@vger.kernel.org>; Fri, 25 Sep 2020 08:16:38 -0700 (PDT)
Date:   Fri, 25 Sep 2020 17:16:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601046997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inzqDMhBmBSxlPcAKUg/MVYBSwG+9w8tzql36Odi0CU=;
        b=XnALWWzeM5LatSIWYs3NRSq7gxmjlPe9ZTPc4UwppAVyyE6aA5l5sZh9MdHM5MHA5tYJdo
        kL/oKFsPmI8QkbkfS28DZwVjIZeH1OOzK+aOtRLn0x2/lYWSiST/huyY5qY0vv1efR0Iue
        tJuOB9uRKqFh9rUdY3f2ViUtu/Uq8rzrIUgV/wlTjgYxq/X6jBWehJO7Y9D01pOwB9XWnO
        V18iaLudKaK4UYyrc3thEm4e/aUWcQHBg4XogNzuR4/gOSEaZ4EJuRxcdiJIpsU8j/sfqC
        ou9BmL44QK3f/3Onp9k52JAIp7nl9cj0xQIIX+pmc3R+QQsA+CehbSUV+jfZeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601046997;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=inzqDMhBmBSxlPcAKUg/MVYBSwG+9w8tzql36Odi0CU=;
        b=lLkjtey+a99ByslDBbh5mQCxb27SaRPr5JM5dvcz1UzBiCy+5+uS8aTmt7ykX9uEy8rVas
        DLYqlMbMymcXk2DQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Aaron Marcher <aaron@sigma-star.at>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: Debugging reboot freeze
Message-ID: <20200925151635.dar46x7shgu4nqms@linutronix.de>
References: <20200925095715.poa62noo7dq2zyyp@linux-8csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925095715.poa62noo7dq2zyyp@linux-8csb>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-09-25 11:57:15 [+0200], Aaron Marcher wrote:
> Hi,
Hi,

> When using the same kernel version without PREEMPT_RT, the issue does
> not occur.
> 
> Do you have any hints for further debugging?
> Thank you very much in advance.

- try a later kernel (v5.9)
- implement ->write_atomic() and make sure the output goes to
  printk_emergency() (so the output hits the uart right away).
- enable lockdep and check what explodes.

> Regards,
> Aaron Marcher

Sebastian
