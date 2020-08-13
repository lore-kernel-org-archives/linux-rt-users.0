Return-Path: <SRS0=doyN=BX=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C110FC433DF
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 08:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0EF204FD
	for <linux-rt-users@archiver.kernel.org>; Thu, 13 Aug 2020 08:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="S55IP4sW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMIZx (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:25:53 -0400
Received: from mail-db8eur05on2097.outbound.protection.outlook.com ([40.107.20.97]:31457
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726044AbgHMIZw (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 13 Aug 2020 04:25:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1NZz8gg8wpIfH4EfHWVQpMTTVfQPv61D7qkhX6eEvcu1KsbgXVNtGhDcnKWHHTcX3dnBmtyB2I96rxKAtN/f7/PXTRU+hkRk4iVQY4bXJNqA+wUY/5LwCsgc9Pwz44S30JA+Hw2800BdpzaI7chjEzEKCw/nGSEg3PbwzIu/GSaPE4esXfHicaZuywEUYt22bWWSprvpgbtwVLaRl2AT7zAblN6yayjv9Ca9o2s3Qd2xaXgHSQkXBjlJ3r3F1DFgpb40yrbhZCCjPveN+JOzy1YeaJhwJEj+XTz4sxI+qxD4cUn35lboGsp6CC8hf2dMGqQhxhPCx7gRoYnuCZm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnZ6m8XpY9wUwzkmQYzS6XJbHQDxT2Yk2QUKfjWOnvo=;
 b=GVorOxNAvzn4uIbghsFzHEBlw7he0qMkTjWDPUs4AAzO6G3Uzs0WhTZzzm5cFtIbK5pvURCMjBPAuxoZQaHQh0gzXKKvsD9yaQb7BFeTvh9Xux3+mT//hstxqGlvhpyxJLK5On2ng57qWh1/en2FEei1MX1VSlcV8HSDRgJ+qxcwlxD7pk+VFXlFiHUBSM3I5ZfPn/ueV6uJkC9iQ8fTbnNcv9a+5bW179Ol8Iud7zuPVgQAhUEFXSyAp1tEfzDYMi7g3+N1wtXtfQwF4frb3aVo5cZlfGvgiqzfo2AMSNwoieEoI+IjGKXfWyPAfSlVKuXeGUav+Y3nfo4Vh3aQYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cnZ6m8XpY9wUwzkmQYzS6XJbHQDxT2Yk2QUKfjWOnvo=;
 b=S55IP4sWYlfaE0QrkDqWDDYqev4gdJSk+UbPo9Vw0f1emEtZcApKO41eqbP6XQFF4KM+vyo5pdvosCPvXI7bGfDALx6VOCSWzaTZ3DYhOlsFA9iJ02G9QlcvLweoS/NdviXyIuGVKaddrB7Gr0hdQ9JTVlGpUwlY8qcPpbEuFfY=
Authentication-Results: codeblueprint.co.uk; dkim=none (message not signed)
 header.d=none;codeblueprint.co.uk; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM8PR10MB4146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1e9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Thu, 13 Aug
 2020 08:25:48 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfb:a3e6:dfc0:37ec]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3cfb:a3e6:dfc0:37ec%3]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 08:25:47 +0000
Subject: Re: [PATCH RT 1/6] signal: Prevent double-free of user struct
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>,
        Matt Fleming <matt@codeblueprint.co.uk>
References: <20200813014534.833107526@goodmis.org>
 <20200813014555.384329363@goodmis.org>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <b4c933e7-62e2-7018-d848-b5cde0d9ef26@prevas.dk>
Date:   Thu, 13 Aug 2020 10:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200813014555.384329363@goodmis.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0108.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::49) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM0PR01CA0108.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Thu, 13 Aug 2020 08:25:46 +0000
X-Originating-IP: [81.216.59.226]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbacc677-6c3b-4434-0ca0-08d83f627af2
X-MS-TrafficTypeDiagnostic: AM8PR10MB4146:
X-Microsoft-Antispam-PRVS: <AM8PR10MB41468D4A90D2EF0A7681360793430@AM8PR10MB4146.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 390+EUX2zeHqHdPnogJ5eRb0uIz+vn3hcZ+bZCc/NXGmvXrHg4hSCCmzAS1CRzzErvwYp4VStbSk1cpEaIC/iaOlNWofY1X3KRJ1Wl4D84oPMpUpWZ9VWy8WCnnS7AhJ0T+whBwNCLdpPkIW5XM2VG9X8Dt2vYqdiAm2qb7qw6Tk9xnSwQOE/HwE1o7oURsL62j0QhPnDaq3lZL1L/VPEZTAFwPuQ4sb7y2hsBPCax0kOchFwTE1/SswaQWtDgc9s4dB2IqwyjyPTVXJYFGw9DNgShkz4+gVb6aM0OXf9NhefuaOLs6rX+IRLF1mm4yhqlbAsISsCpiGibKd3pnHmEKOt6is4Ns0vdYIBoVRRfg/hM8jFnKEXG90DMBYAbL+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(498600001)(2906002)(66476007)(66556008)(66946007)(31686004)(7416002)(31696002)(6486002)(4326008)(8676002)(44832011)(5660300002)(956004)(8976002)(54906003)(86362001)(16526019)(8936002)(26005)(83380400001)(110136005)(16576012)(36756003)(2616005)(52116002)(186003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: CRRQUv+3L7uX/4Ln3VZNk9Rpv3sJVb+wvBvpKlZWOHvP1j0qFXUQqGteGK2+CD6zW3EDzQEPH72S2KnPkJjqc6UpvEmF/M6vm4on+x+1Gs0b48Ch1ENYkSx6mWphTrfdRx3EP68X2enStVZyXyS+yObgihtHw+JY9ZFG/wv4ZtyMTpSnMeyq8AYymijFh7Cqvpk2eL/mIeEg+Bi3sJmcYwpqU2n72IEYc7DqSa+Vwvy5/F5ueOWimVBA09yW+DZYMRJNbLnl69M5T7XTaED7GY5gLvCUG2hAwGPIaanqMKxIrI/zlKRmpZnXda2bBgir5uw6mXbjc2c+QBggNcl9dK6zM/WnhuzgqTvulBWbv01w4FyOC7vMkbwJBYR5Z6lp0eO7QeXxmF87m6qaTX/STJHGX9Ix0/ZaknrvSCcpMEbd8e4O17UoDDzV+sQwbH3SAh3sd1oSo0kJB4Rf6te20PR4XsI1b8c3YvznQ8ousXDR0+Dh8Cn8ZUgcmXeLpl3TQIsjqYQeaT8tIHrwoVtTq/Onsa5WwfgXcPWUts4Vg5seFHGCwHvtIhxZJYVkiBCD9cn891LRi5u7mqX2OHFCXVf8DBCc+3jZMgeW/6TVTTZhV27AVDoEKE97u2pp1EL+ZvnKMcuSoN/ItPM+StKTOA==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bbacc677-6c3b-4434-0ca0-08d83f627af2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 08:25:47.7172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HKzzZCOxfK8dxtu6x0xATQLZCXOXx/IIWYCvLmVY5VBCEYk7LnyG8v9irTI7oRXYOUsP5TeuY/1yOjS2uVFs/COLEgZaHqVY/4uP6yBvBPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4146
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On 13/08/2020 03.45, Steven Rostedt wrote:
> 5.4.54-rt33-rc1 stable review patch.
> If anyone has any objections, please let me know.
>

No objections, quite the contrary. I think this should also be applied
to 4.19-rt:

Commit fda31c50292a is also in 4.19.y (as 797479da0ae9), since 4.19.112
and hence also 4.19.112-rt47. For a while we've tried to track down a
hang that at least sometimes manifests quite similarly

refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 14 at lib/refcount.c:280 refcount_dec_not_one+0xc0/0xd8
...
Call Trace:
[cf45be10] [c0238258] refcount_dec_not_one+0xc0/0xd8 (unreliable)
[cf45be20] [c02383c8] refcount_dec_and_lock_irqsave+0x20/0xa4
[cf45be40] [c0024a70] free_uid+0x2c/0xa0
[cf45be60] [c00384f0] put_cred_rcu+0x58/0x8c
[cf45be70] [c005f048] rcu_cpu_kthread+0x364/0x49c
[cf45bee0] [c003a0d0] smpboot_thread_fn+0x21c/0x29c
[cf45bf10] [c0036464] kthread+0xe0/0x10c
[cf45bf40] [c000f1cc] ret_from_kernel_thread+0x14/0x1c

But our reproducer is rather complicated and involves cutting power to
neighbouring boards, and takes many minutes to trigger. So I tried
Daniel's reproducer

  sigwaittest -t -a -p 98

and almost immediately got a trace much more similar to the one in the
commit message

refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 1526 at lib/refcount.c:280
refcount_dec_not_one+0xc0/0xd8
...
Call Trace:
[cebc9e00] [c0238258] refcount_dec_not_one+0xc0/0xd8 (unreliable)
[cebc9e10] [c02383c8] refcount_dec_and_lock_irqsave+0x20/0xa4
[cebc9e30] [c0024a70] free_uid+0x2c/0xa0
[cebc9e50] [c002574c] dequeue_signal+0x90/0x1a4
[cebc9e80] [c0028f74] sys_rt_sigtimedwait+0x24c/0x288
[cebc9f40] [c000f12c] ret_from_syscall+0x0/0x40

With this patch applied, the sigwaittest has now run for 10 minutes
without problems.

I'll have to run some more tests with our reproducer to see if it really
is the same issue, but even if not, the fact that the sigwaittest fails
should be enough to put this in 4.19-rt.

Three requests (in order of importance):

* pull this into 4.19-rt
* add a note about the sigwaittest reproducer to the commit log
* do publish the rt-rcs in some git repository; that makes it a lot
easier to cherry-pick and test patches

Thanks,
Rasmus
