Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C642C433EF
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 19:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CEE60F3A
	for <linux-rt-users@archiver.kernel.org>; Wed, 22 Sep 2021 19:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhIVTjp (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 22 Sep 2021 15:39:45 -0400
Received: from mx0b-00010702.pphosted.com ([148.163.158.57]:37170 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237232AbhIVTjo (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 22 Sep 2021 15:39:44 -0400
X-Greylist: delayed 1261 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Sep 2021 15:39:44 EDT
Received: from pps.filterd (m0098779.ppops.net [127.0.0.1])
        by mx0b-00010702.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18MCGZio031040;
        Wed, 22 Sep 2021 14:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; h=references : from : to :
 cc : in-reply-to : date : message-id : content-type :
 content-transfer-encoding : mime-version : subject; s=PPS11062020;
 bh=TBqGT/Zd94NVOXlyMwUtG6r+1nDFOCQmZhL6xRDrbJA=;
 b=GegOXPWG8hpCNAkkLKqL+tWUtRBVP/yLZjqJQUcEpfn0Yd09Qf1dwd+HbP5IQaShgHKI
 vL1XZd5BCWyaVBtrhWkImCdXiugOwqwtm8E7bDZ02/3IQnBdf1j5odvdELsDXA7dQhNr
 okgaMt7aGTb9d4DtzLak7tsDso2gSNbdBRG0U0bPBl3yEIlIKjA34i0P3nKt/tpuPSlR
 WroL3/AM7ObegrF4FfcfyP2b777cfkgLzgY7D0eyqsAukQK0z/ce98APBljuF6Rpe31M
 Nofg8Uw1kEQPMygb5yfsX0uIIQmUTm/mtWBmj80ZWik0DOdoiFLedlOGKLbS/a7wrPId Ww== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-00010702.pphosted.com with ESMTP id 3b7q3xj456-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Sep 2021 14:16:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtlgBp6qebQwiG603qIVy8JODoUQl3xn/gHlZuy4QBimoxa0nn4TdXYttlY6tyCTxiLH0xFUyhbKJMwQTZj00cqNlsSCtwuheK+G+bWvFhz4Hhm9snlI9ZhrON7XMkMqAV24+ZOncTEBjuXA2xUo4zoD1julQqLBK0XI+6vdUQmPXQRPENxNVBltd9choYtcjrlGPDQsOrVAdVm14TH/7CDG2ml5I/ZXDGUdeHYrlvZiRUfe7zJgylTlPiUb7Sj5Z4/DL+mrzHazYbedvAx8smLXHuygp2aldBwSY6Z9OZM4MTPfd1yNkgiHL6HfGMdi8kD9UjKIgET4MlbyjilRVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=TBqGT/Zd94NVOXlyMwUtG6r+1nDFOCQmZhL6xRDrbJA=;
 b=fLUuKbgeKcUneeSkxTaHpoCZLlGKu/XAvfhNgTV1Ho0YWcYTwEcr8UMz6QLLosfGwg9owJC2kWmgGyHQZsDyjQZQHHOkrQd6jvveX+gKoegbbd+lfjoIJFa4pF4UErVhQEYslo0BynAhEJNTuo7JfesyzbXAAXj2Ub7twZFfVDOD32F14loILChYvr4WZeps4ODAqm18996EXJ4wfIP9942ClNlSewdSFleBC+SUfrTV3avhkRrevG06NP4nGAWj6e509FLuuWwYHEPVfzxodJNQHmqy7VQ0RlbIKUExTTAS5/pExrdVKsgQ/ng+RPsjE5xSluDrkR4utc3Jimdnug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nio365.onmicrosoft.com; s=selector2-nio365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBqGT/Zd94NVOXlyMwUtG6r+1nDFOCQmZhL6xRDrbJA=;
 b=PdAoMO/dvJ0WQF7K7fW42mLnmXnNYZEFoMhCcyL4yIBMoQ1wNU8bxYleoA6DaV4l5Z9J5zJG6EqzQjYr6SYBziKPs9IT4CL5QV+r+bAtg84aiKPYBTAqtIoROCUsFxk2p2AHRIyjkNMktw8p1sFrPiw8za0ITzs9n4UAHjJrb0o=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by SN6PR04MB5360.namprd04.prod.outlook.com (2603:10b6:805:100::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13; Wed, 22 Sep
 2021 19:16:41 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::455f:a21d:f5b9:84fe]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::455f:a21d:f5b9:84fe%5]) with mapi id 15.20.4544.014; Wed, 22 Sep 2021
 19:16:41 +0000
References: <87a6kd78n7.fsf@ni.com>
 <20210920091806.lgmznb5mkqoyyfkb@linutronix.de>
User-agent: mu4e 1.3.2; emacs 27.2
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org
In-reply-to: <20210920091806.lgmznb5mkqoyyfkb@linutronix.de>
Date:   Wed, 22 Sep 2021 14:16:39 -0500
Message-ID: <877df87754.fsf@ni.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) To
 SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
MIME-Version: 1.0
Received: from quark (130.164.62.127) by SN2PR01CA0072.prod.exchangelabs.com (2603:10b6:800::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Wed, 22 Sep 2021 19:16:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 353061db-8060-4956-cc69-08d97dfd823e
X-MS-TrafficTypeDiagnostic: SN6PR04MB5360:
X-Microsoft-Antispam-PRVS: <SN6PR04MB5360DEEC78386D7722126548FEA29@SN6PR04MB5360.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WUVcPR6lB32/6CgAa3z7JCMF/U3RhJygKqRriZ9wi+lwen5FWEmj5v5JS6tDp/31BFU2Tob0kaMN75vabIKqfoNgTUpSxGochIeUq8qKiKUDkCed1HqBeQ4R+/xJJmLYMgMcgyRadpztdlCce4x6Y74CsgmOAVRZEVIDLcrum9DARpO66YNSEW5rsvBXyTHdJgqKjJJXjZ5cTQWxig+9ESOKofv/sjj5tmQtzhKYKXmabJ42RgMNs5gS+lbvgnq1x7/r7PMyQOywavNeVHkhvIUzyCLArW2R3Z7hAw0CHQ6eRYG9V6BUUNkyI1mYDVL1RKVaZ8kC0F9k1q3sSb96wsfdbMgn2sVPEHkZ0OgVNPyFSuyQzUuDrdx3YthjwbMXjdhwGPPNe9b/ZkcDzjiM7rWqSF5GDgs+W7yFgSj+Bm84SxtswPnxiT/alm8Lb1udUd4t6mRHRITz16jc7qn8mDrZHv9sWv2A2IDuUloWLKR9pJm0+/GiXC3NhemI9ElC+TlL0coTVIljfvMBC10YYZF2+XpOBGDTuA2NUYuJHdy6ej99uW5kW74r+9fLZAuTzgGpoJoT7gEUSKAwp2fiYCexWmK/IZw+PQAZbYVr0pvd0QwgS+BZ0I0sqvXhxnzU9gtvWfzXYq8b4lTTbiR3Y46PUHgcQ/PZMgQi8C5ix8sOj0Wdm4izZ+2q5ZWYQudL98topxzSRKz/SJKTRCtMCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(956004)(54906003)(38350700002)(38100700002)(66556008)(5660300002)(508600001)(26005)(6916009)(66946007)(4326008)(83380400001)(66476007)(53546011)(6496006)(86362001)(6486002)(36756003)(8676002)(2906002)(186003)(8936002)(52116002)(44832011)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NDhIN05MYUMwLzdORFF4TlZNU3Jzb3cvRURUVHREWGk5amMrcEpDWnNaeHVm?=
 =?utf-8?B?VVJ4QUlkNWFXWEptVTduejJONXhFbTNPc2E5RlgrUUMwQ21uTFhmKy9rdUJy?=
 =?utf-8?B?UmpteDVZSURkaXhJemFnZXIxSUJUMFJIc2FHZEoyVTNmVlBSZytXMS8ya09n?=
 =?utf-8?B?dDBvNjhJQjg5K2RaWEVjUkpDVTlsMUpHeWt3bCs0RjNEN1dXQjg4Vm9jZXI4?=
 =?utf-8?B?eC9jTHRGVmVTUXBEeDNEeHZXNXdxbmQ4WnZoOExEN3cyRTVNS3FFQk9oY2U2?=
 =?utf-8?B?QmZmdGV5dUtYYW1Cd3FZQ1E3SEtpVkFxSXZqL0t2dmZpdWYzUzZlUVdLRHFa?=
 =?utf-8?B?Q0Nxb3B6RWhla3hjOFhFc2p3TlYyUWV2OXJQdlRCTDUzbDhGREw3dmpuai9m?=
 =?utf-8?B?RWd5WE5ENUpYVkJFcDVsTTdlaDM5TnhucTZObkx0eHFmc2lWdHpPd3ZpNzFF?=
 =?utf-8?B?YTdwUlJXZnRnU1FWVjgrWkNlZy9wY3dvQ1NmK2dWbUtqdnBJY1FPQzJwNXAr?=
 =?utf-8?B?eTEvZ3ZIVHZNbmdRWUJrbnZPR0UreThhbUFnUUI2VisvbjZIWmxjNzVKSC90?=
 =?utf-8?B?ZkpTdWlVTFBwajY3MVlsVWcyeTk4dVoxcnc4Y2VkZUJaY29NdjI1VndGbmx0?=
 =?utf-8?B?cjhoc3ZhS0hlL1JoRHdLbzNWUnNsem4reXpWc3g0bHdYbHJDU2dhNEgzNHN5?=
 =?utf-8?B?V09uRGs3bUU0clVRdVdaNlZMeXFEZzYwTUVRWlpXc0dXU2c0NFBpaGdLT3dR?=
 =?utf-8?B?RmdtRWw0TUpIbENYODVSblJMeFp4dGZ3dHFVdTl3OUpwZitKRmFsSXVtYllS?=
 =?utf-8?B?V2ZVQllhMFhDUlVvZTI5WjVtNkZPd1h1TllVNTBQT0g2RHhrT0daZmRUUmFs?=
 =?utf-8?B?YjRjK1pvWUJXemNGdGJQOGlyejA2akZ6di9YT1FRK1BSMkh2VWQ5MUd3ZWVw?=
 =?utf-8?B?bjcyR1RwRW9Fd2FQa1gxS250VCtlZVZINVV4WDVKUmpwMkRINW1BY25kTTZN?=
 =?utf-8?B?S3QzVWNqbjdKR3k3UzlrT2cwY3MzNTNIREZjcmM4N2d6dUc3RitIVjg2Ujcv?=
 =?utf-8?B?MW1YQzQrc245dnBUS1lmWXhhdHlha04zT3Q0dnJPdk1ITEdIVCs5aWpNY1BV?=
 =?utf-8?B?UStDVEVxYlRKQWRkMGdmY1JkM01YTVZuZ0I2Mk9samxGaGY3TUsrSlFqTTdK?=
 =?utf-8?B?MUlFVElkVlo3RlVpOVJIWEpvMUUxQnJySmhIZjdOejh0UmthSGZyYVpFSGs3?=
 =?utf-8?B?aTNnTGVSSC9PTnBYczJZMEloYkIzelp1eXhPLzY3QXU2Ni91RVdZMFY2dS8x?=
 =?utf-8?B?dGtiSVdHWjhqTmZCM3p0NGIvNTROL0JwZGpZMmE2NjJiYzF5VmtLaGZ0MVBN?=
 =?utf-8?B?TUNEU1UxQ3NuMTc5N3NhTHRhN3A1emszbFgyOWM3ZXlCZU14bm5WbEp3OXdJ?=
 =?utf-8?B?dS9OMWtJb043NkNRbVBnRStGZStrTzBUcW5XV3dyQzFPMW5GMzRWVVlwZDRp?=
 =?utf-8?B?SkVGa1pxcGRaOVNuUlZ2M005Vi9UdWs1WVRYUzl4aEZvY3MzdUJDUUxHRTls?=
 =?utf-8?B?eFQ2bmRsWVBWQVZUYmIrUWZITWs3bFpSTUJvZ3FlU3RsTWhRaHJIUUJ6TUtO?=
 =?utf-8?B?MzhGa3FsWTF5d2NJQks1aHBZSDExdlZVTzFxbFQ3eXhnRUFxeVZzQ0JOT2FU?=
 =?utf-8?B?TThrcEhtVWJrdmdKaDNLYktETnI5cXVaczRYZVJaaXpuenlBRUZWc3N0SHdk?=
 =?utf-8?Q?kMj5LOLOTM7QIUFLXxBziLy/ocbSfXclqFiFPs5?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353061db-8060-4956-cc69-08d97dfd823e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 19:16:41.8385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kkapuDvclUZLdDyKIaOqu6eDLeN/i/XdKh5+xi+rDYxJHLgxwx+leHNxOTCGpFMI0WwpqgMzf8vJ9MRKlM4iCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5360
X-Proofpoint-GUID: 4hwdA_EDcdPXuEMoxJKheIj8bclII9ok
X-Proofpoint-ORIG-GUID: 4hwdA_EDcdPXuEMoxJKheIj8bclII9ok
Subject: Re: Re: irq thread latency caused by softirq_ctrl.lock contention
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-22_07,2021-09-22_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_policy_notspam policy=outbound_policy score=30
 lowpriorityscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=846 classifier=spam adjust=30
 reason=mlx scancount=1 engine=8.12.0-2109200000
 definitions=main-2109220127
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org


Sebastian Andrzej Siewior writes:

> On 2021-09-15 17:59:50 [-0500], Gratian Crisan wrote:
>> Hi guys,
> Hi,
>
> =E2=80=A6
>> The 'irq/102-atomicc-248' irq thread is our high priority data
>> acquisition thread. The additional pi boost and context switch seems to
>> account for the main differences I'm seeing versus 4.14-rt. This race +
>> pi boost happens with other lower priority irq threads too but the
>> ksoftirq case is the most common one.
>>=20
>> I would appreciate any thoughts on how/if we could improve this?
>
> It appears to be a consequence of the new softirq design/ handling.
> Earlier we could have multiple softirqs running in parallel on a single
> CPU (as in NET_RX and NET_TX).
> With the new design only one softirq can be handled at a time resulting
> in a full synchronisation at local_bh_diable() time by the lock you
> mention in subject.

Makes sense.

> In your case it appears that irq/102-atomicc is force-threaded and
> therefore requires to disable BH before its execution. This is just to
> mimic what upstream does in terms of locking and to ensure that BH
> invocation happens after the threaded interrupt ended.

Yes, good catch.

> If there is nothing special about this interrupt handler (in terms of BH
> handling) you could request a threaded handler for the IRQ. The manually
> threaded handler do not disable BH before their invocation.
>

I appreciate the insight. I think this will solve our problem.

>
> Sebastian

Thanks again,
    Gratian
