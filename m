Return-Path: <SRS0=nqJC=3Q=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70CBC2D0DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99B222527
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Jan 2020 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MakMO4jX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgA0Vo7 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Jan 2020 16:44:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28532 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726080AbgA0Vo7 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Jan 2020 16:44:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580161497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Wy35csZmdYzO2X5OBKE6ZvGgflpVvhADtsDDps9NGI4=;
        b=MakMO4jXP5pzi681uCpaccyUBB83bH+EzgyTRYbZ23HY/4+ASI1MNJRCVc4FF1kXdJqiTJ
        MbwzILCHOkzd2p+GWhV2ACuB+mHxEwNFngHN4N4BCNuNmUWMe5i+DkTGwafbOTxDsM+GzN
        bs64sgkVNnNY9QCf7UTx6CRRjcsknJw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-DGlWSHivNaOdBfwuHlRbIA-1; Mon, 27 Jan 2020 16:44:55 -0500
X-MC-Unique: DGlWSHivNaOdBfwuHlRbIA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FC94477
        for <linux-rt-users@vger.kernel.org>; Mon, 27 Jan 2020 21:44:54 +0000 (UTC)
Received: from tagon (ovpn-121-194.rdu2.redhat.com [10.10.121.194])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13D265D9CA;
        Mon, 27 Jan 2020 21:44:53 +0000 (UTC)
Date:   Mon, 27 Jan 2020 15:44:52 -0600
From:   Clark Williams <williams@redhat.com>
To:     John Kacur <jkacur@redhat.com>
Cc:     RT <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH 0/9] rt-tests: Miscellaneous fixes
Message-ID: <20200127154452.543c378c@tagon>
In-Reply-To: <20200123205029.20176-1-jkacur@redhat.com>
References: <20200123205029.20176-1-jkacur@redhat.com>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

John,

Thanks for this! I suspect we now need an 8.3 bz for updating the rt-tests
package to the latest upstream version.

Clark

On Thu, 23 Jan 2020 21:50:20 +0100
John Kacur <jkacur@redhat.com> wrote:

> Most of the fixes here are just clean-ups to make sure that online help
> or usage message match the man pages according to the current options.
> 
> Some fixes to the queuelat scripts determine_maximum_mpps.sh and
> get_cpuinfo_mhz.sh are perhaps notable though, as people were having
> trouble using them.
> 
> getcpuinfo_mhz.sh now only gets one value as was originally intended,
> and it gets the highest value available. The fixes to quoting in
> determine_maximum_mpps.sh should make the program work correctly now -
> and take longer though.
> 
> John Kacur (9):
>   rt-tests: queuelat: Assume queuelat is in the path
>   rt-tests: cyclicdeadline: Add a simple manpage for cyclicdeadline
>   rt-tests: pi_stress: Add short options to usage message
>   rt-tests: pi_stress: Sync man page with help
>   rt-tests: queuelat: get_cpuinfo_mhz.sh highest value
>   rt-tests: determine_maximum_mpps.sh: Fix quoting and other shell issue
>   rt-tests: ptsematest: Update man page and add -h option
>   rt-tests: queuelat: Fixes to man page and display_help
>   rt-tests: svsematest: Display help with an error message for -h
> 
>  Makefile                               |  1 +
>  src/pi_tests/pi_stress.8               |  9 ++--
>  src/pi_tests/pi_stress.c               | 34 ++++++------
>  src/ptsematest/ptsematest.8            |  3 ++
>  src/ptsematest/ptsematest.c            | 10 ++--
>  src/queuelat/determine_maximum_mpps.sh | 75 +++++++++++++-------------
>  src/queuelat/get_cpuinfo_mhz.sh        |  5 +-
>  src/queuelat/queuelat.8                |  4 +-
>  src/queuelat/queuelat.c                | 22 ++++----
>  src/sched_deadline/cyclicdeadline.8    | 53 ++++++++++++++++++
>  src/svsematest/svsematest.c            |  3 +-
>  11 files changed, 141 insertions(+), 78 deletions(-)
>  create mode 100644 src/sched_deadline/cyclicdeadline.8
> 
> -- 
> 2.20.1
> 


-- 
The United States Coast Guard
Ruining Natural Selection since 1790

