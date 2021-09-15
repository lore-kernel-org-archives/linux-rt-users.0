Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18426C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 23:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF66560F8F
	for <linux-rt-users@archiver.kernel.org>; Wed, 15 Sep 2021 23:38:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232882AbhIOXj3 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 15 Sep 2021 19:39:29 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:34800 "EHLO
        mx0a-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231771AbhIOXj3 (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 15 Sep 2021 19:39:29 -0400
X-Greylist: delayed 2267 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 19:39:29 EDT
Received: from pps.filterd (m0239462.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FI1MEK028872;
        Wed, 15 Sep 2021 17:59:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=from : to : cc : subject
 : message-id : date : content-type : mime-version; s=PPS11062020;
 bh=iAWMJOH+raCVVL/T9U6oBquM9NjAp8B5CxZ1Nk6EXOY=;
 b=ddksn7kA9C5BNuOk3SA2j4mK8v6H0gAVJ6IlQbTwOBacE/CK9TvpEdSIaevj0A+A+Drz
 V0FPUyv94NYuQ4+kcDAfvP8boYkFO1Hl3tuNkzK6VpaMZd+RcTr5vdftsVlI3JHEJ63T
 DHTF7zvT+DB3dvmg6WfzCkdRTWv8ODIrpDFK4au9bO18NBHSvF/I0RqGOTmQ5qqNfoto
 KHx+WccEJTjn02v+mlfg3iCbsBq8uvDFCfvnhkKhEEplZcOG78mUleglfCREta38Eod2
 Gnf0uZyVO1P0wuI91cWZ5Me/+cBc/iSzx2PtI5yS/YZo14TcWKFp8/7EZk5gSpTzLChK lQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0b-00010702.pphosted.com with ESMTP id 3b33extnsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Sep 2021 17:59:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xg4dTEefLGlFUTbJXHkI7wzpdQvlWnfhRNKNs+0eSmqmIuurcsxYkSQZjPrs3txfz2UaKnqqAsE2YKhS1X7t1ist4oiDXryk9wsoUQUErtBshfyfE3JLis7wnaogDUM7k0BS8Y/dZFtz3kHIhYK6WPW+Zl8pZ0YWF2GY28LP3WXStA24B8b9mBNCPiyEZsVkONM5ahYk6moNo1CzA9Qpu74Kwi0wbcnwUDJpqbo0AAmLXlOs2XZXvuosaF9NWbIRC1L0W0tzw1/ROdyxIs1J5bvk85QCTnTUTpAdf5dhHgBWcan3Cb8/DpBEdwrXaThVcNh2CB+u4ADRZtMWC7Cq2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iAWMJOH+raCVVL/T9U6oBquM9NjAp8B5CxZ1Nk6EXOY=;
 b=RmsnmdbssudQmaIyXFdLglt4wRFIM/i765zBIzzOXWRlpWJ7n/YGSo9zIfBLFgZYs9B1+aWQ8wYc3J068fmhWEbTrFQpQwNuoBkfDJ3bMiIldVGMAzmL/VtOSTDA7MjnPTvXqNr5UEOmV9evDxm57wDL91onkBg8yzXotUjDM8FPhlaj8TNdBcPhcJ9aQdzd/A/y93BpIw8+Qn3uyCbANVcHWJO66X08HCm7eANcBEcADtUAWcxPzAatJ3ZQMDecjhOmcQHE2I5hDs5dDGLGlcxV/m+6T7m1O0i4U7YIbdXnKal6uiPesG4MQDHJcCYAkSR8MfX+ijm+Uudxo1haRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iAWMJOH+raCVVL/T9U6oBquM9NjAp8B5CxZ1Nk6EXOY=;
 b=P6iV11yD7HFdjHQj9p2TBTcStYvEGNl+xSU6/wt4qd3BwNLKKI/as3M2WlVw1X9pMSxHLG96d2W+ktCeF4LdQTErVvZ4O+5vNdyc0rA80U8wu0wBQ4I5XQtRvHNYMpqhkmZQ+Ri36xHhmimdkn/ZJ4w7Vs7WMYzFhukIPuuUSNs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by SN4PR0401MB3629.namprd04.prod.outlook.com (2603:10b6:803:49::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 22:59:52 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::455f:a21d:f5b9:84fe]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::455f:a21d:f5b9:84fe%5]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 22:59:52 +0000
User-agent: mu4e 1.3.2; emacs 27.2
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-rt-users@vger.kernel.org
Subject: irq thread latency caused by softirq_ctrl.lock contention
Message-ID: <87a6kd78n7.fsf@ni.com>
Date:   Wed, 15 Sep 2021 17:59:50 -0500
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0178.namprd13.prod.outlook.com
 (2603:10b6:806:28::33) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
Received: from quark (130.164.62.127) by SA9PR13CA0178.namprd13.prod.outlook.com (2603:10b6:806:28::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Wed, 15 Sep 2021 22:59:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a76c7db-50c7-4b10-bc35-08d9789c86e0
X-MS-TrafficTypeDiagnostic: SN4PR0401MB3629:
X-Microsoft-Antispam-PRVS: <SN4PR0401MB36294883F4489B9EC92282E7FEDB9@SN4PR0401MB3629.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bwHfj9TWWw9DtO1UzkPmXaDbtCNnRcz3mfRyjCO9EAEne+QZxesrVr/G2BiFkPd/ER8YLckL4cyLvyEK5eUduyWe4BRxGUHHbOBCt+c54UMbPjHmXDJ+y+HesWbjydZJhULwAnia6Uqyp4iCrKUNbi92wpIePBzYIbQI5nDI9jYZYl1laOQb1jdEJQ7a+x5avIc6XdyItmZXwcJEjJQd5/hzmahtw2QF2Fr5H+jX8G7IbS/ESufImt6W48vumSD9ODzUHF1g9aMwLolVecOIFdcONcLx7Y3V1oW+6KjUlX55GWQFIWA5uCebX8El1MQIC0tXAWaK8Ai3ttZ2GDQYj9QeKR5xRz+o5ByEyAXBJM9sCeRNB74SuQyTul3gXqsX7YbGodvqQTrAFTyMVu6zNLMtQh3bLQoV/cjGo0W4ukXCwm/y9upcR/+GLpJ+BcSTmFTaQNZa0/dcyRUrX3L0on4q5oan2m2mHTaQO1fMhF7tfS977e6vEGjqXW7Vih2i+fIfBFEBRiV8i3M1dS/Ogxq3f8Qpj+B8W+0ToAum9Z5toLi7ZOtcNq6S+wLCc3tdglpQqEKhy7/L9Ro5CD+Dd8b5Egeb47HY8aV19bCfZ1NOUWtVQxCQUgGI/jWApbEYdfwpcOfZDLtqScEXELNDo9qAVcF4THVUuFfyQAG+Spe8LIJnZxt9oOj8Hg1HwzH9MRfdOhEQBfkLgx7FMcwDrA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(39860400002)(396003)(66946007)(38350700002)(66556008)(66476007)(83380400001)(956004)(4326008)(478600001)(2616005)(38100700002)(6496006)(6486002)(52116002)(8936002)(110136005)(44832011)(36756003)(26005)(8676002)(316002)(86362001)(5660300002)(2906002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?diyTUDjAEalfUGDLZh4MTVUpvaZXs5HQWLgU3uZfBd73wvjw563v3FavjDNa?=
 =?us-ascii?Q?5SnBtBxX2sld/0ciMY1tWKDyHFbOtv40yij3MoMvmTTW8WUvSF9hWox2eAs+?=
 =?us-ascii?Q?XETJngyerkfi+c2vskJoJ0ee2MvUhAVb9eViYCSshcesfPHxeKljQU/kdtu1?=
 =?us-ascii?Q?kD7BaVA0SrfEH81KCGm/ZZ873mZ5sQaAUtr/ObHUpmZkxcFq5BFblJPVd+W1?=
 =?us-ascii?Q?dZnPW+/qjKfsjVW76R5l321jqvYMx8CdQkLDF0AoLlT1Vz0gC55TsCQm+QjK?=
 =?us-ascii?Q?yQRTs3ZAQOFkt3ME8YiHRNalezyi43z7HmPrqMIW6s/TKFGx58YNBhppg1YW?=
 =?us-ascii?Q?msYRUL12gt3zme+PkB8afnlT7+UU05oyxPmskrfZLu0mpK6ChGeTVL8RMgwL?=
 =?us-ascii?Q?Kfz1erG1yIhuUh/kODMoZjS892z7N/YWyWGghPvmETJhCAbAQarCxe3T4TTr?=
 =?us-ascii?Q?plXm6ikaJjrZeF/nkKxNNV4YYy9Me+2WuuMBKejEpFX6qJYFVxgtGgrqENAL?=
 =?us-ascii?Q?JTGzZ1R+WV1YZ+2t1GgJIivO6zJcvsyFdrdoy6dlsA6HIm+8t13Hhi0BgCq1?=
 =?us-ascii?Q?/O/DAu9GMKKdYNhF3Vh1jfjjh+TSX7Y43vXLoU4INlUFB3ZeoT33yB4UqTKj?=
 =?us-ascii?Q?mN8gcPSJOFgVpVspA0ctHISpbAOOftFZZkDpxgcyrGtIHdHIWnKGEZmu223Y?=
 =?us-ascii?Q?Pw208q2OFTA/kb7kIUo50JaZBkpinkfiD+hNMY2NC3UO5DuPQGzAQWY0JdIQ?=
 =?us-ascii?Q?ZXBx/99SDCZg17cdf8KJas54EX30SUP0L7+AFQUFvPjzAmwlY3n8xJATU9dT?=
 =?us-ascii?Q?anqU833cR2zL5TGhfFYbJsornFyiijZ5+HkTWUFm7yQE5mP0apP+A0G1Oqgt?=
 =?us-ascii?Q?uYkufNfmx5R7GFimSNOoyZ9ouJcKx0Nbd2RK8psnD9HCl4fHPO/vURb5kvQY?=
 =?us-ascii?Q?H4zEwwg2oxE+1NAGY6b0x7mpDdZcTq7vH7956YWbkQdNktkSVOCqJ5vs8Kth?=
 =?us-ascii?Q?Uyw4ZX2ViQhxoCPBgmbVyCOlGzG+VCRemfQZ/TElSJIQe8B7xKZH1csRZ7gB?=
 =?us-ascii?Q?ihi6E+h4tbYdzXGDuYclGPunmTLZNqqV+cXz4eSbgE2TYa7ikEYV3WEKvjCi?=
 =?us-ascii?Q?uVxCv/rV4Ue53gRuEnaB9dWjG1MuX+At6umqWYoMS8Z+eYmOLxLAGPeCCFBB?=
 =?us-ascii?Q?kjhWJQPTo0Yg5TxyDsbOijA1ryaHWXLp03hFncTs5V3iVT4HEv5fw0K38Xxh?=
 =?us-ascii?Q?MuLiAysrwGlGM0H7e7f7RsBSGem1GuH1dSKjJMXCQcM2X+45KudB4PVjfeCM?=
 =?us-ascii?Q?dzzNK4H/L+KUcgp43cw7wyjk?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a76c7db-50c7-4b10-bc35-08d9789c86e0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2021 22:59:52.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EDuuBZx+IalP8iX0K4Q/pDwxRB01l1rKqA9fo/gfm2nN9umGHufufRwCGM45cpbuIB4W/mInrl4OqZSdCeTYKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3629
X-Proofpoint-ORIG-GUID: AG_CSacUMGRDPiaYcSxHdhVxt53HZFBU
X-Proofpoint-GUID: AG_CSacUMGRDPiaYcSxHdhVxt53HZFBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-15_07,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30 suspectscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 bulkscore=0 phishscore=0
 spamscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=30 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109150131
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi guys,

We are seeing some pretty significant degradation in some of our
benchmarks when using 5.10.59-rt52 or 5.14.1-rt19 kernels versus
previous numbers on 4.14-rt and I'm looking for thoughts/ideas if
anything can be done about it.

The synthetic benchmark in question is measuring the latency of a
"analog in" -> "analog out" loop. We have two versions of this
benchmark: one that is interrupt based and one that polls on the I/O.
The polling mode benchmark is comparable between 5.x-rt and 4.14-rt.
However the most extreme case of the interrupt based one shows up to 60%
degradation in latency in 5.x-rt kernels.

I was able to confirm that the issue is caused by contention on
'softirq_ctrl.lock' local lock in the softirq code. This results in
event traces with the following pattern:

          <idle>-0     [000]   582.023481: sched_switch:         prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=12 next_prio=91
     ksoftirqd/0-12    [000]   582.023485: irq_handler_entry:    irq=102 name=atomicchinchk
     ksoftirqd/0-12    [000]   582.023485: irq_handler_exit:     irq=102 ret=handled
     ksoftirqd/0-12    [000]   582.023486: sched_waking:         comm=irq/102-atomicc pid=248 prio=1 target_cpu=000
     ksoftirqd/0-12    [000]   582.023488: sched_wakeup:         comm=irq/102-atomicc pid=248 prio=1 target_cpu=000
     ksoftirqd/0-12    [000]   582.023490: rcu_utilization:      Start context switch
     ksoftirqd/0-12    [000]   582.023490: rcu_utilization:      End context switch
     ksoftirqd/0-12    [000]   582.023493: sched_switch:         prev_comm=ksoftirqd/0 prev_pid=12 prev_prio=91 prev_state=R+ ==> next_comm=irq/102-atomicc next_pid=248 next_prio=1
 irq/102-atomicc-248   [000]   582.023496: sched_pi_setprio:     comm=ksoftirqd/0 pid=12 oldprio=91 newprio=1
 irq/102-atomicc-248   [000]   582.023499: rcu_utilization:      Start context switch
 irq/102-atomicc-248   [000]   582.023499: rcu_utilization:      End context switch
 irq/102-atomicc-248   [000]   582.023501: sched_switch:         prev_comm=irq/102-atomicc prev_pid=248 prev_prio=1 prev_state=R ==> next_comm=ksoftirqd/0 next_pid=12 next_prio=1
     ksoftirqd/0-12    [000]   582.023503: softirq_entry:        vec=7 [action=SCHED]
     ksoftirqd/0-12    [000]   582.023508: softirq_exit:         vec=7 [action=SCHED]
     ksoftirqd/0-12    [000]   582.023510: sched_pi_setprio:     comm=ksoftirqd/0 pid=12 oldprio=1 newprio=91
     ksoftirqd/0-12    [000]   582.023513: sched_waking:         comm=irq/102-atomicc pid=248 prio=1 target_cpu=000
     ksoftirqd/0-12    [000]   582.023515: sched_wakeup:         comm=irq/102-atomicc pid=248 prio=1 target_cpu=000
     ksoftirqd/0-12    [000]   582.023519: rcu_utilization:      Start context switch
     ksoftirqd/0-12    [000]   582.023519: rcu_utilization:      End context switch
     ksoftirqd/0-12    [000]   582.023521: sched_switch:         prev_comm=ksoftirqd/0 prev_pid=12 prev_prio=91 prev_state=S ==> next_comm=irq/102-atomicc next_pid=248 next_prio=1
 irq/102-atomicc-248   [000]   582.023530: sched_waking:         comm=S81039292 pid=2240 prio=40 target_cpu=001
 irq/102-atomicc-248   [000]   582.023532: sched_wake_idle_without_ipi: cpu=1
 irq/102-atomicc-248   [000]   582.023533: sched_wakeup:         comm=S81039292 pid=2240 prio=40 target_cpu=001
 irq/102-atomicc-248   [000]   582.023539: rcu_utilization:      Start context switch
 irq/102-atomicc-248   [000]   582.023540: rcu_utilization:      End context switch
 irq/102-atomicc-248   [000]   582.023542: sched_switch:         prev_comm=irq/102-atomicc prev_pid=248 prev_prio=1 prev_state=S ==> next_comm=swapper/0 next_pid=0 next_prio=120

The 'irq/102-atomicc-248' irq thread is our high priority data
acquisition thread. The additional pi boost and context switch seems to
account for the main differences I'm seeing versus 4.14-rt. This race +
pi boost happens with other lower priority irq threads too but the
ksoftirq case is the most common one.

I would appreciate any thoughts on how/if we could improve this?

Thanks,
    Gratian
