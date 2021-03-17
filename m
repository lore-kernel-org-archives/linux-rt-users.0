Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDBFC433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD8D364EE7
	for <linux-rt-users@archiver.kernel.org>; Wed, 17 Mar 2021 17:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbhCQRQ2 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 17 Mar 2021 13:16:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:43946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230221AbhCQRP5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 17 Mar 2021 13:15:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1DBF7ABD7;
        Wed, 17 Mar 2021 17:15:56 +0000 (UTC)
Date:   Wed, 17 Mar 2021 18:15:55 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     John Kacur <jkacur@redhat.com>, Peter Xu <peterx@redhat.com>,
        Daniel Wagner <wagi@monom.org>, linux-rt-users@vger.kernel.org,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: Drop use_current_cpuset() check
Message-ID: <20210317171555.uvufojxheuc2wd6a@beryllium.lan>
References: <20210315193707.359702-1-peterx@redhat.com>
 <20210316081826.bthxqja6shbcp36j@beryllium.lan>
 <20210316200705.GC395976@xz-x1>
 <20210317074903.5lskayjwylnvuhks@beryllium.lan>
 <20210317125147.GH395976@xz-x1>
 <7882bec5-be12-267f-94c1-3b7c21193686@redhat.com>
 <YFIxGCKCrhgaorGG@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFIxGCKCrhgaorGG@lx-t490>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 17, 2021 at 05:40:56PM +0100, Ahmed S. Darwish wrote:
> Pardon my ignorance, but (scheduling wise) what does an RT task inside a
> container/cgroup mean?
> 
> AFAIK, the RT task will still command the CPU as it pleases, no matter
> the cgroup's cpu.shares configuration.

It's not about scheduling it's about affinity only.

