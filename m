Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DE8C2D0E4
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 16:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 717902225B
	for <linux-rt-users@archiver.kernel.org>; Fri, 20 Nov 2020 16:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgKTQdl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:33:41 -0500
Received: from mail.monom.org ([188.138.9.77]:36256 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728220AbgKTQdl (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 20 Nov 2020 11:33:41 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 82C505004B8;
        Fri, 20 Nov 2020 17:33:39 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 4E93F500108;
        Fri, 20 Nov 2020 17:33:39 +0100 (CET)
Date:   Fri, 20 Nov 2020 17:33:39 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v1 00/12] Add quiet command line option
Message-ID: <20201120163339.GB22828@beryllium.lan>
References: <20201118190642.16006-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118190642.16006-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Nov 18, 2020 at 08:06:30PM +0100, Daniel Wagner wrote:
> Silence the terminal output for automated tested. I think I got all
> tests udpated which are pretty load.
> 
> This series is ontop of "Teach signaltest affinity" series [1]
> 
> [1] https://lore.kernel.org/linux-rt-users/20201115184059.7286-1-dwagner@suse.de/

BTW, the latest version of the patches are also available in my git repo:

  https://github.com/igaw/rt-tests/commits/quiet
