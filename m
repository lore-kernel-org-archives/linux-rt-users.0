Return-Path: <SRS0=yCAb=37=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BFBC352A3
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 14:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87DBC2086A
	for <linux-rt-users@archiver.kernel.org>; Tue, 11 Feb 2020 14:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=concurrentrt.onmicrosoft.com header.i=@concurrentrt.onmicrosoft.com header.b="4zT/gHyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbgBKOAN (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:00:13 -0500
Received: from mail-eopbgr700095.outbound.protection.outlook.com ([40.107.70.95]:60385
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728080AbgBKOAM (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 11 Feb 2020 09:00:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7x/NfS34eRaX9s3aCKKh3zNeySKbWcckwrL2CXVJN12TTTlXwFPEH6UdWaDEE/rzjyR8vVKpvYvp3iUtm01KeDonJlXdzTw+F0T0uW04Eb+xlXsspgpF5z7Pym4D5WvwM1pqV+6amcypXcEKc++nxucpPGAFbRct9hmKNCU6A0wlFPUPJFUpU/xpwFKOqdZJuj98ttxq4HONal0YdQ4nx5K14OzzkWMKYGiGSiO3v7ndLCBq/ceitbQsE2ulLnUb7QIXwFWnl6zD+bG3Rs9/a5RTysrkpPzY1oCBCK72Z9SDPFX+bibV4qi6PrNV6fpfV9rCuM0fbJq3k0cROUHXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SumIOopN+G2ui0QqnLX12zZmCj/KRtmzV2UXcIdKjSI=;
 b=XSZOV8gaRn7tPgmOMs3W3D+6OogWh8Z45BQcCTn8ACDflKHo5TITAm65WjDoKitqsc0Y+AEt6O4jm8Y2QoSr82+hUloUZalZN26hFsRXNIlXcwQXySeIg4s34t2LgzK3Gl9lda9K+e7A9VEhKkQHvlOQMsXQvwznmWNvO1UpdNDRxmZHnwiiTb+tUM7YYxiikvJ6T8ifcNO9IPCHeM0F77WhStxahqvu7LlIxN2D+8PUMnU1uKs9U01NEXI+a4AQcxxLau8CF1wZlmLWzlOGjHcwT6V5QH09RQeLjrDgE/Wx6r8o2qIXlFiyYzb6dJa1Cl7q+cZNvdhEf6zp9Tx6fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SumIOopN+G2ui0QqnLX12zZmCj/KRtmzV2UXcIdKjSI=;
 b=4zT/gHyS6miPB18jD1FHxeEzTIEq/RGxC/mFINvxc0qNUeys1GZ4q3fxnToblJe8nn23+egnRhqIitwJG76Pe6k2dy8JPhWc9H7r/VVDGoZBTpvuyR9JoOkuaxbM8srN/atD5hfPTeZCrrA809cY58fIEe15BCXqOlNKdNbRm5Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Joe.Korty@concurrent-rt.com; 
Received: from DM6PR11MB2570.namprd11.prod.outlook.com (20.176.103.17) by
 DM6PR11MB3516.namprd11.prod.outlook.com (20.177.220.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.27; Tue, 11 Feb 2020 14:00:09 +0000
Received: from DM6PR11MB2570.namprd11.prod.outlook.com
 ([fe80::4b5:8365:6cda:8f8]) by DM6PR11MB2570.namprd11.prod.outlook.com
 ([fe80::4b5:8365:6cda:8f8%7]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 14:00:09 +0000
Date:   Tue, 11 Feb 2020 09:00:07 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-rt-users <linux-rt-users@vger.kernel.org>,
        joe.korty@concurrent-rt.com
Subject: [PATCH 4.14-rt] Fix wrong-variable use in irq_set_affinity_notifier
Message-ID: <20200211140007.GA6791@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN6PR22CA0068.namprd22.prod.outlook.com
 (2603:10b6:404:ca::30) To DM6PR11MB2570.namprd11.prod.outlook.com
 (2603:10b6:5:ce::17)
MIME-Version: 1.0
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN6PR22CA0068.namprd22.prod.outlook.com (2603:10b6:404:ca::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Tue, 11 Feb 2020 14:00:08 +0000
X-Originating-IP: [12.220.59.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0654da3a-df8d-4baf-f7ef-08d7aefab4b5
X-MS-TrafficTypeDiagnostic: DM6PR11MB3516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB3516E783B948078E87973B07A0180@DM6PR11MB3516.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(396003)(39840400004)(189003)(199004)(66946007)(316002)(186003)(66476007)(16526019)(3450700001)(55016002)(66556008)(19627235002)(2906002)(33656002)(5660300002)(44832011)(107886003)(956004)(81166006)(81156014)(26005)(86362001)(6916009)(508600001)(4326008)(8676002)(52116002)(7696005)(8936002)(1076003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR11MB3516;H:DM6PR11MB2570.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: concurrent-rt.com does not
 designate permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 01BMOE9GyBMzjheNJY7A5A/C0L7RJ9ZIM4M7P1qWEXzS+qnHUIh6C9B47Bp3zHObbdSmN8RUy6uRcRzqlkhrzUfFgs6sXVgphmKbLFyF4tRqlpFuFI+e2ac1wJYuNawwpxAU1B00g6wpZWkJXRUqes45UC4wrzxqdy0FUWqrpCWBForBNxqP82NQ4QrooYcpmpfo1E3D8YBhXzmDqtum5BiTD9gCo4ZtiJc9xwhY07iNzH6TPspu79JrUGoD9rqEH7MKHC/Ke0DCoSOY42ppP/GB48xtRn9Uy3IoTZqHoU5ivYcyDn3PEA24Y1+zpODWAOQFzQ+luQXwfvJ9eYJpqjMogqVjk4uLufnlu3DDLIf3VdiFwX7kWmvkbHsLcotlmb3h3W83lA9p96kFOiEcZqoZ5slJpS1M9kt2ptK64uPZ+4+2qvXvvGoizG5RgMgI
X-MS-Exchange-AntiSpam-MessageData: NFzqahKW4EGSeUis9Acw5eomwWeXolzHhBvCeMUYvwjf6R1i/0cZjShlyVb5ZS3q+r3owlJnHgU4InjeFNqDWLNiU3tVidGT1OMrIMoFxAqCjd/hKP8+7UK9udbT62g6WChOaRTAgw7pCsm4aPHBtQ==
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0654da3a-df8d-4baf-f7ef-08d7aefab4b5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 14:00:09.5894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SKgu3hHPXd64XkH0UKOfNQGCvEcseacvwTN9lgNWmiX3TUYF6uShJprjHpEouQQ3B2tuUKMG5rVq2k4NQ9tibKmtss6uZo3avrSKDadAESo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3516
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

4.14-rt: Fix wrong-variable use in irq_set_affinity_notifier.

The bug was introduced in the 4.14-rt patch
 
   0461-genirq-Handle-missing-work_struct-in-irq_set_affinit.patch

The symptom is a NULL pointer panic in the i40e driver on
system shutdown.

    Rebooting.
    BUG: unable to handle kernel NULL pointer dereference at 0000000000000020
    IP: __kthread_cancel_work_sync+0x12/0xa0
    CPU: 15 PID: 6274 Comm: reboot Not tainted 4.14.155-rt70-RedHawk-8.0.2-prt-trace #1
    task: ffff9ef0d1a58000 task.stack: ffffbe540c038000
    RIP: 0010:__kthread_cancel_work_sync+0x12/0xa0
    RSP: 0018:ffffbe540c03bbd8 EFLAGS: 00010296
    RAX: 0000084000000020 RBX: 0000000000000000 RCX: 0000000000000034
    RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
    RBP: ffffbe540c03bc00 R08: ffff9ee8ccdc3800 R09: ffff9ef0d8c0c000
    R10: ffff9ef0d8c0c028 R11: 0000000000000040 R12: ffff9ee8ccdc3800
    R13: 0000000000000000 R14: ffff9ee8ccdc3960 R15: 0000000000000074
    FS:  00007ffff7fcf380(0000) GS:ffff9ef0ffdc0000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000000020 CR3: 000000104b428003 CR4: 00000000005606e0
    DR0: 00000000006040e0 DR1: 00000000006040e8 DR2: 00000000006040f0
    DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
    PKRU: 55555554

    Call Trace:
     kthread_cancel_work_sync+0xb/0x10
     irq_set_affinity_notifier+0x8e/0xc0
     i40e_vsi_free_irq+0xbc/0x230 [i40e]
     i40e_vsi_close+0x24/0xa0 [i40e]
     i40e_close+0x10/0x20 [i40e]
     i40e_quiesce_vsi.part.40+0x30/0x40 [i40e]
     i40e_pf_quiesce_all_vsi.isra.41+0x34/0x50 [i40e]
     i40e_prep_for_reset+0x67/0x110 [i40e]
     i40e_shutdown+0x39/0x220 [i40e]
     pci_device_shutdown+0x2b/0x50
     device_shutdown+0x147/0x1f0
     kernel_restart_prepare+0x71/0x74
     kernel_restart+0xd/0x4e
     SyS_reboot.cold.1+0x9/0x34
     do_syscall_64+0x7c/0x150

4.19-rt and above do not have this problem due to a refactoring.

Signed-off-by: Joe Korty <Joe.Korty@concurrent-rt.com>

Index: b/kernel/irq/manage.c
===================================================================
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -353,7 +353,7 @@ irq_set_affinity_notifier(unsigned int i
 
 	if (old_notify) {
 #ifdef CONFIG_PREEMPT_RT_BASE
-		kthread_cancel_work_sync(&notify->work);
+		kthread_cancel_work_sync(&old_notify->work);
 #else
 		cancel_work_sync(&old_notify->work);
 #endif
