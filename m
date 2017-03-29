From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: How to write RT applications ?
Date: Wed, 29 Mar 2017 18:37:58 +0200
Message-ID: <20170329163757.hwef6nnhbcoulnqq@linutronix.de>
References: <CAJ2oMhJp-uBxxj7tyPHM2M9cFnjhus4ORYYfFgNywaMFXS4Q9Q@mail.gmail.com>
 <20170317201741.bwwycyl5ggbpjksw@linutronix.de>
 <CAEYdEeR=04qszshTum6mbCwj_H53uLwwgbE4YDnDh1hHYqP7UQ@mail.gmail.com>
 <20170321201702.GF10423@jcartwri.amer.corp.natinst.com>
 <CAEYdEeSChwWd208jLPz+qyiSHHMnnq08q-2mNVEQBU2EL4OYzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: Julia Cartwright <julia@ni.com>, Ran Shalit <ranshalit@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Brian Wrenn <dcbrianw@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:58986 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdC2QiD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 29 Mar 2017 12:38:03 -0400
Content-Disposition: inline
In-Reply-To: <CAEYdEeSChwWd208jLPz+qyiSHHMnnq08q-2mNVEQBU2EL4OYzQ@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2017-03-22 09:10:03 [-0400], Brian Wrenn wrote:
> Hi Julia (and anyone else following),
> 
> I was looking at that exact page yesterday.  W.r.t. the sample code on
> the wiki, I'd need to address five function calls.  Here's what I
> found.
> 
> // ::boost::thread provides it's own ::boost::thread::attributes, but
> it's not as
> // comprehensive, i.e. only includes stack size.  ::std::thread at
> this point aims to
> // be cross platform and hence doesn't.

pthread_attr_setstack() is defined in POSIX so depending on how cross
platform you aim to be, it could be adde…

> // Finding: ::boost::thread==>kinda, ::std::thread==>no
> pthread_attr_init(&attr);
> 
> // Can apply to ::boost::thread via ::boost::thread::attributes, but
> not ::std::thread.
> // Finding: same as previous
> pthread_attr_setstack(&attr, stack_buf, PTHREAD_STACK_MIN);
> 
> // Can only apply at the attribute level prior to creating, at least
> with the pthread
> // API I have for arm64, a therefore not via native_handle().
> // Finding: ::boost::thread==>no, ::std::thread==>no
> pthread_attr_setschedpolicy(&attr, SCHED_FIFO);
> 
> // Can apply via native_handle().
> // Finding: ::boost::thread==>yes, ::std::thread==>yes
> pthread_attr_setschedparam(&attr, &param);
> 
> // Can only apply at the attribute level and not via native_handle().
> // Finding: ::boost::thread==>no, ::std::thread==>no
> pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
> 
> If there's some way to use pthread_self() to address the calls that
> can't work on native_handle(), I haven't found it yet.
> 
> Alternatively, if I were to use sched_setscheduler() instead of
> pthread attributes, that eliminates three of the above, which means
> one could conceivably use ::boost::thread and
> ::boost::thread::attributes to set the stacksize, but to cross compile
> the boost libraries, as I'd need to link against boost_system.so/a, it
> may not be worth the effort over just using pthreads.
 
So if you I get you right, you can't use std::thread or boost because
each one lacks some support you want to have. The best thing you get is
boost which lacks a wrapper around pthread_setschedparam(), is that so?
Because from google most people suggest to use
	pthread_setschedparam(tread.native_handle, &param);

and if that is the case, you could ask the boost folks to get native
support for it, since this is posix.

Sebastian
