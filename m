From: Brian Silverman <brian@peloton-tech.com>
Subject: Re: RT File Logging
Date: Mon, 3 Oct 2016 14:44:17 -0400
Message-ID: <CAGt3f4kxtzLbby_XBAVPP+RVcqNCNkBy0ybHxzOi0M5rguNwSQ@mail.gmail.com>
References: <CAHDbYRiH04GpceLOtboR3QAF9OrYbGLMUgi-f7x6jneqzqbnAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Sabar Siddhartha Dasgupta <sabard@stanford.edu>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:35536 "EHLO
        mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbcJCSot (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2016 14:44:49 -0400
Received: by mail-qk0-f180.google.com with SMTP id t7so171654278qkh.2
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Oct 2016 11:44:48 -0700 (PDT)
In-Reply-To: <CAHDbYRiH04GpceLOtboR3QAF9OrYbGLMUgi-f7x6jneqzqbnAQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Have you looked for any internal locks sqlite3 is using? Keeping in
mind I have no experience with that library whatsoever, it sounds like
you may be running into sqlite3async_run holding a lock while it does
IO, which causes sqlite3_step to block waiting for it to finish. Even
if the disk IO thread doesn't do much with the lock held, you could be
running into priority inversion
(https://en.wikipedia.org/wiki/Priority_inversion has a description
and some solutions).

You might have less problems if you split anything realtime (like
reading your data from shared memory) and all the sqlite3 things out
into separate processes. Pipes and POSIX shared memory queues should
work.

If you're still having problems, it might be worth asking sqlite3
people. Specifically, how they do locking etc sounds relevant.

Best of luck,
Brian
