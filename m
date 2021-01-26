Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071A8C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3C6C22B3B
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728154AbhAZRT7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:45404 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732211AbhAZIQN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 03:16:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 97562AB92;
        Tue, 26 Jan 2021 08:15:29 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:15:29 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 08/20] signaltest: Use affinity_mask for
 stearing thread placement
Message-ID: <20210126081529.s2h53rd5ftqp4fdx@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de>
 <20201218161843.1764-9-dwagner@suse.de>
 <174fc12b-364-9cfa-dfbe-537083e1acad@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174fc12b-364-9cfa-dfbe-537083e1acad@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> In git you wrote Reviewed by instead of Signed-off-by:
> Why?

I am using shortcuts for those things and I used my wrong muscle
memory. Obviously it should be

Signed-off-by: Daniel Wagner <dwagner@suse.de>

