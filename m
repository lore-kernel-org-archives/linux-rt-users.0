Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360A5C433E0
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 08:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E199164EAE
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 08:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhCOI5j (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:57:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:50076 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229526AbhCOI5f (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Mar 2021 04:57:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 08FC2ABD7;
        Mon, 15 Mar 2021 08:57:34 +0000 (UTC)
Date:   Mon, 15 Mar 2021 09:57:33 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH rt-tests v2 01/14] cyclictest: Fix printf format specifier
Message-ID: <20210315085733.ihkbz6x4gzmeug3d@beryllium.lan>
References: <20210305073500.17926-1-dwagner@suse.de>
 <20210305073500.17926-2-dwagner@suse.de>
 <1c4293d8-5c7f-e6e0-cd48-67b240c08d59@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c4293d8-5c7f-e6e0-cd48-67b240c08d59@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Sun, Mar 14, 2021 at 06:45:16PM -0400, John Kacur wrote:
> This had already been added before

Okay, I didn't show up when I pulled.
