Return-Path: <SRS0=DAnd=UK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91572C4321A
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AC0921734
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Jun 2019 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391921AbfFKQXi (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Jun 2019 12:23:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391573AbfFKQXi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Jun 2019 12:23:38 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DBD2080A;
        Tue, 11 Jun 2019 16:23:37 +0000 (UTC)
Date:   Tue, 11 Jun 2019 12:23:36 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-rt-users@vger.kernel.org>
Subject: Re: Stable update for 4.19 RT kernel?
Message-ID: <20190611122336.73e0b8d0@gandalf.local.home>
In-Reply-To: <784070d0-dbd5-a963-45df-da7644f6bb8c@ti.com>
References: <26777fac-77fe-be66-5f85-d708809c2c04@ti.com>
        <784070d0-dbd5-a963-45df-da7644f6bb8c@ti.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 11 Jun 2019 09:56:14 -0500
Dan Murphy <dmurphy@ti.com> wrote:

> On 6/11/19 7:56 AM, Dan Murphy wrote:
> > Hello
> >
> > Is there a timeframe to when the 4.19-rt branch will be updated to the 
> > latest linux-4.19.y dot release?
> >
> > This branch is 13 versions behind
> >

Greg has been busy hasn't he. Note, the last post was a backport of
patches from rt-devel which takes some time.

I'll plan to have an update by the end of the week.

-- Steve
