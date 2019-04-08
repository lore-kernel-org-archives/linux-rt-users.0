Return-Path: <SRS0=BA5Y=SK=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D7CC10F14
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:03:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F52087F
	for <linux-rt-users@archiver.kernel.org>; Mon,  8 Apr 2019 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554750216;
	bh=UkqNorKRQPH1nDpdjaCWL8GwkYVykr469BBQHKxxL1U=;
	h=Subject:From:To:Cc:Date:List-ID:From;
	b=cDOW5kQLopxFGjNjtgdLrUmpaaRNB9RueQQRNCXVp/N3JD6EyJbkmsTGLC31HMS1p
	 niItLh3pVUgGX4M0O5vXkZtn9QMdTw//ZzDWTJ2B3W2ppjlnNlmNxmkQaIKKM0sVzy
	 fBQ1n0zvYKihNZc2Byerxmmmtq8OmaJdi10CukaI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbfDHTDb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 8 Apr 2019 15:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:39858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726630AbfDHTDb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 8 Apr 2019 15:03:31 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 440B220879;
        Mon,  8 Apr 2019 19:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554750211;
        bh=UkqNorKRQPH1nDpdjaCWL8GwkYVykr469BBQHKxxL1U=;
        h=Subject:From:To:Cc:Date:From;
        b=sJpYjBJnWo0tHJ0robJo6pn44nNnKTzzgZZADxO8ASALl5BRMNRW9psSeh8uiOOql
         /ZQJ05bUIqUXNJoaWDIU7syYN8dablz8eAfK1ibPYgybeMVjvSIEYyUOtOOLqL2GKQ
         VL0V0jlqJcu1xUsSIuZz1EGfpLEr3Q6nsaueKIHo=
Message-ID: <1554750209.12566.9.camel@kernel.org>
Subject: [ANNOUNCE] 4.14.109-rt57
From:   Tom Zanussi <zanussi@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Wagner <daniel.wagner@siemens.com>,
        Julia Cartwright <julia@ni.com>
Date:   Mon, 08 Apr 2019 14:03:29 -0500
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello RT Folks!

I'm pleased to announce the 4.14.109-rt57 stable release.

This release is just an update to the new stable 4.14.109 version
and no RT specific changes have been made.

You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v4.14-rt
  Head SHA1: ca1191c8c3aa1529752e6f58b826e6433226fbef

Or to build 4.14.109-rt57 directly, the following patches should be applied:

  http://www.kernel.org/pub/linux/kernel/v4.x/linux-4.14.tar.xz

  http://www.kernel.org/pub/linux/kernel/v4.x/patch-4.14.109.xz

  http://www.kernel.org/pub/linux/kernel/projects/rt/4.14/patch-4.14.109-rt57.patch.xz


Enjoy!
   
   Tom
