Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885BC433B4
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 06:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DDEB613EB
	for <linux-rt-users@archiver.kernel.org>; Fri,  7 May 2021 06:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbhEGGXV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 7 May 2021 02:23:21 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:54078
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230197AbhEGGXV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 7 May 2021 02:23:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oUjVEOhM1OgaAHvRWQ/SkuJ+wpm07P0hURrb/nYwhRV+KfYqCMp9+0tfHfYAoMC00yjKsoOfflIkn03syd+Ew/0WvYuvww1O70XtOFxz+f2Wb/CsXJ06pEqvDwurtLBeBN1MvNyO+ZpUwfwa9prR0E9vlEYZZ7YP1Vy0oj5Fvrcguha6Mq7Y9v3bZN5DMqQbKrey+9m50bKoGRfkZYRdtjgGgDP+YW9ONSu/ORSIjFeQ5WHbKLZbqV3kigi0YSLGiDdzXyLaMkS12ojKCKYhJrRhz8A8Vpj55pwMFkhF3/Qra1W7e3Tved567g2Gt/yhyrrDQt200kUBbCV9yCj0hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwQlfKJgT/gFp8+uxHuIFbPpxZe8fXS63EwuUVNA9lU=;
 b=YPZQh8ieFXQtzJ4hyL61DrGRGFDkZN4GK6idHQXD0eux9/eR7bmPylMnr53W5m0sEYaVr4Nq7rjWvi70oBD1QSHdTZtuOfgWJze2TFNq58oABWcNRNg9fVgEetp4wjzjkRBUhU5mTrTu6XME12Sl5eYLjotNKtNqtWaFvFWqaaw1uJB/ZjGicjiFFbxNuxiilU2rjDG0nm3t4Y2ZeA9JetH5OyjdX5tCPeHQu26sXzFKLSEDVt12nL7c8USwJIJH2wqCQKaTxyYzqrRElWcUFwvlIr2OcOoezqLIMQLhMZqzsDg95ShRCAEr6bRhdd2/67frGZb1C8yxwpRevY8vlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwQlfKJgT/gFp8+uxHuIFbPpxZe8fXS63EwuUVNA9lU=;
 b=OVN1DoUqezhPgCkxGaqHMuOWI1EE3CDqR7Boi4aOeb0WGftHnXgEdQJAE1nXBX8sDeXAsxejSN3RVKZAgQxqFuTHLB7mMyglkDaon2J2i9WjgZw7vN6n3+s/gzgBeJJ/P/iCduDz1a84EA6My9Pekfo7SS2JuHBK7R2PEp9Oz5E=
Received: from AS8PR04MB8182.eurprd04.prod.outlook.com (2603:10a6:20b:3b2::5)
 by AM6PR0402MB3751.eurprd04.prod.outlook.com (2603:10a6:209:22::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.28; Fri, 7 May
 2021 06:22:19 +0000
Received: from AS8PR04MB8182.eurprd04.prod.outlook.com
 ([fe80::180d:50eb:d42c:4e5a]) by AS8PR04MB8182.eurprd04.prod.outlook.com
 ([fe80::180d:50eb:d42c:4e5a%5]) with mapi id 15.20.4108.028; Fri, 7 May 2021
 06:22:19 +0000
From:   Jiafei Pan <jiafei.pan@nxp.com>
To:     "williams@redhat.com" <williams@redhat.com>,
        "jkacur@redhat.com" <jkacur@redhat.com>
CC:     "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [PATCH] rt-tests: pi_stress: fix testing threads' smp affinity
Thread-Topic: [PATCH] rt-tests: pi_stress: fix testing threads' smp affinity
Thread-Index: AQHXIiM8CI5/gVWxU0eUxagcYXlpjqrXzlAg
Date:   Fri, 7 May 2021 06:22:19 +0000
Message-ID: <AS8PR04MB81825DF5E1C40EEED0C2DC2C8A579@AS8PR04MB8182.eurprd04.prod.outlook.com>
References: <20210326094404.18110-1-Jiafei.Pan@nxp.com>
In-Reply-To: <20210326094404.18110-1-Jiafei.Pan@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59c46d43-4657-4a61-128d-08d9112077d1
x-ms-traffictypediagnostic: AM6PR0402MB3751:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR0402MB375199E95FC7A1F88AE51C008A579@AM6PR0402MB3751.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: STvtxlMe9MkEjeO45xOj5iULSA63j7Pe0khKueeJ++upHwQAEmYSW3JpjhXq8zI34ag/c9BM1aOjYjDWF8ub0giJHV1WiXYSX25BmVEUcnIyhsoCT53vyZIku3/cpdlYJhUAxQfuLiricVnKFFS0LKPy7FvSqxlxfVE/R2EFpLtw3EfwpsU6jquCHvkVv+b2WbixpUYQKc4CPQAIeyepjIneGxtYqDOwbNo4ncXBh7nYQ/kX4ElBtXG9AAT+yhPrS5GIYYK94LFDDSipT9vUwx26v8Ua4zAFGQVnx0Om8jnlO/wSYZ0ntVQ5t8Vw9JT5afv3EcId1jfkUlMVWDS5jhMJyfqeh9Ai5QlDm+yVshpwjUT7UhzHu+Me/VEGHTMnR0YuA1MkqCWpmGiXi8U5JPRWL13pKafbmCZ8uSPSBs0W65LQINEN3eRNBi0BB6/MqlQz7P98Sw3TZNwBfK5NAGh3LBoFOnWsbtW8f1YqE4HOP/UhvCeGuxl1skacIeguEQDq/eHs8KWDbvYFsPXkiGCEgCzDHnWl6n8G0oOh84XjvY5/XPNFDN1UHOFlZ+cvEA4uCYv+IEhe93HfzIbVcWMUmVwVBABDOebwWUVf4/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8182.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(366004)(396003)(186003)(44832011)(26005)(55016002)(66946007)(76116006)(8936002)(38100700002)(478600001)(122000001)(5660300002)(66556008)(52536014)(64756008)(86362001)(66446008)(66476007)(316002)(8676002)(54906003)(7696005)(2906002)(33656002)(71200400001)(4326008)(83380400001)(6506007)(53546011)(9686003)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?eqzw8i1D6D2z9sGTCq+JLzHfpooGP360zPUMiqzOXCwKqyxYrhN0yMYGUzQ8?=
 =?us-ascii?Q?0XFmaaZBknkU+mjAtr36sFOhoLAMHQeFN4myebcgFMgg964z6E9bXRVu6oEx?=
 =?us-ascii?Q?8EwVi8gfmUbMh5hjsWFV6TDWkcQEN1j2oVTwDUbm1TSJVxvBKnEyGxEcSw3P?=
 =?us-ascii?Q?9IfmoiWqlAI5iP5cFEIlDVrxDnLWoWionctIQdpsp6W838iEa5z17kAkXdv2?=
 =?us-ascii?Q?OdsbWknXNnUJ7JFCr9bfcGvrkFdh4yr/so9SFqXBfka+iXW0Di1kkkMa4JZi?=
 =?us-ascii?Q?1QecmrCOP8juI0sRzfopHvkX3bnH8nQsko5bNGIgfl6I6IbSKMr7nv4YAMO7?=
 =?us-ascii?Q?pk8feKSDda+uJMrYoGCZYamXPU6qk9YC5rHk5cYihn90I5odnCgLqqMvPjDn?=
 =?us-ascii?Q?Pedjs44ph6vo75GJMDtbYsLcE+gibdozHDFHGrzeoSrL1MDs7UK8byUhFzmv?=
 =?us-ascii?Q?4WyM1J1uo/G3CLSSOVFDh5Bk+qhkYLirgFTczncWtvjjNbcTQb647+O8hUzb?=
 =?us-ascii?Q?2A6VY77R/eLc3+8OxFYrkhq7agFzs7StqdI/8GXm+pChkltNe/4KDvd86pxD?=
 =?us-ascii?Q?jjPLClnf/rFS5kX857fV7Iv/5CIQ/0LPClJ/lyz3sv3MlSy+MuVPqZ4BGBDQ?=
 =?us-ascii?Q?X5x37SllB8OOWOytsdPTLQhFjlzh/6ZAeS2lY9ri/iCjg15FsUFfIT56RTTD?=
 =?us-ascii?Q?u+4AUyiMKVu+sG9dmAj0bvl6AUrtO9EJki0CjwE0yvrcOWtXndDZWKPlBCOZ?=
 =?us-ascii?Q?scYlTj+BsYkq7CZK1HMMAsqV81zgI256C8ewM/KNchFe48a2rIXimvIrf/rV?=
 =?us-ascii?Q?8vdWQfsGGlDStPI2Bd23VXuHOUQu6niQnRVDCyOiMgtdkZT5lr2p/yVP4VUz?=
 =?us-ascii?Q?WmERYzY7BAa1yZW0+heGfoook+s0qamJdbj5m4d7tcXuSf+rlpPAb4MK48EZ?=
 =?us-ascii?Q?qen6Os1dfckMUY94EFhsHgL3mk3ojxkVTMO5yoEOlELmkwlTzs++tS+jadEm?=
 =?us-ascii?Q?W81LNvbSv3R22hCP/x7R+4+f7kFIGfKNUtNCA80t8SaapCtsHuNU4SLKW/Br?=
 =?us-ascii?Q?ZWNNWJzELP1NU31XQVhWRQv7uMtvNskwX5dBtj9QQjUzRNWGyKSM2iRTBPfW?=
 =?us-ascii?Q?pTi2kPowrUM2W1XoUZmJDwTBe3q0dlQ+stHV/dZogL5U1cI+3ogWWPFyN3Tf?=
 =?us-ascii?Q?ceOBpYzSK21sLZb3zSrMhZvEXHxUfJRWrFBGfnEpVi0lDscegVYpYbYofElm?=
 =?us-ascii?Q?VxDz0Ala/lNN8aqeZB/yDVWrXp200DqxDNbKVfU7I6WNgyZ8O/wfFeJSLqMD?=
 =?us-ascii?Q?tpcwDjD84mPaLnaDH/sJAO95?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8182.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c46d43-4657-4a61-128d-08d9112077d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 06:22:19.5655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aMZ18w1MP9I+b13/T/+ny0Ww8J/5STG8scgU/MVEtNnZ9WTMJ0h440iBv3K05X7hxZxJMR3u4WkFM0MPghD/ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3751
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Any comments? thanks.

Best Regards,
Jiafei.

> -----Original Message-----
> From: Jiafei Pan <jiafei.pan@nxp.com>
> Sent: Friday, March 26, 2021 5:44 PM
> To: williams@redhat.com; jkacur@redhat.com
> Cc: linux-rt-users@vger.kernel.org; Jiafei Pan <jiafei.pan@nxp.com>; Jiaf=
ei
> Pan <jiafei.pan@nxp.com>
> Subject: [PATCH] rt-tests: pi_stress: fix testing threads' smp affinity
>=20
> This patch includes the following modification:
> 1. Make sure test threads and admin threads don't run on the same CPU
>    Core if uniprocessor is not set or not on single Core platform to
>    avoid starve admin threads.
> 2. Force to use SCHED_RR if more than one Groups running one a CPU
>    Core to avoid test failure because threads in different Groups
>    are using the same priority, SCHED_FIFO which is default policy
>    and it maybe trigger deadlock of testing threads.
>=20
> Signed-off-by: Jiafei Pan <Jiafei.Pan@nxp.com>
> ---
>  src/pi_tests/pi_stress.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/src/pi_tests/pi_stress.c b/src/pi_tests/pi_stress.c index
> 49f89b7..8795908 100644
> --- a/src/pi_tests/pi_stress.c
> +++ b/src/pi_tests/pi_stress.c
> @@ -237,6 +237,13 @@ int main(int argc, char **argv)
>  	/* process command line arguments */
>  	process_command_line(argc, argv);
>=20
> +	if (ngroups > (num_processors - 1)) {
> +		printf("Warning: One Core will used for administor thread, the other
> CPU Core will run test thread,\n");
> +		printf("\t it will running more than one Group on one Core (groups >
> num_of_processors -1),\n");
> +		printf("\t it will force to use SCHED_RR, or change groups number to
> be lower than %ld \n", num_processors);
> +		policy =3D SCHED_RR;
> +	}
> +
>  	/* set default sched attributes */
>  	setup_sched_config(policy);
>=20
> @@ -285,9 +292,17 @@ int main(int argc, char **argv)
>  			break;
>  	for (i =3D 0; i < ngroups; i++) {
>  		groups[i].id =3D i;
> -		groups[i].cpu =3D core++;
> -		if (core >=3D num_processors)
> -			core =3D 0;
> +		if (num_processors =3D=3D 1 || uniprocessor) {
> +			groups[i].cpu =3D 0;
> +		} else {
> +			groups[i].cpu =3D core;
> +			/* Find next non-admin Core */
> +			do {
> +				core++;
> +				if (core >=3D num_processors)
> +					core =3D 0;
> +			} while (CPU_ISSET(core, &admin_cpu_mask));
> +		}
>  		if (create_group(&groups[i]) !=3D SUCCESS)
>  			return FAILURE;
>  	}
> @@ -1143,7 +1158,7 @@ int create_group(struct group_parameters *group)
>  	CPU_ZERO(&mask);
>  	CPU_SET(group->cpu, &mask);
>=20
> -	pi_debug("group %d bound to cpu %ld\n", group->id, group->cpu);
> +	printf("group %d bound to cpu %ld\n", group->id, group->cpu);
>=20
>  	/* start the low priority thread */
>  	pi_debug("creating low priority thread\n");
> --
> 2.17.1

