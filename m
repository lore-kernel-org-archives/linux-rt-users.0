From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Thu, 22 Sep 2016 17:12:05 +0200
Message-ID: <20160922151205.m3cch6re77tox3aw@linutronix.de>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:38503 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934512AbcIVPMI (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Sep 2016 11:12:08 -0400
Content-Disposition: inline
In-Reply-To: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-22 12:44:00 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> I run the cyclictest with the following options:
> # cyclictest -a -i 100 -d 10 -m -n -t -p 80

there is -S. And then 100 might be a little tight.

> Of course the 2 minutes run-time of cyclictest is only a rough first estimate.

and with no load…

> Once I configure one of the i350 ports
> # ifconfig eth2 up 192.168.100.100
> the cyclictest shows directly and reproducibly significant larger max latency values (40 microseconds, using the same conditions).
> 
> 
> I did the very same test with kernel version 3.18.27-rt27.
> With that version I did not see anything like that.
> 
> Also, only the igb driver seems to cause the trouble. I have also an e1000e based NIC in this PC and 
> the usage of this driver does not add any significant latency.
> 
> Any idea on this?

Does this also happen if you have the NIC up and you plug in / out the
cable? There are two things that come to mind:
  https://lkml.kernel.org/r/1445465268-10347-1-git-send-email-jonathan.david@ni.com
  https://lkml.kernel.org/r/1445886895-3692-1-git-send-email-joshc@ni.com

> Thanks for any feedback
> 
> Best regards
> 
> Mathias

Sebastian
