Return-Path: <SRS0=gxMZ=CN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2097C43461
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 06:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF5D4206B8
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 06:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbgIDGb0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 4 Sep 2020 02:31:26 -0400
Received: from mail.monom.org ([188.138.9.77]:53722 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgIDGbZ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 4 Sep 2020 02:31:25 -0400
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id ABB4950035A;
        Fri,  4 Sep 2020 08:31:23 +0200 (CEST)
Received: from localhost (unknown [94.31.100.251])
        by mail.monom.org (Postfix) with ESMTPSA id 7AB4250016C;
        Fri,  4 Sep 2020 08:31:23 +0200 (CEST)
Date:   Fri, 4 Sep 2020 08:31:23 +0200
From:   Daniel Wagner <wagi@monom.org>
To:     Clark Williams <williams@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 0/4] Streamlining code base?
Message-ID: <20200904063123.uu37gp4ipom64ao6@beryllium.lan>
References: <20200902082725.20037-1-dwagner@suse.de>
 <20200903203948.4d2e5370@tagon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203948.4d2e5370@tagon>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, Sep 03, 2020 at 08:39:48PM -0500, Clark Williams wrote:
> I think it's a noble goal and I'd be up for it, especially trying to come
> up with a parsable output format. Got any thoughts on it? Personally I'd 
> go for (in order of preference): 
> 
> 	XML
> 	JSON
> 	Random Gibberish
> 	Any Damned thing
> 	YAML

For jitterdebugger I ended up adding a bunch of plugins for the output
format. So I don't have to argue which format it best, though if I had
to choose I'd properly pick JSON.

> Did I mention that I hate YAML?

Named must be your fear before banish it you can.
