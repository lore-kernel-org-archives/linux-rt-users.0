Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED4BEB64D9
	for <linux-rt-users@archiver.kernel.org>; Wed, 12 Jul 2023 10:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbjGLKRH (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 12 Jul 2023 06:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGLKRG (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 12 Jul 2023 06:17:06 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114A8CF
        for <linux-rt-users@vger.kernel.org>; Wed, 12 Jul 2023 03:17:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KiEZZJhyJ/6hKHot+AXH5hOfCq056WMeiUVQhHPpQCWbMU1+Lkz+q2/YymwvfeRnc1SYg9SuDLQakmgmQbmndjLAdiaNqeQHm+V59oK8imkzaPyhYHK6kcKRZyKOfszISBQP4Mu1Cwlplge8G3y25pKbEhQScRwA+eoC93hxeSxtutXL6WGwil70jrEQoA8g+ZN2Cimmy3rIE2RaHYGrv9PRdWZa/9/dWlVS5e/PNu28BnAntxXjJAScXwlSJK1+Rpc1GWZO3cIrj6juCTtZkYXGAGSgLmb6zrb7ECJ6AYCbNtj9pLLBm2kd7hk/NHYsrmtfuwRkovkfMuemj0pSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AfzhXc11Ssi9pKCoKRWInrvm7RK7mB/eNOIcfJOAeFw=;
 b=hjJOrgKCjeskl9/bTO95EXMu494fVkhfuwZzTBGRxYec0ax4dcgji4nQ0LrkIUc2Kt0dtXmIZOdT+aSP10HdkxVb66gzaR1iD2jhu7bqzUfWlLbFh2tvBvOmB9hgdPR7nBnxuRn99p7ImXUmHiPD2TEWol4dT45zdAe1DBHR8czmC9zB4xIhc3MSuFfNeTGHYZwINF54ybX3tr5wUDevYlT6LpxgpjvSFgtqQ/MvlKzADD0RTOX8OAdMq7v/y0j9I2QF0tSOS0udaNjq9CpTj4Mg1TX8lL03f+VTEjr8U+C7lUt3afamrBM7XTx1444HhjSfxTfH4uMbtZrvcas4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hms-networks.com; dmarc=pass action=none
 header.from=hms-networks.com; dkim=pass header.d=hms-networks.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hms-networks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AfzhXc11Ssi9pKCoKRWInrvm7RK7mB/eNOIcfJOAeFw=;
 b=xMod7bjOmDDMlLer/9glmJkqlcTC1LGqo+XG/qVRqpCFSz+PTj4p12vinfbrRB8pjxoGpCevNxz2FDZWMhnb1Yyco5P6frwQ+NJJwnnTmZDqEZwj15mvAVjU2NEu+XnOxeasq4JbCLzJxt+JbZ2jyHqjbvw+u94sOmCQoYhlHnvshr9jA79a0+nPb8PeIkenPfNJyEQa4WnK9r72pSXBnUBgFZbCpHmbgNe+hf20LL3FoVqS3unFlZzwXZ8gM1yeaucta+SfKtV1fV1SQbSAfYbrpfieCr1S6w2CPXwdZrzLmDSCx8HuctO0Xa1Iy1C1gwVDcsiAISusQ7zjqYVoxA==
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1d::23)
 by GVXPR10MB5888.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Wed, 12 Jul
 2023 10:16:57 +0000
Received: from AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e6:736a:fd4e:b0db]) by AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::16e6:736a:fd4e:b0db%4]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 10:16:57 +0000
From:   =?iso-8859-1?Q?Andr=E9_Pribil?= <Andre.Pribil@hms-networks.com>
To:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: [preempt-rt] BUG: 4.14 patch uses CONFIG_PREEMPT_RT
Thread-Topic: [preempt-rt] BUG: 4.14 patch uses CONFIG_PREEMPT_RT
Thread-Index: Adm0qYhC+2Lddl+eQbWWorSYW1eAbw==
Date:   Wed, 12 Jul 2023 10:16:57 +0000
Message-ID: <AM5PR10MB1620935083DA304465514B0DBD36A@AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hms-networks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM5PR10MB1620:EE_|GVXPR10MB5888:EE_
x-ms-office365-filtering-correlation-id: a9e30269-d55d-4d45-e400-08db82c11f82
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /V6ZtphirxCVsksMhufRLpBadqM7ypiVbKlm08KFJmtnZziuAcrpimcaWUrr6IzkyYew6YIb2WKXSoHJZmrdVcgODH+hFq69img+nJynaQw/CGEKEIRDshqz16/NqkmqrnC/wo9l9DYPAGeCjorznBl9PePzr+tOi5DynDdWNoBRgpz7yQy0D7A5b9CK9Xz6JqjW9PqmfQwq1XuNmmfaHhADRYTZXZsTBK5B3pGr6pYiB0WmmZQwbOsJc1LGyIHhvqMBh1B4XJMT8va1Xbh+SxBML5nzXvipbV9J27L27nvv66Is4NhzDt7hxY4hG1b5GGSisG+AFSZm1y0BrcVkgsxAq7SCdm2eck9hYdjGj0KXRw1v3KsVzS+8BBus6BYKWKQ6eB06hXnPdEtHG5dGwMtp4QSO5OWyZF+n95utozG79dRn6+75eTCCBlmMQqDkwfAdzbHymmXcVd5D9yCqweHHn/UTFTbOQln0F5tIUiuNb/WsqU+sqrSPpxchHEF4eorjRI+EU6H//SMV3JLPj5n92mv72i2FcFYwalcGhb6N3ja3y+tSRyBfodK/zVqTVjdInpbIcLf0gWHC7awdRbIoIRdGCulW0gupVD/Mg3TgpPLZSnHSdqpyMJtbcwki
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39850400004)(376002)(346002)(396003)(451199021)(110136005)(478600001)(7696005)(71200400001)(76116006)(33656002)(86362001)(38070700005)(55016003)(2906002)(4744005)(66946007)(186003)(6506007)(9686003)(41300700001)(38100700002)(64756008)(8676002)(122000001)(66476007)(26005)(316002)(5660300002)(8936002)(66556008)(66446008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?juHl21kgZbaEe4hNBiQF1wch0nBfwgqMABUgga7l8jFl+kfLtByMf9oO2k?=
 =?iso-8859-1?Q?h4a8cDh0T8eS9E9mL9FGmWx+nmpqiKU8ySWNX9MrIvuMCtbFaJ9L34FnHq?=
 =?iso-8859-1?Q?yKTwOCse6IVA6shCL/oVqGtVAI5KFIDfjfVaviHIBEc2eghRcLsMvvuSjt?=
 =?iso-8859-1?Q?ygaTyuC5zOhspO1aGl1s3ODtzBjdZSRM4vbB8BY55Vl5eNzgYwDBn5Y5u3?=
 =?iso-8859-1?Q?7x2Kb4rypDfAeyKQKLM+pjzB1gUyQKopDD15lJEr40MPzm1KUBvjgDYc4f?=
 =?iso-8859-1?Q?b9VtpXX0IepUd/+azQW+3Vo+tgsqbkxB+CVjuPb9f74b8WZIE4y0CcRX8y?=
 =?iso-8859-1?Q?PV22AoYoTCSH6kvj9wn6ewI0bIJ0+NOysdyxLlYktmgOewf6466C5gwYCA?=
 =?iso-8859-1?Q?fO2wRI8T6vVsqHUaz3zrrPSXYAkSB0igbIBSi6FFIQeS2OKXJZlPr2ZtAE?=
 =?iso-8859-1?Q?Yz7h432JKKs6EmmdvR8Wg1OkgEN2/y2ofnk7P1wsLIBHzVp08sl5Cjqi9v?=
 =?iso-8859-1?Q?IrxqPiCRccjRU84XwTNvsCjTjU4SRwEJgMgoItJo1DO9BKMQBN9EqBgXEi?=
 =?iso-8859-1?Q?9+G6CDK2glqH1BM1duaaBQ7iGHRNn+9Cgw1IYaPtuGStOIHU+Jk/fjjiE0?=
 =?iso-8859-1?Q?co0EqEQtC2Sl7CxLgdR/AspdcoqRkTSjR2ETrxPR3yayaRml7VHhojvmX/?=
 =?iso-8859-1?Q?nKau3e0PTfHVPUzFHesZXPZ4x14lMILp8h37ZzDkT9mD4QcHgoYI1EtRVi?=
 =?iso-8859-1?Q?b5WLnVayYwzMW6SWjdZBnJlXBLhxARh/dQ730wk4NRXrSbFd8yqTJ4Obcd?=
 =?iso-8859-1?Q?8Om/sxQIq+SiifJukwCoyYotnDqyecJkPG09sX1c3PVXmUfpTOth6IT7+g?=
 =?iso-8859-1?Q?0v+xOWTwSjgu53nnev3DbBCWBb+zYAhJlXVIVyTsz6z7r8y16JLSfifT8c?=
 =?iso-8859-1?Q?aoekSNErsH/YOCemFeLoXx0+EFpz0/K2lkb4V8hdLpUP+rPnBEeviadsM0?=
 =?iso-8859-1?Q?RhxsF1FWCISNgN+A/+t10pdKawtYELHeqIJBYtdCrh6dhFCF6+2tJSXx9g?=
 =?iso-8859-1?Q?gFFakP2+QyyMFDlGQWdGtQFlrxOpFBjpcilkD4IAOL2KJf0j4n9gak0B17?=
 =?iso-8859-1?Q?Qv31cUu8+tbjkxx55GpSZyw3SUu1VV5CZBrOW1hcoDAY9eBhjVWW5UHpPO?=
 =?iso-8859-1?Q?Yo/8Gb0lEejm6N2MgqpK5lmhxNkmqPycMt11s+JOyMzsJNvn3e5VPC87GU?=
 =?iso-8859-1?Q?hYWQVpPV12sX63cUgrSq76mBw2YWQvP7SbYp8MUmWtNO7hDB68/v14V8hb?=
 =?iso-8859-1?Q?aNQ+1U9HjnVI5zMfSYWDNOhNA7lxae95RZpnIwujdvGkEzj6HmCKRts5FM?=
 =?iso-8859-1?Q?pw8chujvimmjuU45XO4DMNempD4L46AtVgXgzPR5lZbh0IC0oPk05jRTVK?=
 =?iso-8859-1?Q?01iOpzKkDprEInq9oZiIiJ4rMXVp/7SQ9FhybS60hh5ltDVEioKKzB4R8E?=
 =?iso-8859-1?Q?ZPT/LVETxqtST2f8QUQU3aHOutjg6rCBg91V6Lu79n0ze0BgKJSatCTRmG?=
 =?iso-8859-1?Q?vBzHjGH1H9hOUFhOCIbRqAoniIpWC0qkSXEEKxWV9EouKgFRix3FHncF/+?=
 =?iso-8859-1?Q?OhXFCeUsCZQ24=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: hms-networks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM5PR10MB1620.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e30269-d55d-4d45-e400-08db82c11f82
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 10:16:57.1960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7c1590-4488-4e42-bc9c-15218f8ac994
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p41IyEjwoe4bU0XCdOebAgDoUeVKnG9ibIj2ZiYqby+gmvtHiJr734M8TWjhhQqt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5888
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

I think there is a flaw in the current preempt-rt 4.14 patch (probably sinc=
e v4.14.302-rt142).

The "0515-timers-Prepare-support-for-PREEMPT_RT.patch" uses at two location=
 the=20
following configure option:
  #ifdef CONFIG_PREEMPT_RT

I guess that "CONFIG_PREEMPT_RT" is not defined for the 4.14-rt kernel and =
should be=20
"CONFIG_PREEMPT_RT_FULL" instead, or?

The problem that I was facing was that a tcdrain() call from userspace was =
spinning forever.
I traced this down to an endless loop in del_timer_sync().
After replacing "CONFIG_PREEMPT_RT" with "CONFIG_PREEMPT_RT_FULL", the prob=
lem
seems to be fixed.

Regards,
Andre
