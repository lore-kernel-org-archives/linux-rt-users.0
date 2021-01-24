Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F9C433DB
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Jan 2021 02:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B454229F0
	for <linux-rt-users@archiver.kernel.org>; Sun, 24 Jan 2021 02:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbhAXCHN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 23 Jan 2021 21:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20695 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbhAXCHN (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 23 Jan 2021 21:07:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611453947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=A5UmVTKDoiYfNesNyr3QYPvSARjlxC2oxETHoO/83GM=;
        b=SODJFdSgHWw8uLJdHMdjLeWrvt6G8bqKkDp5J9yn2BuGU1MW+PEMssqw3ISZJ+JEnLhAt4
        gUwYiuZLADdujU4apEQ55rQV61JZeMMT875FUz+4TPjn91VqsP7DV1NZSc+bhNwZS02IAp
        D5/6fJK0EjJgdNUd3a0i5c/sphmpfq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-fh6r8fQLMiW2jwocOhevgQ-1; Sat, 23 Jan 2021 21:05:44 -0500
X-MC-Unique: fh6r8fQLMiW2jwocOhevgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1567D801817;
        Sun, 24 Jan 2021 02:05:43 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-112-57.rdu2.redhat.com [10.10.112.57])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4CF905C260;
        Sun, 24 Jan 2021 02:05:42 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 479003C00CE; Sat, 23 Jan 2021 23:05:40 -0300 (-03)
Date:   Sat, 23 Jan 2021 23:05:40 -0300
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
Subject: [ANNOUNCE] 4.9.253-rt168
Message-ID: <20210124020540.GA83189@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.253-rt168 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 39c70c2a2244ca70ab61d2442b3c4136ed40d8ee

Or to build 4.9.253-rt168 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.253.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.253-rt168.patch.xz

Enjoy!
Luis

