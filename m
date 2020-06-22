Return-Path: <SRS0=LZsy=AD=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04E5C433DF
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Jun 2020 02:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F43120888
	for <linux-rt-users@archiver.kernel.org>; Mon, 22 Jun 2020 02:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JFIZ6jAv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgFVCa6 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sun, 21 Jun 2020 22:30:58 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:54145
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726673AbgFVCa5 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sun, 21 Jun 2020 22:30:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aQcQcz400JEaexoGPij60ae34UwvcdUeyeP/j+DZfGwMhErWz2/F6KRvEYqbsyUxpO8rdwbMCzbXeNxqW/S/ftzWAAoQ0mTSfy5b8HsAUF4nOwVJKkqWM3EbxI3SqRLaJmq7Z0g/xm0Uf/w76bjxaldKQ52kNOEYNthQJ0zNLwaewdu4ASUq9EqL6H0z6tnsS5usf0VczwIOly9mSvNsjRQ6fNasjM2m21h3CG9tDr2mEYdy+ihUEfbpl8Te5IuM4/B0xRpDSeLVKL67QBNarPlgW4PqYFSH8tqROw2BjUnF0AUVirr+lqtg8StJbSaOZ7Eqflf3pHmPZTOPwWII4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73jt1F3KV88NMeCNyBvm/hoCJDumCGLgq5gvnGZw4EI=;
 b=a6ofFqGFuniLtPxWYW4Lb5nC1QwtHPC5IB/MVF4Szjvl2iW/N/JG+ijs5kD+3+kCqiwVi88rCxY+zaXDkLjMfl8ZzSlrCp7TM50UWIOkWWTpilKP9JEmQ5v1fl8gc/znmubvz5aj/j2zM+LCCYdgoDV5exwuMHw27PjNGt9knk8cGnkE/lDlFaaiiveXfdj39HvVWQJuTnZmVx8sHL01CGVBU2pHpFzUvDIEJW/ihvkVycFW/jMBa+o8CxJxeJwFA82fkUX5N93NVNwGCFnb+BxLrAp1lL6sULD6GTjHuoVrLucQsxXn3bPNyR2vmU/uI4eTfMrKzHujwfJHNTSJ+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73jt1F3KV88NMeCNyBvm/hoCJDumCGLgq5gvnGZw4EI=;
 b=JFIZ6jAvx3jJQcqIlCR6vA9XkDGzxVjKkS3Sqd3PbmuFbKrDeZ2XYWQLXJmRHTqEVCNdXtCrAi1ZFJKPsIek1rKRJJ6r0K9yLXdOFc5Y4a97mExQZm0xpGuzFHbyLDTgezimcuM5OZIuXeNgmHCv8acxzuAQfMSL7wH9bMi2ml4=
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com (2603:10a6:208:c2::17)
 by AM0PR04MB6804.eurprd04.prod.outlook.com (2603:10a6:208:189::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 02:30:54 +0000
Received: from AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::e906:2df6:5f0f:8c01]) by AM0PR04MB4772.eurprd04.prod.outlook.com
 ([fe80::e906:2df6:5f0f:8c01%2]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 02:30:54 +0000
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
Thread-Index: AQHWOzjXl4hxTFW9UUeYcrHfuUnL/6jKAZSAgAaAYICAAN+6AIACzZKQgA0ORICAAsYkQA==
Date:   Mon, 22 Jun 2020 02:30:53 +0000
Message-ID: <AM0PR04MB4772E9C0733F81FACF24C58D8A970@AM0PR04MB4772.eurprd04.prod.outlook.com>
References: <4781d250-9a29-cef3-268d-7d83c98bf16a@gmail.com>
 <87y2ovzcmd.fsf@kurt>
 <AM0PR04MB47726B40110E1B02471EEEDF8A810@AM0PR04MB4772.eurprd04.prod.outlook.com>
 <11546107.O9o76ZdvQC@kmk0>
In-Reply-To: <11546107.O9o76ZdvQC@kmk0>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 50126e90-4720-458b-98b3-08d816544994
x-ms-traffictypediagnostic: AM0PR04MB6804:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6804A5E2DC3BBB4B23F2720C8A970@AM0PR04MB6804.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKf0L/P2VlmrzcfVo8hzWfgMdXPAAYy2GBMtm9Mzo/NXkS1kFlOaohpJpGIeX9fTJPfI5lxG7RB2zTAgwqWPsslGQIx0U25bd4GnVNoQNrqATlYpWcsXlcrTIylmMuXq+X03QakUm+6VA+PBaRnxIRvEdrGo+IhWeZZa81kKSc3oyPZRTAkNui86zK/GOaVoyyoNsxrT79f2IFYFSF74OhQnVVKzalspqYy9Q/GuQTN428DHd7rvbeno0ZOUL7cPFHCxHzXOcETaRhwq60KB2pZ+aXZgFKQfbs6wKjDvkplEHmhPOXFNZ/Hs+oTw6oVI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB4772.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(66946007)(54906003)(86362001)(110136005)(4326008)(7696005)(316002)(66446008)(64756008)(478600001)(2906002)(71200400001)(66556008)(52536014)(33656002)(53546011)(6506007)(44832011)(8676002)(8936002)(4744005)(5660300002)(66476007)(76116006)(26005)(186003)(9686003)(55016002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: JhG85oJBsEU3jYnpeuSorIngFeSUaVDb55l9FQ3G+IEP3FSxc2vtqMQIbzFn7xReB8nW78fWBHyIhQ+/TZCyl6FSVoW1Kb2FwWJhefwH7CrXzB2uZIpiVhIM+uIbkkfIOQaDAVHHVF4NTgnwJ571HbN5JUpht+UgLizizaSwTfcEAfhj8sQ7wJUXrk2UAYw8iQ7RxHjHBZwPUoAQt2v6ILl2K/5IE29La+NFM93SmIsXSYv/HNE3j2+QR5vqPk5+Z3zlJpG2nG1Wj+XF4TUk0r5peB0GZS+OIsyuE5khGCptTAs01HkELWJJSFCnmgYmMuFJcyXNer0aiXoHMjza08h1V5cVJJiTNnoZgVDuFj24HIwLg7OSy41JeMZYMeZcl+azveIgNLp2SI5qCeelQAilYbPyxw9vScoHqWrq62GPFUPO/IIr3mznM79YLH1EfR9a/H0jAfyf7hVkJl1mKLWsso4Z4lWIo0aGq8WahN4=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50126e90-4720-458b-98b3-08d816544994
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 02:30:53.9914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFr5mHAN6AvojbpaIgLl+h154USEmKZ1S6N0krfoB6BcIXWmLastZlmYwhD7aahYHN014o86Uc+CBGyygen9wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6804
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks Kurt for your confirmation.

Best Regards,
Jiafei.

-----Original Message-----
From: Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>=20
Sent: Saturday, June 20, 2020 4:08 PM
To: Vladimir Oltean <olteanv@gmail.com>; Jiafei Pan <jiafei.pan@nxp.com>
Cc: linux-rt-users@vger.kernel.org; lkml <linux-kernel@vger.kernel.org>; rc=
u@vger.kernel.org; Colin King <colin.king@canonical.com>; Jiafei Pan <jiafe=
i.pan@nxp.com>
Subject: Re: [EXT] Re: stress-ng --hrtimers hangs system

Caution: EXT Email

Hi Jiafei,

On Friday, June 12, 2020 2:49:17 AM CEST Jiafei Pan wrote:
> Hi, Kurt,
>
> May I know whether you used "root" user to run stress-ng? using "root"
> user will change the scheduler to be "SCHED_RR", so would you please=20
> share test result with root and non-root users? Thanks.

Performed the test now as root and non-root user. Same result: No problem.

Thanks,
Kurt



