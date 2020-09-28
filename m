Return-Path: <SRS0=JPb9=DF=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280A6C2D0A8
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 10:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBB1208FE
	for <linux-rt-users@archiver.kernel.org>; Mon, 28 Sep 2020 10:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iu+tCoJE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgI1KHu (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 28 Sep 2020 06:07:50 -0400
Received: from mail-eopbgr150048.outbound.protection.outlook.com ([40.107.15.48]:36871
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbgI1KHu (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 28 Sep 2020 06:07:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCYAtV9funZ6oUxPsIwYHZljYrKlVhKG8BTQd0mzPwWyAlv9IejpzAifuOxcAYmxf3py9RzmJpUO/5BmiKOmB4oJdkT2gwIH+73N8CXH79jvHeBJENQUxLeXew1O5kTMtF+XWkp9PWsWoQFFiGULLBtHLcSkDdfa8g6qDxRWgGXXY9M7P8boJMB1/urEojO2dwcmb4jv+G8jlUJXc0jcgz+U7pz5A7xbMhs5lhnN/y/OcR0XXLN6f/i+eSblPUfq7O94a2b05P/w8RoaletxPV+AFGIkubhDJY0sVTCW/J4YkR97ptr0vpGaSI/Jws0nHCKbx/mUXuZlrihmccN38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I96z9bydbBkXqoq/DDnFeEJkpZP7T8/ceV1kwHQz+A=;
 b=R1QXbLvlG06k52Oa/1CFxWLZgw/C4TYuw4nYXUcrxA2ukJev32gkHdOI5g6Hg5aTZUy2vjq+dOrU2JwqEwXkZj5w0bNpVPAdsRr1xeV7nIaI8QpHj78xor+CsfCzuYHjbK1wVGwjs9OJtHEzx/MlflZYp+dI+G7QbbNnZsWexF7kLMBAnBKjnrBf3uANUDx++oCsEC5sGIv4oApMNQVZztklV9fng6lChRjPwGHwipcVLoNotyF8evmyszrqol6PzNWXvhJhM3ZVhGwbK0Sjw5aeBEgxQSQ/GYWkVWcmImRuK6ANQ0OzAg+fP0mbrkw7pcwGABUtx96zO+K4ftbGwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2I96z9bydbBkXqoq/DDnFeEJkpZP7T8/ceV1kwHQz+A=;
 b=Iu+tCoJEyw2vMu7XSTOZLmV+L3JXmTCZczPhpzVnNTASnJ9rOtIhAva766pr6V0Ft2pM9PZ0B/iXaqu7LQwkOeip8gHk3V6Vv81dL8D+91ykp8ABogkOEJzfCS8sEKM0au69QEpxL1ovizFbJXAdYR8p+m7oXzVAcW2pFEwg5UM=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20; Mon, 28 Sep
 2020 10:07:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.029; Mon, 28 Sep
 2020 10:07:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aaron Marcher <aaron@sigma-star.at>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: Debugging reboot freeze
Thread-Topic: Debugging reboot freeze
Thread-Index: AQHWkyNcgPqUGjL190yCUeRpYfxpc6l7q9wggAIC/4CAACgssA==
Date:   Mon, 28 Sep 2020 10:07:46 +0000
Message-ID: <DB6PR0402MB276079E8BC4B302DEE99B58488350@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200925100450.3t3xrwwb22fac7ti@linux-8csb>
 <DB6PR0402MB276028AE4CC27F2ACC5D96FC88340@DB6PR0402MB2760.eurprd04.prod.outlook.com>
 <20200928073959.jf5wqgfzirhns6u3@linux-8csb>
In-Reply-To: <20200928073959.jf5wqgfzirhns6u3@linux-8csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sigma-star.at; dkim=none (message not signed)
 header.d=none;sigma-star.at; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 619dda29-c762-4f8b-d854-08d863965982
x-ms-traffictypediagnostic: DB8PR04MB7177:
x-microsoft-antispam-prvs: <DB8PR04MB7177AEDB4B7A63A0E55093E288350@DB8PR04MB7177.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fcr/WyR1PDLs8cE1jZwbHfEEng0Mdz5iFANghuHPxNtM4RZXdY1GbZZjGOkGgroAklGw6PSCc7+vU1gbfdErSVqzgEb6glEWNAW+yiJ+SrAxzOAUFa/qbY3yvyPfRwQETbjXtgqfhsGY42Ef0GFPdqAb3CxXN65FS8Nyh+EsUCVx7dN5u50I0ZKh4zfFY/kmMZcZ7/j5WS4aLZ7Agv8vyX1A7Lr91sWD9U0VRdY9WeCNaaTbJATkcZ0fv0cF1Cz6/NZ8/ZO/EaaCJXXetYUXgvfspW+jkgd3B8Bllw3gd9+mEpVtLZ9+E4nnN8h3+K8qqR5hdgSxVlX//fuhNrdsMdTBSacgXDhZHZ6n4opLuLPsmaCMBSDk09C4ygIQ4MPdoWwzSV3qzn1lGfK3Vkzq8PQmJLimLZNoKyeqATQmhcBj5j3dBHJVBjE6n+vQIHPpBRYNaLKE5cAQYMt7Kdnbug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(55016002)(3480700007)(2906002)(9686003)(4326008)(7696005)(71200400001)(26005)(6506007)(316002)(44832011)(186003)(33656002)(8676002)(8936002)(7116003)(45080400002)(5660300002)(478600001)(6916009)(966005)(52536014)(76116006)(86362001)(66476007)(66556008)(64756008)(66446008)(83080400001)(66946007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rPviXzJYocrDITG1AV42rjvIykPfwLswW8Uaapwd9i2Umyt0zXM9Yycpk0DER9VzmrcMB5nN7KG6XoOSIYMAdwEfwwYA5LUGgEt/1g2IbbK8mCbsPD+S8VFVGkQ7bvLOQrtLAJT9mji84I3kM5b6zt2o5CXBbIYPMy0bFv4APyyDSfE67e9G3T6t6eFjIqTYc0EBYvFDwtWa2jzIDhVgtmJorln7aT+2so4Qgbr2f38Pgg9txzrq1MOQXLxc9IYTFoqFAOfxY/oVCDg8Mk2/lWWg3OCETYcQIaxB6HGd7ODwFM1wAomjoOU2YKHc5S8UTBUDsnGk3ij30SCzw+AUx7y2j3/0psLmaeuWIST1NnroqoZg0xH7mQoGRrEIKuldoT9PZeh2iXNt9xvGmct8x6pO4iovglWvdT/tVKwW8WPT5gtSpMDwrMpRNB3ORGEtvwjduwzBIBgHKn5V8LtpEbE2BBVrW4CZiATL7BfM9lNcynagWu89C/nziiO0uYveWiUAvT4BbMrBQmVBTIp2Fa1+i2zabcMgE7HaizvcLh/LDh+zyx4GnB6MA2EV7QlD4n4881VZA/Jp6Pa69CtToJMIinnjzt314RADK0AHQfSZ7ew4ZZunTkDUuGqI9U4oPJI61LuNFoJSTDmsWHfEuA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 619dda29-c762-4f8b-d854-08d863965982
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2020 10:07:46.9617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfEoS6U4bHYP1qU6+QClSNUTe/bo6QlzvZS6qH7+5zheDDoS4uzelEA9EiYJU7Pifo3rzKAoHRFrHcHEZG8lJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> Subject: Re: Debugging reboot freeze
>=20
> Hi Peng,
>=20
> > Where do you get the kernel source code and which version?
> > NXP release or Linux kernel upstream?
> >
> > Also ATF/U-Boot version?
>=20
> - Kernel: Mainline (5.4.66-rt37) + PREEMPT_RT + your power domain patches

you mean upstream stable branch 5.4.66 + RT37 patchset?
Where is the power domain patches? I not did this part.

Do you have a github branch for this? And what kernel config are you using?

> - U-Boot: NXP (2020.07)

NXP official release is 2020.04, not 2020.07, could you share the link?

> - ATF: NXP (v2.0)

Which specific release branch?

Thanks,
Peng.

>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsourc=
e
> .codeaurora.org%2Fexternal%2Fimx%2Fimx-atf%2F&amp;data=3D02%7C01%7
> Cpeng.fan%40nxp.com%7C18457f343ede453e0b3908d86381b506%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C1%7C637368756031689583&amp;
> sdata=3DIZtLBW6a5e87HRspOW5utxsTTehv6E0ZpnRXQDxhOKU%3D&amp;rese
> rved=3D0
>=20
> > Do you have a debugger to see where it hangs?
>=20
> Unfortunately not.
>=20
> > If you point me your version, and source, I could give a try in my side=
.
>=20
> Thanks, let me know if you need anything else.
>=20
> Regards,
> Aaron
