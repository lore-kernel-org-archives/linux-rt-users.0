From: Sabar Siddhartha Dasgupta <sabard@stanford.edu>
Subject: Re: RT File Logging
Date: Fri, 7 Oct 2016 00:08:20 -0700
Message-ID: <CAHDbYRiCRqaHgN9oYLemS3Jjg9ZPR4HrS7RXPQGvbeM+Rv7r4A@mail.gmail.com>
References: <CAHDbYRiH04GpceLOtboR3QAF9OrYbGLMUgi-f7x6jneqzqbnAQ@mail.gmail.com>
 <CAGt3f4kxtzLbby_XBAVPP+RVcqNCNkBy0ybHxzOi0M5rguNwSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: rt-users <linux-rt-users@vger.kernel.org>
To: Brian Silverman <brian@peloton-tech.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.stanford.edu ([171.67.219.82]:43835 "EHLO
        smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754233AbcJGHIn (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 Oct 2016 03:08:43 -0400
Received: from codegreen1.stanford.edu (codegreen1.stanford.edu [171.67.224.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 2431C341964
        for <linux-rt-users@vger.kernel.org>; Fri,  7 Oct 2016 00:08:43 -0700 (PDT)
Received: from codegreen1.stanford.edu (localhost.localdomain [127.0.0.1])
        by codegreen1.stanford.edu (Postfix) with ESMTP id 0C48381
        for <linux-rt-users@vger.kernel.org>; Fri,  7 Oct 2016 00:08:43 -0700 (PDT)
Received: from pps00-smtp.stanford.edu (pps00-smtp.stanford.edu [171.67.214.166])
        by codegreen1.stanford.edu (Postfix) with ESMTP id E98B281
        for <linux-rt-users@vger.kernel.org>; Fri,  7 Oct 2016 00:08:42 -0700 (PDT)
Received: from pps.filterd (pps00-smtp.stanford.edu [127.0.0.1])
        by pps00-smtp.stanford.edu (8.15.0.59/8.15.0.59) with SMTP id u976xqcx032297
        for <linux-rt-users@vger.kernel.org>; Fri, 7 Oct 2016 00:08:42 -0700
Received: from smtp.stanford.edu (smtp2.stanford.edu [171.67.219.82])
        by pps00-smtp.stanford.edu with ESMTP id 25uy8afrw6-1
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Oct 2016 00:08:42 -0700
Received: from mail-wm0-f69.google.com (mail-wm0-f69.google.com [74.125.82.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 83934341964
        for <linux-rt-users@vger.kernel.org>; Fri,  7 Oct 2016 00:08:42 -0700 (PDT)
Received: by mail-wm0-f69.google.com with SMTP id 74so4649961wma.6
        for <linux-rt-users@vger.kernel.org>; Fri, 07 Oct 2016 00:08:42 -0700 (PDT)
In-Reply-To: <CAGt3f4kxtzLbby_XBAVPP+RVcqNCNkBy0ybHxzOi0M5rguNwSQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thank you for the help!

It ended up being a problem with sqlite3's journaling system waiting
for the writer to unlock the OS buffers before creating a rollback
file. Changing the journal configuration to stay in memory rather than
disk made the journaling way faster and fixed the problem.

I will keep the potential priority problems in mind for the future!

Thanks again,
Sabar

On Mon, Oct 3, 2016 at 11:44 AM, Brian Silverman <brian@peloton-tech.com> wrote:
> Have you looked for any internal locks sqlite3 is using? Keeping in
> mind I have no experience with that library whatsoever, it sounds like
> you may be running into sqlite3async_run holding a lock while it does
> IO, which causes sqlite3_step to block waiting for it to finish. Even
> if the disk IO thread doesn't do much with the lock held, you could be
> running into priority inversion
> (https://en.wikipedia.org/wiki/Priority_inversion has a description
> and some solutions).
>
> You might have less problems if you split anything realtime (like
> reading your data from shared memory) and all the sqlite3 things out
> into separate processes. Pipes and POSIX shared memory queues should
> work.
>
> If you're still having problems, it might be worth asking sqlite3
> people. Specifically, how they do locking etc sounds relevant.
>
> Best of luck,
> Brian

