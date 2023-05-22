Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D529C77B73
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 May 2023 07:44:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjEVHoc (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 May 2023 03:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjEVHoa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 May 2023 03:44:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39261AC
        for <linux-rt-users@vger.kernel.org>; Mon, 22 May 2023 00:44:29 -0700 (PDT)
Date:   Mon, 22 May 2023 09:44:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684741467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/SD2GA84J/tAdAJaC3VN1JF6B5cT0LCh51YjI9xncc=;
        b=C8HKdkI0OjeNbFC51r/IZ2EGMvEtsCooshuQUysMYOo/93/3ATrZ2G43yuYFClYuhf6j4m
        24ov6F2lEElaYpCKJE9lT3MEXpuB6AJAStcwsg96iWeYKA5ohO8lWxTetAa3foyPtoW4oy
        AfJx2Eyyf9LNPwUzgHa400HWcKikJ83OzyFerWtK2EgMXwXOx2EjVc1B5CT6poSJNYZiSu
        RWe/qMfhMX8pYAYUdlDvnNe8sktW6kF4E5MMAqWWe7Fd0VlzhqGdY5aphcTcydLv0nXXLB
        +JyFpHWBxV1G3BBXAkbr4hFew2N6Ve06R/6zQ63hf+DLbu1BP4YaI8/bzkaf/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684741467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d/SD2GA84J/tAdAJaC3VN1JF6B5cT0LCh51YjI9xncc=;
        b=A/b71tN/mRwE4vs5X7vpGsXnX3l6uBUyhZDal/yPJIdYV2Jkj4PXNxTdbjP0Ii8IBlO5wq
        jWgB7369b3fcF3Ag==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pavel Pisa <ppisa@pikron.com>
Cc:     linux-rt-users@vger.kernel.org,
        Pavel Hronek <hronepa1@fel.cvut.cz>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
Message-ID: <20230522074425.6rZNoUx2@linutronix.de>
References: <202305142217.46875.pisa@cmp.felk.cvut.cz>
 <20230519185241.03nTY1UE@linutronix.de>
 <202305211657.21525.ppisa@pikron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202305211657.21525.ppisa@pikron.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2023-05-21 16:57:21 [+0200], Pavel Pisa wrote:
> Dear Sebastian,
Hi Pavel,

> and manually tested your 6.3 RT version and reports that is is stable
> now.

thank you.

> But he has problem that his e-mail didnot pass mailing list filters
> rules. I am trying to resnet from my other e-mail. I cannot send from
> my university account as well so I ma trying my company one if
> it passes

If it is too large it will be dropped. Was there a bounce message?

> -------- Forwarded Message --------
> Subject: Re: Preemp-RT kernel builds from 6.3 on fails on Xilinx Zynq 7Z010
> Date: Sun, 21 May 2023 16:42:13 +0200
> From: Pavel Hronek <hronepa1@fel.cvut.cz>
> To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> CC: Pavel Pisa <pisa@cmp.felk.cvut.cz>, linux-rt-users@vger.kernel.org, 
> Thomas Gleixner <tglx@linutronix.de>
> 
> The last two rounds of automated tests on 6.4.0-rc2-rt1
> (https://canbus.pages.fel.cvut.cz/can-latester/inspect.html?kernel=rt&flood=1&prio=1&kern=1&load=1)
> have completed without the lockup and the messages no longer appear in 
> the console.

6.4 got the same fixes as I added to the last 6.3 release. Good to here
that there isn't anything new.

> Pavel Hronek

Sebastian
