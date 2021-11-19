Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5804BC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3274861AD2
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Nov 2021 11:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbhKSLR6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Nov 2021 06:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhKSLR6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Nov 2021 06:17:58 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D19C061574;
        Fri, 19 Nov 2021 03:14:56 -0800 (PST)
Date:   Fri, 19 Nov 2021 12:14:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637320494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/VZyAtjdIn8jdD6pqRkSFjT2FGF/KDnvfFXvodzNkY=;
        b=NDT9FK7bxmZz20TXrs22ieexWO/hQkopYIQyPVA2J/Xlmx3xlaaLvwxfCBYyOv2/3+7cRi
        7nLgKVNLmwZOXL8WArAKpP+CA0NZxRR1Dva3c5qHCNJqaxCFWEYzu1B36OkUXzclE7Cl5D
        6Cuy1eJoeEey8t9w/d5rzB4MkIQlvl4NDekV9wtH9Ujoejm6EMDKtq36I9oF4qxkXcM+im
        SM+72tgBt2DON8acL6QA9ZtnW+NpVM/eZGHN3LBI7sl5TqCgIMLep7FitZOlV/D3UorHOz
        NEWOhegjiPcfj7jqP5ndgmfo0FNJK4mMBKzbBOe7GVRJRdatUjsWUlRCuGnc7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637320494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+/VZyAtjdIn8jdD6pqRkSFjT2FGF/KDnvfFXvodzNkY=;
        b=X3IQ588Q521jn3d13jhA828FCytG9/ilRet9GDhHrSsYlUqR3ye+W+aOxzkKyRVPZIMYA0
        tqXGCZW/15LgBvAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 0/3] irqchip/gic-v3-its: Fix LPI pending table
 handling vs PREEMPT_RT
Message-ID: <20211119111453.gqly3pyll3eluqap@linutronix.de>
References: <20211027151506.2085066-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027151506.2085066-1-valentin.schneider@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-27 16:15:03 [+0100], Valentin Schneider wrote:
> Hi folks,
Hi,

> This is my take at fixing [1]. Reading about the LPI tables situation was
> entertaining.
> 
> Tested against kexec on an Ampere eMAG. Seems to be working fine atop
> 5.15-rc6. On the other hand, I can only issue one kexec from
> 5.15-rc6-rt12 - if I then issue another one on the new kernel, I get tasks
> hanging. That is true even without my patches and without
> CONFIG_PREEMPT_RT.

What is the status of this? I haven't seen any replies, is this just
sitting to be merged?

Sebastian
