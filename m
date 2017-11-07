From: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Tue, 7 Nov 2017 12:47:27 +0300
Message-ID: <5A01812F.7040406@mcst.ru>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
 <59FC4393.8030005@mcst.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tretyak2.mcst.ru ([80.84.125.22]:34793 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753174AbdKGJra (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 7 Nov 2017 04:47:30 -0500
Received: from frog.lab.sun.mcst.ru (root@frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (8.13.4/8.12.11) with ESMTP id vA79lT8s020176
        for <linux-rt-users@vger.kernel.org>; Tue, 7 Nov 2017 12:47:29 +0300
Received: from [192.168.1.7] (e2k7.lab.sun.mcst.ru [192.168.1.7])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id vA79lROU022518
        for <linux-rt-users@vger.kernel.org>; Tue, 7 Nov 2017 12:47:27 +0300
In-Reply-To: <59FC4393.8030005@mcst.ru>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

Thanks, it works.
