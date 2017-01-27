From: Julia Cartwright <julia@ni.com>
Subject: Re: wake_up does not return
Date: Fri, 27 Jan 2017 16:37:19 -0600
Message-ID: <20170127223719.GO5599@jcartwri.amer.corp.natinst.com>
References: <CAAVaN8wqmh9qYYU7TXR58-0=5Lk_s1vMcdHKdWEp4Ln9iEf=wg@mail.gmail.com>
 <20170126165752.lsjdyuheyvzwjess@linutronix.de>
 <CAAVaN8zW6vEq4Y84N4NKvUFMJsgrUDPbpihuQcon+4jEfsyoEA@mail.gmail.com>
 <CAAVaN8yq4BveUhhed66embAx+NZE0wq6+RgKF_K7imi=07dj2g@mail.gmail.com>
 <CAAVaN8xHrt6NgS9R24eWnBjPcAJV6A05QaCS4HpTj+=6+3kWQw@mail.gmail.com>
 <CAAVaN8ycOtGDBgEuFGz2dp7RqvoywG2172A3dWEhVYyqx=7-5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
To: Andy Ng <andreas2025@gmail.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from skprod3.natinst.com ([130.164.80.24]:53066 "EHLO ni.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750723AbdA0Whf (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 27 Jan 2017 17:37:35 -0500
Content-Disposition: inline
In-Reply-To: <CAAVaN8ycOtGDBgEuFGz2dp7RqvoywG2172A3dWEhVYyqx=7-5Q@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Fri, Jan 27, 2017 at 10:25:08PM +0000, Andy Ng wrote:
> the wake_up from a non threaded isr in RT will end up to try to get
> the spin_lock of of that wait_queue, but this kind of locking in not
> allowed in non threaded isr and therefore the use of wake_up_locked
> does not touches the spin_locks of the queue... and it seems to work

And, have you convinced yourself that this is a safe operation to
perform without taking the lock?

In other words, how are you preventing this interrupt from firing when a
thread is in process of manipulating the wake queue?

   Julia

PS. There is a "simple" waitqueue implementation which may or may not
fit what you want to do.
