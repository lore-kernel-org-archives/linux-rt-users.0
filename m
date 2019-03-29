Return-Path: <SRS0=qNRq=SA=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA17C43381
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Mar 2019 10:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF90206B8
	for <linux-rt-users@archiver.kernel.org>; Fri, 29 Mar 2019 10:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfC2KaM (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 29 Mar 2019 06:30:12 -0400
Received: from mail.monom.org ([188.138.9.77]:49880 "EHLO mail.monom.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728550AbfC2KaM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 29 Mar 2019 06:30:12 -0400
X-Greylist: delayed 455 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Mar 2019 06:30:11 EDT
Received: from mail.monom.org (localhost [127.0.0.1])
        by filter.mynetwork.local (Postfix) with ESMTP id 14872500722;
        Fri, 29 Mar 2019 11:22:35 +0100 (CET)
Received: from localhost (ppp-93-104-175-44.dynamic.mnet-online.de [93.104.175.44])
        by mail.monom.org (Postfix) with ESMTPSA id 7256B5005DA;
        Fri, 29 Mar 2019 11:22:34 +0100 (CET)
Date:   Fri, 29 Mar 2019 11:22:33 +0100
From:   Daniel Wagner <wagi@monom.org>
Subject: [ANNOUNCE] 4.4.177-rt179
Data:   Fri, 29 Mar 2019 10:19:48 -0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Julia Cartwright <julia@ni.com>
Message-Id: <20190329102235.14872500722@mail.monom.org>
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.4.177-rt179 stable release.

This release is just an update to the new stable 4.4.177 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.4-rt
  Head SHA1: 4dedf3b6419c67c249ead4396cf834b8abaf10a3

Or to build 4.4.177-rt179 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.4.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.4.177.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/patch-4.4.177-rt179.patch.xz


You can also build from 4.4.174-rt178 by applying the incremental patch:

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.4/4.4/incr/patch-4.4.174-rt178-rt179.patch.xz

Enjoy!
   Daniel
