Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D693C433ED
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 06:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFB72613F6
	for <linux-rt-users@archiver.kernel.org>; Fri, 14 May 2021 06:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhENHAB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 14 May 2021 03:00:01 -0400
Received: from mail.monom.org ([188.138.9.77]:49560 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhENHAB (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 14 May 2021 03:00:01 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id E30F05005DA;
        Fri, 14 May 2021 08:58:48 +0200 (CEST)
Received: from localhost (unknown [94.31.99.148])
        by mail.monom.org (Postfix) with ESMTPSA id A48FA500322;
        Fri, 14 May 2021 08:58:48 +0200 (CEST)
Date:   Fri, 14 May 2021 08:58:48 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests v3 27/33] pip_stress: Return failure code if
 test fails
Message-ID: <20210514065848.5rexjzwnxpdiqrru@beryllium.lan>
References: <20210320183829.1318-1-dwagner@suse.de>
 <20210320183829.1318-28-dwagner@suse.de>
 <d979f62-e4bc-3f4d-b520-da3ca6e48199@redhat.com>
 <20210512073554.ocoaqweoibkeyxgx@beryllium.lan>
 <CANwBOh0+vYu69ab_iuG_492a2JVzkCxn53bdrHQTfQvRTD7G2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANwBOh0+vYu69ab_iuG_492a2JVzkCxn53bdrHQTfQvRTD7G2g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, May 13, 2021 at 03:27:31PM -0400, John Kacur wrote:
> I suppose this is a fair question, although another question would be
> is it useful in the rt-tests suites for other reasons?
> It could be used as the "engine" of a test that would be similar to
> pi_stress, with a different kind of mechanism.

If there is clear indication which code is provided as coding example
and which is a RT test it would already help. I was under the impression
pi_stress tries to test RT behavior. Maybe moving pi_stress to
'examples' would already be enough.

> So then the question would be, is there a value in another pi_stress
> like test that avoids pthreads?
>
> If so, I could work it up into a test.

I suppose having more RT tests is good thing. IIRC there are more RT
tests available, e.g. in LTP. So not sure if this is not already covered
somewhere else.
