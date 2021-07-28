Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF87C4338F
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 11:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FB8A60F45
	for <linux-rt-users@archiver.kernel.org>; Wed, 28 Jul 2021 11:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232740AbhG1LTb (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 07:19:31 -0400
Received: from mail-eopbgr1400089.outbound.protection.outlook.com ([40.107.140.89]:36672
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232530AbhG1LTb (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 07:19:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHuLSQNLwFHj0XFyXL0UQrAObf5sRvS1bb0gwJ3lDr/qJGLOgGLqSuPIF5rSQjreR3LQBWT6uCVS/IEBD5kexoHf0BKFf4GDH66ptz08jxchFrU4Flyv0HeFPZ2lj8S/9vQaeZgZRP0mFMqiuksN40ninXJtCzgkmOEw+7Na6xMlgI0joII0mRMG6pv4zCEgzYsaxSz2zwN9lTkXWrR+oHBxDWCv/BoXhKv5UJ8fHAYCkBXfxtk1VuexTaJmShebNVqGZs/RSq5pRcUosaNLJOCe2LhKzkUcwhCkbYBUdKQdZjjH3HQ+vMHl/GxEpCDtksmAPmL0FcqXZBSImRn/Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW4Xn/aGHXWsYoXhSQfOolKCQbBoTFFntr4buKcT+kY=;
 b=ldh0xmba5lFzCgqycXT7ZVPDRKAhGUKYxMK5dPKzUXgF+07IBAhuHtPogNpJ9RV8pAVihl3t+uxaVq4MnXeWGhM4YwaIdOC/Ujcfr6KDnqUuX+0USuSc8/AL70evUV4KZpOPm5rJQqTkfGE6lMBp2wKzv41SLfn7byVoJTXgIYxsc+zndMRU80Uw5AEZZ/7ydAoXkuRJeiAK3pSWoSWMYK5Ajefr1aUGCAzCGtNPfR3IZ3QETyqsG3KY+CLmKE66IEiPE+MZrIFO9OhL9xVvRYAQjRfs+bfyADYqQ0vrRvRxu+5vOlkrLezEI+J44P+fWDC9Xvn9wEHt9aPSrfc8FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vW4Xn/aGHXWsYoXhSQfOolKCQbBoTFFntr4buKcT+kY=;
 b=bPc9J/N7JlxJrFs6Z8u8ODwhdqYeIIUjyP/chRtwPlVkmM7olTMlWcqPK7AcQfMcWMbkNeBkRlqRFlYOIN2JiSN7Lacg0MP8PA6WVzrEevAxNo1c1x5SKCbFKwrzhhADzUJxgM2L2Vlx+/ehm0w7lIgrTtSoHWM3xNpOyqCSXsI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OSAPR01MB2196.jpnprd01.prod.outlook.com (2603:1096:603:18::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.28; Wed, 28 Jul
 2021 11:19:28 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%6]) with mapi id 15.20.4352.032; Wed, 28 Jul 2021
 11:19:28 +0000
Date:   Wed, 28 Jul 2021 20:19:27 +0900 (JST)
Message-Id: <20210728.201927.2141210326291227293.atsushi.nemoto@sord.co.jp>
To:     linux-rt-users@vger.kernel.org, John Kacur <jkacur@redhat.com>
Subject: [rteval PATCH] rteval: stressng.py: Fix argument passing to Popen
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR0101CA0041.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::27) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR0101CA0041.apcprd01.prod.exchangelabs.com (2603:1096:404:8000::27) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4331.21 via Frontend Transport; Wed, 28 Jul 2021 11:19:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adb41fc3-41a0-4249-ef22-08d951b99022
X-MS-TrafficTypeDiagnostic: OSAPR01MB2196:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OSAPR01MB21966324134F0BD1E308E4BABBEA9@OSAPR01MB2196.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xvr89WsukzOOaaoiPArqiACIKt031TX2trUOldRCRIU3sC4gFuPcEls+nd2X+IkY2dPkD3QrZhjgZGh3Hsry6wfvfayU3uKVMRKg/7D8C1BgrMFRH/t6BX7tL3pIiWB5zBO27/r/e7B4Z7Y6ZOQnvPruZFJxCZbboX+LdjfUopfOv4DkOV5C6eHY0wzB8uKYEn4E/FERVmUcvrYIQITIegQaZ4r2/8VVjmtocWaoYTfyZ0IgxvaGgxfvk04b837tBz8tVNeC1a34ewTGh1o1sATDy8JGtuSegT+PZW3HS8wH4CK8BB7SForO5+fWo3EW1iQE+/PCw2ZJQEUBvq5eMycsIZTuV10XA/udC/ED1fhR66IIIYwOLPi6LAYxW/aW9t0CNmRrTmSNkE4DgEFK8hfZWSTUGyHOs2oJ/ggBpgPsJSyBKBUeMpmkr8ZbneRTr1x67msDyJFpeSzaigd7LkQ7W1Yxd54iP+sZN6nFXiPt+AHjJFHk89+mV5SGkC0TKK1jQv5KBeplkYF8kj6EzuPdEBih1g5Pp0NPRzEddOK+Ukc3rAVRxYfRjQJXXptbNpGL1xEBiEQarFPlqiW9oZjsjBs+rgBpd67N+i59tWWBRiu8FBoqjmiPeYsaDYj+UfrJG2Fmbc0BoOdcCS6gLLygKP8Y3Wr278AOKlDtZrJi3l3WWzBvsm9uwnHSOAKL/nHX/1UySYecGTuPc+EC2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39850400004)(366004)(376002)(136003)(4744005)(8936002)(316002)(103116003)(2906002)(38350700002)(38100700002)(36756003)(6486002)(6916009)(86362001)(8676002)(26005)(478600001)(6496006)(52116002)(44832011)(5660300002)(66556008)(66946007)(66476007)(186003)(956004)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WS8EtcR4tkDLqS3+rVpIuIQM6CHMgKDlNAUQ0gUoTE/B4xnj0N9gpFESe/SI?=
 =?us-ascii?Q?YLYRaZODRAQJodh1CSXYFCTEqbqVlFzNruhjom6P9cmfcjaWgHlSKTUreYXm?=
 =?us-ascii?Q?jV/EB0w/8IH+h4I+f4mhFXV42Dos031+STad2E0TuCDizxSPAf1gIb+mxx5R?=
 =?us-ascii?Q?j59tlXiR7eweNcUvVPo6yJp4A/r/xcFNm+iLuz1XcahFGwB2N4UF13v6e67O?=
 =?us-ascii?Q?b+z01r1KeqWiJ+tfSfco+O862Es5bQBVg/4hAx7FQTfqFvVSPqe8ZAC5kQrB?=
 =?us-ascii?Q?XsyagP2mnBCaw2SzWwZVs2xe9ytn+1WBKgAm5ve+goe/8STBsiTVLlZSAwrK?=
 =?us-ascii?Q?x2oKUtI4wh/hA8mvDfIPAAiFOjU8ZiVzldPYyjzvANgPWGaMzxjxcB496R5b?=
 =?us-ascii?Q?RY2C3/r7mI9uLQZ7OqQgcEAyzn7PeyA0xqcXOF+fLZZAkracmtyKoHZ5246K?=
 =?us-ascii?Q?RnxcFmq4iEWlWWDdGNGCId7qvlg+ipnLs4N0Hb3zTDpAjzL5HOWGExi9EviI?=
 =?us-ascii?Q?NKB4aZpGs/Lu+8+9zeOwsJLnI0RwFD9BSkl8gAzRC/MQpWx1a2vNbVC1m1yj?=
 =?us-ascii?Q?wVjgF2RGXBp8XBRKUwshY5gIlK5TEBFmjoeoJ6O+Nc40JMc8ifc1TUMDeP+e?=
 =?us-ascii?Q?GxUMLrdtAEUCr7QL66hurA+oYxkI7Q6Iyqcj7JmjqivNagNmP8A2ZowHLVUF?=
 =?us-ascii?Q?6mZz6Von8h6m6C6Ddfwnb5ueOOvgnC31RtkQhb5KGRWIDEws9GbbfdDTTr18?=
 =?us-ascii?Q?bThbRN53/uDaKB2I1zf5IWQ1h7Ql4HhW99MpbdmVyrNAAxnXB3JZpAufdret?=
 =?us-ascii?Q?dEs7o9wmjOSUefCVUtFn5uo5yQGFvasTFJ5uCfZLsCTwF0hBg/9sCOqn5i7B?=
 =?us-ascii?Q?kwIOetH1XaKaUg2kNj8uYpv+Fv/qOBLneZs5pJDx5mWtuWslNWoJU3QL0/yc?=
 =?us-ascii?Q?GPXKxmdfjIvyFUpu27IYepBiK6PVyJ858vUVaTgI2GWDMfxmjTeMsJBvdLf4?=
 =?us-ascii?Q?+8+Y3Q9ka7duzw5LAJLuiQS5TC0mcNC0dihzi0vjgbicYKkeOCu3J38du+WR?=
 =?us-ascii?Q?zCBXcI9S4umVX/gboU02C6xDQIXX7AWfbR6aN/P2pj0F+Bh8XPm4Ws/F7KV3?=
 =?us-ascii?Q?Ms6Cl6gyHSFrsgtIN7JicTY1Jt5eAKFBRDGqcVWJU15PenyRO01I5hh9oV5G?=
 =?us-ascii?Q?Nidbjj2q+tozETKZmyd9JH2QK8CdUF5B58/w2yVkZJfAeodTUR5vF+xlnn43?=
 =?us-ascii?Q?27nEUaGUgD2nsDQjp7FPXDWHGoXEYiIhU7YaAyVp9CBC7+I9BmYKaV+VOsr6?=
 =?us-ascii?Q?isWwq1HB879RExKnpjA/KSX9?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: adb41fc3-41a0-4249-ef22-08d951b99022
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2021 11:19:27.9998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABidY6/9MkVqgDUMbxMHMITwcu0wOEhtNXEd0GJIDt7x7zT+VHaYfndrylzmRIHK4G18vdKvd9Iuv0pZlohi20ooIKekaKXdSVytUGhrNeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB2196
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

The self.args is a list of strings which may contains spaces.
Use shell style and pass self.args as a joined string.

Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
---
 rteval/modules/loads/stressng.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rteval/modules/loads/stressng.py b/rteval/modules/loads/stressng.py
index 926de38..927bee5 100644
--- a/rteval/modules/loads/stressng.py
+++ b/rteval/modules/loads/stressng.py
@@ -84,7 +84,7 @@ class Stressng(CommandLineLoad):
 
         self._log(Log.DEBUG, "starting with %s" % " ".join(self.args))
         try:
-            self.process = subprocess.Popen(self.args,
+            self.process = subprocess.Popen(" ".join(self.args), shell=True,
                                             stdout=self.__out,
                                             stderr=self.__err,
                                             stdin=self.__in)
-- 
2.11.0
