Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873FC433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 12:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2309D60F3A
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 12:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236583AbhJKMbh (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38580 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234635AbhJKMbh (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 08:31:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633955376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=MnnH04LseEOTDWOFIZGCLGe2qMg40d5uyHxJj7UajE8=;
        b=Of97LIZC2wUjfuJx6Egw6kZTwIVBFnkpkYbdNkacQ4WwucwIeGNSyW6r3aS5X0YbhDfKnW
        9+ecrH5WUmlWb1/XAgecNwyzik3L4ulXWDCCo9SF4qyJATwLUqa7yesqHYQxkgLVtdou6i
        XykROKdHrzCX2gpCF64o58KUtNbluQA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-FbJKiNTpN1my6uqCyi773g-1; Mon, 11 Oct 2021 08:29:35 -0400
X-MC-Unique: FbJKiNTpN1my6uqCyi773g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0C7583DBC0;
        Mon, 11 Oct 2021 12:29:33 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.35.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A00BE78834;
        Mon, 11 Oct 2021 12:29:32 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id D80553C0205; Mon, 11 Oct 2021 09:29:30 -0300 (-03)
Date:   Mon, 11 Oct 2021 09:29:30 -0300
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
Subject: [ANNOUNCE] 4.14.250-rt124
Message-ID: <YWQuKvhgXKsR0NBX@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.14.250-rt124 stable release.

This release is just an update to the new stable 4.14.250 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: c7e639ababd959132336f0d89552faf4c0f4ecfc

Or to build 4.14.250-rt124 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.250.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.250-rt124.patch.xz


Enjoy!
Luis

