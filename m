Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A1C433F5
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D5F460C4D
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Nov 2021 14:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhKLODk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Nov 2021 09:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbhKLODk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Nov 2021 09:03:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B9C061766
        for <linux-rt-users@vger.kernel.org>; Fri, 12 Nov 2021 06:00:49 -0800 (PST)
Date:   Fri, 12 Nov 2021 15:00:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636725646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWtuQ3MDvaoJvoXITtlII5NNIUu03+plOT4dKAt7Ues=;
        b=yTLeNFdE14FdP2QHh3LKicrc6cdc1TQmRF/9lUn2OAfLBw+eV6i1bAQWn7hen13xpISTQZ
        swUnev2FRF+navy54JaT87YupAGEVV7PExIUh4GUVpBp+4ms7v5aXKYnDv3VrS5Ng57lx6
        Xs+oih1NC0dl2NVO4tS2+aeXMERRptrWsaotw/S/a6gd0v4skflgix1tQzixrlmzdyUR1i
        LP7dTAxuApPpu09eWedOyF6l9fDbqxRMszK6XdEpFB2vf1jkMBkZjTn5WMbnBFJMhS51CU
        jehpM0xC6jjnXSeMqxVX6hIt2SuDFiEKF4y2ZQ8j7XVLiZb+LoxyXFTtZUJVkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636725646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oWtuQ3MDvaoJvoXITtlII5NNIUu03+plOT4dKAt7Ues=;
        b=+5T8TqayRo5CCtlMHGBJ951merLGvWIyFRyn5rG1vTwwEpIES/cWLzJcgwZNRCpdt/n7qS
        SeEfVQmNTsIo6nAQ==
From:   'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>
To:     Chanho Park <chanho61.park@samsung.com>
Cc:     linux-rt-users@vger.kernel.org,
        'Thomas Gleixner' <tglx@linutronix.de>
Subject: Re: hackbench score comparison between 5.10.75-rt47 and 5.14.14-rt21
Message-ID: <20211112140045.p4bybe4uxy7xwj4i@linutronix.de>
References: <CGME20211103031549epcas2p34418a4e6218ca93da57a0c373691bd41@epcas2p3.samsung.com>
 <009301d7d061$1a1bbeb0$4e533c10$@samsung.com>
 <20211103091349.m7dvgqpbc2epgbi3@linutronix.de>
 <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <000001d7d1e6$47eebaf0$d7cc30d0$@samsung.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-11-05 10:41:40 [+0900], Chanho Park wrote:
> Hi,
Hi,

> I checked the same test on my aarch64 target. I'll do more realistic
> benchmark such as compile bench.
> 
> <5.10.73-rt54 aarch64>
> root@euto-v9-sadk:~# hackbench -l 10000
> Time: 24.994
> 
> <5.15.0-rt17 aarch64 w/o CONFIG_SLUB_CPU_PARTIAL>
> root@euto-v9-sadk:~# hackbench -l 10000
> Time: 31.372
> 
> <5.15.0-rt17 aarch64 w/ CONFIG_SLUB_CPU_PARTIAL>
> root@euto-v9-sadk:~# hackbench -l 10000
> Time: 35.269

The last two are equal, is that on purporse?
Any feedback on v5.14-rc3-rt1 and v5.14-rc3-rt2? v5.13-rt1 should be
identical to you 5.10 numbers.

> Best Regards,
> Chanho Park

Sebastian
