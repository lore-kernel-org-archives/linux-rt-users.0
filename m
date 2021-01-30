Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C2FC433E6
	for <linux-rt-users@archiver.kernel.org>; Sat, 30 Jan 2021 19:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C181664DF5
	for <linux-rt-users@archiver.kernel.org>; Sat, 30 Jan 2021 19:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhA3TQR (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 30 Jan 2021 14:16:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34474 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229990AbhA3TQR (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 30 Jan 2021 14:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612034091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=7F2eZH+5rLeh25XbVNiiOueoMwzXz036jMYcAbT/2s8=;
        b=EuEYK4j3AAAC2O7m+nBMuPrLcAdnIukrvi56xE9UvDHdh9Cv5EqgSeNV80OfEXBYJWIvz+
        HbUBq1lK0tTcfu95oP/1w5v+rJsLiYUFTGTEEXfItJENKPjTpXMZBgZY3dEs5j9tIob0SL
        eZ0HN5roygdNKNwOoQQe2JGdix2hydc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-tACTXDShMDWXSMkvKcYVNQ-1; Sat, 30 Jan 2021 14:14:46 -0500
X-MC-Unique: tACTXDShMDWXSMkvKcYVNQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BC4D180E475;
        Sat, 30 Jan 2021 19:14:45 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-114-22.rdu2.redhat.com [10.10.114.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 054285D9D2;
        Sat, 30 Jan 2021 19:14:43 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 217643C00CE; Sat, 30 Jan 2021 16:14:42 -0300 (-03)
Date:   Sat, 30 Jan 2021 16:14:42 -0300
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
Subject: [ANNOUNCE] 4.9.254-rt169
Message-ID: <20210130191442.GA112111@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.254-rt169 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: a2fd9ee2875f443939cf56c91154ca066ec03028

Or to build 4.9.254-rt169 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.254.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.254-rt169.patch.xz

Enjoy!
Luis

