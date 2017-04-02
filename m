From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: How to write RT applications ?
Date: Sun, 2 Apr 2017 16:08:07 +0300
Message-ID: <CAJ2oMhJr_YV4ZHUWQ1VRfyXePhR6gqEx+cgr-XFD7bpPkR0Rcg@mail.gmail.com>
References: <CAJ2oMhJp-uBxxj7tyPHM2M9cFnjhus4ORYYfFgNywaMFXS4Q9Q@mail.gmail.com>
 <20170317201741.bwwycyl5ggbpjksw@linutronix.de> <CAEYdEeR=04qszshTum6mbCwj_H53uLwwgbE4YDnDh1hHYqP7UQ@mail.gmail.com>
 <20170321201702.GF10423@jcartwri.amer.corp.natinst.com> <CAEYdEeSChwWd208jLPz+qyiSHHMnnq08q-2mNVEQBU2EL4OYzQ@mail.gmail.com>
 <20170329163757.hwef6nnhbcoulnqq@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Cc: Brian Wrenn <dcbrianw@gmail.com>, Julia Cartwright <julia@ni.com>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-wr0-f181.google.com ([209.85.128.181]:35111 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbdDBNIP (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 2 Apr 2017 09:08:15 -0400
Received: by mail-wr0-f181.google.com with SMTP id k6so129283973wre.2
        for <linux-rt-users@vger.kernel.org>; Sun, 02 Apr 2017 06:08:14 -0700 (PDT)
In-Reply-To: <20170329163757.hwef6nnhbcoulnqq@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Wed, Mar 29, 2017 at 7:37 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-03-22 09:10:03 [-0400], Brian Wrenn wrote:
>> Hi Julia (and anyone else following),
>>
>> I was looking at that exact page yesterday.  W.r.t. the sample code on
>> the wiki, I'd need to address five function calls.  Here's what I
>> found.
>>
>> // ::boost::thread provides it's own ::boost::thread::attributes, but
>> it's not as
>> // comprehensive, i.e. only includes stack size.  ::std::thread at
>> this point aims to
>> // be cross platform and hence doesn't.
>
> pthread_attr_setstack() is defined in POSIX so depending on how cross
> platform you aim to be, it could be adde=E2=80=A6
>
>> // Finding: ::boost::thread=3D=3D>kinda, ::std::thread=3D=3D>no
>> pthread_attr_init(&attr);
>>
>> // Can apply to ::boost::thread via ::boost::thread::attributes, but
>> not ::std::thread.
>> // Finding: same as previous
>> pthread_attr_setstack(&attr, stack_buf, PTHREAD_STACK_MIN);
>>
>> // Can only apply at the attribute level prior to creating, at least
>> with the pthread
>> // API I have for arm64, a therefore not via native_handle().
>> // Finding: ::boost::thread=3D=3D>no, ::std::thread=3D=3D>no
>> pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
>>
>> // Can apply via native_handle().
>> // Finding: ::boost::thread=3D=3D>yes, ::std::thread=3D=3D>yes
>> pthread_attr_setschedparam(&attr, &param);
>>
>> // Can only apply at the attribute level and not via native_handle().
>> // Finding: ::boost::thread=3D=3D>no, ::std::thread=3D=3D>no
>> pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
>>
>> If there's some way to use pthread_self() to address the calls that
>> can't work on native_handle(), I haven't found it yet.
>>
>> Alternatively, if I were to use sched_setscheduler() instead of
>> pthread attributes, that eliminates three of the above, which means
>> one could conceivably use ::boost::thread and
>> ::boost::thread::attributes to set the stacksize, but to cross compile
>> the boost libraries, as I'd need to link against boost_system.so/a, it
>> may not be worth the effort over just using pthreads.
>
> So if you I get you right, you can't use std::thread or boost because
> each one lacks some support you want to have. The best thing you get is
> boost which lacks a wrapper around pthread_setschedparam(), is that so?
> Because from google most people suggest to use
>         pthread_setschedparam(tread.native_handle, &param);
>
> and if that is the case, you could ask the boost folks to get native
> support for it, since this is posix.
>
> Sebastian

I would please like to ask the following:
usually when using uio drivers, we use mmap in the user application
for mapping the shared memory (for example for pci memory).
Should we also use the advise in
https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/=
application_base
for "Stack prefaulting:

Since page faults cause non-deterministic behavior, the stack should
be prefaulted before the real-time critical section starts. In case
several real-time threads are used, it should be done for each thread
individually. In the following example, a memory block of a certain
size is allocated. All of its pages are touched to get them mapped
into RAM ensuring that no page faults occur later.

buffer =3D mmap(NULL, MSIZE, PROT_READ | PROT_WRITE,
              MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);

memset(&buffer, 0, MSIZE);"

Does it mean that in such case we also better "Stack prefaulting" with
memset ,for example ?

I think that this case is not relevant (because the memory is mapped
to device - and is not mapped to a file in flash), but since I'm not
absolutely sure - I better ask the question...

Thank you,
Ran
