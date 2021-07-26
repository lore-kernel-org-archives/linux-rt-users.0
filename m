Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED5FC4338F
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 07:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6347060F52
	for <linux-rt-users@archiver.kernel.org>; Mon, 26 Jul 2021 07:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhGZHDT (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 26 Jul 2021 03:03:19 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:61632 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231836AbhGZHDS (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 26 Jul 2021 03:03:18 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 16Q6t2Mk016562;
        Mon, 26 Jul 2021 07:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=PPS06212021;
 bh=pf2H33qB3ubwgkUdzH/XDF7CDn6xCLDYRPlRzFVgUio=;
 b=jKb7iCe3X0cbdUFIHF7zQKmHF01U31Ao588LdfdmXIAIsWzC3i35yilJh4mGEonHEA1C
 aApWW8ZPXttoPOrz98ehIwFEC/Mgya0ZanPWJ4oeLubz7BC/ld+8KvHsMi4lqY1D7vre
 WwvWKtklfgePmJl6xAjIiOBvRRgLM89e6jeDVLZwZQ9pjOgJxSnaj6mTMzQeEmjEWIo5
 L/wwWkbfjPCxMpkM/DDeHKVZs1k3EjQfQlPjVBm/cqC6RUqi8s5hAOXoRSSDErOG12DS
 zm+UfpndIUZ4frCE/fBhdZEN5BP2QI7qwtcap1sX+jOtlk2wue0aRQGhGo8s7UfDfwwj Eg== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-0064b401.pphosted.com with ESMTP id 3a1417ghrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Jul 2021 07:43:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYEdhkgPkeOB8z50tA6A1+xZZ1xXxxN4Lba6vQhYQB+KPB1WWRB1rCNk59avKlGDYFkt++aB27DKMcUI+RFlghclV0cLzDipBjmkyRKRkcD8eW02Zuw8I20fxG4EvURT1zMRVU2bh3ieCZcbeq052/gD2dVtwVKE8+mOXEVj6YViffkhTmy4tookZci6X/py4n1UlzAfCkZ57DZPiZBcSc4v7m1muoJuY/F4EqcPoQDmr7oAeMhLjYxafpOXr5JMagrIW5Uw2oAknX0VrnoP7bY3ggp26l3k4B8vsWJ6EjjIO9i8h8KHi8hXZ2WsIAq3zhFT4qimy8H3fkENrZGgKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pf2H33qB3ubwgkUdzH/XDF7CDn6xCLDYRPlRzFVgUio=;
 b=RLguIy++2AORqKI4b19Tx9NgGaqX7so+KtcS5dJqMFEz5bGh5Nvzb9igiqOEBHdK1kGBTt1BgVLhjiAtSxStbqsqDf4VCKwi1uHIJlnM9oq1YGveE/1isbbqwlWAQ/HCa+jnb4A59IAGwS4hs0GwIcIjo4w9cW90aJ0vKDPcb76wt0eOk1XEtsyaZcSEkG/7iAnfrEEHXrobqP4mED84Tu9xwp/fFC2b0cBsSAcibWt3Lju/LkFDfuCk1JgXdOStCa63KHpTBCOJDsMgK+e9cJetx7WHVCkRtGNg3fZhTuBU+Cn9gfQDOoILawwkvnK05JbBo77ZryZuMohFdJjJ1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 07:43:33 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::a140:b563:8725:5c2b%8]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 07:43:33 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Question on (locking: Make spinlock_t and rwlock_t a RCU section on
 RT)
Thread-Topic: Question on (locking: Make spinlock_t and rwlock_t a RCU section
 on RT)
Thread-Index: AQHXge6b75FTx3VgvUCwMiDockKWIg==
Date:   Mon, 26 Jul 2021 07:43:33 +0000
Message-ID: <BL1PR11MB5478DB9FA9C2BEF56FBFF6AAFFE89@BL1PR11MB5478.namprd11.prod.outlook.com>
Accept-Language: en-001, zh-CN, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0adf7392-b88a-4f01-fde9-08d950091203
x-ms-traffictypediagnostic: MN2PR11MB4551:
x-microsoft-antispam-prvs: <MN2PR11MB455197A7C0AC36ECAE450508FFE89@MN2PR11MB4551.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ap778DeDLWdZRuMB+swIGDt8ZAOyZHQ79tRnWbKGmI/YJITLenCi7M4XnjDrENp3q//ysb0w9xPDuxQebqcpMoqc/Z/7m9MZHE4z/+UQziFlPsF39lotjZtG5M4vGRfdVEJ7Coi6dGLlFL+X9r5XhN3oNR5Zzkq01AyOc4Njtovw0HuFGtHBuGPWSumGWvEiX3gI3wsu8vS/KdBUqFFVhzLrArJgfUilM0wTWTAGlksGG95xh1+fOZ1E8L+CGXz+97daCu3U0/RXAeVcInFX1Qtz9rlJfkLwXSI+iP2LZNMDBXzXMF44w9zaAhP2d8cbS0U2fL0FIx30lAV04qtikVHGaF/m/AN0wfQGlh3+l9dugoJpd5t9KNMkdxghvVIdq+x95EIf3EjMsGeb4QdM5aXz/Ax9QHDjAqk7X2NjoivyWdpRjIH+Qv0xmpnYLgVbUbi/8DJ3NFJt/BvJAGk/uesTXcFxu0KOgE2ZXQZrStLF4X9FJiRq8eAB6i4DsfPRvj8hGE772HdjY4W+W1s8lcQFOfRWT9sIW/or3E+cq3Fid8aQaFrf0WoC15vCuZhGgHYfCSGUXr4u2OKcWLnAU0w7UgRHDCtr7xu/ImxXHcgctlYE6oTh9+r15kBdI3ivfG2JrI9y0zZAUrvhsxmWbqG9YKd4H5yfTj9DyGB3vZCyS1YO/ySr5RcEBbUGL7Pwk2zXgmz/KTcU/Ye9+r3m7w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39840400004)(376002)(66446008)(54906003)(66946007)(6916009)(5660300002)(8676002)(2906002)(186003)(4326008)(91956017)(8936002)(9686003)(55016002)(64756008)(66556008)(76116006)(66476007)(478600001)(316002)(38100700002)(52536014)(83380400001)(86362001)(122000001)(7696005)(6506007)(53546011)(71200400001)(26005)(33656002)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ylbzpwZ8tymflL3jsLze0HFW41UP4C94bKerXCY4P8NoFETDF5JOsArqgygc?=
 =?us-ascii?Q?DT6d6ju4MYEWqcJSbtDkRRybxopwpFy5BeJGj8suHch/I/tKaLFjtBg7KNZx?=
 =?us-ascii?Q?rkKw0zasAvVeppZScm94T9CjJk1dqVijSSQ+R1dmFhyu8qV0AjMkmEY1MzW2?=
 =?us-ascii?Q?c7xLbeu6W1LBEl8Oh0kcNZPPQiPzvGVbvYZCT47kSqTuYhUk709FTYR85JH9?=
 =?us-ascii?Q?ECyQswcyZgggRhQzLGyAajB195mCW7UCWDfi4m1pK5n+88rpzKNO43EwBEtp?=
 =?us-ascii?Q?KcByXcZ8njfathk5XEQP/Rjkt3T8LreRlA3u++EpUo0io++vdX/y39KVghEN?=
 =?us-ascii?Q?6tS/QO0mv5aG4DYbqkDvn0VFL23WXu6/mHZ3Tkhfqr9jzzfmniQmgiZkZq0U?=
 =?us-ascii?Q?Ztjz4KTtPJ7vyYoSt4ACY3plrmz/k5Jl/RL1aY6epL7K2rd9Z1QWzfDxiDuR?=
 =?us-ascii?Q?1my3enYw3qypc42JQb/cbsqk3aW1A7KMdFHADW86/uRPeQNHbbLOPi6QcmQl?=
 =?us-ascii?Q?YvlH5RCZg+Zgy4PtOGTW6pyggNOWJ2wauu+oOU2DbI0Pin2r9zJFDbB9Cu2s?=
 =?us-ascii?Q?esSs1WirvK7FeneRwaKP13zvIpc6UgeGPDNLfxZbioNEqJ/nJAjKCeidDHm3?=
 =?us-ascii?Q?/88HKRpw+Z0WmfR3SUt9NZSLX19VEN/iqtDB/wNZPlLl/YLpgYm3NNfDhCHT?=
 =?us-ascii?Q?YeunIU1azxEJf4yvg1KM08jhwNOyyRjVf3r4UzzwX38c6VKsCdrQacr3e3ax?=
 =?us-ascii?Q?DeMLyZt+96oUv9GzHDJcds9f+53fmm5EYpwf1x0MDqJvXLaJjxf9FXGaRCx+?=
 =?us-ascii?Q?DgSNFF+73ApzUV33gIpGRldVT8MH+xIZuNMCYAYsrskVu1UuiYmdA+yKW8QA?=
 =?us-ascii?Q?wSbYKaFm0aB7g4p32eb2go19T3iuL/xA9rwkx0at3GTA7hJefIEC34xPqRO9?=
 =?us-ascii?Q?kiRPxTgLe4VmpHbJ8EerT5KxgtMUw8ZbnT3vafxHxiCKxnbngb9FC2n7bd2A?=
 =?us-ascii?Q?CxaUMPXO8cBfJgBWPQvPI6ioAwNusaF3HA8opJlkn9azs2gQvhEGrpz3LJX/?=
 =?us-ascii?Q?9p07hpeWohAG4b+H1QvinINZY4DUnxD2Xhya2R8fRU0FHjry28yz7TMaJGBX?=
 =?us-ascii?Q?zACTVuQHLdpRiVUyDfMvCltpZxpzrvtgXvpW5QegxZc1p3R/GjAC/NL3k6Rb?=
 =?us-ascii?Q?D/1PuUcxk/Hw7L+Vo8AWZUpv7mG0n4DC1DiB0lpwTnuo9pIdFqv8WgmjtVLI?=
 =?us-ascii?Q?lKOyhfLXoxbKBr8IDClZ0SVe7fOvPvYjI7/2O343saqlnu8mIUXsOpFZ7qcA?=
 =?us-ascii?Q?1TU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adf7392-b88a-4f01-fde9-08d950091203
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2021 07:43:33.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/9LXrz29roj7goWjWQ3ti+VvikKxD7iqBHf1tMYxkwjm4qpBiYX5kdKHJ5aF/YtN7E16HbNbwcnQ0uXOCOHoghbbVbwy/HgolIigGRMab4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
X-Proofpoint-ORIG-GUID: m9xLbozUEuJoBGtrp0_iwCMSOHmdpf-Y
X-Proofpoint-GUID: m9xLbozUEuJoBGtrp0_iwCMSOHmdpf-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-07-26_03,2021-07-26_03,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=544 impostorscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260045
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hello,  I have some questions about this patch =0A=
=0A=
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
Date: Tue, 19 Nov 2019 09:25:04 +0100=0A=
Subject: [PATCH] locking: Make spinlock_t and rwlock_t a RCU section on RT=
=0A=
=0A=
On !RT a locked spinlock_t and rwlock_t disables preemption which=0A=
implies a RCU read section. There is code that relies on that behaviour.=0A=
=0A=
Add an explicit RCU read section on RT while a sleeping lock (a lock=0A=
which would disables preemption on !RT) acquired.=0A=
=0A=
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>=0A=
---=0A=
 kernel/locking/rtmutex.c   |    6 ++++++=0A=
 kernel/locking/rwlock-rt.c |    6 ++++++=0A=
 2 files changed, 12 insertions(+)=0A=
=0A=
--- a/kernel/locking/rtmutex.c=0A=
+++ b/kernel/locking/rtmutex.c=0A=
@@ -1136,6 +1136,7 @@ void __lockfunc rt_spin_lock(spinlock_t=0A=
 {=0A=
        spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);=0A=
        rt_spin_lock_fastlock(&lock->lock, rt_spin_lock_slowlock);=0A=
+       rcu_read_lock();=0A=
        migrate_disable();=0A=
...............................=0A=
=0A=
Operation of sleep is not allowed in RCU read critical area,  If  after acq=
uiring a rt-spinlock , try to acquire another one rt-spinlock,  This may ca=
use sleep, and trigger RCU warning.  =0A=
=0A=
Is there a problem with my analysis or something I missed?=0A=
=0A=
Thanks=0A=
Qiang=
