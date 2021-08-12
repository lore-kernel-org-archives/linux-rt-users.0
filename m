Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0E7C43214
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649066103E
	for <linux-rt-users@archiver.kernel.org>; Thu, 12 Aug 2021 23:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhHLXHX (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 12 Aug 2021 19:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229919AbhHLXHX (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 12 Aug 2021 19:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628809616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/V6axuy2zVefHSFMXHKocTXKzMu1/qv2lNFHrUEJV0=;
        b=YCrW76WaTXspYuJaAOpf8I3EXdBv+RQDshd5fRgu+DY1w7cFMmtrGl7Uq46/AImujpXI8q
        KfaCZW6I0jlQhlaMIxIfSv8Lp9blXFctQNfvEW6SQg5NVMP0Oco//RhLyHzPaEfdDFGv1+
        l4wRaxJU7nMOzzRsXtLtlHyOlDvrre4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-anvc6_xENdK6lAR6qm86Qg-1; Thu, 12 Aug 2021 19:06:55 -0400
X-MC-Unique: anvc6_xENdK6lAR6qm86Qg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AFB5107ACF5;
        Thu, 12 Aug 2021 23:06:54 +0000 (UTC)
Received: from theseus.lan (unknown [10.22.18.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4319C77701;
        Thu, 12 Aug 2021 23:06:53 +0000 (UTC)
Date:   Thu, 12 Aug 2021 16:47:06 -0500
From:   Clark Williams <williams@redhat.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>
Subject: Re: [ANNOUNCE] v5.14-rc5-rt8
Message-ID: <20210812164706.185552b2@theseus.lan>
In-Reply-To: <58e09984-31fa-2d9e-8c4d-c7813c1d8d54@suse.cz>
References: <20210810163731.2qvfuhenolq2gdlv@linutronix.de>
        <20210812151803.52f84aaf@theseus.lan>
        <58e09984-31fa-2d9e-8c4d-c7813c1d8d54@suse.cz>
Organization: Red Hat, Inc
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 12 Aug 2021 23:36:48 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 8/12/21 10:18 PM, Clark Williams wrote:
> > On Tue, 10 Aug 2021 18:37:31 +0200
> > Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> >
> > Sebastian, et al,
> > 
> > Got the following panic running v5.14-rc5-rt8:  
> 
> BTW, which was the last version that worked for you in this test?
> The SLUB changes in rt8 should have been minimal, and related to
> hotplug. On the other hand, if the previous working one was v5.14-rc4
> based, the problem could be in rc5...
> 

I'm going to have to work my way backwards for that. I had a ton of warning
splats showing up, mainly in kcov and i915 and fixed those before I started
running rteval. I'll see if this showed up in rc4 or before but it may take
me a couple of days.

Clark

-- 
The United States Coast Guard
Ruining Natural Selection since 1790

