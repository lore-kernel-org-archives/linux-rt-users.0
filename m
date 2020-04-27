Return-Path: <SRS0=jUvr=6L=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 704E9C54FCB
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 13:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F42074F
	for <linux-rt-users@archiver.kernel.org>; Mon, 27 Apr 2020 13:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="gIjGZLjV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgD0NKH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:10:07 -0400
Received: from mail-eopbgr00099.outbound.protection.outlook.com ([40.107.0.99]:18179
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726651AbgD0NKH (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 27 Apr 2020 09:10:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LkWfoqcJXjQYHKYApnPNFF5UrK7UEm/+00twEQLTwl8KRRrE6EjB2YplGbIveHZfi5PHhYCaVL/bA07iOcx0igW4dVLkYK1rYzWd9keF4sqwSAdvuddzwBhAlRq3F4qkmT7S0e5mSTGow/F4/TfpOvc3FEhCB1d+mykOMX3a51ujoB/BYozvZfrK3PoQ01JwX9dRpEsipXRsIb7k8G0SW9mnCZGV84xx78tXRcFLkLriLtKK21YYJ2mdImHY+I1TxIqMjTgn6E4BzflehCc2YLinYsEfRQYeS1mRE/ui/V/GK/du3h6UIdCIy6yL/UaclLQ+1U9mQdlRiNPo0DT4xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqCcrceK9gH25lhEB51lREmohX/69QPuq//GqXp2rsE=;
 b=KL2I8ETRb3PT6qTtMhcXEF6AN7gxwVaVGov/7n6oXTTriiA8r5eNbZ8wEl3e//Z4XalqyRFbSm8g6cOfuE8zTgZUMHqB5qWbgKzOG11ae05BKFbfoxlLkA9AJIe8GPpPqoE83dyZVkRvht5EkNT1amUwwUOzwUTT+BLppDXcd5PEf2Sp5e0U1yGMtzL35atnBkVMppNzAOHcCYoHdzHw2KI9J21tYOlbdwE98zjaESoJn33i7knvpwEJ2iM1/d8YEvrRvnqr6kEj+S2rjeO7CxH3EMrqFb95/U2NLpOSpeLwPyN+s/Agwh+0qjmAJVQF/0YI1h3NxE6R+wkdwz9Gcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DqCcrceK9gH25lhEB51lREmohX/69QPuq//GqXp2rsE=;
 b=gIjGZLjVyqsLHj/mFKJSvdIWD7Gn9Xgrz4EBZTlCkc2Wq7IdJ7spf2qoz+alXWHVCJhHzILCazj8o9Ym+F8DwcBmyVyBtOnIKreWEaOQIXeVO8/Em1ONS7jbluwBgwM64H4s5vQWIkgUrKb8V0Qskyet/A6DsFSixMMKZae6rIU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rasmus.villemoes@prevas.dk; 
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e1::21)
 by VI1PR10MB2080.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:3a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 13:10:02 +0000
Received: from VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa]) by VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f0ac:4e97:2536:faa%7]) with mapi id 15.20.2937.020; Mon, 27 Apr 2020
 13:10:02 +0000
Subject: Re: [PATCH RT 10/30] hrtimer: Prevent using
 hrtimer_grab_expiry_lock() on migration_base
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Julien Grall <julien.grall@arm.com>
References: <20200123203930.646725253@goodmis.org>
 <20200123203943.749508731@goodmis.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <ac4168c7-68d6-e558-644e-e0daceea1f61@prevas.dk>
Date:   Mon, 27 Apr 2020 15:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200123203943.749508731@goodmis.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:203:69::20) To VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (5.186.116.45) by AM5PR0202CA0010.eurprd02.prod.outlook.com (2603:10a6:203:69::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 13:10:01 +0000
X-Originating-IP: [5.186.116.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84950678-f2c7-4315-ec09-08d7eaac4bd3
X-MS-TrafficTypeDiagnostic: VI1PR10MB2080:
X-Microsoft-Antispam-PRVS: <VI1PR10MB20809730521A40DFE673B56093AF0@VI1PR10MB2080.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB2765.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39850400004)(31686004)(44832011)(956004)(2616005)(26005)(4326008)(7416002)(2906002)(52116002)(36756003)(316002)(54906003)(5660300002)(6486002)(86362001)(16526019)(8976002)(31696002)(66556008)(478600001)(966005)(186003)(110136005)(8676002)(66946007)(81156014)(16576012)(66476007)(8936002);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: prevas.dk does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HMSnnPg/sWCjAnCC+czhSZAAc1dJ/EXg4c1nw+RKkUJD3XsFRRLmeyhZ1xfN+aVheMe3xVJnmisRQdQaN2Plr9BosztmsmzNoUVamBKc9wEc5tfueQpd3QbOs269KKQn+MbDXVv+UVA2TYTEKtLzXCHxUJPJAq3pw4oNZwmIpquKcMRyhwR1s9jtJFaY+qE+/poXHjqHOOzLK+6UAQB7+45km3bCIUKr4QlKuzZboHRWMwtn7mULm5dv313jnwb2hoe94U1El4mw8c4Oeb3bc48N02vpUAZAl2TBcDPvL8KQtMUNNH8L/D7kkZ/vpDimfdtj9HvTi7AohINAxNAfwoS6VV2bOlrqljbdaBlB6wpPP9SrD/xtuftupUgCF29uXRkG0VPjti8IGYwIMLgbDbDxfUqUfwhPXGwzq7ih+T0d1bn+qqTmGcRRWmFf5vgiJo1JERL635QY1bLlig55LfFGbnC7gZQLl39v4sqg26OcykSYopRb9MANMN+RZhxxZOy2qlvVy3KyZ7nbrx5H/g==
X-MS-Exchange-AntiSpam-MessageData: lbXtgZkwl0F/ope9s0w0HyCBksXImQ4BP91CFyx5GKk1SDttJppqHF1xuT22f/Rg71cz9MnNX28ChCkTb23PLtvMBehNDYF4xKHB5hV58opruGecGpoczmp/qyduJMRV7VndpHBgE7tbCkyGxsWJs2cU/29c05lcDdForHL8h+IV3+mqO7bROWsqFWamOBx8S7us8U2UelirNsftxfcKxYIhCjJKvJwssuNw3ZXMnd2PGFxcfLfJJvsbz1PNcuWWDNPD6hJ2kO9uwd+ug4FFz0sc71BRbybxhmF+DW1Mhzz0l3jUTipAqqYeqtrmKkTG1u6Lg3v97CmCHhwHCxb/rI4krCO5tOvL/wHv7RsgpfnC14+dT56S1pxq6Xko7+Lpd6Ts2GpSoaiaTjQufUqUq7Qi8mRLmPfuYwfEM7jInQa2KXCM5sZ3E0jr4XOhO83PUEiswd9fZfFqbQZEasPM9Em+AEeHAsswksLECoybereSfk+nROk/GmvtRE6BssW0/1N2PeUUd1BXds963DzqUwZPQXeb7Kax1nwOWuzUP+7qTE2rJxY7qrCsqE50daQ0akdxCQR6oQg+Kim9l02r1WMkZwjNY6jsh+9/UmsS9uaXx+hv/JOAAYY05vhp1WjMH/MBOJ9gCEJCPN9L0z3Vy5jd7P8xC/rjXaPErfmMJNfy3Avkcm3pCPDIxxS1OVZ1L58qJzUl71TckGwXxayQ1GlN5e9RAiH4nd74pV0Sdh7OXAA+vxV7nISub/RyJsKHcCXrPoII/ZL3DGpmPmspoESieaZU6a9LyoXevkZ3doY=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 84950678-f2c7-4315-ec09-08d7eaac4bd3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 13:10:02.7986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n2tlZImp0ERGtHOSrCjMr/3H2icuk389LWpUP4iGbtYWtqi+BcLvNfegZSLWglWJvqbsZKJBhVD9bA7A9V7O48XbTyOqyOTaEtp3aRqW0vQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2080
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 23/01/2020 21.39, Steven Rostedt wrote:
> 4.19.94-rt39-rc2 stable review patch.
> If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Julien Grall <julien.grall@arm.com>
> 
> [ Upstream commit cef1b87f98823af923a386f3f69149acb212d4a1 ]
> 
> As tglx puts it:
> |If base == migration_base then there is no point to lock soft_expiry_lock
> |simply because the timer is not executing the callback in soft irq context
> |and the whole lock/unlock dance can be avoided.
> 
> Furthermore, all the path leading to hrtimer_grab_expiry_lock() assumes
> timer->base and timer->base->cpu_base are always non-NULL. So it is safe
> to remove the NULL checks here.
> 
> Signed-off-by: Julien Grall <julien.grall@arm.com>
> Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1908211557420.2223@nanos.tec.linutronix.de
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> [bigeasy: rewrite changelog]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Pretty late to the party, but I think I've bisected a problem to this
patch (and its required fixup for !SMP, "hrtimer: Add a missing bracket
and hide `migration_base on !SMP").

Originally, a customer reported that upgrading from 4.19.82-rt30 to
v4.19.106-rt45 failed to boot, stalling around the time the network gets
initialized (this is a board with an embedded Marvell switch). Perhaps 1
in 10 times, the board would come up successfully. I haven't been able
to reproduce that particular problem (or, perhaps I've seen it once or
twice, but not nearly often enough to use that as a basis for bisection).

However, building with their rescue initrd and booting that, the board
would consistently hang during reboot. Sometimes I would get lines like

[   72.956630] sched: RT throttling activated
[   72.973769] lanx: port 1(lan1) entered disabled state
[   73.000401] lanx: port 2(lan2) entered disabled state
[   73.974951] lanx: port 3(lan3) entered disabled state
[   73.997473] lanx: port 4(lan4) entered disabled state
[   74.968006] lanx: port 5(lan5) entered disabled state

other times there would be no output, but the board was still hanging.
Reverting

b1a471ec4df1 - hrtimer: Prevent using hrtimer_grab_expiry_lock() on
migration_base
40aae5708e7a - hrtimer: Add a missing bracket and hide `migration_base'
on !SMP

on top of v4.19.94-rt39 makes that problem go away, i.e. the board
reboots as expected.

The board is a 32 bit powerpc (mpc8309) !SMP. Any ideas what I can do to
debug this further?

Thanks,
Rasmus
