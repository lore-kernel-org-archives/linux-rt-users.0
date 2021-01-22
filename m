Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5C5C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6BF2343E
	for <linux-rt-users@archiver.kernel.org>; Fri, 22 Jan 2021 12:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbhAVMwJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 22 Jan 2021 07:52:09 -0500
Received: from mail.monom.org ([188.138.9.77]:50940 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbhAVMwH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 22 Jan 2021 07:52:07 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id B4B8550065D;
        Fri, 22 Jan 2021 13:51:19 +0100 (CET)
Received: from localhost (unknown [94.31.99.195])
        by mail.monom.org (Postfix) with ESMTPSA id 7587F500296;
        Fri, 22 Jan 2021 13:51:19 +0100 (CET)
Date:   Fri, 22 Jan 2021 13:51:19 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 00/20] rt-numa.h cleanups
Message-ID: <20210122125119.s6onysng7sxziuet@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218161843.1764-1-dwagner@suse.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Fri, Dec 18, 2020 at 05:18:23PM +0100, Daniel Wagner wrote:
> This series cleans up the rt-numa.h header.

ping
