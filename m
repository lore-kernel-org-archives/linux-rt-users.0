Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC397C388F9
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 08:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8170F207BB
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 08:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508805AbgJ0IHn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:07:43 -0400
Received: from mail.monom.org ([188.138.9.77]:53886 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508795AbgJ0IHi (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 04:07:38 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 8FDCA50046C;
        Tue, 27 Oct 2020 09:07:36 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 62886500299;
        Tue, 27 Oct 2020 09:07:36 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:07:35 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 04/18] cyclicdeadline: Add long command line options
Message-ID: <20201027080735.3pmoofxhtew7722v@beryllium.lan>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-5-dwagner@suse.de>
 <847bac6b-b577-c54-40a9-8acb18dec517@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <847bac6b-b577-c54-40a9-8acb18dec517@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Oct 23, 2020 at 12:07:18PM -0400, John Kacur wrote:
> Go ahead and send me a patch to remove the -c option
> no need to retain this for silent backwards compatibility.

As I said, the reason I left the -c option is my attempt not to break
existing setups. It's usually a bit annoying as user if tools change
interfaces while keeping the same major version number.

But then there are properly not many users anyway and those are capable
to handle the change. I'll send a patch.
