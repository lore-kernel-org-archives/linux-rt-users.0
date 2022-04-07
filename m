Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C3AFC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  7 Apr 2022 03:12:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239693AbiDGDOg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 6 Apr 2022 23:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240009AbiDGDOb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 6 Apr 2022 23:14:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C75229C9B
        for <linux-rt-users@vger.kernel.org>; Wed,  6 Apr 2022 20:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649301149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=o2XJ/PYYYWY5KXzvH0UjPpAiYIxfsM74/YarMZ85AxQ=;
        b=PpxTdld4QIix21RFEdXMuQv3+XqJ1Z/SlvdxmsGuS2Y8GIw+sGaj04JbIqacXpktBKiTMy
        SLuEFwdm4XNeLNmyTzDUyZOAbNkqq5tF7nm0g9FXRVSUKm4yRkjUcKxssIY0Jw4T7/J2uI
        MrRb7MXgVLLlzf8FGQgHikmipNq/WoY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-398HpYHlOL2ydSdzH2-AqQ-1; Wed, 06 Apr 2022 23:12:24 -0400
X-MC-Unique: 398HpYHlOL2ydSdzH2-AqQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B02FC811E7A;
        Thu,  7 Apr 2022 03:12:23 +0000 (UTC)
Received: from localhost (unknown [10.22.17.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BE7CA9D42;
        Thu,  7 Apr 2022 03:12:22 +0000 (UTC)
Date:   Thu, 7 Apr 2022 00:12:21 -0300
From:   "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        stable-rt <stable-rt@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@suse.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Clark Williams <williams@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Pavel Machek <pavel@denx.de>,
        Jeff Brady <jeffreyjbrady@gmail.com>,
        Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.109-rt65
Message-ID: <Yk5WlfFZW6WDk5/A@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 5.10.109-rt65 stable release.

This release is just an update to the new stable 5.10.109
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 9b5a4eb09d95d057621247cd453eafa96f8ffec6

Or to build 5.10.109-rt65 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.109.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/patch-5.10.109-rt65.patch.xz


All keys used for the uploads can be found on the following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git


Enjoy!
Luis

