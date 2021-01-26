Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D22C43331
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38EEE2311C
	for <linux-rt-users@archiver.kernel.org>; Tue, 26 Jan 2021 18:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390648AbhAZRTl (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 26 Jan 2021 12:19:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:43118 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732182AbhAZINP (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 26 Jan 2021 03:13:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AFA19AEAB;
        Tue, 26 Jan 2021 08:11:52 +0000 (UTC)
Date:   Tue, 26 Jan 2021 09:11:52 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests v2 v2 02/20] cyclictest: Use numa API directly
Message-ID: <20210126081152.fx53hhclrtbfrceu@beryllium.lan>
References: <20201218161843.1764-1-dwagner@suse.de>
 <20201218161843.1764-3-dwagner@suse.de>
 <4a45a1e8-1535-375-dd18-c5cb872c2c1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a45a1e8-1535-375-dd18-c5cb872c2c1@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tue, Jan 26, 2021 at 12:31:37AM -0500, John Kacur wrote:
> > @@ -1929,7 +1929,7 @@ int main(int argc, char **argv)
> >  		}
> >  
> >  		/* find the memory node associated with the cpu i */
> > -		node = rt_numa_numa_node_of_cpu(cpu);
> > +		node = numa_node_of_cpu(cpu);
> 
> You've eliminated the error handling that was in the wrapper here.

I was under the impression that cpu will always be a valid. You are
right, we can't be sure of that, because we only warn if the
affinity_mask is not correct (should this be a error?) and things could
change until we reach this point. I'll add the error handling back.
