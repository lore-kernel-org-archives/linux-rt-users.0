Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BA5C432BE
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 07:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A96546023E
	for <linux-rt-users@archiver.kernel.org>; Tue, 31 Aug 2021 07:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbhHaH0N (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 31 Aug 2021 03:26:13 -0400
Received: from mail.nearlyone.de ([46.163.114.145]:54290 "EHLO
        mail.nearlyone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbhHaH0H (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 31 Aug 2021 03:26:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 802F85E358;
        Tue, 31 Aug 2021 09:25:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1630394711; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         in-reply-to:references; bh=yb7sFISylnokYCLbP7fSuQGy4/6eDvYLFqElR1IvOKQ=;
        b=F+i3sWTbV4PPi26uoF/xMKFyscOUBbsdKdHT1KcTCE1EVSeOyumM4LSD7Fcg3mdKvaHowf
        bOO5+dOgvFrL4tYYaCJ7hJOxNFvkL4RSBB8GYxos6bdf5bOCvjIgk9uczK2u13XSdM7VLr
        mDASOG4lhwwgSZiw3Vogy7PjQlSIk4x8P9a8snxk2JCA40VgQuktvkZfr9t7sY2dN4EDRJ
        sr2C2m8y2ZTb3/2W306R05Le4yCEvfBokD6QjFSfYaP27qSg55tkaxXoh+gTLagTAVjkDh
        teDwy1HSH2f9XHHy0Rh0zkQlvW98xDYJXaBHi6S8IXK2FpUebwzZ1SpZVA0ZYA==
Date:   Tue, 31 Aug 2021 09:25:10 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [ANNOUNCE] rt-tests-2.2
Message-ID: <20210831072510.rhflsmevwqzolj3p@beryllium.lan>
References: <20210831022747.26140-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831022747.26140-1-jkacur@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi John,

On Mon, Aug 30, 2021 at 10:27:47PM -0400, John Kacur wrote:
> I'm pleased to announce rt-tests-2.2

Thanks John! Hopefully this is has all necessary changes/fixes to
continue on my LAVA efforts.

Cheers,
Daniel
