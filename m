Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-qk0-f181.google.com ([209.85.220.181]:34268 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750879AbeFDTvC (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 4 Jun 2018 15:51:02 -0400
Received: by mail-qk0-f181.google.com with SMTP id q70-v6so17085705qke.1
        for <linux-rt-users@vger.kernel.org>; Mon, 04 Jun 2018 12:51:02 -0700 (PDT)
MIME-Version: 1.0
From: Ran Shalit <ranshalit@gmail.com>
Date: Mon, 4 Jun 2018 22:51:00 +0300
Message-ID: <CAJ2oMhLfhVMPS1L-kknW_Kb4t=P81KCAhqPz6rL89scsqh4yiw@mail.gmail.com>
Subject: ostream::flush in RT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: linux-rt-users <linux-rt-users@vger.kernel.org>

Hello,

I currently use Linux without rt patch, yet we have some timing
requirements, and we consider moving to RT linux.

We tried to measure time in threads, in order to build a better rt application.

I hope I can ask a question about one issue, which we are not sure about:

We have a thread which does:
...
 <-- start time measurement
{
osteam::write
ostream::flush
.}
<-- end time measurement
...

It seems that in general, the write to disk using these functions add
time for the thread between entrace to main function of thread.

But  the time difference of these two commands behaves strangely: we
see that in of the measurements it's 10msec,  and only once in a while
it gets up to 500msec.

So, I am not sure why it only sometimes consumes more time then the average.
Is it that there is some kernel thread responsible for disk which only
sometimes consumes more time ?

I would assume that the flush should always consume the time for write
to disk, is it wrong to assume so ? we always write the same size, so
why is the average different then the maximum ?

Will it help to put it in another RT thread with lower priority ?

Thank you.
ranran
