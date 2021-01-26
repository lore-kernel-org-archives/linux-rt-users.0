Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4721EC433DB
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 12:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AB212311F
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389194AbhAZMd5 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:33:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:47480 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728040AbhAZMdj (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 07:33:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1D88AD19;
        Tue, 26 Jan 2021 12:32:56 +0000 (UTC)
Date:   Tue, 26 Jan 2021 13:32:56 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Clark Williams <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v4 00/12] Generate machine-readable output
Message-ID: <20210126123256.6xt7zcet6mxtklvf@beryllium.lan>
References: <20210126091946.1241-1-dwagner@suse.de>
 <YA/2b3+WwqqWrBdo@lx-t490>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YA/2b3+WwqqWrBdo@lx-t490>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 12:01:03PM +0100, Ahmed S. Darwish wrote:
> On Tue, Jan 26, 2021 at 10:19:34AM +0100, Daniel Wagner wrote:
> ...
> > {
> >   "file_version": 1,
> >   "version:": "cyclictest V 1.90",
> >   "num_threads": 2,
> >   "resolution_in_ns": 0,
> >   "cmdline:": "./cyclictest --affinity=1-2 --duration=1s --output=dump.json -h 1000 -p 80",
> >   "sysinfo": {
> >     "sysname": "Linux",
> >     "nodename": "beryllium",
> >     "release": "5.9.14-1-default",
> >     "version": "#1 SMP Sat Dec 12 06:57:32 UTC 2020 (c648a46)",
> >     "machine": "x86_64"
> >   },
> 
> Wouldn't it be also helpful to add `"realtime": "true"` if
> /sys/kernel/realtime exists and equal to 1?

Good point, the sysinfo part could certainly have some more information
added. For example a timestamp of the test run.
