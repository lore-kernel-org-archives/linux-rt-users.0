Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C36C433B4
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683066147F
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 May 2021 07:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbhELHer (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 May 2021 03:34:47 -0400
Received: from mail.monom.org ([188.138.9.77]:37128 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhELHeq (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 May 2021 03:34:46 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A6E2250064E;
        Wed, 12 May 2021 09:33:37 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id 71E265001DD;
        Wed, 12 May 2021 09:33:37 +0200 (CEST)
Date:   Wed, 12 May 2021 09:33:37 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v3 15/33] rt-util: Introduce rt_test_start()
Message-ID: <20210512073337.chen4kllvjgkvypv@beryllium.lan>
References: <20210320183829.1318-1-dwagner@suse.de>
 <20210320183829.1318-16-dwagner@suse.de>
 <5a3db222-117-ce6c-4b89-ccf717be19c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a3db222-117-ce6c-4b89-ccf717be19c@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, May 07, 2021 at 12:40:20PM -0400, John Kacur wrote:
> I don't really like this. I think it looks "good" in the json output, but
> I don't think it is providing any kind of meaningful data. My fear is that 
> users will try to assign some kind of significance to these numbers in 
> relation to the tests.

The idea is that you are able to compare timestamps in the further logs
and see if anything is out of the ordinary is logged when the test was
executed.
