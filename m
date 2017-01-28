From: Andy Ng <andreas2025@gmail.com>
Subject: Re: wake_up does not return
Date: Sat, 28 Jan 2017 19:42:50 +0000
Message-ID: <CAAVaN8zaQ0ugx3UdiK9C2aKUoyrzeLg6tu5gvh2bkPgzSYof_g@mail.gmail.com>
References: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
 <20170126165752.lsjdyuheyvzwjess@linutronix.de> <CAAVaN8zW6vEq4Y84N4NKvUFMJsgrUDPbpihuQcon+4jEfsyoEA@mail.gmail.com>
 <CAAVaN8yq4BveUhhed66embAx+NZE0wq6+RgKF_K7imi=07dj2g@mail.gmail.com>
 <CAAVaN8xHrt6NgS9R24eWnBjPcAJV6A05QaCS4HpTj+=6+3kWQw@mail.gmail.com>
 <CAAVaN8ycOtGDBgEuFGz2dp7RqvoywG2172A3dWEhVYyqx=7-5Q@mail.gmail.com> <20170127223719.GO5599@jcartwri.amer.corp.natinst.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Julia Cartwright <julia@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:32993 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751614AbdA1Tm6 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 28 Jan 2017 14:42:58 -0500
Received: by mail-ua0-f173.google.com with SMTP id i68so226590200uad.0
        for <linux-rt-users@vger.kernel.org>; Sat, 28 Jan 2017 11:42:51 -0800 (PST)
In-Reply-To: <20170127223719.GO5599@jcartwri.amer.corp.natinst.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

 This is an rt_mutex in RT, non threaded IRS can't sleep, the waiting
queue is locked by an rt_mutex.
Any better ideas combining non threaded ISR with wake_up calls?

On Fri, Jan 27, 2017 at 10:37 PM, Julia Cartwright <julia@ni.com> wrote:
> On Fri, Jan 27, 2017 at 10:25:08PM +0000, Andy Ng wrote:
>> the wake_up from a non threaded isr in RT will end up to try to get
>> the spin_lock of of that wait_queue, but this kind of locking in not
>> allowed in non threaded isr and therefore the use of wake_up_locked
>> does not touches the spin_locks of the queue... and it seems to work
>
> And, have you convinced yourself that this is a safe operation to
> perform without taking the lock?
>
> In other words, how are you preventing this interrupt from firing when a
> thread is in process of manipulating the wake queue?
>
>    Julia
>
> PS. There is a "simple" waitqueue implementation which may or may not
> fit what you want to do.
