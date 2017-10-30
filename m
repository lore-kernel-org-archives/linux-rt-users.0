From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: avoid recursive locking in
 hci_send_to_channel()
Date: Mon, 30 Oct 2017 09:05:02 +0100
Message-ID: <19282780-42CE-43C9-928E-73F4135D359A@holtmann.org>
References: <86val4928u.fsf@gaheris.avalon.lan>
 <20170831145211.xlu6cvocqdkzevsl@linutronix.de>
 <20170921135123.rgzacdgfonqftlu7@linutronix.de>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Mart van de Wege <mvdwege@gmail.com>,
        Johan Hedberg <johan.hedberg@intel.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170921135123.rgzacdgfonqftlu7@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-rt-users.vger.kernel.org

Hi Sebastian,

> Mart reported a deadlock in -RT in the call path:
>  hci_send_monitor_ctrl_event() -> hci_send_to_channel()
> 
> because both functions acquire the same read lock hci_sk_list.lock. This
> is also a mainline issue because the qrwlock implementation is writer
> fair (the traditional rwlock implementation is reader biased).
> 
> To avoid the deadlock there is now __hci_send_to_channel() which expects
> the readlock to be held.
> 
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@intel.com>
> Fixes: 38ceaa00d02d ("Bluetooth: Add support for sending MGMT commands and events to monitor")
> Reported-by: Mart van de Wege <mvdwege@gmail.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> net/bluetooth/hci_sock.c | 17 +++++++++++------
> 1 file changed, 11 insertions(+), 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
