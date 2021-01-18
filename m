Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B769FC433DB
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jan 2021 03:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FE2224B1
	for <linux-rt-users@archiver.kernel.org>; Mon, 18 Jan 2021 03:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbhARDcC (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 17 Jan 2021 22:32:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28299 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731813AbhARDbk (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 17 Jan 2021 22:31:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610940609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=4oOV9uOT/R4L7lZw3/DtR5eifHD3mnxn+2EAfxBmyFk=;
        b=MLJdlC27cdgGHegSG7Oj5XB1VgSQiKlwMDgG3ys2MCWhm6zMSGMuoVQsm86bMiJgLyCdLZ
        itMDgU+FTEe9PQt6LOut/U3vZgKHmtmPrbVgMqV74H7iCRmcIveXBDYmki2HztG7OlWsV+
        D4EyOiOhN1uZI93x/yD/OyGuA4Ecpn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-BgJLvB03OdijkLPuOliroQ-1; Sun, 17 Jan 2021 22:30:05 -0500
X-MC-Unique: BgJLvB03OdijkLPuOliroQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A7D4107ACF5;
        Mon, 18 Jan 2021 03:30:03 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-112-152.rdu2.redhat.com [10.10.112.152])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 895FE629BF;
        Mon, 18 Jan 2021 03:30:02 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 7D7C73C00CE; Mon, 18 Jan 2021 00:30:00 -0300 (-03)
Date:   Mon, 18 Jan 2021 00:30:00 -0300
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
Subject: [ANNOUNCE] 4.9.252-rt167
Message-ID: <20210118033000.GA3656@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.252-rt167 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 7faa9ce183878ef770c049007634cbaffd8ec129

Or to build 4.9.252-rt167 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.252.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.252-rt167.patch.xz


Enjoy!
Luis

