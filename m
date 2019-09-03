Return-Path: <SRS0=pNo3=W6=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83ADCC3A5A2
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Sep 2019 07:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626AC22CF8
	for <linux-rt-users@archiver.kernel.org>; Tue,  3 Sep 2019 07:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfICHav convert rfc822-to-8bit (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 3 Sep 2019 03:30:51 -0400
Received: from mailin.dlr.de ([194.94.201.12]:37765 "EHLO mailin.dlr.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725888AbfICHav (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 3 Sep 2019 03:30:51 -0400
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2019 03:30:48 EDT
IronPort-SDR: bBXGLNwqc9sw20/rClLJKOe6Z5Dof8W87Y1Y61au/zcQzJpmm8zGmNa2QhFmyT5pUTVbJZlQza
 Dq2+mTJZcbZw==
IronPort-PHdr: =?us-ascii?q?9a23=3AR5hDLxUgxwx8IQukVews4u66DCzV8LGtZVwlr6?=
 =?us-ascii?q?E/grcLSJyIuqrYbBCCt8tkgFKBZ4jH8fUM07OQ7/m6HzVfuN3Y6S5KWacPfi?=
 =?us-ascii?q?dNsd8RkQ0kDZzNImzAB9muURYHGt9fXkRu5XCxPBsdMs//Y1rPvi/6tmZKSV?=
 =?us-ascii?q?3wOgVvO+v6BJPZgdip2OCu4Z3TZBhDiCagbb9oIxi6sBvdutMLjYZgN6o9xQ?=
 =?us-ascii?q?bFrmZJdu9L2W5mOFWfkgrm6Myt5pBj6SNQu/wg985ET6r3erkzQKJbAjo7LW?=
 =?us-ascii?q?07/dXnuhbfQwSB4HscSXgWnQFTAwfZ9hH6X4z+vTX8u+FgxSSVJ8z2TbQzWT?=
 =?us-ascii?q?S/86dmTQLjhSkbOzIl9mzcl8p9h79Zrh28vRxy247abp+IOvpicK3TftIaSn?=
 =?us-ascii?q?ZOUMleTCFBHpq8Yo8TA+YdIepUsY/wrEYOoxukAgmsAfvixzhPiHDsx606z+?=
 =?us-ascii?q?UhEQfc0AMgHtIOqmjUrNXuOagPVeC11rPEwijdYP5P3zr29YvGcgg5rP2RQb?=
 =?us-ascii?q?58a9fdxEogGg/fk1mdp4/oMymI2ukCq2SX8vZsWfiyh2MkpAx9uCWjy8kvh4?=
 =?us-ascii?q?XTmI4Yyl/J+T1kzIs0IdC0UlB3bN6rHZdKtyyWLY97Tt8kTmp1oig10KcGto?=
 =?us-ascii?q?S+fCUSzZQnwAPQZOKffoiT5xLjSP6RITBlhHJ5YL6/hwi98UynyuDkWMe61l?=
 =?us-ascii?q?hEoCVFnNfMsX4D1Bvd5NKbRvZy8Umu2CiC2xrS6uFCPUA0j7DUJ4Q8zb40jJ?=
 =?us-ascii?q?ofq1nMETHulEX3iq+ZaFkk9/C15+j7eLnqu5yROoBuhg3jPKkjmdazDfk3Pw?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7nK7Dv5DAOcQbp6i5DxVV3YYi8Ra/Ezem3c?=
 =?us-ascii?q?8FknkDNlJJYg+IgJbxN1HUPP/4Feu/g0irkDpzw/DGP7vhAojCL3TairfhYa?=
 =?us-ascii?q?9x61NHyAUt19Bf/IlZCq8OIP3tQE/9rt/YAQEjMwyy3ennDM9x1oQEWWKAGq?=
 =?us-ascii?q?WZKr/dsUeU5uIzJOmBfJQauDfyK/c7/fHuln84lEQZfamo25sXdWy4Hu5hI0?=
 =?us-ascii?q?WfYHrtjc0NHnoUsVl2cOu/3FmDVyNDImyuGr8n6ysgIJypAJ2FRY23hrGFmi?=
 =?us-ascii?q?ChEcsFSHpBDwXYNH7ya4SCHcgNcj6SCsNliHoIWO7yGMcayRiyuVqimPJcJe?=
 =?us-ascii?q?3O93hAuA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HjDQCRFG5d/w6KuAplHQEBBQEHBQG?=
 =?us-ascii?q?BZwKBZwWBA4FNlzGZFgkBAQEBAQEBAQE3AQGEPwKDEjgTAgMIAQEFAQEBAQE?=
 =?us-ascii?q?GBAEBAoYjQgEQAYFmIoJyAT02CRIBKhRCJgEEDg0TsRaKRoE0AY4OgVeHUEu?=
 =?us-ascii?q?CcIImBKssbQeBO2qUc41aiwyoTkyBLnGDPIJNF4EEAQeNFoYfiRmBIwEB?=
X-IronPort-AV: E=Sophos;i="5.64,462,1559512800"; 
   d="scan'208";a="21516107"
From:   <Martin.Wirth@dlr.de>
To:     <linux-rt-users@vger.kernel.org>
CC:     <bigeasy@linutronix.de>
Subject: Long latencies during disk-io
Thread-Topic: Long latencies during disk-io
Thread-Index: AdViKHO+FfcazwTSRQyE6lOjoeuKGA==
Date:   Tue, 3 Sep 2019 07:23:35 +0000
Message-ID: <1A2AF5F768264E479963C4D8C015EB696C50C6BB@DLDEFFMIMP02EXC.intra.dlr.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tm-snts-smtp: 82062BB2F1D5D1DD702506EA1C71D590E9467C1BBFD449F3C01C392F7210BD332000:8
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I'm operating a data acquisition system with several digitizer cards and an Adlink  cPCI-6530
 (i7-4700EQ  / Intel QM87 chipset) cpu card. The digitizer cards are hardware triggered with
an external low jitter clock at 200 Hz. I monitor the wakeup latencies and with older 
rt-kernels (4.14) I get maximum latencies of about 24 micro seconds most of the time
with extremely rare spikes of 50 micro seconds under medium other system load.

I now switched to 4.19 and 5.2 rt kernels and suddenly got latencies of 500 micro seconds
and one time I even noticed 1.5 ms, if there is concurrent SATA disk traffic going on (not
from the same DAQ-process, but unrelated file copies for example). I played a bit with different
configurations and found that the long latencies only occur if the ahci interrupt thread is on
the same processor as the interrupt thread of the digitizer card. If I separate them via the
 /proc/irq interface the latencies are gone. The real-time priority of the digitizer IRQ handler
 is set to 53 and that of the corresponding user space thread to 51. The ahci interrupt
 thread is at the standard value of 50.     

Although I now have the solution to put the ahci-handler on a different processor, I would
like to know if it is expected behavior that the ahci interrupt handler blocks other interrupt 
threads of higher priority for more than one millisecond?

Another observation which I cannot understand though, is that a concurrent 
cyclictest -m -Sp98 -i200 -h400 -n
run does not show the latencies...

Does anyone have an explanation for this? As said above this is absent on 4.14-rt and
I observed it with 4.19.59-rt24, 5.2.9-rt3 and 5.2.10-rt5.

Cheers,

Martin

