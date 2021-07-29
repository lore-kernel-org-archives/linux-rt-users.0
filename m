Return-Path: <linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CB4C4338F
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 01:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4741F6103B
	for <linux-rt-users@archiver.kernel.org>; Thu, 29 Jul 2021 01:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbhG2Bz0 (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Wed, 28 Jul 2021 21:55:26 -0400
Received: from mail-eopbgr1410059.outbound.protection.outlook.com ([40.107.141.59]:36648
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233197AbhG2Bz0 (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Wed, 28 Jul 2021 21:55:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8SuVl1cdRnhpLh1eWZBOvryxA6WOyxCW+A12SiE1Q8/diixGDz/obUebyiNfpl1+89H9DMwRFi7iQvabFph6GpzArs4RNcXddhLZJyNUUDoTZ4XFuyAbDQ6aEmASSuo9doa+TKPPvSZwlTL3HXHz/+mTCnDjX/wdffmwjYX/tvvIfU6KlAq2Ra28kRZumt0q645x2E9lumz3qsZVhyV8f4/QzSq0YmVCpw7W4/3UPLUJc68yVsi5wpE0TYHuu4VJ3D6kXxWU00E86b9a+yDtvlBI+MwjzAXfW83TW1k6PrwABU0v/bNZViN9Ie0H4Teq/ENZsxZj8BILYI5t3cGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qJfpKIzb0wpVJQvyw6mX+Mp6MUqnm+aYPHXGzhpIwY=;
 b=QHizOZVSvA5dQdC6moLx+RCVCLWTFl0sZVUaDke5WUAii8tabizDJgju6K6a+fbxElXgXJrwCqCLbeM1zqYzDgqrZygOSfrTgRVMUt0zrw03rKRpwzJUQ8JClJ5uNS+P4JSp3UWIiQuPpOSuK1nwfm56rzvkky+yBX7N7BIRvHnRz7czJpDboLJEiwdKYEXilZOGcHhlY9nSDmGjoYXdwsZw8bcy15S4PY6nYiIR/wTtHrjF0fgOV19YQWitVJUEaHZcNkqGixjcTJdz0t51pUxLMrN+/FQlGAguocC6Ro1PGyaqGuqlJB4TgayGRz4ceAljLBc/YH5HyJd0Rm0Jtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sord.co.jp; dmarc=pass action=none header.from=sord.co.jp;
 dkim=pass header.d=sord.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sordcorp.onmicrosoft.com; s=selector2-sordcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qJfpKIzb0wpVJQvyw6mX+Mp6MUqnm+aYPHXGzhpIwY=;
 b=sUOTR1JILQ8nf/26P2xMAfqb6L2QLfLQEurtUlK0k1naVByUR/wvHp9KUuIZVBuP98xf7Hp7G1Z4+TzgL5S5018meXQ7LUbbNUCejOEDKjK9SdSI2Gr7S4nOBPW86Ve8mgsrG8ibOr/T6oG4T0ypwOuUN0C0GcO8BTkFKOoCP5Y=
Authentication-Results: 189.cn; dkim=none (message not signed)
 header.d=none;189.cn; dmarc=none action=none header.from=sord.co.jp;
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com (2603:1096:604:13c::13)
 by OS3PR01MB6596.jpnprd01.prod.outlook.com (2603:1096:604:10a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Thu, 29 Jul
 2021 01:55:22 +0000
Received: from OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d]) by OSZPR01MB7049.jpnprd01.prod.outlook.com
 ([fe80::48bc:c8c5:3502:349d%6]) with mapi id 15.20.4352.033; Thu, 29 Jul 2021
 01:55:22 +0000
Date:   Thu, 29 Jul 2021 10:55:21 +0900 (JST)
Message-Id: <20210729.105521.488353044950955983.atsushi.nemoto@sord.co.jp>
To:     chensong_2000@189.cn
Cc:     linux-rt-users@vger.kernel.org, jkacur@redhat.com
Subject: Re: [rteval PATCH] rteval: cyclictest.py: Fix config check
From:   Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
In-Reply-To: <617402f2-2dd7-cc41-215a-b7ab9d3e935b@189.cn>
References: <20210728.202110.2259637121232602746.atsushi.nemoto@sord.co.jp>
        <617402f2-2dd7-cc41-215a-b7ab9d3e935b@189.cn>
X-Mailer: Mew version 6.7 on Emacs 24.5 / Mule 6.0 (HANACHIRUSATO)
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR06CA0029.apcprd06.prod.outlook.com
 (2603:1096:404:2e::17) To OSZPR01MB7049.jpnprd01.prod.outlook.com
 (2603:1096:604:13c::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (61.200.21.62) by TY2PR06CA0029.apcprd06.prod.outlook.com (2603:1096:404:2e::17) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.4373.18 via Frontend Transport; Thu, 29 Jul 2021 01:55:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 272bc047-fc61-4656-b1f6-08d95233ece2
X-MS-TrafficTypeDiagnostic: OS3PR01MB6596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <OS3PR01MB659672481CBDC2E6A9285DBFBBEB9@OS3PR01MB6596.jpnprd01.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bEtR6PjWW5YpKpccZUibVwfUknVbbjyHTqYqrtcYiwZcyBt1vFydS0uIX3Wwr0Fm4HRO5dJLH7C0AXsDz9BL6eVJT6mxy+Oi6TleGuuILKVMKZpktHfYWtOnfVE9ycvYCrBQikR1RZJLP+RTsoLkT/ulIP1tKTcqEkaG9K8FrZi188b9IROxA76ztV9kzlp/YwiI1kiWvIMoYYKLq+gtnSduraEzQwpwmeG2ZO+1+ZOl7j0+cUrG7qaL94t47atmFAi4j/3UJkR72lLbpZD7ao4XTAl0Nv/D9sjcn9eEecRXXHwKZ1gWEhF46UN1VxtTBoInLcK1r0sIXZHtxdYWn7K43PeM+PBvA4VuXmJs0E1XMBAqD/IyR47GTX/i7uvkRZQwjMfS6agsIWij5+tsLSvNRbVb10Z+oEO31ob7R3b2mPu3Q9hAQlUWJN5VhTqAkoZkYsJLWkM7m/ZUiQFOGveQuPr9vq95HSB6UMOmZuirUDj702IHHwT6W+RsGkjR0e6AmK2ZdAGficqQtaKnhXfLFRmbcN/vDPe3/SKkljWxXtBSEKm8T03Uee7Z13NIF1z7tCpZfJoRfPRWopYnM9Tz1VckYQfTU+MyRMZ1vyIWe8tjaYTQk3xNRwllu0c/X31invOdxLzJMa33r5DxQJpD9HLEZn0bhrzm5mQ3jCT6ePVq+R9Oa8U0pGunnpp+TtCjYORzXdT3I8UBrvkWMN6jMlNrKBvnXm8GzRlkYjkbHH8ERhsWrpZFYXWfDX8rZPODzHciyUq9HIoktuxHsX5b12giUIkxdwDZGISejco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7049.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(4326008)(6486002)(44832011)(86362001)(2616005)(956004)(186003)(316002)(38350700002)(508600001)(26005)(6916009)(38100700002)(103116003)(966005)(6496006)(8936002)(52116002)(5660300002)(66946007)(8676002)(66476007)(36756003)(4744005)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XqvGdhn/FWB9r+EQEylEO350FHU+Wcj+n7Oo61phfjL/LTWCO4E9WekrjruT?=
 =?us-ascii?Q?2QXc4NJvX1KJ7IwdoE9gA/1OY6SmBHpddhiDqoTnhQ13Uh7ceO2ZPu+rA+6Q?=
 =?us-ascii?Q?rSjAOTJqL8C87Dg2xj7WOctoWNf3Nqz2/LdbIlSLyNRz4yFuRpu64q67v5Pq?=
 =?us-ascii?Q?DfSjM7nle7YLiybaKSqrJAD2menY83X5iBteolWxfswkqIZhdRxjgNx8z7+6?=
 =?us-ascii?Q?kSMWFoOH8fMtmRfH+Tf5HxilQrWvrXkXmskR3dgWQofBJPTOsELnEerEUW5c?=
 =?us-ascii?Q?sZOUOy+5LUXaZsIqVWyLfauJWgtFsnvcmsWYUGSkybrlzGdo2xH+xdPpltfO?=
 =?us-ascii?Q?4axl0my2UZhxFcJOhfh7Gps+3JxpbqXPutycxlD6PsbV6cgAauhYP9qsvGqZ?=
 =?us-ascii?Q?hbwxamod/ncJsrsfsRw8d3Y5TwwSHGFwYQUjM7wAJhj/WoGf9GASF1KN0Av+?=
 =?us-ascii?Q?h8e6JyERvi10K7MHz0heIjK2cq9gPIAUUAAA1pqACnLSPyGQAx1UuBp0B29m?=
 =?us-ascii?Q?1HS0UcGy4UO3fOGZTLsNkNpdm+DCT9ywgtisZrOl++nJuNjPq2s48tYndtHd?=
 =?us-ascii?Q?21RdQ7U1wjsyR6KJV7xDu4+43NYSbQXLHjt/rrMGwjx46KxXeCt48+W+a7fx?=
 =?us-ascii?Q?zik9SBKtooASZB/+RSRV10huD4dXbRTayGu2wV50EgnxTcVUcoBei+GTMkZk?=
 =?us-ascii?Q?o/WsCgeDOj3+5R7g7nBHSSBAANnmhDvFigb4C0N6BbMSDRB1b3ARN6JMEQqU?=
 =?us-ascii?Q?BSbrE1a2o8OYbW5G/laO2MG+3mU9yHrxrShl2AcPzgYGzE/TvB3f23/ybXqf?=
 =?us-ascii?Q?u59rzLfgQGbTkWzTSgNZ4tHxQlHKG0flQLaLUuY0xRfo+nZQbVQ40YNuWo/n?=
 =?us-ascii?Q?+zZm8RpcCHWURCoJ9gaFt27TFN8zs17jhVytk8yVS7lj2RYq5d9b2KrrT38O?=
 =?us-ascii?Q?E+xg4gRVCnSMQ2TPT++u0N6DJkBo4n81Qo6YEK+yO+l2dzN/Pd7GHwq8ajxb?=
 =?us-ascii?Q?Pd5bbmZiNphE1NSDGAUvEBT20FE5YslLpGpjUYCyXgaw63OJgNVL4Xhhh14j?=
 =?us-ascii?Q?hAmEo/1DqodiDlKnJPsMXDOAZZiFCyKkKeapOTn/rwGku+5+xXRAAkprW+OT?=
 =?us-ascii?Q?gaoq+zvNbq/ATYuPrsNUlDeNWoEEEW+UhtYi/ebhICk7Mmoi8IrGAVs1Drzo?=
 =?us-ascii?Q?iK0XWjVtbNaG5jQk+r0GEk8viknvsEsTz8ILOm1mi0+MW+X32Ik+kzudAbQL?=
 =?us-ascii?Q?FryUj5K4TE2J9ZO/VbxQW5cNIS8SSf6zy+r16I8logtvTbmkIoWW204KwcHK?=
 =?us-ascii?Q?z4Sp130OuF6wRXIQT5DNZIUl?=
X-OriginatorOrg: sord.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 272bc047-fc61-4656-b1f6-08d95233ece2
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7049.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2021 01:55:22.2238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: cf867293-59a2-46d0-8328-dfdea9397b80
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z6UmRE0D3ChJYzDMLPT0cUjcsFbt6c26vxEjj6epvqwDsktnWsPbl/YAEHE9MUU/Fa3EtLi11tUSqSnrHhSrkXmm5IBCqb9I1E42IDbSZWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6596
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

On Thu, 29 Jul 2021 09:41:09 +0800, "chensong_2000@189.cn" <chensong_2000@189.cn> wrote:
> If i understand it correctly, cyclictest.py is python cyclictest, is it? It's interesting and i would like to give it a try.

No.  It is a part of the rteval tool.

> Could you please let me know where i can clone its code, i failed to find it in rt-tests.git.

https://git.kernel.org/pub/scm/utils/rteval/rteval.git

---
Atsushi Nemoto
