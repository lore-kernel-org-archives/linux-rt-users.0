Return-Path: <SRS0=SWPK=DE=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEAC2D0A8
	for <linux-rt-users@archiver.kernel.org>; Sun, 27 Sep 2020 00:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9769323719
	for <linux-rt-users@archiver.kernel.org>; Sun, 27 Sep 2020 00:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZGBcnBw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgI0A7u (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Sat, 26 Sep 2020 20:59:50 -0400
Received: from mail-am6eur05on2047.outbound.protection.outlook.com ([40.107.22.47]:40737
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726311AbgI0A7u (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Sat, 26 Sep 2020 20:59:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNU080iyMJusMxZSy6u4CScLizogZ9C3PGAF9r7UK+kGfdYC0c26pWMPHAfLCyLvyz/sU9Rj0bp7XAuGlyvClE6OtK0sCkvO5uv4pkedfF9gWewr0JDCJ/2VzyHqPwX22bEux6pzAG9lDL8q/YUP/iFwvKkFXjsaiXk2tpzG4HxcelWgy/e7tpE4UItBNMHksd+14nGyEwZD6VgscHD8UycQSsdOxOaUTfa0/REjVShWZjxw3EzEiMgwjQqV9yxQdiQnAKoyVn1Hla9vM4gnKXYtarLgylnqibfket9CTo4VnZDqt3xfFh2xkrq8sIaEkrC9MnS5HiNOxYYSlxR/Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vKDYXyKsqDkG0CUP7hglMfBChpCeOe2tm8eKZkdNIE=;
 b=Ruf15lzCCh0PQ4cOeqbPizPnQHzhoLWCT9AZG89EgjcGBdREAbCc5fV/8dPbLva3MeHKlmPaZjGItosasimiu/fbhxJS5WQ9ESfH52HfySR6ciUNRjoUZvy4dq2PW92Ui9ErRLMvgB/5Vev5DT1joZ9zwxB6/gjPlusnSfJb2D1hPic0Xewnsjcuyo6LzeSVoTFTGzcHT5+cw1VkHmtnxXx5GEMT/JajVi86Q8eTJVwW8y6KXOzvH6PcO5Wm8BESiDjTwrhK3WNllDux5zUF23n4Vh6dyFeiSLJV5TUPdsMF3AZ+8v850kI+UTOE0EhTzvOawjQymDDPvBc+GdL9QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vKDYXyKsqDkG0CUP7hglMfBChpCeOe2tm8eKZkdNIE=;
 b=ZGBcnBw1XxgcIEkvQIOQHTdzou67pMEaUSH00kLstNst4HjBKDnMiGQAZSJtM+AAtNeNdSGBF5oKNTs6PeZHnIozCciFUieSgdOW7lxHO4nhYYliWZMx9rOOxbbHwHjjHG3BFV2BA23wlsK+1stuRB/ugXsBW7v+2Qs3JFMly7U=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB6PR0402MB2935.eurprd04.prod.outlook.com (2603:10a6:4:9d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.25; Sun, 27 Sep
 2020 00:59:47 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::35c5:8c71:91f3:6bc6%12]) with mapi id 15.20.3412.028; Sun, 27 Sep
 2020 00:59:46 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Aaron Marcher <aaron@sigma-star.at>,
        "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>
Subject: RE: Debugging reboot freeze
Thread-Topic: Debugging reboot freeze
Thread-Index: AQHWkyNcgPqUGjL190yCUeRpYfxpc6l7q9wg
Date:   Sun, 27 Sep 2020 00:59:46 +0000
Message-ID: <DB6PR0402MB276028AE4CC27F2ACC5D96FC88340@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200925100450.3t3xrwwb22fac7ti@linux-8csb>
In-Reply-To: <20200925100450.3t3xrwwb22fac7ti@linux-8csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: sigma-star.at; dkim=none (message not signed)
 header.d=none;sigma-star.at; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd3d5a74-efa9-4b30-5c0b-08d86280a108
x-ms-traffictypediagnostic: DB6PR0402MB2935:
x-microsoft-antispam-prvs: <DB6PR0402MB2935718F8E79021301C796D288340@DB6PR0402MB2935.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vFLGhvBMCCwISUoT1WO+E1qsJke0l+40lE921omoWfbzWDptdHC05/K4oC6J0g9V+ddSvQ/tAPyxSZ02MwNUwB6s6VXF2acfTHhgPmqlxDgX1ey4x/MAMYSaLs0bBSNchSZmEus9hmoAlUUNYFoSIEvITg018od0bJhc/3rVzWAEB+30DLDQiLaqU4kwCCvvsLIGzNJO1rJjvrHljgJRd/H9ChyT2SgYcczlntMqlxb/kqJ7sXJcMZFxMhhVm846QZf14FQccDnnmBeYviVnmOUlY4aV61kjZ0uBDEPy67wV8dYkeiq50WF4AfpG2fEoLFgqk4m6f4NqHoTG8C7eZI1W7gc7CaqICoXk9nGdjAYYwQZc+TiAl/jAbbQrNoPs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(86362001)(8936002)(64756008)(66556008)(66476007)(5660300002)(2906002)(316002)(478600001)(26005)(186003)(7696005)(55016002)(9686003)(52536014)(71200400001)(110136005)(8676002)(7116003)(83380400001)(6506007)(76116006)(66946007)(33656002)(3480700007)(44832011)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Sh1ZGsCgK/oKE1VZlo7xVjYlISQJlHsx2yN8wQj7djtL+zCBQRhMqglddBzqxPEXrcQ1zRL+p4pIkCga3WWi4/c3WfrmpChiRxGgKKBvuv0/FsC+Ghgm8wCdpgG4uy1bJV3UoO4Cllm4TjCwi6JLB0Gs0xpFzh1U39m/42QgrnHYW/zJomjNQtn51zsoutswX2SwWODGEbE5VM7bQn+emABOfubkITQDyHoRi+fVhHqtHEqe64jzT6TihDIXoo//OcXknsBmagFWyUc+5gLjdn7ShfHRR8hf8T6njsuZ3uLGM8U6e6m9vj1JF0WYucIZ5C0FFuLM3g4SnTSuIGAC0IUaBaLFGouaMMJk3LAFhxxgXQoBExRFif3WI6pa6bEL0ntZbIEivchnPdjxWKtAz1l3b3HGo+yOFMXQvPxc9xMJM2z+UUd+edX+V0f5FqKgKcrpjOLmcI6+Ld+PtNZJKYko71nM3Uoryp4rFhKDp5sWwbiKI1uKDykl0hgHnRtpJ4vh1P+MHRl+BK7fI895yaKGrXfifx0615ueDN5z7ZF1ts2ZAouYZJYM0vToLqJP4GIpCBKDJIkmKRPXKvQ+M+fFediw8w9zLTVK8K61dSVM+dmQV8SPKHqbuToKwHWxqK98cpXMIkh+LdCzmXZXWA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd3d5a74-efa9-4b30-5c0b-08d86280a108
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2020 00:59:46.9460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aX04Iyb4MMRz68dTEOThvZl+OPwYUvNLUppI0Dvsyt14XE8Ne/5EfYPcRjeln6R73z5FHFqYUTbYB99M0xNT7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2935
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Aaron,

> Subject: Debugging reboot freeze
>=20
> Hi,
>=20
> we are encountering reboot freezes on the current 5.4.66-rt38 kernel with
> PREEMPT_RT enabled on i.mx8mm hardware.

Where do you get the kernel source code and which version?
NXP release or Linux kernel upstream?

Also ATF/U-Boot version?

> Unfortunately, debugging is difficult in this situation as the only relat=
ed output
> we get during reboot (via serial console) is:
>=20
>     Rebooting...
>     Segmentation fault

Do you have a debugger to see where it hangs?

>=20
> However, the second line is not shown on every reboot; the freeze happens
> everytime.
>=20
> We already tried various kernel command line options
> (print-fatal-signals=3D1 oops=3Dpanic), earlyprintk/earlycon and a lot of=
 debug
> printk's in the kernel source.
> However it seems that there is no output after
> `kernel_restart_prepare(cmd);` in kernel/reboot.c.
>=20
> When using the same kernel version without PREEMPT_RT, the issue does not
> occur.
>=20
> Do you have any hints for further debugging?

If you point me your version, and source, I could give a try in my side.

Regards,
Peng.

> Thank you very much in advance.
>=20
> Regards,
> Aaron Marcher
