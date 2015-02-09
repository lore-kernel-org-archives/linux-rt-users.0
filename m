From: Gustavo Bittencourt <gbitten@gmail.com>
Subject: Doubt about v3.14-rt-rebase commits
Date: Mon, 9 Feb 2015 21:52:21 -0200
Message-ID: <CAA8Xd+8CxjOFo_SLPfgAnrC7fo-kLxzamTkiOZPTkLVSX1zh7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53880 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbbBIXwW (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 9 Feb 2015 18:52:22 -0500
Received: by mail-ob0-f174.google.com with SMTP id wo20so28275431obc.5
        for <linux-rt-users@vger.kernel.org>; Mon, 09 Feb 2015 15:52:21 -0800 (PST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

This is probably a silly question. I noticed that the below commits
revert each other. Is any reason to maintain those commits in recent
releases?

commit: migrate_disable pushd down in atomic_dec_and_spin_lock
9056f04da7fd3bd39d5bc05cb42cf9d0f5b7b98c
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.14-rt-rebase&id=9056f04da7fd3bd39d5bc05cb42cf9d0f5b7b98c

commit: Revert "migrate_disable pushd down in atomic_dec_and_spin_lock"
2137b9fff666c62077c7ae35e865eec86da0a499
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-stable-rt.git/commit/?h=v3.14-rt-rebase&id=2137b9fff666c62077c7ae35e865eec86da0a499
