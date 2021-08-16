Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAFEC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 00:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1974A6137D
	for <linux-rt-users@archiver.kernel.org>; Mon, 16 Aug 2021 00:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhHPAD1 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 15 Aug 2021 20:03:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230509AbhHPAD0 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 15 Aug 2021 20:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629072175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=46eaLAKLjqXW3qD1FHE2YVxkKYdxndol2gb9aE8pOLk=;
        b=b3hSmO4xpngJEQuSyMdw2Ckb9+Mm06TwcNB4SEQqQ45BM1+I8sjP+zEFmdtxi8yAJmCON7
        UkbpmtJ8taRsONdvJ28bucjOGHB882Ta/JBxOsFUEgYbE0myJbHwN7LZLhAeivJXpQ+iEz
        bExxViZf4ofXlfzZWLkw21+F7TeUF50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-197-sQzHcE-7NWG0jOhR5jcfwA-1; Sun, 15 Aug 2021 20:02:52 -0400
X-MC-Unique: sQzHcE-7NWG0jOhR5jcfwA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EF3A18C89D9;
        Mon, 16 Aug 2021 00:02:50 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.33.59])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 77EC56789C;
        Mon, 16 Aug 2021 00:02:49 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id B68CA3C0205; Sun, 15 Aug 2021 21:02:47 -0300 (-03)
Date:   Sun, 15 Aug 2021 21:02:47 -0300
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
Subject: [ANNOUNCE] 4.14.244-rt121
Message-ID: <YRmrJ1IeKdjXsfHD@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.244-rt121 stable release.

This release is just an update to the new stable 4.14.244 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 1e79ba58f443c4d68ad23473ac3665b5ae43646b

Or to build 4.14.244-rt121 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.244.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.244-rt121.patch.xz


Enjoy!
Luis

