Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94259C433E0
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61BC964EC4
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355252AbhCDAVs (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:21:48 -0500
Received: from mail.monom.org ([188.138.9.77]:59196 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356510AbhCCH3d (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 02:29:33 -0500
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id A05E25005A9;
        Wed,  3 Mar 2021 08:28:34 +0100 (CET)
Received: from localhost (unknown [94.31.96.195])
        by mail.monom.org (Postfix) with ESMTPSA id 6881F500222;
        Wed,  3 Mar 2021 08:28:34 +0100 (CET)
Date:   Wed, 3 Mar 2021 08:28:34 +0100
From:   Daniel Wagner <wagi@monom.org>
To:     Christian Eggers <ceggers@arri.de>
Cc:     John Kacur <jkacur@redhat.com>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH] all: Fix printf format errors
Message-ID: <20210303072834.pi2pej3xczdx4jsa@beryllium.lan>
References: <20210226073802.9406-1-ceggers@arri.de>
 <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
 <9852721.nUPlyArG6x@n95hx1g2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9852721.nUPlyArG6x@n95hx1g2>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Mar 03, 2021 at 07:23:50AM +0100, Christian Eggers wrote:
> On Tuesday, 2 March 2021, 20:58:22 CET, John Kacur wrote:
> >
> > On Fri, 26 Feb 2021, Christian Eggers wrote:
> >
> > > time_t is "long" or "long long" (depending on the system).  So it should
> > > be safe to convert it to "long long", in order to get a consistent data
> > > type on all systems.
> > >
> > > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > > ---
> > >             fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
> > > [...}
> > Are you seeing a compile time warning on some systems?
> 
> Yes, I do. I have an ARM32 system with 64 bit time_t.
> 
> I think that some of the printf format strings are simply wrong (e.g. using
> PRIu64 for a "long int").  For time_t, some systems require "%ld" while others
> require "%lld".  Casting the values to "long long" seems to be easier compared
> to have individual format strings for different platforms.

Indeed, that was my fault. I've also send out patches for this a couple
of weeks ago IIRC.
