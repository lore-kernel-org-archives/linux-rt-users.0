From: Frieder Rick <Frieder.Rick@yahoo.de>
Subject: softirq handling / prioritization of the Ethernet traffic
Date: Thu, 10 May 2012 23:42:46 +0200
Message-ID: <4FAC3656.5060403@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from nm17.bullet.mail.ukl.yahoo.com ([217.146.183.191]:46995 "HELO
	nm17.bullet.mail.ukl.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757552Ab2EJVtZ (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Thu, 10 May 2012 17:49:25 -0400
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I would like to know if it is possible to prioritize the Ethernet 
traffic till it reaches napi_gro_receive() or netif_receive_skb() called 
inside the network card driver.

First I thought it is possible by the prioritization of the irq/XX-ethX 
thread which is used by the network card and the NET_RX_SOFTIRQ, 
NET_TX_SOFTIRQ threads. Till I read that the split from software 
interrupts to threads are gone in the RT patch. Now I'm a bit confused 
and unsure about the softirq handling.

I used ftrace to determine the path of an incoming packet and it looks 
to me that the softirq is prozessed inside the irq/18-eth1 thread. So if 
I give the irq/18-eth1 a higher priority than the others, can I be sure 
that it gets not interrupted?

here a part from my ftrace:

      irq/18-eth1-1738  [001]  1366.914708: function:             
e1000_intr <-- irq_forced_thread_fn
      irq/18-eth1-1738  [001]  1366.914711: function:             
__napi_schedule <-- e1000_intr
[...]
      irq/18-eth1-1738  [001]  1366.914718: function:             
__do_softirq <-- local_bh_enable
      irq/18-eth1-1738  [001]  1366.914719: function:             
__do_softirq_common <-- __do_softirq
      irq/18-eth1-1738  [001]  1366.914719: function:             
net_rx_action <-- __do_softirq_common
      irq/18-eth1-1738  [001]  1366.914720: function:             
e1000_clean <-- net_rx_action
      irq/18-eth1-1738  [001]  1366.914721: function:             
e1000_clean_rx_irq <-- e1000_clean
      irq/18-eth1-1738  [001]  1366.914722: function:             
__netdev_alloc_skb <-- e1000_clean_rx_irq
      irq/18-eth1-1738  [001]  1366.914722: function:             
__alloc_skb <-- __netdev_alloc_skb
[...]
      irq/18-eth1-1738  [001]  1366.914744: function:             
e1000_receive_skb <-- e1000_clean_rx_irq
      irq/18-eth1-1738  [001]  1366.914744: function:             
eth_type_trans <-- e1000_receive_skb
      irq/18-eth1-1738  [001]  1366.914744: function:             
napi_gro_receive <-- e1000_receive_skb

I hope someone can explain it to me. The reason I want to prioritize the 
incoming network traffic is cause I'm writing a module for the 
TTEthernet protocol which is Time-triggered and and based on the 
standard Ethernet. I need the packets without or very less jitter. And I 
would like to use it by changing the  napi_gro_receive() funtion in the 
network card driver to my module function to use it with any card by 
almost no modification in the code.

I'm quite new to kernel development and the module I'm writing is part 
of my bachelor thesis. If there is a paper or a book who explains this 
behavior I'm happy to know about it!

Best regards
Frieder
