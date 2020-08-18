Return-Path: <SRS0=5BY9=B4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33A7C433E3
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D7220825
	for <linux-rt-users@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgHRPz6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:55:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:57022 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728276AbgHRPzx (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 18 Aug 2020 11:55:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65E68AE38;
        Tue, 18 Aug 2020 15:56:17 +0000 (UTC)
Date:   Tue, 18 Aug 2020 08:42:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH -RT] net: xfrm: fix compress vs decompress serialization
Message-ID: <20200818154250.evbjaxzdyzh7oz7b@linux-p48b>
References: <20200814173700.1532-1-dave@stgolabs.net>
 <20200817144754.5lyhn3xtenigvfbd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200817144754.5lyhn3xtenigvfbd@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 17 Aug 2020, Sebastian Andrzej Siewior wrote:
>So what you are saying that this patch isn't needed v5.0.19-rt10+
>because local_bh_disable() acts there as a lock. Repost is then with Tom
>in Cc because he will be the first one to apply to the v4.19 tree. And
>please shrink the patch description to a sane amount of information.

Sure, but which Tom are you refering to?

Thanks,
Davidlohr
