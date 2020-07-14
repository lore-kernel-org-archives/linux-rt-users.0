Return-Path: <SRS0=fwOa=AZ=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0924BC433E1
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 16:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9ABF2255F
	for <linux-rt-users@archiver.kernel.org>; Tue, 14 Jul 2020 16:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594745902;
	bh=vCNTULi6O+1BLjxJ2PVfqm+Hj9JXikuIYiaXPY+f9wc=;
	h=Subject:From:To:Date:List-ID:From;
	b=gJ7DDihkzUfyAEGkIIzNl2YLoFCmD9w4qa+ODLl1/K04LVQCd6DpxAz6kRwBtoF0z
	 PRBFCDF2SBdEaEEvkbFOBUUYi2pE1wUwMj7IU+vJrk9W4n+vqdGdXGsHnqfb3IWZqK
	 06o5pA68oxsioBsyCJhbJMpzkwE0bAQQI5PqDFhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGNQ6T (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 14 Jul 2020 12:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbgGNQ6T (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 14 Jul 2020 12:58:19 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24ADD22571;
        Tue, 14 Jul 2020 16:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594745899;
        bh=vCNTULi6O+1BLjxJ2PVfqm+Hj9JXikuIYiaXPY+f9wc=;
        h=Subject:From:To:Date:From;
        b=sYMSRaDTcAgM0oAGCodUPAkDHDoErHGIztFelNcN1+llcuGxDKdx9Qo2yncyQGJgI
         zPSVDKGViTRyqnC9J96WBOT2xWj6yLw+91rcdQtCJzR/BUwT6pKGeqBHMy9B8UTMkX
         85yZpN5GSD5d8cGmqa487avUEASAjv/6CK8OmESY=
Message-ID: <82932b48972f38fccf9920e2ec75b555c2b2494a.camel@kernel.org>
Subject: [ANNOUNCE] 4.19.132-rt59
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Clark Williams <williams@redhat.com>,
        Pavel Machek <pavel@denx.de>, Tom Zanussi <zanussi@kernel.org>
Date:   Tue, 14 Jul 2020 11:58:17 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.19.132-rt59 stable release.

This release is just an update to the new stable 4.19.132
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.19-rt
  Head SHA1: 1eebf4069aa37e54330cce9a42608517ea6996fe

Or to build 4.19.132-rt59 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.19.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.19.132.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.19/patch-4.19.132-rt59.patch.xz

Enjoy!

   Tom

