From: Brian Wrenn <dcbrianw@gmail.com>
Subject: Re: How to write RT applications ?
Date: Wed, 22 Mar 2017 09:10:03 -0400
Message-ID: <CAEYdEeSChwWd208jLPz+qyiSHHMnnq08q-2mNVEQBU2EL4OYzQ@mail.gmail.com>
References: <CAJ2oMhJp-uBxxj7tyPHM2M9cFnjhus4ORYYfFgNywaMFXS4Q9Q@mail.gmail.com>
 <20170317201741.bwwycyl5ggbpjksw@linutronix.de> <CAEYdEeR=04qszshTum6mbCwj_H53uLwwgbE4YDnDh1hHYqP7UQ@mail.gmail.com>
 <20170321201702.GF10423@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ran Shalit <ranshalit@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:32784 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933720AbdCVNKE (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Mar 2017 09:10:04 -0400
Received: by mail-io0-f173.google.com with SMTP id f84so65088031ioj.0
        for <linux-rt-users@vger.kernel.org>; Wed, 22 Mar 2017 06:10:04 -0700 (PDT)
In-Reply-To: <20170321201702.GF10423@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi Julia (and anyone else following),

I was looking at that exact page yesterday.  W.r.t. the sample code on
the wiki, I'd need to address five function calls.  Here's what I
found.

// ::boost::thread provides it's own ::boost::thread::attributes, but
it's not as
// comprehensive, i.e. only includes stack size.  ::std::thread at
this point aims to
// be cross platform and hence doesn't.
// Finding: ::boost::thread==>kinda, ::std::thread==>no
pthread_attr_init(&attr);

// Can apply to ::boost::thread via ::boost::thread::attributes, but
not ::std::thread.
// Finding: same as previous
pthread_attr_setstack(&attr, stack_buf, PTHREAD_STACK_MIN);

// Can only apply at the attribute level prior to creating, at least
with the pthread
// API I have for arm64, a therefore not via native_handle().
// Finding: ::boost::thread==>no, ::std::thread==>no
pthread_attr_setschedpolicy(&attr, SCHED_FIFO);

// Can apply via native_handle().
// Finding: ::boost::thread==>yes, ::std::thread==>yes
pthread_attr_setschedparam(&attr, &param);

// Can only apply at the attribute level and not via native_handle().
// Finding: ::boost::thread==>no, ::std::thread==>no
pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);

If there's some way to use pthread_self() to address the calls that
can't work on native_handle(), I haven't found it yet.

Alternatively, if I were to use sched_setscheduler() instead of
pthread attributes, that eliminates three of the above, which means
one could conceivably use ::boost::thread and
::boost::thread::attributes to set the stacksize, but to cross compile
the boost libraries, as I'd need to link against boost_system.so/a, it
may not be worth the effort over just using pthreads.


On Tue, Mar 21, 2017 at 4:17 PM, Julia Cartwright <julia@ni.com> wrote:
> On Tue, Mar 21, 2017 at 01:08:40PM -0400, Brian Wrenn wrote:
>> I've tried to find a way to use ::std::thread or ::boost::thread to
>> accomplish what the article for creating a simple RT application with
>> pthreads does, but unfortunately I don't think those two OOP
>> approaches provide enough attribute configuration to suffice.  Has
>> anyone else found otherwise?
>
> There is a defined member function for the std::thread type,
> native_thread() which will return the underlying native thread type,
> which, if you're using gcc/glibc is most likely the pthread_t.
>
> Alternatively, the thread can adjust its own scheduling properties using
> pthread_self().
>
> See: http://en.cppreference.com/w/cpp/thread/thread/native_handle
>
> For an example.
>
>    Julia
