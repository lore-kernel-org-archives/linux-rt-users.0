Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-lj1-f176.google.com ([209.85.208.176]:33957 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbeGMIrf (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 13 Jul 2018 04:47:35 -0400
Received: by mail-lj1-f176.google.com with SMTP id f8-v6so6261910ljk.1
        for <linux-rt-users@vger.kernel.org>; Fri, 13 Jul 2018 01:33:57 -0700 (PDT)
From: Esben Haabendal <esben.haabendal@gmail.com>
Subject: Re: tty latency and RT
References: <681500CE65202E47A192754B01DAB4673BE3D87A37@SDE12.beckipc.net>
        <87muv4zpu8.fsf@linutronix.de> <87pnzwag3n.fsf@gmail.com>
        <20180711080957.f6txdmzrrrrdm7ig@linutronix.de>
Date: Fri, 13 Jul 2018 10:33:54 +0200
In-Reply-To: <20180711080957.f6txdmzrrrrdm7ig@linutronix.de> (Sebastian
        Andrzej Siewior's message of "Wed, 11 Jul 2018 10:09:57 +0200")
Message-ID: <87muuvzg99.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: John Ogness <john.ogness@linutronix.de>, =?utf-8?Q?Andr=C3=A9?= Pribil <a.pribil@beck-ipc.com>, "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2018-07-09 11:55:08 [+0200], Esben Haabendal wrote:
>> I am using the following patch.
>> Not sure if it is worth proposing it for mainline inclusion, though.
>> RFC:
>
> | ======================================================
> | WARNING: possible circular locking dependency detected
> | 4.16.18-rt9+ #187 Not tainted
> | ------------------------------------------------------
> | sshd/3205 is trying to acquire lock:
> |  (&buf->lock){+.+.}, at: [<        (ptrval)>] flush_to_ldisc+0x1e/0xa0
> | 
> | but task is already holding lock:
> |  (&ldata->output_lock){+.+.}, at: [<        (ptrval)>] n_tty_write+0x12a/0x480
> | 
> | which lock already depends on the new lock.
> |
> | 
> | the existing dependency chain (in reverse order) is:
> | 
> | -> #2 (&ldata->output_lock){+.+.}:
> |        _mutex_lock+0x26/0x40
> |        n_tty_write+0x12a/0x480
> |        tty_write+0x1b3/0x320
> |        redirected_tty_write+0x9a/0xb0
> |        do_iter_write+0x159/0x1a0
> |        vfs_writev+0x93/0x110
> |        do_writev+0x5f/0xf0
> |        SyS_writev+0xb/0x10
> |        do_syscall_64+0x73/0x220
> |        entry_SYSCALL_64_after_hwframe+0x42/0xb7
> | 
> | -> #1 (&tty->termios_rwsem){++++}:
> |        down_write+0x39/0x50
> |        n_tty_flush_buffer+0x19/0xf0
> |        tty_buffer_flush+0x71/0x90
> |        tty_ldisc_flush+0x1d/0x40
> |        tty_port_close_start.part.5+0xa0/0x1b0
> |        tty_port_close+0x29/0x60
> |        uart_close+0x26/0x70
> |        tty_release+0xfc/0x4f0
> |        __fput+0xf1/0x200
> |        ____fput+0x9/0x10
> |        task_work_run+0x8b/0xc0
> |        exit_to_usermode_loop+0xbc/0xc0
> |        do_syscall_64+0x21b/0x220
> |        entry_SYSCALL_64_after_hwframe+0x42/0xb7
> | 
> | -> #0 (&buf->lock){+.+.}:
> |        lock_acquire+0x95/0x240
> |        _mutex_lock+0x26/0x40
> |        flush_to_ldisc+0x1e/0xa0
> |        tty_flip_buffer_push+0x28/0x40
> |        pty_write+0x4e/0x60
> |        n_tty_write+0x1ae/0x480
> |        tty_write+0x1b3/0x320
> |        __vfs_write+0x35/0x160
> |        vfs_write+0xc1/0x1c0
> |        SyS_write+0x53/0xc0
> |        do_syscall_64+0x73/0x220
> |        entry_SYSCALL_64_after_hwframe+0x42/0xb7
> | 
> | other info that might help us debug this:
> |
> | Chain exists of:
> |   &buf->lock --> &tty->termios_rwsem --> &ldata->output_lock
> |
> |  Possible unsafe locking scenario:
> |
> |        CPU0                    CPU1
> |        ----                    ----
> |   lock(&ldata->output_lock);
> |                                lock(&tty->termios_rwsem);
> |                                lock(&ldata->output_lock);
> |   lock(&buf->lock);
> | 
> |  *** DEADLOCK ***
> |
> | 4 locks held by sshd/3205:
> |  #0:  (&tty->ldisc_sem){++++}, at: [<        (ptrval)>] ldsem_down_read+0x2d/0x40
> |  #1:  (&tty->atomic_write_lock){+.+.}, at: [<        (ptrval)>] tty_write_lock+0x19/0x50
> |  #2:  (&o_tty->termios_rwsem/1){++++}, at: [<        (ptrval)>] n_tty_write+0x9a/0x480
> |  #3:  (&ldata->output_lock){+.+.}, at: [<        (ptrval)>] n_tty_write+0x12a/0x480

Yes, it seems like there is:

1. tty_buffer_flush(), which results in

  mutex_lock(&buf->lock);
  down_write(&tty->termios_rwsem); # in n_tty_flush_buffer()

and with my patch:

2. n_tty_write(), which results in

  down_read(&tty->termios_rwsem);
  mutex_lock(&ldata->output_lock);
  mutex_lock(&buf->lock); # in flush_to_ldisc() (from tty_do_flip())

So both

  &buf->lock --> &tty->termios_rwsem

and

  &tty->termios_rwsem --> &ldata->output_lock --> &buf->lock

chains, which I guess is what lockdep refers to, and which indeed looks
like a deadlock waiting to happen.

But is the lock ordering in tty_buffer_flush() really needed?
Could we move the

	if (ld && ld->ops->flush_buffer)
		ld->ops->flush_buffer(tty);

lines out of the &buf->lock section?  I don't think that any code
outside of tty_buffer.c should touch the port->buf code, and thus should
not need to hold the &buf->lock.

/Esben


