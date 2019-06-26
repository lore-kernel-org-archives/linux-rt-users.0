Return-Path: <SRS0=t/x/=UZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4621C48BD3
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 11:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AF120663
	for <linux-rt-users@archiver.kernel.org>; Wed, 26 Jun 2019 11:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfFZLMq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 26 Jun 2019 07:12:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47006 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfFZLMq (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 26 Jun 2019 07:12:46 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1hg5r2-0005UT-Ko; Wed, 26 Jun 2019 13:12:44 +0200
Date:   Wed, 26 Jun 2019 13:12:44 +0200
From:   Sebastian Siewior <bigeasy@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     rt-users <linux-rt-users@vger.kernel.org>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH] rt-tests: Use gettid from rt-utils.c everywhere
Message-ID: <20190626111244.bl25f2wjsklwnm7f@linutronix.de>
References: <20190626110838.7800-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190626110838.7800-1-jkacur@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 2019-06-26 13:08:38 [+0200], John Kacur wrote:
> gettid is defined in rt-utils, so we should use that everywhere instead
> of defining a separate macro in each test for it.

perfect.

Sebastian
