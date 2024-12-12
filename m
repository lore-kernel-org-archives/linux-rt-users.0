Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2121.outbound.protection.partner.outlook.cn [139.219.17.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3900F20B1EE
	for <linux-rt-users@vger.kernel.org>; Thu, 12 Dec 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733995057; cv=fail; b=S5UNR8XfKCVVl9lca01XgG5anhD0dYOYJSnvLXfEYTzNAAWb+NcwVXCdpsSa/OEFIO4hipiHiE0DK7/4pFFr/YvcKxcvAp1k99k9kxssqsK0M8ipkVnEq7KACBJBcsZ0P270+bobiihlb3MwGMkt1ZEdqImKbcNypAeLZl6LfKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733995057; c=relaxed/simple;
	bh=fp4JxZTHxXJ3ITU6GUubNzaNjuDWJ46WlUYSXn5UQgI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ptV5t7DevnAyksp8xzJCUzt6zK9OqrsjCzOrUKloR+qpNmFMLoF/tmmD8qu5MOHxBtd7JGyka7/o2XMf8bJxOVnJD2B/ASxfQleORMYH4TYCYeUDUAWOUaKgAfE7ukGmjA0cOHywY37SXlvEhqT/xDOpca8TX3bz2iOo6pW9G+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oSVgYSbCTs/mgyDdarkkydEPfa4kVkJ9owvuhK8jrrJCFWqIo31O+u6ElUp6zVuWhWa8r6e2qv3Npno8/SmEdREn77tf8yTjnwECA+2WTyI+53LlOInPw0zdT6yARH4gTv1BeebrYH1Q06XTrYLHpPjmTDgjnHqq1EkRZEwC+PT+bUU1ywFtyfKqPDE0oIKR1PUXFI9fMFt79Vhw5VoQqbGP4og0mZxvK8DSKjrff6mYpZTGTRwVURYgluiK07fZQzf3MWd4Pl7BvgSrJmqvdOp3HGR+vsARJH+pZ3kO9v/bEFGmEbwG9AJy0122CHhw/dRDEjxuAh1QHw2OEMRZqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fp4JxZTHxXJ3ITU6GUubNzaNjuDWJ46WlUYSXn5UQgI=;
 b=QZ4Ny3yNiP0UGmVHWqH+fRhmGOWeuFzrj2jO8aaXtF/awyoUaAORy4jQKEk1bq7EROYARQK67B8BCEvBv7oiW2I9NKG/L/teEY8bzUFbCLgf+1LvsWeTJ8/bEGkATucnc/q57dyKb5W3ECix5BcT7DUhSenaK0lxWEVPSpSy8zRg3Oo63Fx7oR5x2+FGuWjnh458K4JNVXojTLOxDZVSR0X3u9CWffgggbviq2amrBvQYgWnt1YOk+6dPcitWn85Wn27AC9+JBK3g1LH41uX1LOF5KkjNKvN9BluAf38O+jxiJvtAiUPu0wBeZ+VRqGZbZPSlpUwgIer8MQUYlYLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:d::5) by NT0PR01MB1213.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 05:43:28 +0000
Received: from NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn
 ([fe80::44d2:4d05:c7ca:8356]) by
 NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn ([fe80::44d2:4d05:c7ca:8356%4])
 with mapi id 15.20.8251.008; Thu, 12 Dec 2024 05:43:28 +0000
From: EnDe Tan <ende.tan@starfivetech.com>
To: John Kacur <jkacur@redhat.com>
CC: "linux-rt-users@vger.kernel.org" <linux-rt-users@vger.kernel.org>,
	"mtosatti@redhat.com" <mtosatti@redhat.com>, "williams@redhat.com"
	<williams@redhat.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	"endeneer@gmail.com" <endeneer@gmail.com>
Subject: RE: [1/1] rt-tests: determine_maximum_mpps.sh: Introduce '-F' option
 to specify CPU frequency
Thread-Topic: [1/1] rt-tests: determine_maximum_mpps.sh: Introduce '-F' option
 to specify CPU frequency
Thread-Index: AQHbS+/rWWv4MN2mdkGyvK1jLhpzn7LhbOWAgACpq6A=
Date: Thu, 12 Dec 2024 05:43:28 +0000
Message-ID:
 <NT0PR01MB1024694086DE4C6265BF22DEF83FA@NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn>
References: <20241211171158.1344674-1-ende.tan@starfivetech.com>
 <dd8872e6-2278-b77b-7b98-2c69fbc7270e@redhat.com>
In-Reply-To: <dd8872e6-2278-b77b-7b98-2c69fbc7270e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NT0PR01MB1024:EE_|NT0PR01MB1213:EE_
x-ms-office365-filtering-correlation-id: b003a456-9298-4f1b-f47b-08dd1a6fe76a
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 qDU1h9sCx6H3J5FM0CKxS59NDkFj2leYcuz0mwQPXO6GUxFhUYT9RHbHJ0dxQH07+jokf0hD9pjf+oaaIMCWae9dYOXWCYDrPBtwnEfgCUmbGvUR9Ff3GDBXtPdXf6y4bPW9YxO4AHHx9gLu8O4C0gkfmLtnTb+Cp85NpOgUL+0mxShs9mfYqPv0Jxp72DV4jqQ69rl0RHnP4s9aTQq3RWJlRuNG1ATnG32dGF4P4YEXoSEWdR28T4n+mHSDn9YuOePx/vUIJ0ZEGSH4zMWKdONaME27RQUQSvgcxzuM4kqPUev0iGamEUXQtUiqPbv9R+LnaV735jBks2SmHfkwyla98KDaiN9u+/TiBgSXiBKiULpREv5a2BFnzvcPMljHvhHrBSZbdYDsdbm7Em5hav21bklajSIqComZIzj/01nzHQDOWNUBkH7kTqP9yGRkKy78g/rgUtUHRpuUv4szvRQeaGTrZ1okU82C3xzTfs2wAarPF7NU3MMeMwvAD+4c+zt5/YLCK4A10eLo1N8Io/njLZiyv/4M3sV3ow79d3blvZqSHVYC1b3MG8VmpPw9B8Es5dveA0+NreITUT4gFQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+BJlcR5yOSb2ZIjWIfC9+au+P15/D9HEglWwHF8IFSsTy50+UC/2IRgKfvB2?=
 =?us-ascii?Q?69G0Ud08T/ehTA6LcJ0INzbmAgYJ7u4e7CaZ14YfdynIPBvU6fKn1teb/6X1?=
 =?us-ascii?Q?HwCMiCmXCCAI+TH5GFrbotchNgu77lGDKCwD221YMbZTbSYlBGZJC1eKOzxy?=
 =?us-ascii?Q?8/L5abdIp/fCg5yYOWhtuvv7pJVWeClsXRBAHwP1CprdPLJzFG6Xlt1aEi02?=
 =?us-ascii?Q?26W84v7/oWFcawOHYY5KiYZm3IHsNC8gRGCQ6yGInEmO46bXeX/OlFfLFsv4?=
 =?us-ascii?Q?J9+rkeXFyT32ZKivsGLD6vkqzQOPGhaD+Io7/PDYJe9QTL3UqKN7NGMyVQtF?=
 =?us-ascii?Q?gP6dFwK3x0weNiXRdWKcKT82oXMEGnuhid/7GDvrdTv3m+5ZdjVag19tswDB?=
 =?us-ascii?Q?yEqtlDizr68nZiu/ls/wi7LrXPVC3J7vmbOar2NoZS3ggI16abP9vg6iFpVl?=
 =?us-ascii?Q?c2I8QEMIzYot0dg4JC4VfVPTypKq8PcM0R/K4imJ+8KtekRu04WeKXmxjFS1?=
 =?us-ascii?Q?2oUQg+O4A+1VCWBHrlf1OaWqcdtd8qxTQIjQLuPFIWI0Jw438BtYhCzRrjLg?=
 =?us-ascii?Q?hYkTn8jq8st5FOwoTK8sp9syplZeZcEMxMPIKJXxdbmUukwUARw1mHUq6/kR?=
 =?us-ascii?Q?wMx//IqCLH3pEPy4ocYhgcwJBRlvlsxlToXEPtMpn7Bi+KHlXeYNPZ+AS+xV?=
 =?us-ascii?Q?UbeXllujMTWnGQ/Wihwqj+0XMOYQbORSTqHk+uxeUV592UX0a/s/NjjCs/WT?=
 =?us-ascii?Q?GaXaWyXcljE5OQPoILQRFMdTX0ic5ncw8n67OoWIQQF+C/6lIwTg+WVFGoO3?=
 =?us-ascii?Q?FKmDghbAPbeqjmgdLGCaN8pXmijzC1SMZwAUAYmihTMWYoK/R+toWvt3cwbd?=
 =?us-ascii?Q?MHfgz3E04GBlU9Znd86EcFUJktrAv8WMNDzcrZWaw6xvo+hp81ooe7e2PA2R?=
 =?us-ascii?Q?jtma9dGBqfEssIjzHqGDwzA4Pi9+EIwGOQM3K0MowocCTQLxIBaEWw+LnsKy?=
 =?us-ascii?Q?yRq6nBH1fq3DhdyZ3/8TBOtwxoXUbeC7ZbQs77lLcD/CpEcfy3P0oReV59Sr?=
 =?us-ascii?Q?ECdQu2TtanJyyHdfw7vs+lvNVw5eXlU3VFqxDl8UsKPdmEqxjjWh671exhmb?=
 =?us-ascii?Q?c0W7id31ABRYREsO/T9mcgqELHCQKNPF7pHZ01fH1/3asvRUbC76AsRCzH1m?=
 =?us-ascii?Q?5VVOO6mGPXU7uaCSOan4hB/XYTsBGtiRgeVLZtNEHW3tEkGCw+edYEgP9Fd4?=
 =?us-ascii?Q?t8LNJDs+R7y9LNnlKZ7k2TzVCPGuj3TmraencOkNT0vEIBRpl7Zdifl/ZEYO?=
 =?us-ascii?Q?DMtPiD9a/fnjs2A7tkV49+BdSAu5j9PCkV1mDQEMth2eS7cZVVsimTfR56RE?=
 =?us-ascii?Q?pZU8xOuKpLKfKRa/pXkZwVUcuxwcKDoSJKCZv1Dcr28qOkPPMKj1/0B1+K7V?=
 =?us-ascii?Q?H51BHhdH/Qeqx0LDodqDBw0q5Zrx83Ve/uDzaiU2zgKcpj55H8iD95nbAkxB?=
 =?us-ascii?Q?bMPBeAp73wtfBEWH+y+bNDx97bgjqofPum2jQ6gzD+UkfpE7m+iMTv87XNp8?=
 =?us-ascii?Q?YAnFcnbsmIUC2vl2qRVHNwzedwiZzXHHt5nvpUyF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1024.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: b003a456-9298-4f1b-f47b-08dd1a6fe76a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 05:43:28.2086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NGazgfQg3YmnVSvfHd486auy1uskBOePzITXXySKnwQPl27L0jJn/Rf8DSDOt4QbbV4tAPnDK3SVcOvKFj3zwYeTTqYr0Y9WMRsSb/RBzao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1213

> Are there other places to get this information, for example
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
It is possible to specify "clock-frequency" in CPU nodes in device tree,
which corresponds to entry like this
/sys/devices/system/cpu/cpu0/of_node/clock-frequency

However, it's not mandatory to specify "clock-frequency", so maybe
adding a '-F' option is more useful.
