From: eg Engleder Gerhard <eg@keba.com>
Subject: AW: [RFC] e1000e: Add delays after writing to registers
Date: Tue, 12 Jan 2016 16:37:33 +0100
Message-ID: <12C1B74BDFD05D40B2356A9B12DFA3396C355BE411@KEBMXSPMB01.keba.co.at>
References: <1445465268-10347-1-git-send-email-jonathan.david@ni.com>
 <20151022055909.GA7263@icarus.home.austad.us> <5638F239.1030804@ni.com>
 <20151103194246.GA19824@sisyphus.home.austad.us> <563930CF.9090800@ni.com>
 <20151106055349.GA10665@icarus.home.austad.us>
 <alpine.DEB.2.11.1511060929430.4032@nanos> <563CF3B1.2040904@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"josh.cartwright@ni.com" <josh.cartwright@ni.com>,
	Henrik Austad <henrik@austad.us>,
	Thomas Gleixner <tglx@linutronix.de>
To: Jonathan David <jonathan.david@ni.com>
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from xlspam03.mdcs.at ([217.13.183.27]:55629 "EHLO xlspam03.mdcs.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752222AbcALPre convert rfc822-to-8bit (ORCPT
	<rfc822;linux-rt-users@vger.kernel.org>);
	Tue, 12 Jan 2016 10:47:34 -0500
In-Reply-To: <563CF3B1.2040904@ni.com>
Content-Language: de-DE
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

> >
> > Now my question is how big is the induced latency.
> >
> After the wake-up timer is armed, the e1000e driver handles the network link
> configuration after the NIC was reset. When the function
> "e1000e_update_mc_addr_list_generic" is called, the MTA table is rewritten (the
> writing of this table consists of >70 MMIO writes followed by a read).
> 
> We see the hrtimer entry expire at the value 73712084997 near the bottom of the
> trace.
> 
> 73712084997ns - 73712055622ns = 29375ns
> 
> So, we see a ~29us latency, in comparison to a good case where we see about
> 1us.

I have a similar problem, but in my case the hardware latency is the problem.
We are executing DMA transfers over PCIe for fieldbus communication over
Ethernet (PCIe target is own fieldbus FPGA, not the e1000e).
Usually the DMA transfers start with a maximum delay of ~25us. But in case of
link down and up on the e1000e controller the worst case delay is 65us. This
violates our real-time deadlines. DMA transfer is triggered by the hardware and
delay is also measured by the hardware, no software is involved. With the following
patch the problem disappears:

 @@ -376,9 +376,10 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
        }

        /* replace the entire MTA table */
-       for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
+       for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
                E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
-       e1e_flush();
+               e1e_flush();
+       }
 }

 /**

What is the state of your patch for the e1000e driver?

regards, gerhard

