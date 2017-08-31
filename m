From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Possible BT deadlock due to recursive read locking (Was: Re: kernel
 BUG at kernel/locking/rtmutex.c:1059)
Date: Thu, 31 Aug 2017 16:52:12 +0200
Message-ID: <20170831145211.xlu6cvocqdkzevsl@linutronix.de>
References: <86val4928u.fsf@gaheris.avalon.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linux-rt-users@vger.kernel.org, tglx@linutronix.de,
        Peter Zijlstra <peterz@infradead.org>
To: Mart van de Wege <mvdwege@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <86val4928u.fsf@gaheris.avalon.lan>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

On 2017-08-30 23:25:53 [+0200], Mart van de Wege wrote:
> Hi,
Hi,

> The issue persists up to v4.11.12-rt10
Does
	CONFIG_RWLOCK_RT_READER_BIASED=y
make it go away?

> Stacktrace:
> 
> Aug 29 17:28:04 localhost kernel: [   46.483810] ------------[ cut here ]------------
> Aug 29 17:28:04 localhost kernel: [   46.483812] kernel BUG at kernel/locking/rtmutex.c:1059!

this is a deadlock on RT however !RT has a hidden problem which not
yelled at by lockdep. We have the following call path:

| hci_send_monitor_ctrl_event()
|   read_lock(&hci_sk_list.lock);
|
|   hci_send_to_channel()
|      read_lock(&hci_sk_list.lock);

So both functions acquire the same read_lock. If a write comes along
between the first read_lock() and second read_lock() then we have a
deadlock because the write_lock() will lock down further readers from
acquiring the read-lock until the writer completed its task.

This recursive locking was introduced in 38ceaa00d02d ("Bluetooth: Add
support for sending MGMT commands and events to monitor").

Sebastian
