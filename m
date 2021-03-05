Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142BDC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B906164F44
	for <linux-rt-users@archiver.kernel.org>; Fri,  5 Mar 2021 07:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbhCEHlk (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 5 Mar 2021 02:41:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:46840 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229446AbhCEHlj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 5 Mar 2021 02:41:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BB086AD72;
        Fri,  5 Mar 2021 07:41:38 +0000 (UTC)
Date:   Fri, 5 Mar 2021 08:41:38 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 00/14] JSON cleanups and more tests updated
Message-ID: <20210305074138.lobxlbt7sirtj7lb@beryllium.lan>
References: <20210305073500.17926-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305073500.17926-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Fri, Mar 05, 2021 at 08:34:46AM +0100, Daniel Wagner wrote:
> v2:
>   - added 'return_code' to the common section of the JSON output
>   - dropped 'inversion' as we have 'return_code' in pip_stress
>   - dropped 'success' as we have 'return code in ssdd

I am pretty happy with the this version now. That means I don't plan to
change more on the JSON feature. Well, one thing I am still not really
happy is the name '--output'. But as no one had any better idea, let's
keep it as it is. Hopefully no one wants it changed in 2 weeks from now
:)

So if you want to do a release, please go ahead.

Thanks,
Daniel
