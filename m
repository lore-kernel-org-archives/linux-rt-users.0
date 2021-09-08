Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C2EC433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A090A6108B
	for <linux-rt-users@archiver.kernel.org>; Wed,  8 Sep 2021 02:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346771AbhIHCSb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 7 Sep 2021 22:18:31 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:49517 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347111AbhIHCSb (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Sep 2021 22:18:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 8C8983200985;
        Tue,  7 Sep 2021 22:17:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 07 Sep 2021 22:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=XpBX03ofTywQgFacgXDG1pZnMP+
        5dK41kLgfbvxz1O8=; b=vefuPfVGtc/b90iJSbhosL2zzG/5ncgLrxYd1mMbkST
        5wMhlFPbptLMut4VDPB3L4vcAgBFMPslBfzzaNdSdQZPguX12B7NWauXwa0X6BNp
        QJa+hoiBdHFJNRvNGUl2EZMYo4ZZIizTSWsYWbd3O+jsAgdKt+r8uLm+ViJbc9cT
        SfoZ27dk+fvb+EOtKaxoE1esjj9N9BqOWZW9annXz2RDW8T5t+clxZsbu59VWisM
        Pze3rVKT/d/iQXPSCTW7f4se1u/rhM1fDWvLnJ58mQStRG0e31w1JzNGmMiw4lPi
        l3oNkgLh5B1BPadqlsyxSaB2091SITD82aU/7rfFZzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=XpBX03
        ofTywQgFacgXDG1pZnMP+5dK41kLgfbvxz1O8=; b=NCbZLVBdq20uU76hRrohup
        mkJaVbehVe5tcTQNzK4eDvIVBbpQ0STcG9x7K/BQF6Mm05dl5TlPoujHIypS/9lC
        eDi0wLnODl9P9yjdtxZ1VX1hZv5L8pFcQAuxQbl2kKDxR1ElHjk5UxSwF+k1FlOC
        mNkT8z7ts3CdSgldEH6jhRSufAZ+9gXifMj146t1LRTO0gsNrjQDKL743wuRTSCR
        vO0oKfr9OGaxbob4msuji3/tFyGtas64CDYgiZUru/+lgK7QWOt+BDSuBRMRqEvt
        1YNfxsEHUdT2ijtfiyggcjprR/B7bsn8NFshVo4qpVuMq0tlefjJE3zWzRqc1phQ
        ==
X-ME-Sender: <xms:Mh04YUl5tJ-FAyiAyZEWhiW8KjBW1yQN29w7K84SoNJx8cQMEBN6QA>
    <xme:Mh04YT1WEYreZKYIN8kFQXX4xODjFLMHkmFLHyZXFli7fwsdAbA7zfu_jeA-Oo8w8
    a8sraE7J82SyHvRL5I>
X-ME-Received: <xmr:Mh04YSreeLqYBlV2v24tgFB61X_2fZyryy0Rx-f5iIRLgI6VJQKAvTqTJYmmR2uW3LYIzFKt4Y8KNEf43tsTaTPIDI-s6FTB8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefiedgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeeugefhhfeileevtdegleduleeffedvkefhueekveei
    hfeijeejvdekuddthfekhfenucffohhmrghinhepphhkghgsuhhilhgurdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Mh04YQnAq3w9MqNRMOWH-sqEMvt4Sb68GLs00tJutW9xKeBV7_5ILA>
    <xmx:Mh04YS2eOHYme2SRRMLH0iZEVTxpBC51R6Bd4fwiZDZ2hN3G52B0wg>
    <xmx:Mh04YXtjmozt1vR9cdQA3YxwEjX2v8u0NtoXLPBl63N284MFJDwYbQ>
    <xmx:Mx04YVQV14bk-TSR0lDpnr3f6JjBsxsBq079qZ4TTNAVg2REUP93Uw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Sep 2021 22:17:20 -0400 (EDT)
Date:   Wed, 8 Sep 2021 11:17:18 +0900
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     David Runge <dave@sleepmap.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kristian Hoegsberg <krh@bitplanet.net>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
Message-ID: <YTgdLkTs7wEmj8fh@workstation>
Mail-Followup-To: David Runge <dave@sleepmap.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kristian Hoegsberg <krh@bitplanet.net>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
References: <20210205112638.xuduvuefy3auycht@linutronix.de>
 <YB3TLNN39/XhUyUY@hmbx>
 <YB+5tdIpbTfnDnIi@hmbx>
 <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx>
 <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de>
 <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTfy7pLhWkTOn+aI@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

On Wed, Sep 08, 2021 at 01:17:02AM +0200, David Runge wrote:
> Upon first boot the /dev/fw0 and /dev/fw1 nodes did not show up
> initially [1] (log without using -1 debug parameter), which is why I
> switched the device off and on again.
> Afterwards the device nodes were created, so I attempted to use aplay -l
> to check whether the device was detected. The command hung forever (also
> starting jackd) and I had to reboot eventually. Using alsamixer I was
> able to select the Fireface800 device from the list of devices though.
> 
> Upon 2nd boot I used the -1 debug parameter for firewire-ohci [2].
> The device nodes were created automatically, but neither aplay -l nor
> alsamixer showed the audio interface. The attempt to switch the device
> off and on again and afterwards to remove the firewire-ohci module lead
> to another freeze and a successive reboot.
> 
> If I can provide further information, please let me know!
> 
> I hope I can try the vanilla 5.14.1 kernel tomorrow to see how it
> behaves in regards to firewire-ohci (judging from the past it will
> probably work though).
> 
> Best,
> David
> 
> P.S.: I have added Kristian Hoegsberg in CC, who is mentioned as the
> author of firewire-ohci and firewire-core.
> 
> [1] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.1.19.realtime1-kernel.log
> [2] https://pkgbuild.com/~dvzrv/bugs/2021/09/linux-5.14.1.19.realtime1-restart_device_kernel.log

```
kernel: INFO: task pipewire-media-:2554 blocked for more than 122 seconds.
kernel:       Not tainted 5.14.1.19.realtime1-1-rt #1
kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kernel: task:pipewire-media- state:D stack:    0 pid: 2554 ppid:  1803 flags:0x00000220
kernel: Call Trace:
kernel:  __schedule+0x338/0x1580
kernel:  ? __mod_zone_page_state+0x81/0xf0
kernel:  ? rt_spin_unlock+0x13/0x40
kernel:  ? rmqueue_bulk+0x201/0x820
kernel:  schedule+0x43/0xf0
kernel:  schedule_timeout+0x14d/0x190
kernel:  wait_for_completion+0x9e/0x100
kernel:  fw_run_transaction+0xd7/0x110 [firewire_core bb04f32445782056ab0dc73199b57a87dc27c06d]
...
```

According to the log, the task of 'pipewire-media-:2554' is blocked during
122 seconds by call of 'wait_for_completion()' in code of
'fw_run_transaction()'. This is odd in two points of transaction service
programmed in Linux FireWire subsystem:

1. The process context should be awakened by softIRQ context, which should
   be scheduled by hwIRQ context for hardware interrupt of OHCI 1394
   controller.
2. Even if the softIRQ context is not invoked, the process context
   should be awakened by wheel timer context, which is scheduled to finish
   the transaction several jiffies later (originally prepared for the case
   of split-transaction). In the case, the result of transaction is
   'RCODE_CANCELLED'.

The call graph is below:

1 in the process context:

```
(drivers/firewire/core-transaction.c)
->fw_run_transaction()
  ->timer_setup_on_stack()
  ->fw_send_request()
    ->timer_setup()
    ->struct fw_card_driver.send_request()
    (drivers/firewire/ohci.c)
    = ohci_send_request()
      ...
      ->writel()
  ->wait_for_completion()
    (blocked and awakened by softIRQ context later)
  ->destroy_timer_on_stack()
```

2 in the hwIRQ context:

```
(drivers/firewire/ohci.c)
->irq_handler()
  ->tasklet_schedule(&ohci->at_response_ctx.tasklet);
```

3 in the softIRQ context:

```
(drivers/firewire/core-transaction.c)
->handle_at_packet()
  ->struct fw_packet.callback()
  = transmit_complete_callback()
    ->close_transaction()
      ->struct fw_transaction.callback()
      = transaction_callback()
        ->complete()
```

4. in the timer wheel context:

```
(drivers/firewire/core-transaction.c)
->split_transaction_timeout_callback()
  ->struct fw_packet.callback()
  = transaction_callback()
    ->complete()
```

I guess we have issue in the softIRQ context or timer wheel context
instead of hwIRQ context, if the OHCI 1394 controller you use has
no quirk (I suggest you to give information about the controller).

I'd like you to check it. The firewire-ohci module has 'debug' parameter.

``
$ modinfo firewire-ohci
...
parm:           debug:Verbose logging (default = 0, AT/AR events = 1, self-IDs = 2, IRQs = 4, busReset events = 8, or a combination, or all = -1) (int)
``

When the parameter has value '5' (= 1 | 4), we can see information per
transaction, like:

```
kernel: firewire_ohci 0000:0b:00.0: IRQ 00000001 AT_req
kernel: firewire_ohci 0000:0b:00.0: AT spd 2 tl 27, ffc1 -> ffc0, ack_pending , QR req, fffff0000400
kernel: firewire_ohci 0000:0b:00.0: IRQ 00000020 AR_resp
kernel: firewire_ohci 0000:0b:00.0: AR spd 2 tl 27, ffc0 -> ffc1, ack_complete, QR resp = 04101573
```

The first line:  in hwIRQ context for request subaction
The second line: in softIRQ context scheduled by the above.
The third line:  in hwIRQ context for response subaction
The fourth line: in softIRQ context scheduled by the above.

If we have any issue in invocation of softIRQ, we would often see
missing swIRQ logs (and it might be the most concern to RT Linux
developers).

If you need instruction to configure module parameters, 'man modprobe.d'
may be a good help.


Thanks

Takashi Sakamoto
