Return-Path: <SRS0=HWFh=7I=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA4C433DF
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 16:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAB720787
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 May 2020 16:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEZQov convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 May 2020 12:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgEZQov (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 May 2020 12:44:51 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E931CC03E96E;
        Tue, 26 May 2020 09:44:50 -0700 (PDT)
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jdcgc-0006hh-2Z; Tue, 26 May 2020 18:44:18 +0200
Date:   Tue, 26 May 2020 18:44:18 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     wang.yi59@zte.com.cn, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        jiang.xuexin@zte.com.cn, wang.yong12@zte.com.cn,
        linux-rt-users@vger.kernel.org
Subject: Re: [RT PATCH] Fixed: line break of pr_cont not take effect
Message-ID: <20200526164418.oqdbs3a7zdpb4ynq@linutronix.de>
References: <202005231419598080913@zte.com.cn>
 <87imgnndbc.fsf_-_@vostro.fn.ogness.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <87imgnndbc.fsf_-_@vostro.fn.ogness.net>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2020-05-23 12:41:27 [+0200], John Ogness wrote:
> > Signed-off-by: 汪勇10269566 <wang.yong12@zte.com.cn>
> 
> Acked-by: John Ogness <john.ogness@linutronix.de>
> 
> @Sebastian: The original patch submission is here[0].

I reworded it and applied it. Thanks everyone.
汪勇, I suggest to mail patches as root in future.

> Thanks,
> John Ogness

Sebastian
