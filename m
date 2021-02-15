Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5B0C433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Feb 2021 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B585C601FF
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Feb 2021 09:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhBOJBJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Feb 2021 04:01:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:49834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229595AbhBOJBJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Feb 2021 04:01:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EADF2AD73;
        Mon, 15 Feb 2021 09:00:27 +0000 (UTC)
Date:   Mon, 15 Feb 2021 10:00:27 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v4 03/16] cyclictest: Simplify --smp vs
 --affinity vs --threads argument logic
Message-ID: <20210215090027.yrnkhxym63zpal5p@beryllium.lan>
References: <20210210133450.6991-1-dwagner@suse.de>
 <20210210133450.6991-4-dwagner@suse.de>
 <877dnax9cz.fsf@kokedama.swc.toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dnax9cz.fsf@kokedama.swc.toshiba.co.jp>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Punit,

On Mon, Feb 15, 2021 at 01:06:52PM +0900, Punit Agrawal wrote:
> Spotted one typo below while browsing through the patches.

Thanks, fixed the two commit message up.
Daniel
