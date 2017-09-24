From: Mart van de Wege <mvdwege-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: avoid recursive locking in
 hci_send_to_channel()
Date: Sun, 24 Sep 2017 16:53:54 +0200
Message-ID: <20170924165354.33a5da4d@gmail.com>
References: <86val4928u.fsf@gaheris.avalon.lan>
        <20170831145211.xlu6cvocqdkzevsl@linutronix.de>
        <20170921135123.rgzacdgfonqftlu7@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>,
        Johan Hedberg <johan.hedberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Gustavo Padovan <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>,
        linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-rt-users-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org,
        Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
To: Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170921135123.rgzacdgfonqftlu7-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-rt-users.vger.kernel.org

Confirm that 4.11.12-rt14 with this fix boots normally.

On Thu, 21 Sep 2017 15:51:23 +0200
Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> wrote:

> Mart reported a deadlock in -RT in the call path:
>   hci_send_monitor_ctrl_event() -> hci_send_to_channel()
> 
> because both functions acquire the same read lock hci_sk_list.lock.
> This is also a mainline issue because the qrwlock implementation is
> writer fair (the traditional rwlock implementation is reader biased).
> 
> To avoid the deadlock there is now __hci_send_to_channel() which
> expects the readlock to be held.
> 
> Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
> Cc: Johan Hedberg <johan.hedberg-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Fixes: 38ceaa00d02d ("Bluetooth: Add support for sending MGMT
> commands and events to monitor") Reported-by: Mart van de Wege
> <mvdwege-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> Signed-off-by: Sebastian Andrzej Siewior
> <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org> ---
>  net/bluetooth/hci_sock.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
> index 638bf0e1a2e3..f1ee820d871c 100644
> --- a/net/bluetooth/hci_sock.c
> +++ b/net/bluetooth/hci_sock.c
> @@ -251,15 +251,13 @@ void hci_send_to_sock(struct hci_dev *hdev,
> struct sk_buff *skb) }
>  
>  /* Send frame to sockets with specific channel */
> -void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> -			 int flag, struct sock *skip_sk)
> +static void __hci_send_to_channel(unsigned short channel, struct
> sk_buff *skb,
> +				  int flag, struct sock *skip_sk)
>  {
>  	struct sock *sk;
>  
>  	BT_DBG("channel %u len %d", channel, skb->len);
>  
> -	read_lock(&hci_sk_list.lock);
> -
>  	sk_for_each(sk, &hci_sk_list.head) {
>  		struct sk_buff *nskb;
>  
> @@ -285,6 +283,13 @@ void hci_send_to_channel(unsigned short channel,
> struct sk_buff *skb, kfree_skb(nskb);
>  	}
>  
> +}
> +
> +void hci_send_to_channel(unsigned short channel, struct sk_buff *skb,
> +			 int flag, struct sock *skip_sk)
> +{
> +	read_lock(&hci_sk_list.lock);
> +	__hci_send_to_channel(channel, skb, flag, skip_sk);
>  	read_unlock(&hci_sk_list.lock);
>  }
>  
> @@ -388,8 +393,8 @@ void hci_send_monitor_ctrl_event(struct hci_dev
> *hdev, u16 event, hdr->index = index;
>  		hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
>  
> -		hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
> -				    HCI_SOCK_TRUSTED, NULL);
> +		__hci_send_to_channel(HCI_CHANNEL_MONITOR, skb,
> +				      HCI_SOCK_TRUSTED, NULL);
>  		kfree_skb(skb);
>  	}
>  
