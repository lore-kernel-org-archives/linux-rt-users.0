Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EFA1C433E0
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Feb 2021 14:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D62164EE1
	for <linux-rt-users@archiver.kernel.org>; Fri, 26 Feb 2021 14:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbhBZOjQ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 26 Feb 2021 09:39:16 -0500
Received: from mail-eopbgr770091.outbound.protection.outlook.com ([40.107.77.91]:40926
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhBZOjN (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 26 Feb 2021 09:39:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GstHCl6wwg924CH3qogyvPVX8NNkDRuljFk9vRdipOu6u/bFmHviNg1PA48YbCFLwABEPfhD4PQ8DoR6+UtSF4CRK7g84F84O808fW3qAFFbGlGpMSuWpr6A7I44KEHmcuHi64rVkHnT4cIHOboJVia2eWP560BRgIspcpgZcwDZWIz3oxmkkQvVDaBNCdlnVrOsu0SQyxbe7SUnmp6fUhtMYMo8UNI6mk6+exb9cp77A0uUPkBKkAEMqwUw0oGH/zpWMQLy6XE8Fmzl5U4r6vpCc0IglnZINJcfOlCHjxBCJCutuGQXUxobmFMigkySGn3EU1z6xoazPgXOxPOkAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WV841uKc49DpLe2varIk2TTNLoUK4LsYjWhBiPgwkU=;
 b=GS176T7k1oWV7dXOUlmLozSCx2Umoj1g96q5riQmjSqEIPDyM9YpBEZvx9pHApIiUIi7GYZlCMyQC7mBqEsP83f23bCB52l8V66H2A9KfhvaIMnJ+T6DzBLT112/iX6BiPGbQXbrH66N4OdN2KJ0d1GDdkt6cDPr/+tG8nZkjDd9jwycuik7jCcPU31dG0vI47zRptwGIwWugyowpckwIWWBSL/7Q6Ry8OlcZ0ur4rkbRSkONq6qz0VFHcIMpo59EZv4Ys+jmvgdFhG+nq+1wkby2SSTavvaMphRO4YsaVztk7QPoQohRSJjOau0FbhE1cIsdlE4y+xLnlvpvF0X6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=concurrentrt.onmicrosoft.com; s=selector2-concurrentrt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WV841uKc49DpLe2varIk2TTNLoUK4LsYjWhBiPgwkU=;
 b=cVqA+1lOC61G33EAxZcWEitFB/m1aTQ+z4tbUztLD1F76XIH1BPvyFjIihnzb/AiimNsIjcA/lb7X6kKGq0gS82wbimHlPVGsQth7304uGbc4X1dbzy6wmWvTZ/S3KxGnRR2wQ8vTSJ3B+tVlc5/gb8PRX9Q+vOA/cjCpylh+pI=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=concurrent-rt.com;
Received: from CY4PR11MB2007.namprd11.prod.outlook.com (2603:10b6:903:30::7)
 by CY4PR1101MB2102.namprd11.prod.outlook.com (2603:10b6:910:1e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25; Fri, 26 Feb
 2021 14:38:24 +0000
Received: from CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::d9e3:f5a3:ae25:3bf0]) by CY4PR11MB2007.namprd11.prod.outlook.com
 ([fe80::d9e3:f5a3:ae25:3bf0%6]) with mapi id 15.20.3868.033; Fri, 26 Feb 2021
 14:38:23 +0000
Date:   Fri, 26 Feb 2021 09:38:20 -0500
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "J. Bruce Fields" <bfields@redhat.com>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Repair misuse of sv_lock in 5.10.16-rt30.
Message-ID: <20210226143820.GA49043@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [12.220.59.2]
X-ClientProxiedBy: BN1PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:408:e1::24) To CY4PR11MB2007.namprd11.prod.outlook.com
 (2603:10b6:903:30::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from zipoli.concurrent-rt.com (12.220.59.2) by BN1PR12CA0019.namprd12.prod.outlook.com (2603:10b6:408:e1::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Fri, 26 Feb 2021 14:38:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30ad0565-7b2f-4885-0f0a-08d8da642b95
X-MS-TrafficTypeDiagnostic: CY4PR1101MB2102:
X-Microsoft-Antispam-PRVS: <CY4PR1101MB210277658E33233BA891081BA09D9@CY4PR1101MB2102.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JDZXgPTkh8jY8mtWrYZYc6erVo9X35OpgkBiOc0V4Sp0OngsbCqbfgdIOA03Zb/Z2yaa+advLw/iMJXLuk7GBtAT+E6J37D5N2goMyR8zyUhF7TRMNsmrPmTUa/H0pon1EksOTPzs8sWXuvgQTZjBEG9UDoWjgiPPiIQXA9fAnMM9Wz2arxHeS9GcmSELt3RdNo8R07UUsPHYuGs/AoDsj+bejUNaRbwUVE90taS1LkzUgmZ5ftPtWdQcRRBuXZo+k6zeY0KVFTNX3By3fn8Mym0vw/f4OTyuNfBXoiTftF9pwU4Y19P0oMC+7N/zAU6IfknxzxM3lVBrK5JwhFu/h6DY/P2t1EkFk14/Fa+03XeTzbyRPZCK0/jONwRMgvFXV8K1Q4rPwjdBj2g00mFejC5CdXtdBdX0hzZzMkxma89Sxt+Tcdj+2JwTe8KO1FzWXqusXfto4L9VPtZf8OZXjpF6Fzq+2NLva5OWyl1gvTftisvveHQBT7JjQ9OT9cejKzGK8W7jzbpU7HwKF2Ykw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB2007.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39840400004)(366004)(346002)(136003)(26005)(956004)(186003)(16526019)(8936002)(1076003)(8676002)(83380400001)(44832011)(478600001)(5660300002)(110136005)(33656002)(316002)(3450700001)(55016002)(66946007)(86362001)(66556008)(7696005)(52116002)(66476007)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mdu02E9LyxNJsSOGi3T4/BEjgfw6vJaM0nGSNNM+Jw3RUyKCruKwnHsoo8MX?=
 =?us-ascii?Q?5UReQTCDrT6Xht6XfCwLUwNzkqdKsJ2u4Z/KqNTVjI2NYH/NmKV7ZuplWTpk?=
 =?us-ascii?Q?yBmS+8wdWxZRkEFbHkDwgu7MuGS43CM5R/1/Bm1OPMoyVhJ5HxAQCxSOhkAu?=
 =?us-ascii?Q?UwYNnGVLaNjl3GISjWvkSM25U1Av/ldd17YbBY/NVhjpg4U8q2JXotJVdqm6?=
 =?us-ascii?Q?AJsGAfmOD+YT5vQoxq9zLomX0QpYDARk0W0g7DXHTa4Ecwd3shx4RcPSpBSR?=
 =?us-ascii?Q?1rjMbE3PXhu6V+WZsUrQTPSp44SfkS5ZmEkrrtmb1xmK29XnNLxgplkwrg+z?=
 =?us-ascii?Q?JoPXGv+9tgBvqrSo9byIPKbMtm/gma4Nnhz0RGmK7bWrYFhrVZSfK3lEHyFX?=
 =?us-ascii?Q?c/3bmqcN+A7u1OJ02zZOlJ/6q+bZ3qWlLIcwAFbgyEW+FXir2SjM4nY8DpmD?=
 =?us-ascii?Q?vOAuRjAL8VyThi8PCTyjAgne/qQNpLWz4f9qELuV81miDryeCYoabjC/2Kc3?=
 =?us-ascii?Q?/skDnUAxMNo5z2WIMEp/ttkGlCW5JECrPMljPt6CzRa62MGmr0sjAY+SR1Ui?=
 =?us-ascii?Q?rGCAal/IplnnyzbIm4N+Foz6psMze8tAaQ4XPsT+gQNmheGJksi1kERSeaaT?=
 =?us-ascii?Q?3QmRmMHsPkdyluYRjgLokU/ETZdbc4LObAYcLIS5FEH7Q6MKhZuCQIhrPQUC?=
 =?us-ascii?Q?uLT6RLtowecNPtgmy47OvmNw2od6QXHbDjSfA/rDBs9u6YmGQ5peyjG/6GjC?=
 =?us-ascii?Q?X5ti4E6EsxjeGCB6v9TqUh/sbLEGsbTZP/tU17k2mScqei86knRVzg/FgKYk?=
 =?us-ascii?Q?x7wVpl9fHNXLvi0C4WoeoZ49QtAmWLaWcOTMOywBnouCGQAdukmJksErA0Ug?=
 =?us-ascii?Q?I/kLCiJzUd6qQHPY62HUv2YjG6muUITEgzUS7zqf+aXr+WVL2ROyy5tE79cC?=
 =?us-ascii?Q?VXv+Ac43a2sm2HlaUrOhCmXeeCGyqrfefca6//bnxCAjG6lriOyTKBMOO5Jo?=
 =?us-ascii?Q?ndMFwWx1CwGFy9dLN/hWrjzomovh0NaKP5uIeqaj3kUxOOTnyCqDM2vwymDz?=
 =?us-ascii?Q?Utum8Amz+FkxsZYNtL1xqp2SfCyka4I+XsbbJlyJ852hLJgO+OfPWVZTeFZ3?=
 =?us-ascii?Q?xalDV0sdLz1QRY+Vl3Nra6qF/rwr3Pv8LRrIHTNyo6EjG0FTJL/cC9nGDBpv?=
 =?us-ascii?Q?Qp+Qn4WS76VT13LbftW8iIfbHstZ5ksqiMJhXCzhAiD+i33scO8QO0kIBpxJ?=
 =?us-ascii?Q?kI2RD44uPBowF6wcTjmAaozBxSCHgxma9Am9UgE/ZGqmwvZusuLHdrzCzR6M?=
 =?us-ascii?Q?FwW8sX6BkuRdlraUuCe8ipHx?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ad0565-7b2f-4885-0f0a-08d8da642b95
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB2007.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 14:38:23.8087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38747689-e6b0-4933-86c0-1116ee3ef93e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pq3sgqak0nH2SkhKuD8OLG8jd4xA+8ji/oxChn5LJRfvTa6CSUuIRHNunlO1/pSKpnkOteh8hli9G+OFsu+HEA7viV+2wvZtpBBwrsGEO7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2102
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Repair misuse of sv_lock in 5.10.16-rt30.

[ This problem is in mainline, but only rt has the chops to be
able to detect it. ]

Lockdep reports a circular lock dependency between serv->sv_lock and
softirq_ctl.lock on system shutdown, when using a kernel built with
CONFIG_PREEMPT_RT=y, and a nfs mount exists.

This is due to the definition of spin_lock_bh on rt:

	local_bh_disable();
	rt_spin_lock(lock);

which forces a softirq_ctl.lock -> serv->sv_lock dependency.  This is
not a problem as long as _every_ lock of serv->sv_lock is a:

	spin_lock_bh(&serv->sv_lock);

but there is one of the form:

	spin_lock(&serv->sv_lock);

This is what is causing the circular dependency splat.  The spin_lock()
grabs the lock without first grabbing softirq_ctl.lock via local_bh_disable.
If later on in the critical region,  someone does a local_bh_disable, we
get a serv->sv_lock -> softirq_ctrl.lock dependency established.  Deadlock.

Fix is to make serv->sv_lock be locked with spin_lock_bh everywhere, no
exceptions.

Signed-off-by: Joe Korty <joe.korty@concurrent-rt.com>




[  OK  ] Stopped target NFS client services.
         Stopping Logout off all iSCSI sessions on shutdown...
         Stopping NFS server and services...
[  109.442380] 
[  109.442385] ======================================================
[  109.442386] WARNING: possible circular locking dependency detected
[  109.442387] 5.10.16-rt30 #1 Not tainted
[  109.442389] ------------------------------------------------------
[  109.442390] nfsd/1032 is trying to acquire lock:
[  109.442392] ffff994237617f60 ((softirq_ctrl.lock).lock){+.+.}-{2:2}, at: __local_bh_disable_ip+0xd9/0x270
[  109.442405] 
[  109.442405] but task is already holding lock:
[  109.442406] ffff994245cb00b0 (&serv->sv_lock){+.+.}-{0:0}, at: svc_close_list+0x1f/0x90
[  109.442415] 
[  109.442415] which lock already depends on the new lock.
[  109.442415] 
[  109.442416] 
[  109.442416] the existing dependency chain (in reverse order) is:
[  109.442417] 
[  109.442417] -> #1 (&serv->sv_lock){+.+.}-{0:0}:
[  109.442421]        rt_spin_lock+0x2b/0xc0
[  109.442428]        svc_add_new_perm_xprt+0x42/0xa0
[  109.442430]        svc_addsock+0x135/0x220
[  109.442434]        write_ports+0x4b3/0x620
[  109.442438]        nfsctl_transaction_write+0x45/0x80
[  109.442440]        vfs_write+0xff/0x420
[  109.442444]        ksys_write+0x4f/0xc0
[  109.442446]        do_syscall_64+0x33/0x40
[  109.442450]        entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  109.442454] 
[  109.442454] -> #0 ((softirq_ctrl.lock).lock){+.+.}-{2:2}:
[  109.442457]        __lock_acquire+0x1264/0x20b0
[  109.442463]        lock_acquire+0xc2/0x400
[  109.442466]        rt_spin_lock+0x2b/0xc0
[  109.442469]        __local_bh_disable_ip+0xd9/0x270
[  109.442471]        svc_xprt_do_enqueue+0xc0/0x4d0
[  109.442474]        svc_close_list+0x60/0x90
[  109.442476]        svc_close_net+0x49/0x1a0
[  109.442478]        svc_shutdown_net+0x12/0x40
[  109.442480]        nfsd_destroy+0xc5/0x180
[  109.442482]        nfsd+0x1bc/0x270
[  109.442483]        kthread+0x194/0x1b0
[  109.442487]        ret_from_fork+0x22/0x30
[  109.442492] 
[  109.442492] other info that might help us debug this:
[  109.442492] 
[  109.442493]  Possible unsafe locking scenario:
[  109.442493] 
[  109.442493]        CPU0                    CPU1
[  109.442494]        ----                    ----
[  109.442495]   lock(&serv->sv_lock);
[  109.442496]                                lock((softirq_ctrl.lock).lock);
[  109.442498]                                lock(&serv->sv_lock);
[  109.442499]   lock((softirq_ctrl.lock).lock);
[  109.442501] 
[  109.442501]  *** DEADLOCK ***
[  109.442501] 
[  109.442501] 3 locks held by nfsd/1032:
[  109.442503]  #0: ffffffff93b49258 (nfsd_mutex){+.+.}-{3:3}, at: nfsd+0x19a/0x270
[  109.442508]  #1: ffff994245cb00b0 (&serv->sv_lock){+.+.}-{0:0}, at: svc_close_list+0x1f/0x90
[  109.442512]  #2: ffffffff93a81b20 (rcu_read_lock){....}-{1:2}, at: rt_spin_lock+0x5/0xc0
[  109.442518] 
[  109.442518] stack backtrace:
[  109.442519] CPU: 0 PID: 1032 Comm: nfsd Not tainted 5.10.16-rt30 #1
[  109.442522] Hardware name: Supermicro X9DRL-3F/iF/X9DRL-3F/iF, BIOS 3.2 09/22/2015
[  109.442524] Call Trace:
[  109.442527]  dump_stack+0x77/0x97
[  109.442533]  check_noncircular+0xdc/0xf0
[  109.442546]  __lock_acquire+0x1264/0x20b0
[  109.442553]  lock_acquire+0xc2/0x400
[  109.442564]  rt_spin_lock+0x2b/0xc0
[  109.442570]  __local_bh_disable_ip+0xd9/0x270
[  109.442573]  svc_xprt_do_enqueue+0xc0/0x4d0
[  109.442577]  svc_close_list+0x60/0x90
[  109.442581]  svc_close_net+0x49/0x1a0
[  109.442585]  svc_shutdown_net+0x12/0x40
[  109.442588]  nfsd_destroy+0xc5/0x180
[  109.442590]  nfsd+0x1bc/0x270
[  109.442595]  kthread+0x194/0x1b0
[  109.442600]  ret_from_fork+0x22/0x30
[  109.518225] nfsd: last server has exited, flushing export cache
[  OK  ] Stopped NFSv4 ID-name mapping service.
[  OK  ] Stopped GSSAPI Proxy Daemon.
[  OK  ] Stopped NFS Mount Daemon.
[  OK  ] Stopped NFS status monitor for NFSv2/3 locking..
Index: b/net/sunrpc/svc_xprt.c
===================================================================
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -1062,7 +1062,7 @@ static int svc_close_list(struct svc_ser
 	struct svc_xprt *xprt;
 	int ret = 0;
 
-	spin_lock(&serv->sv_lock);
+	spin_lock_bh(&serv->sv_lock);
 	list_for_each_entry(xprt, xprt_list, xpt_list) {
 		if (xprt->xpt_net != net)
 			continue;
@@ -1070,7 +1070,7 @@ static int svc_close_list(struct svc_ser
 		set_bit(XPT_CLOSE, &xprt->xpt_flags);
 		svc_xprt_enqueue(xprt);
 	}
-	spin_unlock(&serv->sv_lock);
+	spin_unlock_bh(&serv->sv_lock);
 	return ret;
 }
 
