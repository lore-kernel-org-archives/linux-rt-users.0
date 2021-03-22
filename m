Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC82C433C1
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 04:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A024461969
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Mar 2021 04:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhCVEOy (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 22 Mar 2021 00:14:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57516 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229455AbhCVEOa (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 22 Mar 2021 00:14:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616386470;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=a4v4LZd/KuNB4nVBOBAV0fJoffXp/cjO8///uHfP+rY=;
        b=e65cgInzjXayAgophjEVWVUy8cWZMeZKTDsSeMEzo77I7p+RbMAxO/tglimu7vo8arhm90
        KM9Uhas1QX1thyPHLCsWeL0J/NQkHQ6EyoI58dkD9tpaVyracoPpKRzqEi+3Q/m4GTF4HB
        ZznfDGGP8gIkLhXjkcUsjTHuhdgx6DA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-Tr9bnYNBMRihkF_mIxSP9A-1; Mon, 22 Mar 2021 00:14:25 -0400
X-MC-Unique: Tr9bnYNBMRihkF_mIxSP9A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BCFE1084C95;
        Mon, 22 Mar 2021 04:14:24 +0000 (UTC)
Received: from lclaudio.dyndns.org (ovpn-117-44.rdu2.redhat.com [10.10.117.44])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 758F6100AE42;
        Mon, 22 Mar 2021 04:14:23 +0000 (UTC)
Received: by lclaudio.dyndns.org (Postfix, from userid 1000)
        id A7BEC3C1752; Mon, 22 Mar 2021 01:14:21 -0300 (-03)
Date:   Mon, 22 Mar 2021 01:14:21 -0300
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
Subject: [ANNOUNCE] 4.9.260-rt174
Message-ID: <161638639759.450582.3060675159400489865@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT-list!

I'm pleased to announce the 4.9.260-rt174 stable release.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.9-rt
  Head SHA1: a1ce8735f60285bcf3df3ab01e1ea2588e90c540

Or to build 4.9.260-rt174 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.9.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.9.260.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.9/patch-4.9.260-rt174.patch.xz

Enjoy!
Luis

