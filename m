Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFB9C4361B
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 09:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA2623105
	for <linux-rt-users@archiver.kernel.org>; Wed, 16 Dec 2020 09:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725890AbgLPJkM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 16 Dec 2020 04:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgLPJkM (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 16 Dec 2020 04:40:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F104C0613D6
        for <linux-rt-users@vger.kernel.org>; Wed, 16 Dec 2020 01:39:32 -0800 (PST)
Date:   Wed, 16 Dec 2020 10:39:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608111570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9FP44BJMzY6HszezzEwCQo1JwF7Me3G+7bDvlSGFNQ=;
        b=ZiKqlcp2zVrAh3cApsFOP8K+PCMGY/j3mot/uWeg1xtF5vPuAT1ApKqvpGd6xYkLSLigi7
        DQz6I8NciJ3EKp1lIoDGJ5/tsYkmg6FGRd59yL6AA1CURJNnpsgPr57jZoRf+1gaUfgh8s
        tCYey/xdFrVtiGINAFgSfl7Q2c2i0+TpvFzX+UQFfXFYjPcmScWDpczmo+0bOp1oVXwIGi
        +cK8qU+KoafxhKzDiyUKyxXFMNgqMq4ch/v7jJPI29+I2VwbFyCTEc9h0pghLHm309xF0y
        /DQPYTPTQRoiJytFevn0NSi+v0xOPlCxVwk1oLhBgu8ezZQV2Ax2+DQ7E0UvAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608111570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9FP44BJMzY6HszezzEwCQo1JwF7Me3G+7bDvlSGFNQ=;
        b=AkrEE0oTYLZ1Jq+eqwj0CchU0ahfOsBQ5+uPb7bxVxVx+YZ74LsrvVmqXs8cJXkGNLWPiC
        B7qBq5E1RAystsBw==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     John Kacur <jkacur@redhat.com>
Cc:     Daniel Wagner <dwagner@suse.de>,
        RT <linux-rt-users@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Clark Williams <williams@redhat.com>
Subject: Re: [PATCH 1/3] rt-tests: determine_maximum_mpps.sh: Add a menu to
 get user settings.
Message-ID: <X9nV0RLSY+A3vpF1@lx-t490>
References: <20201209183100.16836-1-jkacur@redhat.com>
 <20201214093049.pl2guoij4kjw2ifc@beryllium.lan>
 <9b24db5-61d2-9d3c-7f5d-271e6366add2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b24db5-61d2-9d3c-7f5d-271e6366add2@redhat.com>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Dec 16, 2020 at 01:22:36AM -0500, John Kacur wrote:
> On Mon, 14 Dec 2020, Daniel Wagner wrote:
...
> >
> > What about long options? Long options are propably a bit harder to
> > implement in shell but it would be good in my opinion to keep all those
> > tests commands as close as possible.
> >
...
>
> Yeah, long options are a PITA in shell script, I think I might just
> convert the script to python where command line options are a breeze.
>

Just a FYI, it's quite O.K. when using util-linux getopt(1) instead of
bash's getopts builtin.

thanks,

--
Ahmed S. Darwish
Linutronix GmbH
