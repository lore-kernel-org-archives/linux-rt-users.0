Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB071C43331
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 08:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBAB64EBE
	for <linux-rt-users@archiver.kernel.org>; Mon, 15 Mar 2021 08:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbhCOI5H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 15 Mar 2021 04:57:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:49802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229636AbhCOI4t (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 15 Mar 2021 04:56:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 58269AC1D;
        Mon, 15 Mar 2021 08:56:48 +0000 (UTC)
Date:   Mon, 15 Mar 2021 09:56:47 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Clark Williams <williams@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH rt-tests v2 04/14] rt-util: Copy command line before
 getopt_long() is called
Message-ID: <20210315085647.6extplrdianzsb4b@beryllium.lan>
References: <20210305073500.17926-1-dwagner@suse.de>
 <20210305073500.17926-5-dwagner@suse.de>
 <da896064-9c42-9e26-c8e6-2758c28c64cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da896064-9c42-9e26-c8e6-2758c28c64cf@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Mon, Mar 15, 2021 at 01:47:22AM -0400, John Kacur wrote:
> 
> 
> On Fri, 5 Mar 2021, Daniel Wagner wrote:
> 
> > By default, getopt_long() permutes the contents of argv as it scans,
> > so that eventually all the nonoptions are at the end. This is
> > confusing in the JSON output, thus copy the command line before we
> > call getopt_long().
> > 
> > Introduce a rt_init() which copies the command line. This makes also
> > rt_write_json() function arguments a bit cleaner.
> > 
> > Signed-off-by: Daniel Wagner <dwagner@suse.de>
> > ---
> >  src/cyclictest/cyclictest.c           |  3 +-
> >  src/include/rt-utils.h                |  7 +++--
> >  src/lib/rt-utils.c                    | 45 ++++++++++++---------------
> >  src/oslat/oslat.c                     |  5 +--
> >  src/pmqtest/pmqtest.c                 |  3 +-
> >  src/ptsematest/ptsematest.c           |  3 +-
> >  src/rt-migrate-test/rt-migrate-test.c |  3 +-
> >  src/sched_deadline/cyclicdeadline.c   |  4 ++-
> >  src/signaltest/signaltest.c           |  3 +-
> >  src/sigwaittest/sigwaittest.c         |  3 +-
> >  src/svsematest/svsematest.c           |  3 +-
> >  11 files changed, 44 insertions(+), 38 deletions(-)
> > 
> > diff --git a/src/cyclictest/cyclictest.c b/src/cyclictest/cyclictest.c
> > index c43dd7cbbd64..3f3b91bab53b 100644
> > --- a/src/cyclictest/cyclictest.c
> > +++ b/src/cyclictest/cyclictest.c
> > @@ -1778,6 +1778,7 @@ int main(int argc, char **argv)
> >  	int i, ret = -1;
> >  	int status;
> >  
> > +	rt_init(argc, argv);
> 
> Why should we call this if we're not using formatted output?

Yes unfortunately. We only know after we used getopt_long() that we should
have stored argv, kind of chicken-egg situation.
