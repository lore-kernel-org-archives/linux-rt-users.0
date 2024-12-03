Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2135.outbound.protection.partner.outlook.cn [139.219.146.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AE21AA1EB;
	Tue,  3 Dec 2024 20:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733256901; cv=fail; b=LMc4o+jFyynggUm35qoPKde2xC4j/gc5uO9YuXd2jeXD/1km5mbBrfboY91/KqW2lASU6GH0p9bjiw9sKK6tvr6NHLytlytqv46tuD6Py/n1zqbqu+ChiyqrCo7DGdvyDRPmqJASOx3qWcd0BOMC4Y3G/m1FQZje2dD8CfgrxdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733256901; c=relaxed/simple;
	bh=Q7El93QUwlgG24Y/6wXYZKkWLTTiXyNZM4WqiuCho0w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=dzKyp1ZuoAzmB11jUOl8+3Wvumi1uwrcB2mcLJw3kceAPU8KZCl8hVdxE676Iwdu0CjeJJV+A2NT/CzqhDmiCA2DRS8dkPWDuiWZ8O2sX5ttjaJ1fe6Ohar/y1oU+4Jl9Q5eEJwonOGrQ5Abc0JkDUf4EPmniUdPp2PIC104sXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ki+77gjNE74kTCzanUKIkIHiWRdapTDrqRZAgBULv/6CFEoRNMm++GOSRgIgBhYpfwCgO2j+8JupN11RLhsd3uQa6SXxjPDWYyT2nkr/DJ+Yf2Rd70hNAT2i2dAwlpgyGrk9KBw1Em05+sw3d7JPm/6ExX4jr39AI9aeuiYaMpdTqst78Q2Sr2zAA/ZDm0Mo6qV1PbXXMn2MLv3lojtNlnrr9f1FrOzepEtjCUBH0UlXV4oQCAXnY1EtRp0exTwDG+xxH+Dv1/7+oQelBAIWoMvb1uLPe71WvTCg3Fao85EeHIifGEikk9OffT297/TfCi0X/4zkltjIsCIu1v+9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhAcOYuEkOTf8sEayTQbBAP5kwZVTeEy9FKI2JcFZKg=;
 b=T4QiwlKNBuDr2EWE8xWW+5bd7hTy5m08zp1TeWlj93INReERbzhDds8pQvqT87ObheqHGJXES6Xez2Yhm3WIQAe8OqvB+Zy5tCmWuJLXa2/ASzaB5AYUxK+xRMRwNzolm+H1epQcRUDP8IW1y/JevU8EnOKHX9p6ApirzoscEJvqxBo5tNdWX+2jk8swoMG8q4Xc0lF52sa2zpNsU3eh2Ut9YgxoT8NtkH1MBt4msXoiIXaj70sYuIwfRLZV7R+rIgHEE931kN6rK5O579WoUHV6qXRrLhm66rhEFD7I3WXAdFL7VxKi1GsUcxO20H7WiBPsGOMkUJ81gG9Y8QfiSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Tue, 3 Dec
 2024 09:41:57 +0000
Received: from NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5]) by NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 ([fe80::e1c4:5bb3:adc:97f5%3]) with mapi id 15.20.8207.010; Tue, 3 Dec 2024
 09:41:57 +0000
From: ende.tan@starfivetech.com
To: linux-kernel@vger.kernel.org
Cc: bigeasy@linutronix.de,
	tglx@linutronix.de,
	rostedt@goodmis.org,
	linux-rt-users@vger.kernel.org,
	leyfoon.tan@starfivetech.com,
	endeneer@gmail.com,
	Tan En De <ende.tan@starfivetech.com>
Subject: [RT,1/1] tty/serial/sifive: Make the locking RT aware
Date: Tue,  3 Dec 2024 17:40:09 +0800
Message-Id: <20241203094009.67697-1-ende.tan@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0023.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::35) To NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::7)
Precedence: bulk
X-Mailing-List: linux-rt-users@vger.kernel.org
List-Id: <linux-rt-users.vger.kernel.org>
List-Subscribe: <mailto:linux-rt-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rt-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NTZPR01MB1018:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c9de802-4ff1-4032-ea8c-08dd137eba69
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|41320700013|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	lmHPTlvZ26k2EUTNF26o575OND2UjqbM7OtglTEVbIWYortE8bUVIWtR+NfzQaMsyAUC5UJ32R+D91Kk04Ivc19x/49b28dK8L/+qwjx1odhvFupH+fFEdf9OvMNKqfA+kWuPTZPB81xbAr3rfL3qDxN4gZjuyf1zcRaE/HLd8iee6YX/idjj+lIgkKyP47K1dkG3H266eWqjCiQPYRyZtoPHLsCX9ubxYmUGWt0P/2wFXUjpGDegDkBS1gXsgjesa6SFYh1ciHWUx5Yvf8X2ykgw3u3vsCmO7rMQnG3t921zcazJk4LZgLUUXuFLPTpC4Ca5asIQYOhzH0lVe2k9RNKPaIs12OAOHn3MVivI616xwFBhUhfya+Geq6RkluqooPqF5LaIe0YTfr0O4YrKzxSf3+va3Cpt/Aj/w/+jB60RNp6nc/3ik2A/PCt2EvzaXTvDCn06Ai+mkjo/Ut9Q8f8VuWfsASbX37tsmh1FIAPtK2MqridaOIixUe1QWm0E28RIUUOUHorBRt0XQgM1IJgtjCBWVZ/NiNmr23wogJ43gjpAbtyoK3ZtESfel9Ze+1dldkq8Kv63cP6s+tk+dmcWFmIeFovtB909sqvozYjloKxen1QSUpcW5Udyn8H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(41320700013)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b5uXxg85fvxczAzSS8iik1JaxQk1/shAG8AmvOrsCb7OWsK+XWZ55OF+oDyH?=
 =?us-ascii?Q?uZmGDHgU7nijb+AtoFBXnt5OdN2aQU1gk5xrxhohkHM34sOz9BBq5J+sovMY?=
 =?us-ascii?Q?UyPKKdBg25w+Bo2oTN2wQtYFIfaelNFsi7RreSqKbFUlUtULVFzMhtC+Mshl?=
 =?us-ascii?Q?PJhv5bbR7f0P3rRVfD5QsuvLRP2dqzdigubiyfq7gQJ88QYDCotdaCtoQ6K7?=
 =?us-ascii?Q?39sayTWHPhZS8+HT6Rj8P4jyM+5QM30dJfAir83SOwTm2mK9Ed0vYcuuetdC?=
 =?us-ascii?Q?aJwfL6AfWJGQwnlVZU5/eGJUk0tPuK/yGALzUNr3l87rI/7Di+pQnQkCWw1l?=
 =?us-ascii?Q?3C5SkzxAgrxj9S0ew2PSunBhjuSnMMvM5jizTF8u/uQFnQo2ToNb9BW/vLMw?=
 =?us-ascii?Q?5uqJYiKM5K9U8yb2MNSaY4cNe01AevdVMHftsyTS5zyrPvnCoJl4AD87FO/6?=
 =?us-ascii?Q?fHIg6FQmCJi/eROcgHmZirYU8yEtdyIT0p/9ojKTOvGWG02/ss/dfUZUt2Lk?=
 =?us-ascii?Q?3BX7VvJp/ekSugd3+p5BO/K3CdXPPrI6f0pL19TaPXCxTgJvnndoPXTcceJb?=
 =?us-ascii?Q?P3UUjzucC/YX9Wovn/CHJ3yxcIqhrvMH2/riR1nz9z2r85E8551dFfmdBDuU?=
 =?us-ascii?Q?77GYL3boC/7KLooPNjMry7vYL+uI5tfL+SqM1+g1iQIlPbw0ZqzdccBGX3Ao?=
 =?us-ascii?Q?3BSMd+yMndnasc/I3EO4ehN1l5HxzRYGFvTkvaPRL7SpohrCz0XlaT3tRqRO?=
 =?us-ascii?Q?xOllt5wfWUAnlzTYZmtUiZrFbBelBujzaDJMNqQIPoxA9uaji6EKXXAzB/5v?=
 =?us-ascii?Q?lTZX+G9CtvEQkjjCSt93Ohf5zsVI9pT9+OjfHp8SbR5dlk1opq4KNTsM2Cky?=
 =?us-ascii?Q?QZYzxtNgotHXBy79yjM0u8e0rbqSnA3s+j0z55d01uGrczef9l8yUl9ZX0Vt?=
 =?us-ascii?Q?8bEqwGrlN9nClwuZ0xbAXvwCPNY+mHnZUDMvAI//Z3SImSdqqGmMQR2Z5uof?=
 =?us-ascii?Q?gkFuYAZEKYomQRz5sYQrWdu0iFB1O4Li9Ie9lPoXUhkhHz8s/06yt/ngYpso?=
 =?us-ascii?Q?6LemYZUTw2KxHNKWyyF4ScI+ptQCEJC+syHgjQX7tXAlUR40RnNZH7307kcI?=
 =?us-ascii?Q?WGwwitvM/zjsbe0auyocVPaG9ixW+ht4qnixgULA25uJM+gtxeG6Dbd0+x0e?=
 =?us-ascii?Q?yKwWYfK+P5+2HW0zdgyb10f98AuZAi2+vbDuhFBk81WUHW2Vouqv27ux2znR?=
 =?us-ascii?Q?cxAyDPKDZ4Qy1ksAse5bKoGrCpLB5w6VRa2mE1IAZ2dHzQPSUpb1dRqA3TXy?=
 =?us-ascii?Q?jo812AFa77ReqLHH1br3uYagVfFw+KCPbHtbsKhycz6eTPrhYVw6naJkdQX7?=
 =?us-ascii?Q?gShlD0Vfk8Y7iC1Ij+AzWigiOZ5aKAOQqIXPFMV9S+LBFV/KSkablOqisqzs?=
 =?us-ascii?Q?mrruCt43sl4IHi9I7JnsJHdDHH2gAJmbs5lw94vcpUhNKQYo3Uip3l/jcbZ3?=
 =?us-ascii?Q?Z0xetGoSwIpX0Q/tG85kC/bw3MeNBsvTuXRGfrQ6VNPzMLGqFUkYSqgtg/ew?=
 =?us-ascii?Q?MDEiYc4va6KJa4CjYImPuZ6sr/9DZIGaR4OWZDeYeN5TtutX37T6/dKAB2uk?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9de802-4ff1-4032-ea8c-08dd137eba69
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB1018.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 09:41:57.2058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hBeeBzYYijxruNC3/w2vRYBoZyoEIc3swxEiChFw4PV4URViOFj/t/Le6g7fAObxuz4sp9VktAlzPXgxBavy7dETHEodU3rmc2LQbU3yMx4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1018

From: Tan En De <ende.tan@starfivetech.com>

The lock is a sleeping lock and local_irq_save() is not the optimsation
we are looking for. Redo it to make it work on -RT and non-RT.

Signed-off-by: Tan En De <ende.tan@starfivetech.com>
Signed-off-by: Tan Ley Foon <leyfoon.tan@starfivetech.com>
---
 drivers/tty/serial/sifive.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index b296e57a9dee..074c9f392634 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -791,13 +791,10 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	if (!ssp)
 		return;
 
-	local_irq_save(flags);
-	if (ssp->port.sysrq)
-		locked = 0;
-	else if (oops_in_progress)
-		locked = uart_port_trylock(&ssp->port);
+	if (ssp->port.sysrq || oops_in_progress)
+		locked = uart_port_trylock_irqsave(&ssp->port, &flags);
 	else
-		uart_port_lock(&ssp->port);
+		uart_port_lock_irqsave(&ssp->port, &flags);
 
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
@@ -807,8 +804,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
 
 	if (locked)
-		uart_port_unlock(&ssp->port);
-	local_irq_restore(flags);
+		uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 static int sifive_serial_console_setup(struct console *co, char *options)
-- 
2.34.1

