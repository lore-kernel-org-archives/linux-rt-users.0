Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3003C433EF
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Sep 2021 09:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B52F660F24
	for <linux-rt-users@archiver.kernel.org>; Sat, 11 Sep 2021 09:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235481AbhIKJsQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 11 Sep 2021 05:48:16 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:46201 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235443AbhIKJsQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 11 Sep 2021 05:48:16 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 049263200939;
        Sat, 11 Sep 2021 05:47:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 11 Sep 2021 05:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ALRQvkuUO/Bbr8HWamoT1D0i6Bs
        soUh0UPD6C16R7RM=; b=Mx9m4iQiNLSmqFz0u1UDVRzsfxbaGbBEDdpiZF3NUXe
        POMSjja8X6PTmEmf+AE+k4bVs24MuAjQjGmtzbwXMMiYOpGMXTQD5v0VolYnwh7O
        caxvoebN08k6WnmiIfMlezMd89kMImellkHvnQ2ruW1W9iDoq3QYU5IqOQPzIMIo
        ecpyOE02/LE14/OaMZDlfqy6wxYR3o5sLHatZN0E12Qaz+hVzGWPk5Tw0ouG8BxH
        qK61ywFL8OPOt06ha7Aj7TeZDZ5+G08Blp4p7ABhmaKc3j4YPs4OmwYNc1iZRImx
        x3GABp9MsPIsSCcrYN45g/BNsU5u94vN2SgFMxRZBQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=ALRQvk
        uUO/Bbr8HWamoT1D0i6BssoUh0UPD6C16R7RM=; b=riCnbQ7oe/OK3Oht+ZDSiM
        j/5IxZ3UBJcWMV31stWLDVe0PC9RWrWDkZ0l8cc9tcPq/wcOzblX3tkHMrgk/AT9
        50LrlOnMmNDHQD65ed5rXmF20npInkoRO0Sz+j1y+vXK+mp5VHHVFUHmL+duwPEF
        EBSVjqyEwVpwK6yOp89REVy8zVhjcjo27sgCpKiIFyO8vggvRJN4F5qiItAh7TgQ
        1nkn33CG9tQD1Y+LaGZyeZzQ717l/RQcOCTRUAYXChKVfUPZuxIhYobe2b/fHpLA
        5utguwJV5UCjr8rTco5A1aucbGZWQPEVMxMKgPrgvehjvIJ/BcJyjBH7mEwfTWiA
        ==
X-ME-Sender: <xms:Fns8YdV4R001-9xlmdw5YSY0YbC8ITK9MFdknN10EgIUYrSDn_oK-A>
    <xme:Fns8YdnsT4ArZpPaZhVo4DCh4-6Bf7StEolTzZReiqG4kLaiuTtsuip3p6BhTfnL-
    6jRF2ZhiQW1rXOcnjA>
X-ME-Received: <xmr:Fns8YZYmP-7YDl7MFiSvBEAeCdeOZj3K4YRSyNzGWnyH5UuPLIZ2uxGg18AtxafUiivfqM4Y2at1WMKz8SpUlu6P_6Ii7ahxUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudegfedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeejgeeifeeuveeufeeigeegjeelvdfgjeegffejgfdv
    keelhefgtdefteejleekjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhh
    ihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Fns8YQWeuRjKueuauLxHqBHFKHxqJ7vX63uNRTJFsoUfnaxusTl0bw>
    <xmx:Fns8YXmK4IlCkLCiekau_SXeeAnATebvvoRV6eyhJT-Yd0owW0E_yA>
    <xmx:Fns8YddHdoeEIwGQcOPwv8r2_nz3LO0AiNFX8rU8C_svHpXtnb0eQA>
    <xmx:Fns8YVgxmb3outCvn8Yt3aghEwb9tleaL3Dcr-r0MEkN6DvILWE3Rg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 11 Sep 2021 05:47:00 -0400 (EDT)
Date:   Sat, 11 Sep 2021 18:46:57 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     David Runge <dave@sleepmap.de>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YTx7EVV5vFuhKM5i@workstation>
Mail-Followup-To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        David Runge <dave@sleepmap.de>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
References: <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx>
 <YTgdLkTs7wEmj8fh@workstation>
 <20210910115541.jjf3fovv4v3etvde@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910115541.jjf3fovv4v3etvde@linutronix.de>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Fri, Sep 10, 2021 at 01:55:41PM +0200, Sebastian Andrzej Siewior wrote:
> On 2021-09-08 11:17:18 [+0900], Takashi Sakamoto wrote:
> > Hi,
> Hi,
> 
> > According to the log, the task of 'pipewire-media-:2554' is blocked during
> > 122 seconds by call of 'wait_for_completion()' in code of
> > 'fw_run_transaction()'. This is odd in two points of transaction service
> > programmed in Linux FireWire subsystem:
> > 
> > 1. The process context should be awakened by softIRQ context, which should
> >    be scheduled by hwIRQ context for hardware interrupt of OHCI 1394
> >    controller.
> > 2. Even if the softIRQ context is not invoked, the process context
> >    should be awakened by wheel timer context, which is scheduled to finish
> >    the transaction several jiffies later (originally prepared for the case
> >    of split-transaction). In the case, the result of transaction is
> >    'RCODE_CANCELLED'.
> 
> 
> Side note: David is using PREEMPT_RT and his problem can be reduced to
> plain vanilla with `threadirqs' boot option. Back in February I sent him
> a patch [0] which inlines the tasklet job as I assumed it is not good
> reset the IRQ-event in the tasklet/workqueue. It seemed to improve the
> situtation as it recognized the device attached to the bus but ended
> then in the same timeout behaviour as now.
> 
> [0] https://https://lkml.kernel.org/r/.kernel.org/all/20210218083849.iitcrhdgv2oajfhv@linutronix.de/

Thanks for the side note, and I apologize to follow the thread partially,
not entire.

Furthermore, I'd like to correct my misunderstanding about the 2nd point
since the timer wheel context is scheduled only when the peer of
transaction transfer ack_pending for the request subaction. Without the
hwIRQ context, the task is blocked ever anyway.


Regards

Takashi Sakamoto
