Return-Path: <SRS0=fi+z=6M=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B455AC83006
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 13:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD4520775
	for <linux-rt-users@archiver.kernel.org>; Tue, 28 Apr 2020 13:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgD1N1o (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:27:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726825AbgD1N1n (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 28 Apr 2020 09:27:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8044206D7;
        Tue, 28 Apr 2020 13:27:42 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:27:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Scott Wood <swood@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
Message-ID: <20200428092741.3170d28e@gandalf.local.home>
In-Reply-To: <20200428050242.17717-1-swood@redhat.com>
References: <20200428050242.17717-1-swood@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, 28 Apr 2020 00:02:39 -0500
Scott Wood <swood@redhat.com> wrote:

> There was a note at the end about wanting further discussion on the matter --
> does anyone remember if that ever happened and what the conclusion was?
> Are there any other issues with enabling interrupts here and/or moving
> the newidle_balance() call?

Honestly, I think we got distracted by other issues and never revisited
it :-/

-- Steve
