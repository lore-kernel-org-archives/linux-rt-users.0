Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19207C433EF
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 17:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F025F61058
	for <linux-rt-users@archiver.kernel.org>; Thu,  4 Nov 2021 17:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233815AbhKDRbt (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 4 Nov 2021 13:31:49 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:12165
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231709AbhKDRbs (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 4 Nov 2021 13:31:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuEOzuu6EAnnBpuNCRAmVLy+S2qE8N0tM1Kxyi1QuRwKRuhK2QX7V83l2533Ln7We9EqxNd942qKFSRT806g4kMZc6ChGOSjazYOCh7ylw2tGGB3Kx8bbAHSUq0DtLZlVnrBbzrFlVJKg5ss08G/UHbO4342g+1fHWlF8uHLI6zBMglNvCd9zORl0CfO3C1A4HnybQJc4f13RacyU2qZ7HD4fK5SfyoTGJ/ilgbb/7+piJ6CFaRGhNXFhn6pzhVkMPLxYLjI+CDvsAkmPdy4QgM+bKO2mz8X2WaM8nlsMW7nVfGJ8YZsoSFTU71Z9DezjjiZ2eY1r/806H3IDl8pZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ys9oIi7KrFier2lb7LpERJFhP1zqIaI34BXuJ545Uog=;
 b=EVhxPtrIqC9QDlNec8huGcrsQz2NV8COXnR1NBDiFTUvu1d/REeVu5c2jV/QI2jB7iO+tNBCfCHqkIbW2mAGvGFHGySWK8ALg6a/AWcOE/24tP30iNhVZacOTI37PBt69detY22n5NEDY9lRbFI6CzXf7vXGDAnEZgAf48zVMd3PIp0JRkBbkeVVyg8ZyU3DphbAINt+c4sjFZl1piJYKW26EYR5WWVnFMn95Zk7X/vP7KqRfX15BYYi9iwkq9NORxIsxbw8xnCF/XeEKUuIfEf5Ijz/PBpS64zWnuzXLt+GIc0aTi0M5E3q5fFnheor3EKpYkc9X/AAjJ+sBFgGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ys9oIi7KrFier2lb7LpERJFhP1zqIaI34BXuJ545Uog=;
 b=hMyt/1HiVvvXt3pH+pw4o/2PuXjK8vwREkg25u1kP3F4yn6M69X9c+FSCxYj/ludxokC29daV7q82ODg4+CYCPVm5D9A7ARx8L9Pt1vcSOk/nMewFF+6viI5LW7owmhT/u9PlGhayqiTLbvTy0JaZ8ijeY6K+9FRTJcfLEhXVFua+eimIzrPNIjDYtelpkHDQfW6QYVqDBh5ks8/xOrQeQtpWoxee7zRhRXNgg4FSjHDaUGnw7nreBTZ/d2V29Ub+DVNypTWAKh2Yy3NQM+f4DMZMpq886DTBPR4MLD5PgH2X9I+iokuaf200wNfvnaj4hQSN8x5Xt3C71bh9JXc8g==
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:418::19)
 by AM0PR10MB2644.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:128::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10; Thu, 4 Nov
 2021 17:29:08 +0000
Received: from AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb]) by AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6d66:e6b9:219c:48fb%8]) with mapi id 15.20.4669.011; Thu, 4 Nov 2021
 17:29:08 +0000
From:   "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
CC:     "henning.schild@siemens.com" <henning.schild@siemens.com>,
        "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>,
        "Schmidt, Adriaan" <adriaan.schmidt@siemens.com>
Subject: Questions about replacing isolcpus by cgroup-v2
Thread-Topic: Questions about replacing isolcpus by cgroup-v2
Thread-Index: AdfRoQau9QpbKiacQpSAjNJcfArMZQ==
Date:   Thu, 4 Nov 2021 17:29:08 +0000
Message-ID: <AM9PR10MB48692A964E3106D11AC0FDEE898D9@AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Enabled=true;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SetDate=2021-11-04T17:29:06Z;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Method=Standard;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_Name=restricted-default;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ActionId=955ebe31-eab7-4cc8-8f87-ae0c154ca21c;
 MSIP_Label_a59b6cd5-d141-4a33-8bf1-0ca04484304f_ContentBits=0
document_confidentiality: Restricted
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5cb1b43-5da5-4e30-f48a-08d99fb89ba9
x-ms-traffictypediagnostic: AM0PR10MB2644:
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-microsoft-antispam-prvs: <AM0PR10MB2644DB8808CFF30ABB26FB76898D9@AM0PR10MB2644.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /NfbqPxvfTcvV5h4g8KpJ5s24+Tht5oO1jP/2xA2cr+Fd8ZyvfWDpVnHGVbkQ5131HccdX6SYYE5Ruv35nIV1X0JvejRdxZLmXD1DZTSfPYzKrkdRzjr5FvTgX5lqH9aC4HM8f94I9KcC0BZIHeDVXhGXQLkmJQaXN3LPvLxCxm7uoz7bGv/krBkyRA3v5iTJgvvsM+FNMvzhscciABcsduFE18HVVvE4DVFyPrtDbZSqJO9CdSxfhoyAJQm3hHST74ssRgPQ3qn3R9xIq01e8VL0AUffCOsArVURv2m3uSGKxse96kTU4pExrHtSvK24UttWa9pKbfFVi84QEwiiI2lnqGnQPm/43XXEddmTVmKggnptsAbREF8Z/ChzCB/qfswhI+FNWg3+ttwFj8kiShg+pslvLp+wd3SxgqFLDhshhzNtPhicQWea1njxrYZikWXRM8UNiEI6/vR+DOptqRsTUKtvTHoUOQ51vGNPitwpdEqvLfwUTzBZ2tQOWfHxbGGAzNZBeraNRdeVhhjr9uDqhXr5YwBHOPC0l12kuGWldER0EhMH3JZ8NWPjIaU+1Vueqb/vpw9QnfuCw1fkd7fqBAwBiCNtZ8AC0e0ughcRp3XD27gWfFSICibwfpNa3ij5NxqO9op+pIi1SDnX/riKdstYBmOrdZb+6GaDwMwZqDRozz7Ln6vlgFsHftA8zpML8kdKvKOAJh1l6qPhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(107886003)(55016002)(38070700005)(33656002)(66946007)(316002)(64756008)(66476007)(66446008)(66556008)(76116006)(9686003)(8676002)(52536014)(508600001)(86362001)(38100700002)(7696005)(122000001)(186003)(83380400001)(2906002)(6916009)(6506007)(71200400001)(82960400001)(5660300002)(26005)(4326008)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UGGFiSBrkps8w87KhK+TfmS9jxFneiZuZO6omWM3uo9XV35ZLXECCdEGWH?=
 =?iso-8859-1?Q?1LQ35nLYi2vw4nWQwb+uh6MH/Q7DTvavnn41aeuUeeN6tMaVO3y52IuCGb?=
 =?iso-8859-1?Q?XMU/kJh7/00UDM4NaduZ/UlVtxbJzLrcKpeFKXBu1T3CAIhPLcsKO8J/or?=
 =?iso-8859-1?Q?K6liFG4biWMzmW510z/AB6MNClYlbLVnOqVVWiZjs8t2QIuTOsHA7MIS5T?=
 =?iso-8859-1?Q?rmVOGxDEaaYmnXJAMB7aAKb0VkJrpuvZvpvC/937Yglqgio6TBHFqcqCFC?=
 =?iso-8859-1?Q?abCNoVPkuFkO2vT6ME8FSKp9QJaZlixxLYwyKDpcHFI1bmEnk8nOj6nEeK?=
 =?iso-8859-1?Q?OeR3cJcPFCiL8ZgqSFdN0tzDD3uZeekql0N/KUSEXGoqeH+jkT4dwWjrqG?=
 =?iso-8859-1?Q?ijSKYx3WxlnOgNhLgmZsfdv0+536HIxGWbkVpinuBUB95QL9mYyCZGycZg?=
 =?iso-8859-1?Q?hMwWVROpBNMRC/AiJ5oRmFnL9lWo1eZE6SknOZVWL3/YX8xTd02mhyW/P5?=
 =?iso-8859-1?Q?j3vpn3nIXx6Dv++KQ4zQ9Lm+x/0ZQ/v3ZsweYU9aeIr20eT7MGaTU0fJzl?=
 =?iso-8859-1?Q?NT10qWbREG2xUvtO/fb6kttvtqh+zqz23Li6A280yfhBrgiZnsdb4KS5pv?=
 =?iso-8859-1?Q?Cb6oje9I/g55nxqh5gj0sQj7WuXk3SGCLjos3mVpyIcpZEhtbq2NlVT0sj?=
 =?iso-8859-1?Q?BjQtDMtE8m3ztgOGD2e8k8SucQPBnq/GXcCd/E8MUO84K8dWbzT4ial/HK?=
 =?iso-8859-1?Q?9iDl3bFrTmqlzh4hUveCB4nq30pgPyV1Swapo5oM+48LLxlZJjIbgxAFrm?=
 =?iso-8859-1?Q?SpazVEPzUSODKjbxmxKgO817aDt1kNK3akI7+3LnCaMtATNow7kkd8k8aS?=
 =?iso-8859-1?Q?1a0v82UUcV7VMMIJYPd5yDGhUJEo0ME9J/aPWFPEYN8rdgexniliOsaDgd?=
 =?iso-8859-1?Q?oFR4fyYcLYmdmgmL1UxAskgj6sPnao733NYPI1lg+gtR5D6W2gJfdH+4X0?=
 =?iso-8859-1?Q?Kwc3HmtLf4ZZmFeCICUszotduLxdz+PhIHdYm6ar1REtp+Tnj4wmeoyG62?=
 =?iso-8859-1?Q?HLbTmrhbb/Ec8bCBCWkZO0HvWIyZWBQdaG5CLFAHqC0vxLHtQqvSqGBygZ?=
 =?iso-8859-1?Q?HOGYtNgjCUWOuNaUonrSqcp1Z43xU3e7gLwSac8ETe1h3Lnpd8c1E8Crcj?=
 =?iso-8859-1?Q?7XYiXYJwZV1pKrPV66zgw1Lu9DOfYqImW/JopqqP9MdcXINNDO3ap8uajf?=
 =?iso-8859-1?Q?qc6jzm22DRKVeKgUAWLPcV6EIR3w1inxhA8A81hUgNBlvRBFS4a/xXnJ7G?=
 =?iso-8859-1?Q?+U3U+ReynwaXivOrcJB7MTmVerDx0ekW5ed2gSgoV3RlkXX8BQSgxAQPEc?=
 =?iso-8859-1?Q?gJ8/VWCzXSp4jb8jxFklSIUt9NKMu699FhjLkAp5SY/kQ/IGQaUsziQaKx?=
 =?iso-8859-1?Q?ZDSeq4qO8qvhJNbueKMJq3K7Yx7OaxfY+sZ43tsFITikBLaAG5UuGcXAsV?=
 =?iso-8859-1?Q?Kn1vEkg+8Mx4fVhG3dIGWG9izEFvou832C/mjeTu9qOjb+V+NjZNsG/8Ny?=
 =?iso-8859-1?Q?XPZ4gbd7WqnqEpB8U3R7l84ksWHp36XgJk1AvzW1ZiKGouTPpQ61hIPba7?=
 =?iso-8859-1?Q?Vdkt/W8P0UiHVAO1bHjz/3XPGbz9DkU0wqgJa8DNfvAAYovYFydZjk7jNK?=
 =?iso-8859-1?Q?jh3OvUnfiKvRYQQj6DHKqdr5UQXOJ9cLzmhBybM0/2eIx/MsWjVUT0eaYl?=
 =?iso-8859-1?Q?/0aA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4869.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cb1b43-5da5-4e30-f48a-08d99fb89ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2021 17:29:08.3215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WqyImrokCxy+QQxYbQDOCvVAEosgEr8rebqDQqViRlHrXugjQGV5Q/A9/r/Y7Ew+mJ8Apu9CEj9pHTOVBiM/OwT8FptXPWcH7g1yyUIwv8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB2644
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Dear subscribers,

we are currently evaluating how to rework realtime tuning to use cgroup-v2 =
cpusets instead of the isolcpus kernel parameter.
Our use-case are realtime applications with rt and non-rt threads. Hereby, =
the non-rt thread might create additional non-rt threads:

Example (RT CPU=3D1, 4 CPUs):
- Non-RT Thread (A) with default affinity 0xD (1101b)
- RT Thread (B) with Affinity 0x2 (0010b, via set_affinity)

When using pure isolcpus and cgroup-v1, just setting isolcpus=3D1 perfectly=
 works:
Thread A gets affinity 0xD, Thread B gets 0x2 and additional threads get a =
default affinity of 0xD.
By that, independent of the threads' priorities, we can ensure that nothing=
 is scheduled on our RT cpu (except from kernel threads, etc...).

During this journey, we discovered the following:

Using cgroup-v2 cpusets and isolcpus together seems to be incompatible:
When activating the cpuset controller on a cgroup (for the first time), all=
 default CPU affinities are reset.
By that, also the default affinity is set to 0xFFFF..., while with isolcpus=
 we expect it to be (0xFFFF - isolcpus).
This breaks the example from above, as now the non-RT thread can also be sc=
heduled on the RT CPU.

When only using cgroup-v2, we can isolate our RT process by placing it in a=
 cgroup with CPUs=3D0,1 and remove CPU=3D1 from all other cgroups.
However, we do not know of a strategy to set a default affinity:
Given the example above, we have no way to ensure that newly created thread=
s are born with an affinity of just 0x2 (without changing the application).

Finally, isolcpus itself is deprecated since kernel 5.4.

Questions:

1. What is the best strategy to "isolcpus" similar semantics with cgroups-v=
2?
2. Is there a way to specify the default affinity (within a cgroup)

We are currently at a point where we would write patches to add a default a=
ffinity feature to cpusets of cgroupv2.
But maybe that is not needed or would be the wrong direction, so we wanted =
to discuss first.

Best regards,
Felix M=F6=DFbauer
Siemens AG
