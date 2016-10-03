From: Austin Schuh <austin@peloton-tech.com>
Subject: Re: RT File Logging
Date: Mon, 3 Oct 2016 11:02:30 -0700
Message-ID: <CANGgnMa7eKQXGy4ssxD5COu8V_1+-haF6KZHw13Wi-VwLgQ92g@mail.gmail.com>
References: <CAHDbYRiH04GpceLOtboR3QAF9OrYbGLMUgi-f7x6jneqzqbnAQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Sabar Siddhartha Dasgupta <sabard@stanford.edu>,
        rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-yb0-f170.google.com ([209.85.213.170]:33292 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbcJCSCv (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 3 Oct 2016 14:02:51 -0400
Received: by mail-yb0-f170.google.com with SMTP id v83so51395579ybv.0
        for <linux-rt-users@vger.kernel.org>; Mon, 03 Oct 2016 11:02:51 -0700 (PDT)
In-Reply-To: <CAHDbYRiH04GpceLOtboR3QAF9OrYbGLMUgi-f7x6jneqzqbnAQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Sep 30, 2016 at 5:21 PM Sabar Siddhartha Dasgupta
<sabard@stanford.edu> wrote:
>
> Hi all,
>
> I am working with the 4.4.12-rt19 kernel patch.
>
> I have a realtime application that has separate processes running on
> separate cores taking in data from the network, computing on that
> data, and then logging results. I am attempting to log on the order of
> 10KB per ms tick of data to file.
>
> The logging process has access to all of the incoming data in shared
> memory. Right now, I am using sqlite3 and sqlite3async to buffer the
> database to memory in one thread of the logging process and then
> commit the in-memory instance to file every second with a call to
> sqlite3async_run().
>
> The problem is that during part of the sqlite3async_run() execution,
> the sqlite3_step() command to write to the in-memory database buffer
> hangs and violates my 1ms timing guarantee.
>
> This question may not be relevant here, but I am still not sure if the
> error is happening because of how threaded processes work in a
> realtime environment or because of how sqlite3async works. As far as I
> can tell, sqlite3async is supposed to be able to buffer the database
> in memory using the sqlite3 virtual file system and then handle the
> actual file write with a background thread (as detailed here:
> https://www.sqlite.org/asyncvfs.html). I have tried changing the
> scheduling priorities and nicenesses of each thread to no avail.
>
> Any help or suggestions would be greatly appreciated! (or direction to
> the right forum if this is not the right place).
>
> Best,
> Sabar


We've seen cases where disk IO ties up the interrupt line and causes
latency.  Your application might also be lower priority than the IRQ
for the disk.  My best advice for debugging latency events is to use
the kernel tracers to figure out what is happening when you have an
issue.  Unfortunately, it is a big hammer.  It takes a lot of work to
understand what is in the resulting logs, and enabling tracing can
cause other issues, but it lets you actually observe what is
happening.

Good luck!
Austin
