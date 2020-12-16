Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4060C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A914023343
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 08:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgLPIOx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 03:14:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:52434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725274AbgLPIOx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 03:14:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DEF6BAC91;
        Wed, 16 Dec 2020 08:14:11 +0000 (UTC)
Date:   Wed, 16 Dec 2020 09:14:11 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] rt-tests: determine_maximum_mpps.sh: Change the -c
 option to -a
Message-ID: <20201216081411.v5umwehqktzwbyj7@beryllium.lan>
References: <20201216071642.24466-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216071642.24466-1-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 16, 2020 at 02:16:42AM -0500, John Kacur wrote:
> Change -c to -a so that the options in this program match the options
> of the other programs in the rt-tests suite as much as possible
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Thanks

Reviewed-by: Daniel Wagner <dwagner@suse.de>

