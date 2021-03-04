Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8718BC433E6
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFEF64E76
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236498AbhCDIVS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Mar 2021 03:21:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48116 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbhCDIVN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Mar 2021 03:21:13 -0500
Date:   Thu, 4 Mar 2021 09:20:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614846032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTuJuTrbiZ6VTD1R/lrd9AzhCEA2AWnEneTYlx/iSmI=;
        b=udltgCovXJKQHL/loT8Cl5n/knKIhtCbC7Mt/lc4SvrHg7tDOJIv33js9Ux3Nmp0BEEdAr
        YgwXj3xj63pdk40upIxgHtk5SsSQUBHy//WMb0qM4bLcc87nsUZhKiHGmuDzbP9GugDT+L
        abwzr4ApYOdQDTVwR5mS+PEkCqz91K84wpNXZu9MvoP5NYBdXKnGr2r5+zKW2GhpTpxPrK
        l4DdO5HzzaT0nBN8hi/ts0W0iQoKNrsd+Krg07QxbqvTW22hA7MEFu1bUa99xj5e5A8cRR
        AeusUNc+Vctxv4QrCodcH+VxYAuyyB4n8nwjAxUNXmXDGr2XqSTDLRykZnhcDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614846032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTuJuTrbiZ6VTD1R/lrd9AzhCEA2AWnEneTYlx/iSmI=;
        b=a8H/Bb2IvPqOZFPxij4INQmj8HCjyGtZdD5ZhsuKC1lDN265bDH1VXr5tXkVnX0Q/iaMCe
        K5kQDGwj7tCN5qAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Christian Eggers <ceggers@arri.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] all: Fix printf format errors
Message-ID: <20210304082031.lraphjbjjvr2e6jg@linutronix.de>
References: <20210226073802.9406-1-ceggers@arri.de>
 <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
 <20210303072608.stni24hteabncdjw@linutronix.de>
 <20bcaff3-a669-c627-867d-27fbd9c4f32@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20bcaff3-a669-c627-867d-27fbd9c4f32@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2021-03-03 18:16:18 [-0500], John Kacur wrote:
> 
> 
> On Wed, 3 Mar 2021, Sebastian Andrzej Siewior wrote:
> 
> > On 2021-03-02 14:58:22 [-0500], John Kacur wrote:
> > > Are you seeing a compile time warning on some systems?
> > 
> > My wild guess would be 32bit systems.
> 
> haha, mine too, but is it too much to ask for some better
> descriptions in the patches than, "fix printf format errors"?

nope.
Not sure the author is aware if the request :)

Sebastian
