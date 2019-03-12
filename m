Return-Path: <SRS0=Dbld=RP=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C16C43381
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 12:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22E66206BA
	for <linux-rt-users@archiver.kernel.org>; Tue, 12 Mar 2019 12:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfCLMBg (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Tue, 12 Mar 2019 08:01:36 -0400
Received: from gecko.sbs.de ([194.138.37.40]:44014 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725844AbfCLMBg (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Tue, 12 Mar 2019 08:01:36 -0400
X-Greylist: delayed 1213 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 08:01:35 EDT
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id x2CBfIoU030444
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Mar 2019 12:41:18 +0100
Received: from [139.25.69.33] ([139.25.69.33])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id x2CBfIXT001020;
        Tue, 12 Mar 2019 12:41:18 +0100
Subject: Re: [RFC PATCH] rt-tests: Add --runtime argument to tests
To:     John Kacur <jkacur@redhat.com>
Cc:     linux-rt-users@vger.kernel.org
References: <20190312100912.19253-1-daniel.wagner@siemens.com>
From:   Daniel Wagner <daniel.wagner@siemens.com>
Message-ID: <d01e1814-0058-f65b-d6b3-68df141c130b@siemens.com>
Date:   Tue, 12 Mar 2019 12:41:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190312100912.19253-1-daniel.wagner@siemens.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

> Some of the test have already claimed the -r argument
> (e.g. cyclictest) or are using --duration (e.g. pmqtest) which can't

D'oh, I just realized that cyclictest has -D and --duration including
the parser part for 'm', 'h' and 'd'. I am going to update the patch
accordingly.
