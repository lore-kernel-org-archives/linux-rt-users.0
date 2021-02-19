Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0128AC433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5FF364D74
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 Feb 2021 16:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhBSQ2H (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 Feb 2021 11:28:07 -0500
Received: from mailout04.rmx.de ([94.199.90.94]:53574 "EHLO mailout04.rmx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229535AbhBSQ2G (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 Feb 2021 11:28:06 -0500
Received: from kdin02.retarus.com (kdin02.dmz1.retloc [172.19.17.49])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mailout04.rmx.de (Postfix) with ESMTPS id 4Dhxn60fZ0z3qxZ8
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 17:27:22 +0100 (CET)
Received: from mta.arri.de (unknown [217.111.95.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by kdin02.retarus.com (Postfix) with ESMTPS id 4Dhxn31888z2TRv3
        for <linux-rt-users@vger.kernel.org>; Fri, 19 Feb 2021 17:27:19 +0100 (CET)
Received: from n95hx1g2.localnet (192.168.55.15) by mta.arri.de
 (192.168.100.104) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 19 Feb
 2021 17:27:15 +0100
From:   Christian Eggers <ceggers@arri.de>
To:     Daniel Wagner <dwagner@suse.de>, John Kacur <jkacur@redhat.com>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        <linux-rt-users@vger.kernel.org>
Subject: Re: [rt-tests v2 v2 01/20] cyclictest: Always use libnuma
Date:   Fri, 19 Feb 2021 17:27:14 +0100
Message-ID: <4628381.31r3eYUQgx@n95hx1g2>
Organization: Arnold & Richter Cine Technik GmbH & Co. Betriebs KG
In-Reply-To: <f06c535-f340-4b51-2c0-369d88d39236@redhat.com>
References: <20201218161843.1764-1-dwagner@suse.de> <20210219161602.j7w6gwk7rao5u3ek@beryllium.lan> <f06c535-f340-4b51-2c0-369d88d39236@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [192.168.55.15]
X-RMX-ID: 20210219-172719-fTTdbwWyyqjc-0@out02.hq
X-RMX-SOURCE: 217.111.95.66
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Friday, 19 February 2021, 17:21:21 CET, John Kacur wrote:
> 
> On Fri, 19 Feb 2021, Daniel Wagner wrote:
> 
> > On Fri, Feb 19, 2021 at 04:21:46PM +0100, Christian Eggers wrote:
> > > CONFIG_NUMA is not available on ARM32:
> > 
> > libnuma is not happy if the kernel doesn't have the config
> > option. Well, in this case we just revert the patch I suppose.
> > 
> 
> Yeah, I'm not happy with this.
> To be sure Daniel did a lot of good work cleaning-up some of the numa 
> calls and cleaning up the somewhat artificial smp / numa divide.
> 
> That work needs to continue, but I want the ability to build cyclictest
> without NUMA, and that also means we need the small helpers.

Just for clarification: Does this mean that cyclictest shall link against
libnuma (libnuma can be built on ARM without problems), but not call it
functions at runtime?

From the numa.h:

/* NUMA support available. If this returns a negative value all other function
   in this library are undefined. */
int numa_available(void);

regards,
Christian



