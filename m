Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB34C47082
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 00:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DB961168
	for <linux-rt-users@archiver.kernel.org>; Tue,  8 Jun 2021 00:14:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbhFHAQn (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:16:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59628 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230254AbhFHAQm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 7 Jun 2021 20:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623111290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=wpxqu7nlR+qfyW47VklMw7CiXq/f2mTRGWg18HtxmBg=;
        b=Vzww6uiAr1FE7ejTh4G2NHHCRWaAXe47I1H1u9Qs4ReJyhbhY4W3ql/rb3K3Rnwp8VAeoC
        WD9ry6D5qXb4zsm6+plo9eAUuUdnpAXTJsoUoDBuXJmwSPgRU6rCJh5bbi/00+S7X5otqM
        htCuFhy3eQXW67OeZxUqpopsKV6xh+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-522-XO0OKak2Ov6wyGe7-93-5g-1; Mon, 07 Jun 2021 20:14:49 -0400
X-MC-Unique: XO0OKak2Ov6wyGe7-93-5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B19101371C;
        Tue,  8 Jun 2021 00:14:47 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-119-82.rdu2.redhat.com [10.10.119.82])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0395A5D9C0;
        Tue,  8 Jun 2021 00:14:46 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 3F9753C0174; Mon,  7 Jun 2021 21:14:45 -0300 (-03)
Date:   Mon, 7 Jun 2021 21:14:45 -0300
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
Subject: [ANNOUNCE] 4.9.270-rt181
Message-ID: <162311119045.386957.17084375241539376690@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.270-rt181 stable release.

No RT-specific changes in this release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: fbbceb73637a5c44e6a556e45cce0fb662cd92ec

Or to build 4.9.270-rt181 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.270.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.270-rt181.patch.xz


Enjoy!
Luis

