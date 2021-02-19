Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7A8C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 15:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3A90601FA
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 15:18:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhBSPSB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 10:18:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhBSPSB (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 10:18:01 -0500
Date:   Fri, 19 Feb 2021 16:17:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613747838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEEXqvrwGIafMy/FE6fVCtvhZRmIcjjf+TuyZX+cwTQ=;
        b=W+N15WUFhphpyXPceQip+FJv/9NZti9N8Qm4ISnqMKOpeeoWA58b5V0PbY15gpc39VzpQW
        kLwJitgq6GIJqHBnAs/NDdD1IdxaB7CQGQRZpedL7HYVO8OyQ0xePeB2oJ6RdMuim7WvH7
        TcwKCRGwY9XFZIOllbmsbVbsbfK/1W6mmCPTQjfnKxuXZSZjwV8XxRNlxZtURAP15mstMy
        m2J1an7S10gWVM68jgxA2h9o2v0wy4/2IBe2CFQLAEovUsgZYYsWWvVQcTcsSE9+RwrAiu
        6ROw3RMkHKg2ieK/8Z0I5SWHxyiuS2P5K465juOIOI00bUFGfIwtpwM+/IXTVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613747838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CEEXqvrwGIafMy/FE6fVCtvhZRmIcjjf+TuyZX+cwTQ=;
        b=2pZkpRIQ8SV8axXESJ+g0Z9wZ1ii2NRgSZlH2Dy/Ta3Js+H/JFK5uUxLswKYrgyfl5Gfkc
        TG6Ofvj8jKuWwUAw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        Christian Eggers <ceggers@arri.de>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Message-ID: <20210219151717.4cqc6lhrsocebw3p@linutronix.de>
References: <20201218161843.1764-1-dwagner@suse.de>
 <20201218161843.1764-2-dwagner@suse.de>
 <878s7k41ff.fsf@kurt>
 <20210219141237.kksuqsgmmmis7iht@beryllium.lan>
 <875z2o3yvi.fsf@kurt>
 <20210219145422.lvodigbgtymr5ajc@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219145422.lvodigbgtymr5ajc@beryllium.lan>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-02-19 15:54:22 [+0100], Daniel Wagner wrote:
> I try to reproduce this here. Building libnuma from source right now.

|~# uname -m
|x86_64
|~# ./cyclictest 
|FATAL: Couldn't initialize libnuma~# 

Just do
 # CONFIG_NUMA is not set

in your .config and it is done.

Sebastian
