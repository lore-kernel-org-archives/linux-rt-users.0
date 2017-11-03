From: "Pavel V. Panteleev" <panteleev_p@mcst.ru>
Subject: Re: schedule under irqs_disabled in SLUB problem
Date: Fri, 3 Nov 2017 13:23:15 +0300
Message-ID: <59FC4393.8030005@mcst.ru>
References: <CADF-jezvVP2O++FR2KiRSSSJF7oObjy8LSP3-yj1HCmxyTzB_Q@mail.gmail.com>
 <20171102165009.u7a7ahmmywo2qugd@linutronix.de>
 <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: linux-rt-users@vger.kernel.org
Return-path: <linux-rt-users-owner@vger.kernel.org>
Received: from tretyak2.mcst.ru ([80.84.125.22]:36975 "EHLO tretyak2.mcst.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750971AbdKCKXc (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 3 Nov 2017 06:23:32 -0400
Received: from frog.lab.sun.mcst.ru (root@frog.lab.sun.mcst.ru [172.16.4.50])
        by tretyak2.mcst.ru (8.13.4/8.12.11) with ESMTP id vA3ANIx0025406
        for <linux-rt-users@vger.kernel.org>; Fri, 3 Nov 2017 13:23:26 +0300
Received: from [192.168.1.7] (e2k7.lab.sun.mcst.ru [192.168.1.7])
        by frog.lab.sun.mcst.ru (8.13.4/8.12.11) with ESMTP id vA3ANF0m017588
        for <linux-rt-users@vger.kernel.org>; Fri, 3 Nov 2017 13:23:15 +0300
In-Reply-To: <CADF-jexLs9vRuiuoRmcA+0L6Mp-XxW75okheWV+ipGf1b_Ua1w@mail.gmail.com>
Sender: linux-rt-users-owner@vger.kernel.org
List-ID: <linux-rt-users.vger.kernel.org>

I'll try Sebastian's patch on the next week. Thanks!
