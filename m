Return-Path: <SRS0=5J30=EC=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778AC4363A
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 08:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8509B20829
	for <linux-rt-users@archiver.kernel.org>; Tue, 27 Oct 2020 08:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508826AbgJ0IJt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 27 Oct 2020 04:09:49 -0400
Received: from mail.monom.org ([188.138.9.77]:53922 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2508817AbgJ0IJs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 27 Oct 2020 04:09:48 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 4C74C50046C;
        Tue, 27 Oct 2020 09:09:47 +0100 (CET)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 198AE500299;
        Tue, 27 Oct 2020 09:09:47 +0100 (CET)
Date:   Tue, 27 Oct 2020 09:09:46 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 08/18] pip_stress: Add command line parser
Message-ID: <20201027080946.ow6pk76rz2duyzto@beryllium.lan>
References: <20201007085653.11961-1-dwagner@suse.de>
 <20201007085653.11961-9-dwagner@suse.de>
 <6b9b3b38-f2e3-ed6e-8d3b-61c08387b69c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b9b3b38-f2e3-ed6e-8d3b-61c08387b69c@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Oct 23, 2020 at 01:33:42PM -0400, John Kacur wrote:
> Uglifying my beautiful program in the name conformity?

But now it can say 'help' :)
