Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55E0FC433EF
	for <linux-rt-users@archiver.kernel.org>; Fri, 24 Jun 2022 08:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiFXIm2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 24 Jun 2022 04:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiFXIm1 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 24 Jun 2022 04:42:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D957374E71
        for <linux-rt-users@vger.kernel.org>; Fri, 24 Jun 2022 01:42:26 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:42:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1656060144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQARJDFDCFpWYrUcB3KZ6FdDYT8R/FB5JrIBZ9DtUeo=;
        b=wMd08sMoIOGdkVdYVJd1Rt9idm6Hxhpi/U+OzNTmniKgmbTbQSpfv9Mjg7MCTpURwn672V
        C7sl/Ykcev+VXCpMwyUdzUTKF12sRzpypuB0cD1pYPC3i11fu4Tn46D0LZbALmW6sDttGK
        npWaizmr2lqJ1rOr1jRVwxz5OEkF0seywF4ECKvae6Y8fL2syLFtKTxkY9RZnaLsNR3fiM
        CrOOhI0vlWhkD/2FWDahwEub/0mAGYLR8ZMmGTO5hg9RVg8hxj35A7ftGf9bCfZwmYNzGs
        AyFDrwJvzL4WREtt6hZNOQ4UHXnFkFgfdnQsNXdu20d4EcuDNM8Wud7S8ZMOYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1656060144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jQARJDFDCFpWYrUcB3KZ6FdDYT8R/FB5JrIBZ9DtUeo=;
        b=frBJddPDnSVm9WVfezSlf/2LtBRH48U9/oAkEdaInwoX0G7W0dSErvjo8XmEfmNvwNKDY9
        u/vw/ihysa0OLdCA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Mike Galbraith <efault@gmx.de>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: v5.19-rc2-rt3: nouveau might sleep splat
Message-ID: <YrV4795StT13AUC+@linutronix.de>
References: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01e0c6949e6f0611954016552da8f0795b20600a.camel@gmx.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-06-18 11:25:39 [+0200], Mike Galbraith wrote:
> I haven't done any digging to see why this now happens where it
> previously did not.

I don't see where interrupts have been disabled but they have been. The
printk path should yell earlier but did not the crng path is kind of
late and I don't see anything obvious in between.

Sebastian
