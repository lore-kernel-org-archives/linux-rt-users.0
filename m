Return-Path: <SRS0=Foxt=BW=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C27C433E0
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 15:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE9220781
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Aug 2020 15:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHLPIr (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:08:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbgHLPIo (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Aug 2020 11:08:44 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E5720781;
        Wed, 12 Aug 2020 15:08:43 +0000 (UTC)
Date:   Wed, 12 Aug 2020 11:08:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     zhantao.tang@windriver.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, tglx@linutronix.de,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH linux-5.2.y-rt only] hrtimer: correct the logic for grab
 expiry lock
Message-ID: <20200812110841.122b440b@oasis.local.home>
In-Reply-To: <86790e56-9cec-5cea-8387-f7010b88708b@prevas.dk>
References: <20200812105053.602-1-zhantao.tang@windriver.com>
        <86790e56-9cec-5cea-8387-f7010b88708b@prevas.dk>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, 12 Aug 2020 13:45:02 +0200
Rasmus Villemoes <rasmus.villemoes@prevas.dk> wrote:

> Yup, same patch sent back in April, which also had a fixes tag for 5.2.
> 
> https://lore.kernel.org/lkml/20200428144026.5882-1-rasmus.villemoes@prevas.dk/
> 
> It got picked up for 4.19-rt, dunno why it wasn't for 5.2-rt.

5.2-rt is no longer supported. The -rt trees follow mainline trees.
When a mainline version is EOL so is the -rt version associated with it.

-- Steve
