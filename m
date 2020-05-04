Return-Path: <SRS0=LbvN=6S=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A95C47258
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 15:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC01206D7
	for <linux-rt-users@archiver.kernel.org>; Mon,  4 May 2020 15:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgEDPlv (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 4 May 2020 11:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727929AbgEDPlv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 May 2020 11:41:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CF0C061A0E
        for <linux-rt-users@vger.kernel.org>; Mon,  4 May 2020 08:41:51 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jVdE5-00006d-3r; Mon, 04 May 2020 17:41:49 +0200
Date:   Mon, 4 May 2020 17:41:48 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Joe Korty <joe.korty@concurrent-rt.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH] signals: Allow tasks to cache one sigqueue struct,
 version 2
Message-ID: <20200504154148.lkowhavipj65c76n@linutronix.de>
References: <20200428154536.GA33300@zipoli.concurrent-rt.com>
 <20200430161848.GA29113@zipoli.concurrent-rt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430161848.GA29113@zipoli.concurrent-rt.com>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-04-30 12:18:48 [-0400], Joe Korty wrote:
> [5.4.28-rt19] Cache up to one sigqueue per task.
> 
> This replaces an earlier version of this rt patch,
> 
>     signals-allow-rt-tasks-to-cache-one-sigqueue-struct.patch
> 
> which is able to generate a kernel splat of the form,

Does this
	https://lkml.kernel.org/r/20200407095413.30039-1-matt@codeblueprint.co.uk

help the problem you see?

Sebastian
