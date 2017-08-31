From: Pratyush Patel <pratyushpatel.1995@gmail.com>
Subject: Re: kernel BUG at kernel/locking/rtmutex.c:1059
Date: Thu, 31 Aug 2017 21:32:28 +0530
Message-ID: <CAAnMKKYTrq95T6gQu4vqGq7Ft6FGiif2rzEh57AMpP2NE_=7Rw@mail.gmail.com>
References: <86val4928u.fsf@gaheris.avalon.lan> <CAAnMKKa2LiYMCr0v32Wnd6TzdpnfZ0qKcecaFp6vpT8gR6+fvg@mail.gmail.com>
 <20170831145435.lgeod4vih3blevfw@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mart van de Wege <mvdwege@gmail.com>,
        linux-rt-users@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35560 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751788AbdHaQC3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 31 Aug 2017 12:02:29 -0400
Received: by mail-io0-f193.google.com with SMTP id n74so85540ioe.2
        for <linux-rt-users@vger.kernel.org>; Thu, 31 Aug 2017 09:02:29 -0700 (PDT)
In-Reply-To: <20170831145435.lgeod4vih3blevfw@linutronix.de>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On Thu, Aug 31, 2017 at 8:24 PM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2017-08-31 16:29:54 [+0530], Pratyush Patel wrote:
>> Hello,
> Hi,
>
>> I too faced a similar issue on startup when I ran v4.11.12-rt10 on a
>> virtual QEMU-KVM setup with Arch Linux. The kernel panics when the
>> Locking API test suite runs during the startup. I'm not sure if these
>> could be related.
>
> This recursive locking is done by the self-test with the same result. I
> suggest you disable it.
>

It works after disabling the self-test and also after switching
CONFIG_RWLOCK_RT_READER_BIASED=y.

Thanks,
Pratyush
