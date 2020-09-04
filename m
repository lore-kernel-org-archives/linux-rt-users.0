Return-Path: <SRS0=gxMZ=CN=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E33C433E2
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 01:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3788320716
	for <linux-rt-users@archiver.kernel.org>; Fri,  4 Sep 2020 01:39:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BXdXFdC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgIDBj4 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 3 Sep 2020 21:39:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47108 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728271AbgIDBjz (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 3 Sep 2020 21:39:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599183593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DApoNlcx2IJYbu9Hs+ld7QpdA1LDRBT7OUseKa+UWt8=;
        b=BXdXFdC8u5O8L3+j/CkcJ+wS5VQan9vHeZ2x6HZ4hH62XdAlwBXUIOyxK3i0PDbxsuhFKV
        UyMmrVXWcRn9WehrRXonUQznrUfsXa25OKXkKIykWET6YJ/fOeoauz8KPAfNdmKCCXX9OS
        /AMsiXPFy+wNQ2zKmBdtf35EHVyUHAk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-z2wXxcU3N3KAmH_I_zEhLw-1; Thu, 03 Sep 2020 21:39:51 -0400
X-MC-Unique: z2wXxcU3N3KAmH_I_zEhLw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD06E185FD6F;
        Fri,  4 Sep 2020 01:39:50 +0000 (UTC)
Received: from tagon (ovpn-114-233.rdu2.redhat.com [10.10.114.233])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BB037E414;
        Fri,  4 Sep 2020 01:39:50 +0000 (UTC)
Date:   Thu, 3 Sep 2020 20:39:48 -0500
From:   Clark Williams <williams@redhat.com>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     John Kacur <jkacur@redhat.com>, linux-rt-users@vger.kernel.org
Subject: Re: [rt-tests 0/4] Streamlining code base?
Message-ID: <20200903203948.4d2e5370@tagon>
In-Reply-To: <20200902082725.20037-1-dwagner@suse.de>
References: <20200902082725.20037-1-dwagner@suse.de>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed,  2 Sep 2020 10:27:21 +0200
Daniel Wagner <dwagner@suse.de> wrote:

> Hi Clark and John,
> 
> I'd like to streamline all tools, so that the usage, command arguments
> and the output is more consistent. Every tool seems to be a bit
> different which makes all automatization around the tools more complex
> than needed.
> 
> Eventually, I'd like to add an easy machine parseable output from all
> tools. So what do you think? Stupid effort, go away?

I think it's a noble goal and I'd be up for it, especially trying to come
up with a parsable output format. Got any thoughts on it? Personally I'd 
go for (in order of preference): 

	XML
	JSON
	Random Gibberish
	Any Damned thing
	YAML

Clark

Did I mention that I hate YAML?

> 
> Here are a bunch of patches to illustrate what I mean. Before invest
> too much time I'd like to discuss it, e.g. format.
> 
> Cheers,
> Daniel
> 
> Daniel Wagner (4):
>   cyclicdeadline: Streamline usage output and man page
>   deadline_test: Streamline usage output and man page
>   oslat: Streamline usage output and man page
>   oslat: Use string parser utilies
> 
>  src/include/rt-utils.h              |   1 +
>  src/lib/rt-utils.c                  |  30 ++++++
>  src/oslat/oslat.8                   |   2 +-
>  src/oslat/oslat.c                   | 143 ++++++++--------------------
>  src/sched_deadline/cyclicdeadline.8 |  24 ++---
>  src/sched_deadline/cyclicdeadline.c |  41 ++++----
>  src/sched_deadline/deadline_test.8  |  37 ++++---
>  src/sched_deadline/deadline_test.c  |  47 +++++----
>  8 files changed, 145 insertions(+), 180 deletions(-)
> 
> -- 
> 2.28.0
> 


-- 
The United States Coast Guard
Ruining Natural Selection since 1790

