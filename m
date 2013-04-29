From: =?UTF-8?B?TmVib2rFoWEgxIZvc2nEhw==?= <nebojsa@asnn.org>
Subject: UDP jitter
Date: Mon, 29 Apr 2013 22:22:38 +0200
Message-ID: <20130429222238.2b440d8c@sanja.asnn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: linux-rt-users <linux-rt-users@vger.kernel.org>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:54602 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756890Ab3D2UtZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Mon, 29 Apr 2013 16:49:25 -0400
Received: from ipb5.telenor.se (ipb5.telenor.se [195.54.127.168])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 7DD10E9ABE
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2013 22:22:41 +0200 (CEST)
Received: from sanja.asnn.org (sanja [192.168.0.3])
	by mali (Postfix) with ESMTPSA id 9D5A21138F8
	for <linux-rt-users@vger.kernel.org>; Mon, 29 Apr 2013 22:22:39 +0200 (CEST)
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Hi,
I am doing some work on a product running kernel 2.6.33.7.2-rt30.
Applications running on this kernel are a bit specific, meaning that
there are a number of threads running on a different priorities.
=46or a several months I was haunted with spurious jitter, detected on
UDP messages - multicast UDP messages where received on originating
node without any delay, but on other nodes a delay in range of 10s of
milliseconds was detected. Simply, it looked like a message was stuck
in kernel before finally getting transmitted.
=46inally, thanks to LTTng tool, I was able to locate the problem down =
to
this peace of code in net/sched/sch_generic.c:

int sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
                    struct net_device *dev, struct netdev_queue *txq,
                    spinlock_t *root_lock)
{
        int ret =3D NETDEV_TX_BUSY;

        /* And release qdisc */
        spin_unlock(root_lock);

        HARD_TX_LOCK(dev, txq);

        if (!netif_tx_queue_stopped(txq) && !netif_tx_queue_frozen(txq)=
)
                ret =3D dev_hard_start_xmit(skb, dev, txq);


        HARD_TX_UNLOCK(dev, txq);

        spin_lock(root_lock);
=2E..

When transmit queue is empty, thread wanting to send a message comes
directly to sch_direct_xmit, without changing context. It then releases
spin lock, and than takes another. So far so good.
If this starting thread is of lower priority, it can be preempted by
another thread, while still being in dev_hard_start_xmit function
This thread will check if HARD_TX_LOCK is taken, and if so, go on and
queue its own message.
If there are enough higher priority tasks, tx can be stalled
indefinitely... Effectively, there is priority inversion.
My temporary workaround was to simply remove lock handling from
sch_direct_xmit, getting priority inheritance on root_lock, and
effectively disabling queuing... Not very good solution, but it works
perfectly well for my particular application.
I see that the same code still exists in latest kernels, so I suppose
that problem exists even there. It is RT specific thou.=20
What would be a proper solution to this problem?
Sending first message without switching context is a nice
optimization, but it creates problems...

--=20
Regards
Neboj=C5=A1a
--
To unsubscribe from this list: send the line "unsubscribe linux-rt-user=
s" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
