Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A904C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23B2A64E8A
	for <linux-rt-users@archiver.kernel.org>; Thu, 11 Feb 2021 13:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbhBKNvr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Feb 2021 08:51:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:51172 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231268AbhBKNtT (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Feb 2021 08:49:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4630FADF0;
        Thu, 11 Feb 2021 13:48:37 +0000 (UTC)
Date:   Thu, 11 Feb 2021 14:48:36 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>,
        "Reported-by : Peter Xu" <peterx@redhat.com>
Subject: Re: [PATCH] rt-tests: oslat: print version string
Message-ID: <20210211134836.4itpmwmp443u7v5j@beryllium.lan>
References: <20210211044221.27851-1-jkacur@redhat.com>
 <20210211074529.wxm66aeszzfs5gek@beryllium.lan>
 <ec91e6ef-11f7-5cb7-445-dd5bf2d467@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ec91e6ef-11f7-5cb7-445-dd5bf2d467@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Feb 11, 2021 at 08:42:41AM -0500, John Kacur wrote:
> Because the version is printed out before the call to parse the options.
> If you don't remove it here, it gets printed out twice.

Ah, that makes sense.
