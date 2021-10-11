Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBB8C433F5
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 12:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA31660F57
	for <linux-rt-users@archiver.kernel.org>; Mon, 11 Oct 2021 12:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbhJKMiq (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 11 Oct 2021 08:38:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35657 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236667AbhJKMip (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 11 Oct 2021 08:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633955805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=UhoDjtVs91AeOEtNbkRqqIG1MWI1FQFYVYnkbzkEOx8=;
        b=PHK5080Oj2czHSmJOeL2JpNoeA64qFsG14JliE3aj/GUvkGDL/PrSQ9OwonFKURgp61lPB
        mbYB20Q2p+0R8MCK/LWDqEJOA336gMmAS0MkqUS/M/RNkOzxZ7XmbBbuT/uzGaMerC/Hym
        0ZvfLI4GVqZ0jqVIMpVW1jgxqNo6l+0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-fIxn8nW4PhmsWJHbZRNO8g-1; Mon, 11 Oct 2021 08:36:42 -0400
X-MC-Unique: fIxn8nW4PhmsWJHbZRNO8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 139E2EC1A5;
        Mon, 11 Oct 2021 12:36:41 +0000 (UTC)
Received: from lclaudio.dyndns.org (unknown [10.22.35.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6568819E7E;
        Mon, 11 Oct 2021 12:36:40 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id 831063C0205; Mon, 11 Oct 2021 09:36:38 -0300 (-03)
Date:   Mon, 11 Oct 2021 09:36:38 -0300
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
Subject: [ANNOUNCE] 4.9.286-rt189
Message-ID: <YWQv1ue+fucyQFYC@uudg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.286-rt189 stable release.

This release is just an update to the new stable 4.9.286 version and
no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: 73474e89c88797e9cfdf86f744addbfc32a74b9c

Or to build 4.9.286-rt189 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.286.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.286-rt189.patch.xz


Enjoy!
Luis

