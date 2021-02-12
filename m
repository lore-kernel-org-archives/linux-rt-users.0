Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F68C433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Feb 2021 17:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39A8464E8C
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Feb 2021 17:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhBLRdo (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 12 Feb 2021 12:33:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:60680 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229451AbhBLRdn (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 12 Feb 2021 12:33:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A53E3AD29;
        Fri, 12 Feb 2021 17:33:02 +0000 (UTC)
Date:   Fri, 12 Feb 2021 18:33:02 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Pradipta Kumar Sahoo <psahoo@redhat.com>
Subject: Re: [PATCH] rt-tests: oslat: Allocate memory for cpu_set
Message-ID: <20210212173302.qpdjoqbf2yklhh3t@beryllium.lan>
References: <20210212172913.10843-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212172913.10843-1-jkacur@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 12, 2021 at 12:29:13PM -0500, John Kacur wrote:
> - cpu_set is a pointer to a bitmask struct
> Memory needs to be allocated for the struct, so call
> numa_allocate_cpumask()
> 
> - use rt-tests fatal to exit on error conditions
> 
> Signed-off-by: John Kacur <jkacur@redhat.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>
