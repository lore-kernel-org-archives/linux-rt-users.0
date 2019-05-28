Return-Path: <SRS0=Q2zZ=T4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43305C04AB6
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 May 2019 16:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2339021670
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 May 2019 16:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbfE1QEn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 May 2019 12:04:43 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51052 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfE1QEn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 May 2019 12:04:43 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hVeae-0001cm-Hy; Tue, 28 May 2019 18:04:40 +0200
Date:   Tue, 28 May 2019 18:04:40 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     ddu <dengke.du@windriver.com>
Cc:     linux-rt-users@vger.kernel.org
Subject: Re: rt kernel break printf command's parent process
Message-ID: <20190528160440.nbrhmchexbz2jh5s@linutronix.de>
References: <205dd879-fedc-2edf-92b3-0bd8a3ee1870@windriver.com>
 <20190528143329.yxpzhu2ov5piiceb@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190528143329.yxpzhu2ov5piiceb@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-05-28 16:33:29 [+0200], To ddu wrote:
> On 2019-05-27 17:47:04 [+0800], ddu wrote:
> > Hi all
> Hi,
> 
> > I use yocto rt-kernel which rebase on rt kernel:
> > 
> > http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto/log/?h=v5.0/standard/preempt-rt/intel-x86

That tree has -rt3. Please update to -rt9.

Sebastian
