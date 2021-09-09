Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180FAC433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 00:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB0260FDA
	for <linux-rt-users@archiver.kernel.org>; Thu,  9 Sep 2021 00:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348834AbhIIArV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 20:47:21 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:53949 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236691AbhIIArU (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 8 Sep 2021 20:47:20 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id A3BAB3200933;
        Wed,  8 Sep 2021 20:46:11 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 08 Sep 2021 20:46:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=r9KKyrg35zjwF5gzemAFneUD2tT
        gxa8lll8DSYozUoM=; b=wrFybNCFu1mw9VhzSkEjX0OC+9rYH40ihV7LKw/RLQD
        mqefXgAO68JjX+09jOPKWUu3pfSqOiO2e98LeGEipuM+JKXgod498vIVwyR8hKiS
        C2ruu8974nslWzmEqxw9BbvSFc1ePBGltgwqtTbLdQ+rBNSJPPjTz39lGd8J/bb5
        NeWj01bPd0il8shPxApKRnpeCr7Hgix6oR6YLTYH+pjooNOWsYGDlw73eK6muupk
        aUkrIuxtRv1Ya743ytihT21CWNR8UDjGHTdYUvbOCLnTV/FJqUW7wyM5WGk4sMlW
        3Z3z8JTAXLl4ckQ+lBFlkkuk7P8+59ef5o73MUJyzYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=r9KKyr
        g35zjwF5gzemAFneUD2tTgxa8lll8DSYozUoM=; b=Kio+5OedCLZQce3sTpKrrX
        e7J7Ay/oCfGJKrWFJB9+5PbGfBodwH8lrLNePk/LGsU0ESJrQ5oX8Ks+zS5DmpnB
        tAucCFotf0QbU0ShrGw6N5+dN6oudRtQQ1Ex9QPEJAYOjSCplKgccNVoeKcS/hKN
        YhoW3nWyBFovXe4zAZM4155h4914ENQqCPU/iEVOsjnAB8Q5G6DiLarqMOZCYwlD
        SFAjfltOX9Y9vccLcDUXRY+VYty2bllTjtmWAlQyu/SMcrQAv5DdhyXuaTK5grAO
        tbZt49H/f3YU5Et5lQbaRSUuasW4aU5LJw4HO71sebTiaUe/UIPUG4hu0MXb8pxQ
        ==
X-ME-Sender: <xms:Ulk5YdjvHrmILuBWSIXlnu3wgGj69upAkEsu-yMIV0T7u0-qaeB8HQ>
    <xme:Ulk5YSBLvlAATd20ULpAdHjRsenuY4Zj4LW7gSzAKZyhIdVFpfFmq34V39jcFQkvg
    CQR1Wc21peji36i8X4>
X-ME-Received: <xmr:Ulk5YdEUZVFwGnb5GgM6zAXbjWLzv9uJ0hVtaHB_GHmAuRWDoiIhZsXW8Mszd567FesYwcxCoDYEtGM0FglqO3F4IBEeU5kV4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudefkedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvrghkrghs
    hhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjh
    hpqeenucggtffrrghtthgvrhhnpeelhfeugedvjefgjefgudekfedutedvtddutdeuieev
    tddtgeetjeekvdefgeefhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:Ulk5YSQPTSxl8pzGwLWrZzoEqq_10MHaxlKGS12yZIrdpmvx0sJnUw>
    <xmx:Ulk5YayO3YGqTXQYe8sWtLE8LgXrC-krpmr6kzhANeL8el-JBF2pFg>
    <xmx:Ulk5YY7j-ojvu88PaY_y3IttaCZcVy2ctmDqSgpWu3ap1Q43BoB9Zw>
    <xmx:U1k5YUs7_dLcuLqTwgKjNyq6tYErZ5K-9FI6_fVBl8GhEaW7jjgyqg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Sep 2021 20:46:08 -0400 (EDT)
Date:   Thu, 9 Sep 2021 09:46:06 +0900
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
Message-ID: <YTlZTvb6B3O2as+q@workstation>
Mail-Followup-To: David Runge <dave@sleepmap.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kristian Hoegsberg <krh@bitplanet.net>,
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
 <YTjzKftQmFtPLYUR@hmbx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YTjzKftQmFtPLYUR@hmbx>
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Wed, Sep 08, 2021 at 07:30:14PM +0200, David Runge wrote:
> I am using '-1' (all) in the 2nd link in my previous mail. It appears to
> not show a different output in the kernel logs from when I set it to '5'
> though. There seems to be something wrong...
> I'm adding the options in a .conf file below /etc/modprobe.d/, e.g.:
> 
> ```
> options firewire-ohci debug=5
> ```
> 
> The only output I get from that is:
> 
> ```
> firewire_ohci 0000:05:00.0: enabling device (0000 -> 0002)
> firewire_ohci 0000:05:00.0: added OHCI v1.10 device as card 0, 8 IR + 8 IT contexts, quirks 0x2
> firewire_core 0000:05:00.0: created device fw0: GUID 7856341278563412, S800
> firewire_ohci 0000:05:00.0: isochronous cycle inconsistent
> firewire_core 0000:05:00.0: created device fw1: GUID 000a3500ada83262, S400
> firewire_core 0000:05:00.0: phy config: new root=ffc0, gap_count=5
> ```

Before printing 'created device fw1', Linux FireWire subsystem already
initiates asynchronous transactions to retrieve content of configuration
ROM located in 0x'ffff'f000'0400 of node address space. If you can see
no transaction record but see the print, it means to fail configuration
of the parameter of firewire-ohci module.

I think your system uses initramfs. Any node for storage function in
IEEE 1394 bus is available as initial boot disk, thus it's reasonable
that the designer of your initramfs puts firewire-ohci/firewire-core
modules into it. In the case, we can not configure module by
'/etc/modprobe.d/*' since the modules are already loaded before mounting
root file system.

I think the design of initramfs differs depending on distribution, thus
you need to find instruction for the way to configure module parameter
by yourself.

Instead, I suggest you to configure the module via sysfs after booting,
like:

```
# echo 5 > /sys/module/firewire_ohci/parameters/debug
```

Then retry detection of node for your Fireface 800. When turning off the
debug print, write 0 to the node of sysfs.


Regards

Takashi Sakamoto
