Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA77C433F5
	for <linux-rt-users@archiver.kernel.org>; Tue, 10 May 2022 08:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbiEJIrS (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 10 May 2022 04:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232706AbiEJIrQ (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 10 May 2022 04:47:16 -0400
Received: from mail.pcs.gmbh (mail.pcs.gmbh [89.27.162.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DACDA2A28DF;
        Tue, 10 May 2022 01:43:18 -0700 (PDT)
Received: from mail.csna.de (mail.csna.de [89.27.162.50])
        by mail.pcs.gmbh with ESMTPA
        ; Tue, 10 May 2022 10:43:15 +0200
Received: from EXCHANGE2019.pcs.ditec.de (mail.pcs.com [89.27.162.5])
        by mail.csna.de with ESMTPA
        ; Tue, 10 May 2022 10:43:15 +0200
Received: from EXCHANGE2019.pcs.ditec.de (192.168.8.214) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 10:43:15 +0200
Received: from lxtpfaff.pcs.ditec.de (192.168.9.96) by
 EXCHANGE2019.pcs.ditec.de (192.168.8.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22
 via Frontend Transport; Tue, 10 May 2022 10:43:15 +0200
Date:   Tue, 10 May 2022 10:43:15 +0200
From:   Thomas Pfaff <tpfaff@pcs.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>, <linux-rt-users@vger.kernel.org>
Subject: Re: [PATCH v3] irq/core: synchronize irq_thread startup
In-Reply-To: <87mtg0m2jb.ffs@tglx>
Message-ID: <e64aa9cb-a1ae-7534-8bf1-446d9d8c512@pcs.com>
References: <552fe7b4-9224-b183-bb87-a8f36d335690@pcs.com> <87mtg0m2jb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-KSE-ServerInfo: EXCHANGE2019.pcs.ditec.de, 9
X-KSE-AntiSpam-Interceptor-Info: white sender email list
X-KSE-AttachmentFiltering-Interceptor-Info: protection disabled
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 10.05.2022 06:00:00
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org



On Mon, 2 May 2022, Thomas Gleixner wrote:

> On Mon, May 02 2022 at 13:28, Thomas Pfaff wrote:
> > While running
> > "while /bin/true; do setserial /dev/ttyS0 uart none;
> > setserial /dev/ttyS0 uart 16550A; done"
> > on a kernel with threaded irqs, setserial is hung after some calls.
> >
> > setserial opens the device, this will install an irq handler if the uart is
> > not none, followed by TIOCGSERIAL and TIOCSSERIAL ioctls.
> > Then the device is closed. On close, synchronize_irq() is called by
> > serial_core.
> 
> This comment made me look deeper because I expected that free_irq()
> would hang.
> 
> But free_irq() stopped issuing synchronize_irq() with commit
> 519cc8652b3a ("genirq: Synchronize only with single thread on
> free_irq()"). And that turns out to be the root cause of the problem.
> I should have caught that back then, but in hindsight ....
> 

Sorry for coming back to this again late, but this makes me believe that 
the real problem for the freeze in setserial is that uart_port_shutdown() 
is calling synchronize_irq() after free_irq(), which is illegal in my 
opinion.

It can be done only before the interrupt thread is stopped, and free_irq() 
itself is already taking care about synchronizing, no matter if its done by 
__synchronize_hardirq() or by synchronize_irq(), like it was before commit 
519cc8652b3a.
If it is called after free_irq(), the context is already lost.

I am not sure about all the other drivers, but at least serial_core should 
be fixed if you agree.

Thanks,
    Thomas


