Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C079FC433FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Nov 2022 08:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiK1Imn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Nov 2022 03:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiK1Iml (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Nov 2022 03:42:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA53D53
        for <linux-rt-users@vger.kernel.org>; Mon, 28 Nov 2022 00:42:39 -0800 (PST)
Date:   Mon, 28 Nov 2022 09:42:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669624957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTnWV7m1eJ9F9vXYWYUc9YXvjxLvj314ZSAQaFOMD10=;
        b=mSWwzEB7wIN2ztpVWtpQKZXOi8ELoKzYdFkFtsdL/eiFaST7Mlmi76LNv8iyPi98D+eVF1
        4M776fs1AQl4M3oE188GCDYF8U16TY6377ladL2GEbSGNoDFsUECu7K0pafntXT49ejwo2
        B8hXJbgXH6rLZUS8z4FhUxwO4QQ4MwyekAjM0pVJpNFrJ6wGyMQEoXCmcMo2yixtsEYceG
        VvIfbuUR98cj+0+9cy3Z9HW1EW9+cuJUYJObwgiBheerxdyqziy/n5dOTyJM87VAqfWbGU
        zLQPhDelh75uimmBAV3xBNuN2K1mCxNv5ac1vbz6s/BliMZewckCY/USfGxwqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669624957;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTnWV7m1eJ9F9vXYWYUc9YXvjxLvj314ZSAQaFOMD10=;
        b=gOPCoF35S+uJfnTNODOAdCCHc16egIS1sEO3zEiEyJeKMyTiduDSy0BMK+DwopVXG1mC0A
        Bi0wG6+VlLsKlLAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     Mike Galbraith <efault@gmx.de>, linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: v6.1-rt4 rpi4 boot time atomic_sleep splat
Message-ID: <Y4R0e2EaEAtXKJk9@linutronix.de>
References: <1806ff76592576c6e6dba91f09ce661b7c75a9a9.camel@gmx.de>
 <859aadda-c971-d16b-44a1-4e15ef49bf8b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <859aadda-c971-d16b-44a1-4e15ef49bf8b@arm.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2022-11-28 09:40:48 [+0100], Pierre Gondois wrote:
> Hello Mike,
> There is a patch-set currently ongoing aiming to solve this at:
>   https://lore.kernel.org/all/20221121171217.3581004-1-pierre.gondois@arm.com/

Thanks. I did remember that this looked familiar but I couldn't remember
where it is handled.

> Regards,
> Pierre

Sebastian
