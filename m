Return-Path: <SRS0=tdbZ=Y7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F682C43331
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Nov 2019 18:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D862085B
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Nov 2019 18:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbfKGS6M (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 7 Nov 2019 13:58:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:55552 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbfKGS6M (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 7 Nov 2019 13:58:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 29C1AAAC2;
        Thu,  7 Nov 2019 18:58:11 +0000 (UTC)
Date:   Thu, 7 Nov 2019 10:53:58 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users@vger.kernel.org, tglx@linutronix.de
Subject: Re: rcu stalls with pi_stress in latest rt
Message-ID: <20191107185358.idayofpic7itcd5l@linux-p48b>
References: <20191028182258.76o6qnbgmzm525ff@linux-p48b>
 <20191104152931.dzdhn3wwilohlttc@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191104152931.dzdhn3wwilohlttc@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, 04 Nov 2019, Sebastian Andrzej Siewior wrote:
>That means you might not have RCU-boost enabled.

Alas, that was it. I was going to send you a patch that enabled the option
when PREEMPT_RT_FULL, but then realized I was using a busted config file.
It specifically didn't have CONFIG_RCU_BOOST enabled.

Thanks for having a look!
