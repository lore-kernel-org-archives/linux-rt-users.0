Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBA4C433F5
	for <linux-rt-users@archiver.kernel.org>; Wed,  5 Jan 2022 21:40:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiAEVkB (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 5 Jan 2022 16:40:01 -0500
Received: from mail.punkt-k.de ([5.180.65.207]:44538 "EHLO mail.punkt-k.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244548AbiAEVjw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 5 Jan 2022 16:39:52 -0500
X-Greylist: delayed 2262 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Jan 2022 16:39:52 EST
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=dehnhardt.org; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:To:Subject:From:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jq+DlxaisFempPqUN77I3VjSwvqRcJv9r5pCkPI0Vks=; b=sdGw0ilXkT9fk2oOeOhPsJyKUC
        wmq7rXm0Rrz7QgZCggbPbVM2opaTfcFwghkRpyp3en4SFAoKFOoAuevvQl1whF5LhydZXDXRJ/fLC
        351TjDD8BHC0PoNvJJXPpDOOROmONamGuEai1twxfjNDbSi93TtgRck5iSKLKZBCgtH19x/Ru9AZe
        1EZ+l0D0y0v+fw2TUWYwn2uEN2ntA2Wi7/tUOW6vpNCmXhI0S/P939HWBJRrYmpvGx8f3HX6vzsEy
        Pz+2UYDZO7jUpplYpjwxNyuFFjJ6I/3cG8FjdwrnwH2x5fbyrR3b4jugMOfSbILzyGcaB1T3Ugf42
        Pu1TDtxw==;
Received: from p4fc95a37.dip0.t-ipconnect.de ([79.201.90.55]:42420 helo=[192.168.201.44])
        by mail.punkt-k.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <holger@dehnhardt.org>)
        id 1n5DQ5-0000Sc-TL; Wed, 05 Jan 2022 22:02:05 +0100
From:   Holger Dehnhardt <holger@dehnhardt.org>
Subject: Re: firewire-ohci fails to initialize Texas Instruments
 XIO2213A/B/XIO2221 based controller on realtime kernels [5.4.91-rt50,
 5.10.8-rt24]
To:     David Runge <dave@sleepmap.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux1394-devel@lists.sourceforge.net,
        linux-rt-users@vger.kernel.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
References: <20210208091940.csuyf7l73n4ofpmz@linutronix.de>
 <YCl28sXo7LEyCK8y@hmbx> <20210218083849.iitcrhdgv2oajfhv@linutronix.de>
 <20210218092751.ahn262llcpp2loz7@linutronix.de>
 <20210308141210.yoa37dsc26p4jsim@linutronix.de> <YEkMvjJt/Vu9Jbgu@hmbx>
 <YTfy7pLhWkTOn+aI@hmbx> <YTgdLkTs7wEmj8fh@workstation>
 <20210910115541.jjf3fovv4v3etvde@linutronix.de>
 <YTx7EVV5vFuhKM5i@workstation> <YT5MvpE5yrqj/5WI@hmbx>
Message-ID: <90f0895e-0629-a921-0af7-ddb5a6552ba0@dehnhardt.org>
Date:   Wed, 5 Jan 2022 22:01:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YT5MvpE5yrqj/5WI@hmbx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-List: Yes
X-SA-Exim-Connect-IP: 79.201.90.55
X-SA-Exim-Rcpt-To: a.darwish@linutronix.de, linux-rt-users@vger.kernel.org, linux1394-devel@lists.sourceforge.net, bigeasy@linutronix.de, dave@sleepmap.de
X-SA-Exim-Mail-From: holger@dehnhardt.org
X-SA-Exim-Scanned: No (on mail.punkt-k.de); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 12.09.21 20:53, David Runge wrote:
> 
> Thanks at any rate to look into this! It is much appreciated!
> 
> Is there anything further I can try to debug this using threadirqs? It
> would be really amazing to be able to use this device on PREEMPT_RT
> again (especially given that now the ALSA driver has improved so
> drastically). :)
> 
> Best,
> David
> 


Hi,
since a processor and BIOS update I ran into the same problems as David.

* former processor alt: AMD Ryzen 2 0600X 6-Core
* new processor neu: AMD Ryzen 7 3700X 8-Core Processor
* kernel (Ubuntu): 5.4.0-91-lowlatency #102-Ubuntu SMP PREEMPT Fri Nov 5 
18:18:39 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux
* chipset: AMD B450
* firewire card:
05:00.0 FireWire (IEEE 1394): Texas Instruments XIO2213A/B/XIO2221 
IEEE-1394b OHCI Controller [Cheetah Express] (rev 01) (prog-if 10 [OHCI])
         Subsystem: Device 3412:7856
         Flags: bus master, 66MHz, medium devsel, latency 32, IRQ 36
         Memory at fc204000 (32-bit, non-prefetchable) [size=2K]
         Memory at fc200000 (32-bit, non-prefetchable) [size=16K]
         Capabilities: [44] Power Management version 3
         Kernel modules: firewire_ohci

I did not change the kernel version - it worked before upgrading the 
processor and BIOS with the same kernel!

Now jack or alternatively "ffado-test Discover" immediately get 
zombified when I try to start them.
In addition to Davids findings a can add the following:
Under some weird circumstances I got the card to work (once immediately 
after loading BIOS to defaults and three times after an unsuccessful try 
to downgrade the BIOS).
Appended are two dmesg outputs one in which the card is initialized 
correctly [1], one in which the card did not work [2].
Another finding was, that after the driver was trying some time to read 
the config ROM, it gave up and, did a bus reset and everything was fine [3].

I just have build the kernel modules with some mor debugging output. So 
if there's something I should try, just give me intructions ;-)

Holger

[1]
https://cloud.dehnhardt.org/s/Z7jwqT9y3x6JgbE

[2]
https://cloud.dehnhardt.org/s/GAm2MjSqdbYDcod

[3]
[Mo Jan 3 18:41:53 2022] firewire_ohci 0000:05:00.0: added OHCI v1.10 
device as card 0, 8 IR + 8 IT contexts, quirks 0x2
[Mo Jan 3 18:41:53 2022] firewire_core 0000:05:00.0: created device fw0: 
GUID 7856341278563412, S800
[Mo Jan 3 18:41:53 2022] firewire_core 0000:05:00.0: phy config: new 
root=ffc1, gap_count=5
[Mo Jan 3 18:45:59 2022] Workqueue: firewire fw_device_workfn 
[firewire_core]
[Mo Jan 3 18:45:59 2022] fw_run_transaction+0xdc/0x110 [firewire_core]
[Mo Jan 3 18:45:59 2022] ? fw_core_handle_bus_reset+0x440/0x440 
[firewire_core]
[Mo Jan 3 18:45:59 2022] ? close_transaction+0x110/0x110 [firewire_core]
[Mo Jan 3 18:45:59 2022] ? transmit_phy_packet_callback+0x20/0x20 
[firewire_core]
[Mo Jan 3 18:45:59 2022] read_rom+0x5e/0xa0 [firewire_core]
[Mo Jan 3 18:45:59 2022] read_config_rom+0x8b/0x3d0 [firewire_core]
[Mo Jan 3 18:45:59 2022] fw_device_init+0x35/0x320 [firewire_core]
[Mo Jan 3 18:45:59 2022] fw_device_workfn+0x12/0x20 [firewire_core]
[snip...]
[Mo Jan 3 19:04:25 2022] Workqueue: firewire fw_device_workfn 
[firewire_core]
[Mo Jan 3 19:04:25 2022] fw_run_transaction+0xdc/0x110 [firewire_core]
[Mo Jan 3 19:04:25 2022] ? fw_core_handle_bus_reset+0x440/0x440 
[firewire_core]
[Mo Jan 3 19:04:25 2022] ? close_transaction+0x110/0x110 [firewire_core]
[Mo Jan 3 19:04:25 2022] ? transmit_phy_packet_callback+0x20/0x20 
[firewire_core]
[Mo Jan 3 19:04:25 2022] read_rom+0x5e/0xa0 [firewire_core]
[Mo Jan 3 19:04:25 2022] read_config_rom+0x8b/0x3d0 [firewire_core]
[Mo Jan 3 19:04:25 2022] fw_device_init+0x35/0x320 [firewire_core]
[Mo Jan 3 19:04:25 2022] fw_device_workfn+0x12/0x20 [firewire_core]
[Mo Jan 3 21:03:50 2022] firewire_core 0000:05:00.0: giving up on node 
ffc0: reading config rom failed: bus reset
[Mo Jan 3 21:03:51 2022] firewire_core 0000:05:00.0: rediscovered device fw0
[Mo Jan 3 21:03:56 2022] firewire_core 0000:05:00.0: rediscovered device fw0
[Mo Jan 3 21:03:56 2022] firewire_core 0000:05:00.0: phy config: new 
root=ffc1, gap_count=5
[Mo Jan 3 21:04:01 2022] firewire_core 0000:05:00.0: created device fw1: 
GUID 000ff20400001d98, S400
