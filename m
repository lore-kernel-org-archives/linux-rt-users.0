Return-Path: <SRS0=aYAi=XS=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F940C04EBF
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 14:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56373207FD
	for <linux-rt-users@archiver.kernel.org>; Mon, 23 Sep 2019 14:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbfIWOS7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 23 Sep 2019 10:18:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbfIWOS7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 23 Sep 2019 10:18:59 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1iCPB3-0006mB-Fw; Mon, 23 Sep 2019 16:18:57 +0200
Date:   Mon, 23 Sep 2019 16:18:57 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: cyclictest: Assume libnuma version 2 by default
Message-ID: <20190923141857.lbkmvmtsqvfc6o3d@linutronix.de>
References: <20190919183114.11569-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190919183114.11569-1-jkacur@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-09-19 20:31:14 [+0200], John Kacur wrote:
> Most distributions have used libnuma version 2 for awhile now, so make
> it the default.
> 
> This doesn't prevent people from defining it as version 1, or compiling
> without numa.

"LIBNUMA_API_VERSION 2" was introduced in version v2.0.2 of the numactl
package. "LIBNUMA_API_VERSION 1" was never defined.
The version v2.0.2 was released in late 2008 as in more than a decade
ago. Therefore I would suggest to just drop that compatibility layer and
depend on the new API version. So if libnuma is used then the "one"
please, otherwise no libnuma.

Sebastian
