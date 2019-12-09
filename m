Return-Path: <SRS0=ajRN=Z7=vger.kernel.org=linux-rt-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47A7C43603
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 11:50:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D7C4207FD
	for <linux-rt-users@archiver.kernel.org>; Mon,  9 Dec 2019 11:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfLILuz (ORCPT
        <rfc822;linux-rt-users@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:50:55 -0500
Received: from mail.thorsis.com ([92.198.35.195]:60215 "EHLO mail.thorsis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbfLILuz (ORCPT <rfc822;linux-rt-users@vger.kernel.org>);
        Mon, 9 Dec 2019 06:50:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.thorsis.com (Postfix) with ESMTP id 243F5CE9
        for <linux-rt-users@vger.kernel.org>; Mon,  9 Dec 2019 12:52:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mail.thorsis.com
Received: from mail.thorsis.com ([127.0.0.1])
        by localhost (mail.thorsis.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J1AyY4Mg8UQK for <linux-rt-users@vger.kernel.org>;
        Mon,  9 Dec 2019 12:52:42 +0100 (CET)
Received: by mail.thorsis.com (Postfix, from userid 109)
        id 058E3357B; Mon,  9 Dec 2019 12:52:41 +0100 (CET)
From:   Alexander Dahl <ada@thorsis.com>
To:     linux-rt-users@vger.kernel.org
Subject: Re: How to use PREEMPT_RT with kernel 5.4
Date:   Mon, 09 Dec 2019 12:50:49 +0100
Message-ID: <1824476.9sc4eYzNRE@ada>
In-Reply-To: <20191209105920.09e6eb65@archlinux>
References: <7f488716-f294-a21c-4588-6753ff9bd0df@linux.intel.com> <20191209105920.09e6eb65@archlinux>
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-rt-users-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rt-users.vger.kernel.org>
X-Mailing-List: linux-rt-users@vger.kernel.org

Hi,

Am Montag, 9. Dezember 2019, 10:59:20 CET schrieb Ralf Mardorf:
> just out of curiosity, why can't you use a rt patched 5.2 kernel

v5.2 is EOL and receives no (security) updates anymore. Projected EOL for v5.4 
is December 2021. 

But I'm sure you already knew that. ;-)

A

