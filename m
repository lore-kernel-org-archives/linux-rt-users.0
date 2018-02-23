Return-Path: linux-rt-users-owner@vger.kernel.org
Received: from mail-oi0-f50.google.com ([209.85.218.50]:45647 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751158AbeBWBXL (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 22 Feb 2018 20:23:11 -0500
Received: by mail-oi0-f50.google.com with SMTP id j79so5160769oib.12
        for <linux-rt-users@vger.kernel.org>; Thu, 22 Feb 2018 17:23:11 -0800 (PST)
MIME-Version: 1.0
From: Diana Burgess <diana@peloton-tech.com>
Date: Thu, 22 Feb 2018 17:23:10 -0800
Message-ID: <CADJaPTADCHOgHJYJYkaR0pboqNZH_jH_zY0vWAzMxp1NBLTDcA@mail.gmail.com>
Subject: peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is occupied!
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>
To: s.grosjean@peak-system.com, linux-can@vger.kernel.org, linux-rt-users@vger.kernel.org
Cc: Philipp Schrader <philipp@peloton-tech.com>

Hi,

I am seeing the following error:

peak_pciefd 0000:06:00.0 can1: can_put_echo_skb: BUG! echo_skb is occupied!

I am running 4.13.10-rt3 kernel using the following PCIe card connect
to my board:

06:00.0 Network controller: PEAK-System Technik GmbH Device 0013 (rev 01)
    Subsystem: PEAK-System Technik GmbH Device 0014
    Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B- DisINTx-
    Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
    Latency: 0, Cache Line Size: 64 bytes
    Interrupt: pin A routed to IRQ 16
    Region 0: Memory at fb100000 (32-bit, non-prefetchable) [size=64K]
    Capabilities: <access denied>
    Kernel driver in use: peak_pciefd

This occurs when I am sending messages over the CAN bus with
and without the other device on the bus also sending.

I have not seen this issue with other can devices in similar setups
 (different kernel versions). It also only seems to occur on CAN1 which is
set to a higher baud rate then all the other buses.

I do have CONFIG PREEMPT RT turned on which might be exposing this
issue more often.

Has anyone seen this before? Does anyone know how to fix this or have a fix?

Thanks,
Diana Burgess
