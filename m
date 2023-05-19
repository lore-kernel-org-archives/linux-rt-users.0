Return-Path: <linux-rt-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C24C77B7F
	for <linux-rt-users@archiver.kernel.org>; Fri, 19 May 2023 14:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbjESOhE (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Fri, 19 May 2023 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjESOhD (ORCPT
        <rfc822;linux-rt-users@vger.kernel.org>);
        Fri, 19 May 2023 10:37:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2108.outbound.protection.outlook.com [40.107.21.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A345116
        for <linux-rt-users@vger.kernel.org>; Fri, 19 May 2023 07:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIrtumN+SYOioCktnaM4DbpPEKGrLIF84GnRyHoqmyw1PmuXVmNKzTciLCwtAEqKbQPdTEsna6Omzp2q9jRwshidqfsRLoMUkuXiIXH3MgqN09nXte+xSzP1SkEdU4bDNf8hl6LnSO9VmKPvXnOOKpncjYDSf7y97HHVO5tNnGPPGpkGTYNds6jwgnqOAJmq+x7WeECMCkmwWYSoHjqlDC/CUNS12wkPVZKXb2YVJGIsLIeNHW+CDymjhZC0X9FE/O+JT7oEE/8YIn97ykRwLWGks0F6teDW206VV5DvCbmZIIEhCJ1Yxt5kd9o6j1yllA9g7ubKdS2NeWsfoQcMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gi5TcACUsmjNRMYygTDfBFu4csqrrNPtv6WXdKg8+j0=;
 b=EX+vuECNg40XGSLkWZjw5bUy6/gBIvS0mkqD0z6vDROSFITJHCKDrivUTMIKdja+okvpZiRnyN+cX8stdzU+V+ByTUhjIE7MpDY23V2jgtGUguNkY6UUpyM9bk9HBJVZhJRCFoOayL7Gn19jf+eXMhIi9zRR2uFwjkaaIxS+dpDNIHiUCfMEUqrEY/Pc9FNzgfSO+wCroQCDr7IYSyDBYFgbnFmbQFFiE4YD+anY9HtLeTiq7fMeHcrrmDpzYXK0eAQZUI/21cq85qmekjCZcjcRO9YYMGgTpWKEtQQ5q8eUCcR/KtbrZj2Xmzo6KsDdreJT1azpl9mCkfF7i48+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gi5TcACUsmjNRMYygTDfBFu4csqrrNPtv6WXdKg8+j0=;
 b=NeeX/H/4AEYAp3csikq2epGmhcgb7/a1TwRhjYz4ciLjEc98hj6+vgNRk5ZgKkh6kkOn1jW9Y8MmTzLSTLACoZYsdK3WL/eY6+u0/CIKNQdCf9WUnS4F6mPw/jiKSlFHwxr/cMdcsYXnNTpd4YGsRnq+ofzPugTaxgSrileKY4nDMw0Cka1q+oXziFGAZrIewiFW5KaufzyErqNIsyw1bVDzD2QexTKxc7ONTmzOhNDuA6w7aMmDy8DfPELSWNUKcV3bgTRo0FVLbTXuAhHn0sqFXdjZQstO9vo0FcJojCY1vdm6xefe3T3DgGsR3FSBRiZh60APcxWN/7u9CF/a5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by PR3PR09MB4348.eurprd09.prod.outlook.com (2603:10a6:102:3f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 14:36:47 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::8e5f:9f4c:ffdc:f38d]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::8e5f:9f4c:ffdc:f38d%2]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 14:36:47 +0000
Date:   Fri, 19 May 2023 10:36:41 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     williams@redhawk.com
Cc:     linux-rt-users@vger.kernel.org
Subject: 6.1.19-rt8 has vanished from kernel.org
Message-ID: <20230519143641.GA50570@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN9PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:408:f9::23) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR09MB3582:EE_|PR3PR09MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f57d4d2-b7da-4c2d-1341-08db5876799e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rut4iRVOSIWMkVBYN4qYDBui0Am3vGyQtddyWjrVFuY/yfgBh0Et+xtd1WAL4uVY1kHTfR8/UJT0yDu8FaPPmB5r7H8ySb+//DR/PgoYUkMJiI/eyJ0/YJpiNgomKii76Nz0BR4v6QpmZ1bzXYSEWKLFUhyy6YdmryxkmRlcqBpMmBFy1cS2yu+xH0Ipnl+IdFE1nftLY+qPJ1cWSBtCxVcjSoUCZrf/Y0e+7xVUoeWu1PL764IP+Sbwlx+9PJUfc46c+2btLRYo6gSn8z03HEYuF0w8YUZl5gnWP9kuyj86ijHwy3dWSLa9a2r+pcYCr60PXWICO/CgLKpwJWi7COdjowxjeiO4aq8BTi/pbEjlphWjKVWPXh0O1qboo120HkKf0VFyW7ufgJs80CnOZfq5iVYaBPAxvzjEynM+BDwmKpPMsRmeoPGcLlleQauPigq1tpoiAUeDmXVCcRuyzFeYnmvTvlZJKPPM+Gsr0NHd8bwmaoPMBnalh0GXsq6zIe8l4V3a/H+pFS986KsQ9s7GM0Sv/6XlTtqfdPN3AekhuJTIKakJ3DF3r3A4MFhpJPXpvlCjZ/DoABTYLIgcT4xBwwSyJHFGzAVb1Amyxo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(66556008)(66476007)(66946007)(6916009)(4326008)(8936002)(8676002)(316002)(478600001)(41300700001)(6666004)(52116002)(966005)(4744005)(2906002)(3450700001)(86362001)(33656002)(6512007)(6506007)(26005)(1076003)(6486002)(44832011)(38350700002)(38100700002)(186003)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a4QDvLovKODmtIAu1x/TDIx93XAq5RWvAhcXxxlUnLVKWiJZaPT9Yty/E1WF?=
 =?us-ascii?Q?HAeKYVJdh8FiZz1Orc3gbWaJmHGlTDZ6mMNu29MN6j6k6hiCT/VtBOL6Oh5U?=
 =?us-ascii?Q?sryctq0+6QcgQKVZhKX7pe7iaHW3OfsXhwPJ52qLTCsPDeDWsQfqrqa02HoW?=
 =?us-ascii?Q?xGAX18g1NETr3aBju7hP1PBDT+kG0PMKySxRD4KNz6a7RvaYqFRwrJDSlPGA?=
 =?us-ascii?Q?wwrEG5dAfunhXUKd7Ia0JJ11VfYMch6rkUzWxOl09BoJT1iG7p4dAQnRJbzO?=
 =?us-ascii?Q?iWZMm3tuQsxepC7e9ZgRHjrXzXwR+1d/qc5UA/CjV6qU/F+7a/I9LerBGNtq?=
 =?us-ascii?Q?y3elBjv2FNLGn1KszahiZo9OnL4HdfS0AKu0Be11nCX+gA5ekPHqYRVSXETI?=
 =?us-ascii?Q?vgZw38Jll6RrkmpGs76uUH13YkXMhBOFLVv1oIdXOcHTALYea89+/nx0cSIf?=
 =?us-ascii?Q?NwbETaZlFa+3zdgiGk3je1SwhlnYLweTi2AMVceCTs2O99uAIqaLiIb1kzEB?=
 =?us-ascii?Q?wGXosDuDKW68bA5ygIPvYc6/AbSUi19LTzBqYahmzItY4++yyrCnQ5aedSWR?=
 =?us-ascii?Q?NO3irN4r3I4L3jRllZN00QWucqZ0VU5LQYUqI8DMXig04OhvvPJAlXPeIco6?=
 =?us-ascii?Q?qKQ058WSHIXcelnI4fKyBIhtpXGvEefYPtBiEudomdCR1osFNRK7GpPuQ02J?=
 =?us-ascii?Q?jskAEd3aVx/TK1W7p8B3TqIJ4C0Gs5c4ngC1k3Bxu9IzU4cWpGZ+Vp2eFPa2?=
 =?us-ascii?Q?ibO0r9eIYX0mCAQfpChhZWrMSyT82mNyYYuT7uySRHQMEPhSgZLh9nHV/o0Q?=
 =?us-ascii?Q?VOdnTWX1g487lY225wzhM+Uj8N0AxHSXbXWf/bLIzWmwWSDda2pQveWuRJ7R?=
 =?us-ascii?Q?OAz9xo1zFq2wJIpUw1E7kOzK/6b37aDLFQVha22eaTygMfo0tkptSClyOSNB?=
 =?us-ascii?Q?v4uVQ1Vcl7S5m5vlzhgViufexi68aC/+KiGXl20Qjapi0Ww3WZRWZexKmHsb?=
 =?us-ascii?Q?QosuKDV03eBToxLxN+AwlZncG6xmaL8ehRZLrg09ph8e3WjVk1Nyn8EdAcq/?=
 =?us-ascii?Q?NFMPH93c8qShX8M16YORjptCWgcnBNku7ZZ6T07WKOO8x+gbzcrRAgOY5fpm?=
 =?us-ascii?Q?18aHfD0Gn68y5zzobAPDGPkfJaHq4sA0PBNY3kcqxTlVI4kNaVa+aFvQK7QT?=
 =?us-ascii?Q?Z+YLpZz06/F4kPz8GG2s7ldUoo0e8EGH3RpdcjAkHGoWi+5k2VWeshjQFj8r?=
 =?us-ascii?Q?jx4E2vA/rKYRGLXXm6npGc6dB+Dd3LM/EY4Lkc/uSqwCOtU/+hn2L+En+0sc?=
 =?us-ascii?Q?wCVlZZeZXPLGJ/DgUPjoXRkyVgqul8h35q+LBhqh2ydA0oxR5B+gNn+igF1N?=
 =?us-ascii?Q?pPz4k017FPYcjKZLlCXm8uEZPuXN8MIpGkzWW+zNg98ds7H93I2RoWbO6/HA?=
 =?us-ascii?Q?A2rECAmeKCyvPnY6NCdqgYnToBk7ta0JzQsL4SXdeU0+oHdnF7wxjUPHzhXF?=
 =?us-ascii?Q?I8q7PPme7sIfzYQXqqF78PbhUl2jrBfSRhtXzIoMdXVl8eulMRaVDESKI/+0?=
 =?us-ascii?Q?JykEA3VNYr/ivmjqjZQwTok75CcX2uuEGValRiFeksgSnpdUk9jyC3v+IQV3?=
 =?us-ascii?Q?Sw=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f57d4d2-b7da-4c2d-1341-08db5876799e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:36:47.4824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSDDCczyTR2DWuA81axYQXJj9zlwTxJV75+13Zw6aeIvKjqavgtGRzbwGIUmITG5m+wuzwnSfOjX6KnjyHQPwyO8FIIduZFfXNoXvbpxCSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB4348
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi Clark,
I/we just noticed that 6.1.19-rt8 has vanished from the
kernel.org archives.  I'm letting you know in case this was
not intentional.  It is not in either the main directory
or in the 'older' directory.

I hope the policy to preserve all old tarballs and patches
still exists.

Regards,
Joe

PS: The two directories I looked in for 6.1.19-rt8:
https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/6.1/
https://mirrors.edge.kernel.org/pub/linux/kernel/projects/rt/6.1/older/

