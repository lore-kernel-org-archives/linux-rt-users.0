Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A37C433E9
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5934F64E7E
	for <linux-rt-users@archiver.kernel.org>; Wed, 10 Feb 2021 16:31:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbhBJQbB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 10 Feb 2021 11:31:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:53072 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232455AbhBJQa1 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 10 Feb 2021 11:30:27 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5079EB024;
        Wed, 10 Feb 2021 16:29:46 +0000 (UTC)
Date:   Wed, 10 Feb 2021 17:29:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org,
        psahoo@redhat.com
Subject: Re: [rt-tests v1 6/6] oslat: Use parse_cpumask() from rt-numa.h
Message-ID: <20210210162945.lk352qjq2a6gnwzu@beryllium.lan>
References: <20201113210910.21807-1-dwagner@suse.de>
 <20201113210910.21807-7-dwagner@suse.de>
 <20210210160745.GH103365@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210160745.GH103365@xz-x1>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Peter,

On Wed, Feb 10, 2021 at 11:07:45AM -0500, Peter Xu wrote:
> This seems to have broken oslat with --cpu-list...
> 
> xz-x1:rt-tests [master]$ sudo ./oslat -c 1-2
> Total runtime:          1 seconds
> Thread priority:        default
> CPU list:               1-2
> CPU for main thread:    0
> Workload:               no
> Workload mem:           0 (KiB)
> Preheat cores:          1

$ ./oslat  -c 1-3
[...]
CPU list:               1-3
[...]
        Core:    1 2

looks like there is a off by one

Will look into it
