Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84854C433ED
	for <linux-rt-users@archiver.kernel.org>; Sat,  1 May 2021 03:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F7161073
	for <linux-rt-users@archiver.kernel.org>; Sat,  1 May 2021 03:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhEADax (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 30 Apr 2021 23:30:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29071 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhEADaw (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Apr 2021 23:30:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619839803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=cLw324W+h4aff9KOf/JPfSaakJj/rbJdzvMw/riyeDE=;
        b=CqgftGxLl4uvtSvOVLpscO2+cDQOt/u6DkrnNopChsVaPGlqGfNDYkW2vJku0dLpa4GTY9
        EFH1ihqExRoE2C5KP7pHyGbgIx5Tce+G9oNdRknsI/T2LA5qOcV+5VM3l7/9FLIuo0MZvn
        daOqwBbbCYwSf1AI+a01ICoAwH8ePYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-XoeH7PoWN8K0DoTSo-x1Rw-1; Fri, 30 Apr 2021 23:30:01 -0400
X-MC-Unique: XoeH7PoWN8K0DoTSo-x1Rw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 299FA10060C3;
        Sat,  1 May 2021 03:30:00 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-234.phx2.redhat.com [10.3.117.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E222A6A05A;
        Sat,  1 May 2021 03:29:59 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 5438D3C0053; Sat,  1 May 2021 00:29:58 -0300 (-03)
Date:   Sat, 1 May 2021 00:29:58 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 4.14.232-rt111
Message-ID: <YIzLNua6b2utBIfA@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.232-rt111 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 746ebb3ffc9c1ff8e89fc57ef13e694b48e93963

Or to build 4.14.232-rt111 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.232.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.232-rt111.patch.xz


Enjoy!
Luis

