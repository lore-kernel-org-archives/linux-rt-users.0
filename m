Return-Path: <SRS0=Qk+l=Z4=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,PDS_TONAME_EQ_TOLOCAL_SHORT,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678D8C43603
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 16:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3C821835
	for <linux-rt-users@archiver.kernel.org>; Fri,  6 Dec 2019 16:44:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="qnkKdPD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfLFQoV (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:44:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:30754 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLFQoV (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 6 Dec 2019 11:44:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2019 08:44:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,285,1571727600"; 
   d="scan'208";a="237068168"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by fmsmga004.fm.intel.com with ESMTP; 06 Dec 2019 08:44:20 -0800
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Dec 2019 08:44:20 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 6 Dec 2019 08:44:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.52) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 6 Dec 2019 08:44:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9OijTU3SWsW/gqfPQqYtVXxzsNxRxt7ulg+949l+8eoKfAcHBnu/G50JkRiXPsl9en4OoMRAXAh8DnyUuc7pKtU8vciz3J43qaRSZiP+AT5DJDH5plGaN0ChGnxNk2bkx5Bw77A2rU+741XzYElEfwR2/QM/A4BZLil/+++9YSkwPN9E2RLAEjJ5WPllKH/T7o9ZPsaO64IXrqUKCHMbnOJ8qd71kl+6oVFU9Iip0dFYmN9Ofq5vZo/vuaxlnne2/0jChhD0vF36lvcVFtt9mO6N5TmRzxU9L/v9gptqdVGD5LdolZ18icsp5RY0H8x0tqxKO68rRTWChaewHCv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbMjBreH390/ewPIU7liCDycSfC+f5oQGJOUrnpvLoI=;
 b=G3LWQGzsl/E/pzFmBB3PcJJ9k3xgi1NpflJP8iKsJm1oYt8oMZsA/slo8VTrd1Cj7y6TJIi0KmWL52XK8olo5V5zUkrJbDH6qu83r7hY5T3FEapgUVolT4Ffc7vodCE8qXWKBcBcjMZrqJJMyCPn5G2YMXCtlSonPI6rWdaQGEe5DGcpQLJybX7mNiSphCCuzi+s6d/a6G5g/fKvndRf9ZztW5bL5F28vCSHQQjolgBWqRgD8wTxrQukA0Pe2ZkwgiE3wStGtDtRYiusqIhAoCMx+e63gFXzjZdecz0zJlOrTAsuyQwEidPjD/3tBLYyWzBsSXvs4fca/kTmTzmmAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbMjBreH390/ewPIU7liCDycSfC+f5oQGJOUrnpvLoI=;
 b=qnkKdPD4FCF12PRJUZ4WuUg1zRuKcS359/6eYkPgYZlAA0lCr5R3l2RrW9BzKqKgflGNRsyZcRJiwBgbP9mAlyXG2JE+5wRoVkLf4WsdQ3ESub8cJiPk0As1+HK17qGJ/Na9T94s0J//cfiMhc55jGCFUIveUgDWYsxsHjGBJSk=
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (20.177.228.18) by
 BYAPR11MB3750.namprd11.prod.outlook.com (20.178.237.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.14; Fri, 6 Dec 2019 16:44:17 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::45c:1188:22bf:5633]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::45c:1188:22bf:5633%7]) with mapi id 15.20.2516.013; Fri, 6 Dec 2019
 16:44:17 +0000
From:   "Tseng, Kuo-Lang" <kuo-lang.tseng@intel.com>
To:     linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: ETA for 5.4 rt-devel patch set
Thread-Topic: ETA for 5.4 rt-devel patch set
Thread-Index: AdWsVEpdIbMWIjkKQnWa+SKoIGB1tg==
Date:   Fri, 6 Dec 2019 16:44:17 +0000
Message-ID: <BYAPR11MB3062ABE980C2E40E759BF49FD25F0@BYAPR11MB3062.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2Y0NGIzNDItN2QwOC00NzE0LWFjNTEtOWYyM2JkOThkNDYxIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiV2JVVGduN0EwZ05OeVJzYytZR0VJczJraWViSFpsTW9BeUxHMXQ3WTRkVHVBMFpwSHVFVk9CRkdMMnFPMEQyVCJ9
x-ctpclassification: CTP_NT
dlp-reaction: no-action
dlp-version: 11.2.0.6
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kuo-lang.tseng@intel.com; 
x-originating-ip: [192.55.52.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 64841435-d1fb-4e2a-130c-08d77a6b88e7
x-ms-traffictypediagnostic: BYAPR11MB3750:
x-microsoft-antispam-prvs: <BYAPR11MB37504BF38DEE03681ED55221D25F0@BYAPR11MB3750.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(136003)(366004)(346002)(189003)(199004)(5660300002)(9686003)(71200400001)(71190400001)(52536014)(7696005)(26005)(99286004)(6506007)(102836004)(66946007)(64756008)(66446008)(186003)(66556008)(76116006)(66476007)(558084003)(33656002)(74316002)(86362001)(2906002)(305945005)(478600001)(8676002)(6916009)(55016002)(81166006)(8936002)(81156014)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR11MB3750;H:BYAPR11MB3062.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: stXMe1KQnmwyHj0Ob/x7rMSsxcNrpcDjTvoL2qu61WP8uXhugZQDpbO++c4BW8RIUHF70UsyUTeBEV/sWWDM87jE/cDK/uZXufrWbHDX/T/ftKO59l8gkOFG5/YEWHo189+YmiVqofKquu4p2/m18/Yoh2cKOwkyt38inRUHwKIlENgk9f3A9yYgGii7QP42hIO/25tzbEWF3bvcH5xRV1YTWbQ4AIff72kmfPafAltUOMetAUxS9gbMWuuonUZ6GNYA6uOZT798SNIAVBvt6u4EjIzzQ0d8t/x56+07lPbBPrhzYMhhu+qVSd0wWB/oOzTaEXDxfg8Yk357cjW0RkjxBsDRKiHw3QvHv0r/fWD+eGVdmNW+9+TdWwzPgsf6CUkWk2TgGFZlGXFqBr7hFuHtWCaXOiqXhLvLXaxqLDdPF8fCqmyFsIOj0iGaxqil
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 64841435-d1fb-4e2a-130c-08d77a6b88e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 16:44:17.2209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NinumZSCDPDT6PgQ6Zm1vaOOi8F3dZ1UH0SjCzRxuYCzf9/Xu19u8cP5xaRNg/Vqg1KwcLdjsrspRQWtFbQpsQ+sUfZT9MTVPkrMxTTUuEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3750
X-OriginatorOrg: intel.com
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,=20

Will there be 5.4 rt dev patch set and if so, any estimate timeframe on whe=
n that=20
might be available?=20

Thanks
Kuo-Lang Tseng
