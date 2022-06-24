Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419AAC43334
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 14:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiFXOb2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 10:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXOb1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 10:31:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAA555535A
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 07:31:26 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656081085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+ikyKxH7IHKFSSz6uKtvnrqrRRHHnom1CmDIqB3QOQ=;
        b=nE5ptUbysXNaNkYI5pfYkTXSZoB57rZcq8Z+750uW6escEZ7Ic2ZmI6U3d9aUgqL6cP1EE
        kxsa1D60Q4SWktccyShPeNd/Hl+e/BUreQq8Lo38JddzE6/2rjB3H282bXCIy1dgr6M6Bd
        qlkNoTV/ZVgW/pAl4i68eh/vLhyS4+ECPtBwlbyhOORU6WPivssyxxasQKPAnLxq2vKB6N
        Duuazly88T+XW+KFb6dkQ952sPCalJuSu3S97F5EjG6ZSI5SQvH3DWUWVjRkHAgq6cZ40g
        yBO0q0Luywfp4CR0PFUz9HfBg3yNJVjitpywnFL6AR1hizMzXcYfLoi+UufUtw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656081085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+ikyKxH7IHKFSSz6uKtvnrqrRRHHnom1CmDIqB3QOQ=;
        b=D4HHeUZbXLmEtEO/egkzi3cfQB6twZ0SXbuFOhrhX8S7yRXrfYDY0qWGUty9P0mD6W2lpL
        AL79UOsVvueuZfCg==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
In-Reply-To: <87wnd616ds.fsf@jogness.linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
 <YrV4795StT13AUC+@linutronix.de>
 <a35dc9666de31d406a2132fc9457349dc8ee10ef.camel@gmx.de>
 <YrWPiwtk0kAWxXI9@linutronix.de> <87wnd616ds.fsf@jogness.linutronix.de>
Date:   Fri, 24 Jun 2022 16:37:25 +0206
Message-ID: <87tu8a16bm.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-24, John Ogness <john.ogness@linutronix.de> wrote:
> As to this the actual problem reported in this thread, I believe this
> patch solves it:
>
> https://lore.kernel.org/lkml/20220609121709.12939-1-Jason@zx2c4.com

There was a cleaner v2 later in the thread:

https://lore.kernel.org/lkml/20220609123319.17576-1-Jason@zx2c4.com
