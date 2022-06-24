Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A49C433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 06:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiFXGqS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 02:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiFXGqR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 02:46:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5328B6362A
        for <linux-rt-users@vger.kernel.org>; Thu, 23 Jun 2022 23:46:17 -0700 (PDT)
Date:   Fri, 24 Jun 2022 08:46:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656053176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EvnQFrUsklfAcC7OiiVMgJASpGCzbvqKvbsKH87pemU=;
        b=m6IZfh/kS0HrgBNODulMgLLRvzlJf3QSvBpX8o2mXZH64oObyWUkA0p1PWWWGiwxkViGEC
        s0IIj7QdOFCX3lo42ZmsPkLaljh1oA5h2gzjgU2kDDK4QeOezh6xe4M8bgXQJ7yYPrRGc6
        vjoSf7fLXDweG3kBi9QH8o/Yw40Ag+B5GsU26i61Q941mdYYbfLyei6jBAtKkmtDPMos70
        fQ0zF0JdrewR0uxLsyFMhGT44kxjnNZ3l2uiBwAPRN1l+vujF90LXE2BRHbEEn4DarBBlG
        2eznu16HSFahY3PfJ2NkgSZCQ1pu9+8GS00XygT6vOkWnkluIZ7POGS+dDP9aA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656053176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EvnQFrUsklfAcC7OiiVMgJASpGCzbvqKvbsKH87pemU=;
        b=cgeY4My9rSgoZY5oN6hharOS+fK2eL5pqVDeQX48F4NjiJ1JpS/REpNCPnGI6ZJsBWX9nk
        FtOAtboAXj9wqtDA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Baoquan He <bhe@redhat.com>
Cc:     Waiman Long <longman@redhat.com>,
        Zhipeng Shi <zhipeng.shi0@gmail.com>, linux-mm@kvack.org,
        linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        shengjian.xu@horizon.ai, schspa@gmail.com, peterz@infradead.org
Subject: Re: [Question] vmalloc latency in RT-Linux
Message-ID: <YrVdtvZgH2aLreOG@linutronix.de>
References: <20220621121547.GB37196@ubuntu20>
 <YrRFpmk0pxvXanbH@MiWiFi-R3L-srv>
 <dd4f2422-3151-2c0b-e4c6-fe49f6d2ac30@redhat.com>
 <YrUj70P1sYFXsnqf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrUj70P1sYFXsnqf@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-24 10:39:43 [+0800], Baoquan He wrote:
> Then this is a good chance to reconsider it, maybe with a test from Zhipeng.

I reconsidered and it was dropped purpose, see
	https://lore.kernel.org/lkml/YT80AB8%2FG59QBSVq@hirez.programming.kicks-ass.net/

Sebastian
