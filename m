Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C28DAC433DB
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E40E64D92
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbhBSQQr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:16:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:47538 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230110AbhBSQQp (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:16:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C9216AC6E;
        Fri, 19 Feb 2021 16:16:02 +0000 (UTC)
Date:   Fri, 19 Feb 2021 17:16:02 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Christian Eggers <ceggers@arri.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Message-ID: <20210219161602.j7w6gwk7rao5u3ek@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de>
 <20210219145422.lvodigbgtymr5ajc@beryllium.lan>
 <20210219151717.4cqc6lhrsocebw3p@linutronix.de>
 <2570027.mvXUDI8C0e@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2570027.mvXUDI8C0e@n95hx1g2>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Feb 19, 2021 at 04:21:46PM +0100, Christian Eggers wrote:
> CONFIG_NUMA is not available on ARM32:

libnuma is not happy if the kernel doesn't have the config
option. Well, in this case we just revert the patch I suppose.
