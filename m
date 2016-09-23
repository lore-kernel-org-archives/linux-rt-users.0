From: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>
Subject: Re: Kernel 4.6.7-rt13: Intel Ethernet driver igb causes huge
 latencies in cyclictest
Date: Fri, 23 Sep 2016 16:41:40 +0200
Message-ID: <20160923144140.5tkzeymamrb5qnsv@linutronix.de>
References: <d648628329bc446fa63b5e19d4d3fb56@FE-MBX1012.de.bosch.com>
 <20160922151205.m3cch6re77tox3aw@linutronix.de>
 <c91ce66d47ff470a94e10e2347eafe4a@FE-MBX1012.de.bosch.com>
 <ac1207c12ad34059956c2729ccf31e97@FE-MBX1012.de.bosch.com>
 <20160923123224.odybv2uos6tot6it@linutronix.de>
 <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
To: "Koehrer Mathias (ETAS/ESW5)" <mathias.koehrer@etas.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:41833 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034672AbcIWOlm (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 23 Sep 2016 10:41:42 -0400
Content-Disposition: inline
In-Reply-To: <ae35c863cdf246ac8da94277418921ef@FE-MBX1012.de.bosch.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

On 2016-09-23 13:23:22 [+0000], Koehrer Mathias (ETAS/ESW5) wrote:
> Hi Sebastian,
Hi Mathias,

> The critical stuff seems to be
> igb_has_link() calling hw->mac_ops.check_for_link (which is igb_check_for_link_82575() )
> calling igb_check_for_copper_link() calling igb_phy_has_link.
> 
> Within igb_phy_has_link() the line with the code
>    ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
> seems to be the candidate that causing the trouble.
> And this function pointer points to igb_read_phy_reg_82580().
> 
> Does this give you any idea what goes wrong?

Nope. There is nothing that might prevents preemption (unless I missed
something). However if you there are a lot of posted writes writes to
the HW, the read might force them to occur *now* which will stall the
CPU until it happens.
Try to comment the function(s) out to see if that spikes vanishes. 
That igb_read_phy_reg_82580() function also invokes another one for the
acquire callback.

> Thanks for any hints!
> 
> Regards
> 
> Mathias

Sebastian
