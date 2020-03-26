Return-Path: <SRS0=WgF6=5L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B888C43331
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Mar 2020 20:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5CF2070A
	for <linux-rt-users@archiver.kernel.org>; Thu, 26 Mar 2020 20:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585256210;
	bh=iiSdTqkLDRwK7LvruCCeWue1ynuARz02GYEhyA4VgFU=;
	h=Subject:From:To:Date:List-ID:From;
	b=WUwBzDPlRty7WefZk8tSobTMwS27Oj0vUlm2zTLXLl0xRfdc0LQENtFmlQvIP5rWG
	 +AZ/QGz4Tvu+FLE04ybqoeZPq/M51g4c4BlzGfxJ/w81Px4w3hxUdkNoEtVE2TN2SM
	 ZNz6mc7JHJA/AEUkY13jy8fqa77Ur4lRLGdcYkss=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgCZU4p (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgCZU4p (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 26 Mar 2020 16:56:45 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51ADD20722;
        Thu, 26 Mar 2020 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585256205;
        bh=iiSdTqkLDRwK7LvruCCeWue1ynuARz02GYEhyA4VgFU=;
        h=Subject:From:To:Date:From;
        b=OTk5eiK1JUQJhNTQUIz6M5fMaeBclE7EI2irNPU9LcqX1Sa6dGe8o4gY7zOzzZ3xb
         6ePVUl1W+nX32Nvo3h701tCET6f7IKfum+OyQuH3jQDKCYbAa8NtYN6qttzJw/QKpE
         d/1TnKRgm5/hj1FNk0N65pLmKKS7uAhVyBYdX6bE=
Message-ID: <91b23f5a400f433a262a54716a39c3489e2bde23.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.174-rt79
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>
Date:   Thu, 26 Mar 2020 15:56:43 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.174-rt79 stable release.

This release is just an update to the new stable 4.14.174
version and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: 6345c1bdf52c25e579c9804e8410d75b1c618b2e

Or to build 4.14.174-rt79 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  https://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.174.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.174-rt79.patch.xz

Enjoy!

   Tom

