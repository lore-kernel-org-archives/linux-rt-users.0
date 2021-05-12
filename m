Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5729C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7704A61936
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhELHhE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 May 2021 03:37:04 -0400
Received: from mail.monom.org ([188.138.9.77]:37158 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhELHhE (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 May 2021 03:37:04 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 6124E50064E;
        Wed, 12 May 2021 09:35:55 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id 2E7005001DD;
        Wed, 12 May 2021 09:35:55 +0200 (CEST)
Date:   Wed, 12 May 2021 09:35:54 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 27/33] pip_stress: Return failure code if
 test fails
Message-ID: <20210512073554.ocoaqweoibkeyxgx@beryllium.lan>
References: <20210320183829.1318-1-dwagner@suse.de>
 <20210320183829.1318-28-dwagner@suse.de>
 <d979f62-e4bc-3f4d-b520-da3ca6e48199@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d979f62-e4bc-3f4d-b520-da3ca6e48199@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> It isn't really an error if no priority inheritance occurs.
> An error from this program would be something like mmap returning an error 
> code.
> 
> I'm not sure this one is suitable for the json treatment, it's more of a 
> demonstration of how to use priority inheritance with processes instead of 
> threads. Thomas told me this was possible and I was curious to see if this 
> was true, so I scratched that itch. Not sure if it is useful as a test.
> 
> Let's leave pip_stress alone for now please

If it's a for demonstration purposes only, could we remove it from the
source tree? I don't think it should be left there if it's not
considered a proper test.
