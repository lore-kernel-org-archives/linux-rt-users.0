Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68A9C4320A
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C21613D1
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Aug 2021 16:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbhHWQvy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Aug 2021 12:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbhHWQvs (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Aug 2021 12:51:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA2C061575;
        Mon, 23 Aug 2021 09:51:05 -0700 (PDT)
Date:   Mon, 23 Aug 2021 18:51:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629737463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyRUi1erXIf9vdU9EaE7gDkitJbqBl0J6BSh9JWvOs8=;
        b=Ze5YMe0eX14wZObuQDmHIMNEdCm6fyJ7bOVqh+kU2LASIB7N4fF0IPemTS6LoL5TSSsGku
        YvsoU9xRaw8KQv1x17K2G7p8WK4Cebpk5tkyU0Abu0P5pF1xg6tpdonT3vNnDunn1CghiR
        KWif6bO4XTZEe6gTO1mh8ZgyRaU3MsBSqlipfNWE7cy9C1gxbc4tERbS96xYuOCRhKeZNi
        cgPVcNKXS4osMpyxJ+FqeRVtcQ8hT0LS4KxC+i2/mYn895oDsaaYk4HMZSuo/+qtTR4tnG
        ghCjKxLvIjiVhbML2onlQmLhNprOf8/rH1HLGgPev6SFSYZIkOzFYHk12Isozw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629737463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eyRUi1erXIf9vdU9EaE7gDkitJbqBl0J6BSh9JWvOs8=;
        b=xbCGbipYA9FSFod8hQ26tLdNwIYEZkpOkSopBIRYVrPxbVvL51DP5qypIh5R14XdHEzARx
        7Paq2owVKsBnXnAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Jeaho Hwang <jhhwang@rtst.co.kr>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Linux team <team-linux@rtst.co.kr>,
        =?utf-8?B?67OA66y06rSRKEJ5ZW9uIE1vbyBLd2FuZykv7J6Q64+Z7ZmU7JewKUF1dG9t?=
         =?utf-8?B?YXRpb24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <mkbyeon@lselectric.co.kr>,
        =?utf-8?B?7LWc6riw7ZmNKENob2kgS2kgSG9uZykv7J6Q64+Z7ZmU7JewKUF1dG9tYXRp?=
         =?utf-8?B?b24gUGxhdGZvcm3sl7DqtaztjIA=?= 
        <khchoib@lselectric.co.kr>
Subject: Re: [PATCH v2] usb: chipidea: local_irq_save/restore added for
 hw_ep_prime
Message-ID: <20210823165102.gk5ibzgi6qlgvrxf@linutronix.de>
References: <20210817095313.GA671484@ubuntu>
 <20210818161752.vu6abfv3e6bfqz23@linutronix.de>
 <CAJk_X9h_GqUyir7oG33pFrLgknj7DZfd6esiKb07w7QWjZqX0g@mail.gmail.com>
 <20210819084759.stnmit32vs2be46m@linutronix.de>
 <CAJk_X9gyWch6Z1=hbe2vvqGu61mdavAU62+6dSka0tZoMzxu5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJk_X9gyWch6Z1=hbe2vvqGu61mdavAU62+6dSka0tZoMzxu5Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-08-20 14:15:55 [+0900], Jeaho Hwang wrote:
> So we protect irqs inside hw_ep_priming not to make error cases and
> also add a timeout inside the hw_ep_set_halt loop for a walkaround.
> The timeout patch is submitted to linux-usb.
> ( https://marc.info/?l=linux-usb&m=162918269024007&w=2 )
>
> We withdrew this patch since we don't know if disabling irq is the
> best solution to solve the problem and udc would work fine with
> hw_ep_set_halt walkaround even though hw_ep_prime fails.
> But we are still trying to find out the cause of this symptom so We'd
> so appreciate it if RT or USB experts share some ideas or ways to
> report somewhere. Xilinx doesn't provide any support without their
> official kernel :(

The UDC driver sometimes drops the lock and acquires it again. On UP it
would not matter but on SMP/RT the other may acquire lock and do
something with the HW. One thing that you could check if there is any HW
access in between which would affect the behaviour.

> Thanks for the discussion Sebastian.
> 
> Jeaho Hwang.

Sebastian
