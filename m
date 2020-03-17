Return-Path: <SRS0=iQLd=5C=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FA9C1975A
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Mar 2020 23:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3948C206EC
	for <linux-rt-users@archiver.kernel.org>; Tue, 17 Mar 2020 23:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CyzSEAhO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgCQXvJ (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 17 Mar 2020 19:51:09 -0400
Received: from mail-am6eur05on2089.outbound.protection.outlook.com ([40.107.22.89]:24092
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726564AbgCQXvJ (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 17 Mar 2020 19:51:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zb6ROwiCLz7pQyPNkA8NZ3oXi4hhPiYZ5lpK2Tj6NtxcA6+kSxyoYNSH/sC6Q9TYjzcJoE6E4Qi5Gymo8FtRy4KxOmvP1HUQDrleT1lx3NFLsYzkPmozPqNDe8bK/cddO4Yq94XH5V8GVfdRH8baRL2hggV+82yztSPD7G1YKabfo4hGqoaxBwcu4xdA7lzCVU1d+HN/pvhKPbhTYrDqZ6LJ1ni5WZbMkocrXCosBWrPEGr7af67IKDFY0ZhSyWz9mdBhXAWTWBTqAzl8SgPrm4303nD/+jA8q2mHSNID1bkPzLDcB3FrlQSdVie/tSvT4LAHG1G62P7aIdIO76kyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUtX7ZUeiNoqOlKQHq0PdQJ9vUz7TjPTyWH7OwJwDzg=;
 b=IVzJmok3aqDMwTRmFRbRmVPv3hlpgAzzi/7J/STmJssOdt81yFwlDKH8pKPRQfHf6a1ayHE2PhI0+rp0u4NZja9u8tZ3ARqXK6uj7dzKGQgscpaMxa3G9vIpc6w4tLAO+q3s4vTRHOT6spzaIuoAJEImo22v0bqZ28cNKoeN1ZVBGtDd+BpwCRkNoN8srplF7AjUW8LGcQc+7vK4GfmagmMZF0zJwXNtijUp+6NxY6xAGsitm4H6jhOW3Bi2v9NYb5lywhsB5ttu2F/KD1GZ22BvVAI6SlImND3fKhrGWFZDFuaeHvPv7HGZlzrwtrOj0ViMBE5SNwRloftUb3IIjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TUtX7ZUeiNoqOlKQHq0PdQJ9vUz7TjPTyWH7OwJwDzg=;
 b=CyzSEAhOXuxO2K3Ye0dkeaiqKTrKnvP+RrFSzcm4gNm0HQHix3FsuM8yWnCsgoU3aghp9YXUTen/SvOgfZ+6ChbTo+v8HnOchWAfJMjSjJER9ReP/Cwaiz1NP5xjJN8py9WMC94oc6y9DKz5AcJvDMGy4WY9xpG9iMejLFEntII=
Received: from DB3PR0402MB3708.eurprd04.prod.outlook.com (52.134.70.139) by
 DB3PR0402MB3802.eurprd04.prod.outlook.com (52.134.71.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.19; Tue, 17 Mar 2020 23:51:06 +0000
Received: from DB3PR0402MB3708.eurprd04.prod.outlook.com
 ([fe80::9c7:bde0:8d1d:e6ce]) by DB3PR0402MB3708.eurprd04.prod.outlook.com
 ([fe80::9c7:bde0:8d1d:e6ce%4]) with mapi id 15.20.2814.021; Tue, 17 Mar 2020
 23:51:06 +0000
From:   Marouen Ghodhbane <marouen.ghodhbane@nxp.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Daniel Wagner <wagi@monom.org>
Subject: Re: [EXT] Re: complete_all warning with 3 waiters
Thread-Topic: [EXT] Re: complete_all warning with 3 waiters
Thread-Index: AdX3wkCZEtHecTYWRr+nbNN5fw+/fQEkn1CAABgaIcM=
Date:   Tue, 17 Mar 2020 23:51:06 +0000
Message-ID: <DB3PR0402MB3708CE604A639117EDA4588DF6F60@DB3PR0402MB3708.eurprd04.prod.outlook.com>
References: <DB3PR0402MB3708A4D019B384FE29CBDD96F6FC0@DB3PR0402MB3708.eurprd04.prod.outlook.com>,<20200317120817.zm3a2zr4bsvpcbsn@linutronix.de>
In-Reply-To: <20200317120817.zm3a2zr4bsvpcbsn@linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=marouen.ghodhbane@nxp.com; 
x-originating-ip: [93.26.44.137]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4844b650-02dd-4386-48d4-08d7cace0f2b
x-ms-traffictypediagnostic: DB3PR0402MB3802:
x-microsoft-antispam-prvs: <DB3PR0402MB38021F99B5B1057E9CEA01EDF6F60@DB3PR0402MB3802.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:497;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(478600001)(6916009)(86362001)(54906003)(33656002)(316002)(55016002)(4744005)(7696005)(66946007)(9686003)(52536014)(6506007)(66476007)(44832011)(66446008)(64756008)(66556008)(5660300002)(4326008)(2906002)(26005)(76116006)(81166006)(71200400001)(8676002)(8936002)(81156014)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0402MB3802;H:DB3PR0402MB3708.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsZaGoYhfe1CKlfgzo+aAJWjym2DinrVOW5wx7KXZW5n5db+lptlEnZCuaQMxx+mXQXbikD5Mrwa1iw/25ugqrJ8gQEb3TTjUePyY4wOcvF5a0sBtAmml03kF7dvJabX9KKQ1H2Vg3LpflqahU/LPHWVUnYljw5pzGxhH3mz83HWoqW8K8VKvDV6sOIQPK44S8lvEl6JalgPJFQw/4a2tMOzCPmoTFJKDoLJu5lSS2x4c25xoLYgeNJSMUJp6FRoNPpBOcBnKY31ewPxjsA+hc+ZzC+E1ofrlZ9gFR1ACyUDcJMDfKuT771isOHEUWLFkWV+lVSs1NT/rmuknnP3HShOpoRmR8ANFNe4xgzIvwBSIw2l1bZ2oGdDkFGaBEsR75Vz4OsyKlZTkR1i1jLb8YPa+UwNFiC4PNgRKqEWaQN7hAjfYZ1SeVboV4qK0Xfa
x-ms-exchange-antispam-messagedata: WmQnYHqMhAKUGs7p/Bhj6e6dD2/Ln5oSFTMfdPr7jSwtTKSS9K4XSCQZ3m7EaRB/ue6zdeWv9DlsWnXt8ikKdX6kTSpwSiPUTKFrgXuk2yk9Q0fHHNLd8f7yyOm14Lcu3Q0CbSmh4O53ZdXGvNihfg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4844b650-02dd-4386-48d4-08d7cace0f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 23:51:06.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: roDK1bf8YINMmukj15YNejsXYa8mjbR/GlnnTjWooEiF96pTxPJaj8EQgwGt3LefU0Za3zgPPC1RTYTQppMyqdmJP8h/zIcGWsA5m9lYwys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3802
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Thanks Sebastian and Daniel for your answers.=0A=
=0A=
>> In fact, there is 3 sdma controller devices on the target pointing to=0A=
=0A=
>> the same firmware file and the imx-sdma driver is requesting the=0A=
=0A=
>> firmware asynchronously with request_firmware_nowait(). The=0A=
=0A=
>> request_firmware API in linux is making all waiters, requesting the=0A=
=0A=
>> same firmware file, wait on the same completion which triggers this=0A=
=0A=
>> warning.=0A=
=0A=
=0A=
> This looks like something that happens at boot / hardware setup time and=
=0A=
=0A=
> not while the system is running "production". Thanks for the feedback.=0A=
=0A=
Indeed, this happens only on system boot (more precisely on the imx-sdma =
=0A=
driver probe). So, no RT workload is impacted here.=0A=
=0A=
=0A=
> Feel free to raise the bar here to avoid the warning in your case here.=
=0A=
=0A=
> I'm currently thinking about removing the warning due to lack of new=0A=
=0A=
> cases.=0A=
=0A=
That's exactly what I implemented for the moment.=0A=
=0A=
Thanks,=0A=
Marouen. =0A=
