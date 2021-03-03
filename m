Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F6CC433E6
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 515D164E12
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Mar 2021 00:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355244AbhCDAVp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:21:45 -0500
Received: from mailout02.rmx.de ([62.245.148.41]:51303 "EHLO mailout02.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1842196AbhCCG5j (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 3 Mar 2021 01:57:39 -0500
X-Greylist: delayed 1946 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Mar 2021 01:57:38 EST
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout02.rmx.de (Postfix) with ESMTPS id 4Dr3qD6r32zNlbC
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 07:23:52 +0100 (CET)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4Dr3qD0JLkz2TTFX
        for <linux-rt-users@vger.kernel.org>; Wed,  3 Mar 2021 07:23:52 +0100 (CET)
Received: from n95hx1g2.localnet (192.168.54.61) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 3 Mar
 2021 07:23:51 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     John Kacur <jkacur@redhat.com>
CC:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] all: Fix printf format errors
Date:   Wed, 3 Mar 2021 07:23:50 +0100
Message-ID: <9852721.nUPlyArG6x@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
References: <20210226073802.9406-1-ceggers@arri.de> <ef6ce578-18c2-562a-222-c83d449ccd3@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.54.61]
X-RMX-ID: 20210303-072352-MFbFtnZVnRZQ-0@out02.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Tuesday, 2 March 2021, 20:58:22 CET, John Kacur wrote:
> 
> On Fri, 26 Feb 2021, Christian Eggers wrote:
> 
> > time_t is "long" or "long long" (depending on the system).  So it should
> > be safe to convert it to "long long", in order to get a consistent data
> > type on all systems.
> > 
> > Signed-off-by: Christian Eggers <ceggers@arri.de>
> > ---
> >  		fprintf(f, "    }%s\n", i == num_threads - 1 ? "" : ",");
> > [...}
> Are you seeing a compile time warning on some systems?

Yes, I do. I have an ARM32 system with 64 bit time_t.

I think that some of the printf format strings are simply wrong (e.g. using
PRIu64 for a "long int").  For time_t, some systems require "%ld" while others
require "%lld".  Casting the values to "long long" seems to be easier compared
to have individual format strings for different platforms.

regards
Christian




