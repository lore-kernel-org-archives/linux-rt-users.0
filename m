Return-Path: <SRS0=3N3c=R7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A162C43381
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 10:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425712177E
	for <linux-rt-users@archiver.kernel.org>; Thu, 28 Mar 2019 10:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbfC1KVl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 28 Mar 2019 06:21:41 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbfC1KVl (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 28 Mar 2019 06:21:41 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1h9SAG-000231-0f; Thu, 28 Mar 2019 11:21:40 +0100
Date:   Thu, 28 Mar 2019 11:21:39 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Bernhard Landauer <bernhard@manjaro.org>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: firefix core dump with linux 5.0.3_rt1-2
Message-ID: <20190328102139.64lryzhkaoizlxb5@linutronix.de>
References: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dcf61b0e-31ca-0848-84c5-b200a15f3a89@manjaro.org>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-03-28 10:29:54 [+0100], Bernhard Landauer wrote:
> The following happens only with Manjaro's rt patched version of linux50.
> No issue with the regular version.
> 
> When firefox tries to recover tabs of a previous session, they crash.
> Normal operation of firefox is not affected. Only these specific tabs
> are broken.

Is this only related to 5.0-RT or are also previous RT versions
affected?

> Full journal with core dump here:
> 
> https://pastebin.com/W1mTnQ6N

This is not helpful. Do you have an reproducer?

> kind gregards
> Bernhard

Sebastian
