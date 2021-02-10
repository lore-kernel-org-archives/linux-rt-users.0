Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F26C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 18:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E3064D99
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 18:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234065AbhBJSY4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 13:24:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:54094 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233912AbhBJSWx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 13:22:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B303EAB98;
        Wed, 10 Feb 2021 18:21:14 +0000 (UTC)
Date:   Wed, 10 Feb 2021 19:21:14 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH rt-tests 1/2] oslat: Print version string
Message-ID: <20210210182114.xbxw62gj6n6ox6pt@beryllium.lan>
References: <20210210165407.9770-1-dwagner@suse.de>
 <20210210165407.9770-2-dwagner@suse.de>
 <9c2916d8-14ab-3465-97fa-2a9b52c83b1e@redhat.com>
 <20210210173353.pqeu2sm33qs7hjna@beryllium.lan>
 <7a61c0fd-90fe-69a4-5d26-4b688e2147b5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a61c0fd-90fe-69a4-5d26-4b688e2147b5@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Feb 10, 2021 at 12:59:29PM -0500, John Kacur wrote:
> Are you really telling me you won't fix a problem you introduced unless
> I first take all the other code you would like to get in rt-tests?

I've already done the long option support in the JSON series. It would
make my life way simpler if those bits would be in the tree.

I think, the simplest fix for now is to temporarily a local fix for
oslat.
