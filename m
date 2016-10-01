From: Sabar Siddhartha Dasgupta <sabard@stanford.edu>
Subject: RT File Logging
Date: Fri, 30 Sep 2016 17:20:29 -0700
Message-ID: <CAHDbYRiH04GpceLOtboR3QAF9OrYbGLMUgi-f7x6jneqzqbnAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtp2.stanford.edu ([171.67.219.82]:33900 "EHLO
        smtp.stanford.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752720AbcJAAVL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 30 Sep 2016 20:21:11 -0400
Received: from codegreen1.stanford.edu (codegreen1.stanford.edu [171.67.224.2])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id 9A089340D86
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:52 -0700 (PDT)
Received: from codegreen1.stanford.edu (localhost.localdomain [127.0.0.1])
        by codegreen1.stanford.edu (Postfix) with ESMTP id 8299381
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:52 -0700 (PDT)
Received: from pps00-smtp.stanford.edu (pps00-smtp.stanford.edu [171.67.214.166])
        by codegreen1.stanford.edu (Postfix) with ESMTP id 6C7B781
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:52 -0700 (PDT)
Received: from pps.filterd (pps00-smtp.stanford.edu [127.0.0.1])
        by pps00-smtp.stanford.edu (8.15.0.59/8.15.0.59) with SMTP id u910JjO1021117
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:52 -0700
Received: from smtp.stanford.edu (smtp3.stanford.edu [171.67.219.83])
        by pps00-smtp.stanford.edu with ESMTP id 25sapjncjd-1
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:52 -0700
Received: from mail-wm0-f69.google.com (mail-wm0-f69.google.com [74.125.82.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp.stanford.edu (Postfix) with ESMTPS id E5C9310160C
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:51 -0700 (PDT)
Received: by mail-wm0-f69.google.com with SMTP id f193so6472348wmg.0
        for <linux-rt-users@vger.kernel.org>; Fri, 30 Sep 2016 17:20:51 -0700 (PDT)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi all,

I am working with the 4.4.12-rt19 kernel patch.

I have a realtime application that has separate processes running on
separate cores taking in data from the network, computing on that
data, and then logging results. I am attempting to log on the order of
10KB per ms tick of data to file.

The logging process has access to all of the incoming data in shared
memory. Right now, I am using sqlite3 and sqlite3async to buffer the
database to memory in one thread of the logging process and then
commit the in-memory instance to file every second with a call to
sqlite3async_run().

The problem is that during part of the sqlite3async_run() execution,
the sqlite3_step() command to write to the in-memory database buffer
hangs and violates my 1ms timing guarantee.

This question may not be relevant here, but I am still not sure if the
error is happening because of how threaded processes work in a
realtime environment or because of how sqlite3async works. As far as I
can tell, sqlite3async is supposed to be able to buffer the database
in memory using the sqlite3 virtual file system and then handle the
actual file write with a background thread (as detailed here:
https://www.sqlite.org/asyncvfs.html). I have tried changing the
scheduling priorities and nicenesses of each thread to no avail.

Any help or suggestions would be greatly appreciated! (or direction to
the right forum if this is not the right place).

Best,
Sabar

