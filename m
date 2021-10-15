Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B5C433FE
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061CD6108B
	for <linux-rt-users@archiver.kernel.org>; Fri, 15 Oct 2021 17:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241928AbhJORFf (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 15 Oct 2021 13:05:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51446 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237591AbhJORFe (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 15 Oct 2021 13:05:34 -0400
Date:   Fri, 15 Oct 2021 19:03:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634317407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOyUI0ODUwcB/DpCaZncwjS5P6oVgAM8u+fmdmPd+Fk=;
        b=wjNvJJ3hyPp12T0AiywUMmJPt0ILxqPF0IB35M24zW3pATFmuSLNc/r27dkBM4b2JMUKYs
        U3xl+seWFBD24uBKDU8vCYSp39IKJ3PR1F+QTKp5GGj0lf+C2auGePXccyBpcIn5jRZqXT
        07DSWAzKYO9Ik+bUmhXadWkjseVsByha7xSYRHLllk2Pc/zqXW9eQ0onEiaxmtb0FwvwKC
        c/2Y2PpHmG8zaBZmLkAJPeMz5WKHIWUDWVzApsbINeqUW4vlnYltsvvRN7718uXMXFNjQm
        kcofalzMHppaZhyLUUCRrNAJ+aimERXtuYlvrLEzMmyoc2YcXUV6jFZ9uOA0dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634317407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KOyUI0ODUwcB/DpCaZncwjS5P6oVgAM8u+fmdmPd+Fk=;
        b=K+GqVMI9fY1fegKjJGNJpmfBezDn7/SJk5Nf6AtxFwuFU2XwugmgUJBU105w5xlL7xcgjP
        TnvFhzxQPAztFvAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, rostedt@goodmis.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] arm64: signal: Delay calling signals in atomic
Message-ID: <20211015170325.li5rugf6u4rghkrd@linutronix.de>
References: <20211012084421.35136-1-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211012084421.35136-1-zhe.he@windriver.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-10-12 16:44:21 [+0800], He Zhe wrote:
> Debugging with breakpoints on arm64 and RT would trigger the following
> call trace. When CONFIG_PREEMPT_RT is enabled, spin_locks become mutexes,
> and one of these is the spin lock used in signal handling.

Applied.

Sebastian
