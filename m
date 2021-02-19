Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C9C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 20:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7E0B64EB8
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 20:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhBSU2g (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 15:28:36 -0500
Received: from mailout08.rmx.de ([94.199.90.85]:34068 "EHLO mailout08.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBSU2b (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 15:28:31 -0500
Received: from kdin01.retarus.com (kdin01.dmz1.retloc [172.19.17.48])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout08.rmx.de (Postfix) with ESMTPS id 4Dj36W2npKzMmvd
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 21:27:47 +0100 (CET)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin01.retarus.com (Postfix) with ESMTPS id 4Dj36S6tdbz2xDK
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 21:27:44 +0100 (CET)
Received: from n95hx1g2.localnet (192.168.55.15) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Feb
 2021 21:27:41 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     RT <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        "John Kacur" <jkacur@redhat.com>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        "John Kacur" <jkacur@redhat.com>
Subject: Re: [PATCH 0/3] Revert always use libnuma patches
Date:   Fri, 19 Feb 2021 21:27:40 +0100
Message-ID: <2188166.ElGaqSPkdT@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <20210219184801.13905-1-jkacur@redhat.com>
References: <20210219184801.13905-1-jkacur@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.55.15]
X-RMX-ID: 20210219-212744-kLpZByBHjfwz-0@out01.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Friday, 19 February 2021, 19:47:58 CET, John Kacur wrote:
> libnuma is a build requirement but not a runtime requirement.
> 
> Test branch unstable/devel/no-numa-runtime
> 
> I would appreciate some testing before I push commits upstream
> 
Now it is the same situation as in v1.10: 
With the --smp option set, cyclictest runs on arm32. Otherwise I still get the 
"FATAL: Couldn't initialize libnuma" (newline missing!)

regards
Christian


