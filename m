Return-Path: <SRS0=URGt=7Z=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55231C433E2
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Jun 2020 00:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 331A420823
	for <linux-rt-users@archiver.kernel.org>; Fri, 12 Jun 2020 00:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MWTbei/s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgFLAtW (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:49:22 -0400
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:35200
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726305AbgFLAtV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Thu, 11 Jun 2020 20:49:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgKvDs0itCNwBoNwvZZH+rY3ZgMy+fhOlHqiZ7kRZn7V3uJRMf/NruPVxqA64+I8swwiUAy9oNXxbw309VJhv/TgOUbzpHKTgrS38FQi/xTweGViSYkmXK3HvAzQiqfDhFXWzxBtNUhBeYVA0SWXM/jbbuFYangpW8eazBKX68AbH0/SZVp59uYzFDfd2AtUrQYekrWDROG/qr+vuhfATBgLUPaitcJpcG7Xu06aJ5BfFZ6/GHBJcZfuIS/RG6ccqv4tmrIZA9gZItKgCJ6/iB55SDjaU3MU4vp4bMuYKWT2Q69J05Q2wwNhorDVmauOoYrDuGrC8VuvFzM1XtEgAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azDjWR9doyCywmdhAdppsha7g06leW4SRB9ro9Thbhw=;
 b=TOWCXRnT36GEbdqOoXlDJCfDt1QjJV4hlSwtZOge4vBrgtwHN3hN6Wn/KJ4y+dGkkubMz2gpE6n1PbPaSKbKP/s75jQ0RMP3K8OytIlwGw+znL9006B7jWLtV5KB75IiXfZu/WNvd+UFQfny6NCz8PxPjE9vlTjsh+wnbMCvomt8o7SS2EVZuI+snp54wx6KDnyIxBkIJnUjr+PHtBYj/2s9/+iym3Jdvt38VN5qUshJVVqERdOC5D6BDSd5kZo8JnEex+JvX5GId2FtH80GbpmPYzx0SfFQq50xbN60ZcpKNKlWLuSYvHMIegRYXwqdEYzD+I9tT4QlgwZbFz6+2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azDjWR9doyCywmdhAdppsha7g06leW4SRB9ro9Thbhw=;
 b=MWTbei/sBegLJXvjA/Bd0ZP8NYCsufMX2+VZGm/6VSIeDtP+b8tcnDbPoEPo8cMN7wb81zsfA2jFDKgGsi6oFwL8aNBAlcgDnU/C8fPXeMWNZbmxkGckWFKsSIjwIxgNT3psRwIAkU5nM2RQIvXyYPPnGb0/AZw4RKQ2vdrf1yw=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR04MB5281.eurprd04.prod.outlook.com (2603:10a6:208:c6::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Fri, 12 Jun
 2020 00:49:17 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::e906:2df6:5f0f:8c01]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::e906:2df6:5f0f:8c01%2]) with mapi id 15.20.3066.023; Fri, 12 Jun 2020
 00:49:17 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        Colin King <colin.king@canonical.com>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [EXT] Re: stress-ng --hrtimers hangs system
Thread-Topic: [EXT] Re: stress-ng --hrtimers hangs system
Thread-Index: AQHWOzjXl4hxTFW9UUeYcrHfuUnL/6jKAZSAgAaAYICAAN+6AIACzZKQ
Date:   Fri, 12 Jun 2020 00:49:17 +0000
Message-ID: <AM0PR04MB47726B40110E1B02471EEEDF8A810@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
 <87wo4lekm5.fsf@kurt>
 <CA+h21hqbKasMAuHL+B-2Gb-YQ3QGF+_pWGCxr8LTcusjvuqFeg@mail.gmail.com>
 <CA+h21hp+UsW+Uc-xHyQAMrRVLX9CXZu8B2Svq+9npLtxs0_DWw@mail.gmail.com>
 <87y2ovzcmd.fsf@kurt>
In-Reply-To: <87y2ovzcmd.fsf@kurt>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [124.64.121.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 781a382e-ef78-41cc-007d-08d80e6a6f99
x-ms-traffictypediagnostic: AM0PR04MB5281:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB5281FD791D1B3CC85DB7EC6C8A810@AM0PR04MB5281.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0432A04947
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V+dRRHJL7awiM+BhwM2TMx4BqatQNDC1Anmz2xesa+54O5sPS+vCaDCiL8sfN+CKGMLZzn+lYQEnHLyNhD7E5784Gspxlm0+hltWwpTLX6Tnt7Nt2kXVDss4EKo9xdOk2SqfoLEYYjMCgpazYm735wNiSwWv6x40F2hEPt3m0rOzueKtjxMXOUefpNbu8uHPXq2nJLnP11jaY7TXQkey5cZHAahqKWB5mS1S1Px6rSpBscV2oZXvcFnkUOag9VaOK3rsT8Zl4ok98tyE1mvbLDLEqb7nsk+MXmVtCttpB5d18JL5wludwGIioc+vvHbrNKDDy/2XIg2o8pH8/aQkDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(86362001)(4326008)(66556008)(52536014)(6506007)(8676002)(8936002)(66946007)(66476007)(53546011)(76116006)(66446008)(64756008)(26005)(4744005)(5660300002)(186003)(33656002)(316002)(110136005)(2906002)(55016002)(44832011)(54906003)(71200400001)(9686003)(478600001)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: aYGtA6hDWXJ4LdCFtiNKK+3GerOQQyUSDllqupAtitp1QAmVXQEkoyLfL8mxMjgae5MYHlWp3PG8C6zeNErprrJ/xUdprxskSKOR8rHCaSWxK57qUXG323vgPg/dCIu8daJ8u+cDox9t3tCBj+5fVD3TQJHJNG7wyEJEIXyNu6Mzh6c5/r8lc2Lc4veA0JNhAXUT4OvIuWPz7hmTPW0opOe3rGFWMuEvQ+DwWRh+2tfBGfspwtb+ce39We7LwkiR+2ov4GdID0TqP8vzOKxC1L7Z2XF3i56rl1t3r5QcrOI9LlhQhAiytxXAGXIQB9i+AqjlSEDRd+ytA+JlKwCksT8yHRp9UO76wwxWvgY0LBYW8cOZ9WoMTAEfwdTy6REejMidu1cBRw5UYeCtkgJfj1HUfzq2x8OqskJquwCwiLiQxq5uIrtL6G442aUcE69CXyOe44zels2k6Zd8fMhlfVdSoI1e8i7DfK8QOHBG43zmwjAOwo0oKX8JpDGp5f4v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 781a382e-ef78-41cc-007d-08d80e6a6f99
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2020 00:49:17.2776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MH1NUdLerpDX/QxxBGsD38LzbfNf7LCMH4n9jPrVzzmtvUMcECciI4+n0Z9poIAhytyvrAbrNZ5nP61vj2dqgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5281
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi, Kurt,

May I know whether you used "root" user to run stress-ng? using "root" user=
 will change the scheduler to be "SCHED_RR", so would you please share test=
 result with root and non-root users? Thanks.=20

Best Regards,
Jiafei.

-----Original Message-----
From: linux-rt-users-owner@vger.kernel.org <linux-rt-users-owner@vger.kerne=
l.org> On Behalf Of Kurt Kanzenbach
Sent: Wednesday, June 10, 2020 1:58 PM
To: Vladimir Oltean <olteanv@gmail.com>
Cc: linux-rt-users@vger.kernel.org; lkml <linux-kernel@vger.kernel.org>; rc=
u@vger.kernel.org; Colin King <colin.king@canonical.com>
Subject: [EXT] Re: stress-ng --hrtimers hangs system

Hi Vladimir,

On Tue Jun 09 2020, Vladimir Oltean wrote:
> Just out of curiosity, what and how many CPU cores does your ARM64 box=20
> have, and what frequency are you running them at?
> Mine is a dual-core A72 machine running at 1500 MHz.

That particular machine has a dual core Cortex A53 running at 1GHz.

Thanks,
Kurt
